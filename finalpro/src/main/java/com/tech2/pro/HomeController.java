package com.tech2.pro;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.apache.pdfbox.pdmodel.*;
import org.apache.pdfbox.pdmodel.common.PDRectangle;
import org.apache.pdfbox.pdmodel.font.PDType1Font;
import org.apache.pdfbox.text.PDFTextStripper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.File;
import java.io.IOException;
import java.nio.file.*;
import java.time.LocalDateTime;
import java.util.List;
import java.util.regex.*;

@Controller
public class HomeController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ProjectRepository projectRepository;

    @Autowired
    private MessageRepository messageRepository;

    private static final String UPLOAD_DIR = "uploads/";

    // ------------------- LOGIN -------------------
    @GetMapping("/")
    public String showLoginPage() {
        return "home";
    }

    @PostMapping("/login")
    public String login(@RequestParam String username,
                        @RequestParam String password,
                        HttpSession session,
                        Model model) {

        User user = userRepository.findByUsername(username);

        if (user != null && user.getPassword().equals(password)) {
            user.setLastLogin(LocalDateTime.now());
            userRepository.save(user);

            session.setAttribute("user", user);

            String resumePath = UPLOAD_DIR + user.getResume();
            Portfolio portfolio = parseResume(resumePath);

            List<Project> projects = projectRepository.findByUser(user);

            model.addAttribute("user", user);
            model.addAttribute("portfolio", portfolio);
            model.addAttribute("projects", projects);

            return "welcome";
        }

        model.addAttribute("error", "Invalid username or password");
        return "home";
    }

    // ------------------- REGISTER -------------------
    @GetMapping("/register")
    public String showRegisterPage() {
        return "register";
    }

    @PostMapping("/register")
    public String register(@RequestParam String username,
                           @RequestParam String email,
                           @RequestParam String password,
                           @RequestParam String confirmPassword,
                           @RequestParam("resume") MultipartFile resumeFile,
                           @RequestParam("profilePhoto") MultipartFile photoFile,
                           Model model) {

        if (!password.equals(confirmPassword)) {
            model.addAttribute("error", "Passwords do not match");
            return "register";
        }

        if (userRepository.findByUsername(username) != null) {
            model.addAttribute("error", "Username already exists");
            return "register";
        }

        String fileName = resumeFile.getOriginalFilename();
        String photoFileName = photoFile.getOriginalFilename();

        try {
            Path uploadPath = Paths.get(UPLOAD_DIR);
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }
            Files.copy(resumeFile.getInputStream(), uploadPath.resolve(fileName), StandardCopyOption.REPLACE_EXISTING);
            Files.copy(photoFile.getInputStream(), uploadPath.resolve(photoFileName), StandardCopyOption.REPLACE_EXISTING);
        } catch (IOException e) {
            e.printStackTrace();
            model.addAttribute("error", "Could not save files");
            return "register";
        }

        User user = new User(username, email, password);
        user.setResume(fileName);
        user.setProfilePhoto(photoFileName);
        userRepository.save(user);

        return "redirect:/";
    }

    // ------------------- LOGOUT -------------------
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

    // ------------------- WELCOME -------------------
    @GetMapping("/welcome")
    public String showWelcomePage(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user != null) {
            model.addAttribute("user", user);

            String resumePath = UPLOAD_DIR + user.getResume();
            Portfolio portfolio = parseResume(resumePath);
            model.addAttribute("portfolio", portfolio);

            List<Project> projects = projectRepository.findByUser(user);
            model.addAttribute("projects", projects);

            return "welcome";
        }
        return "redirect:/";
    }

    // ------------------- UPDATE SKILLS -------------------
    @PostMapping("/updateSkills")
    public String updateSkills(@RequestParam String skills, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user != null) {
            // Append instead of overwrite
            if (user.getSkills() != null && !user.getSkills().isEmpty()) {
                user.setSkills(user.getSkills() + ", " + skills);
            } else {
                user.setSkills(skills);
            }
            userRepository.save(user);
            session.setAttribute("user", user); // keep session updated
        }
        return "redirect:/welcome";
    }


    // ------------------- ADD PROJECT -------------------
    @PostMapping("/addProject")
    public String addProject(@RequestParam String title,
                             @RequestParam String description,
                             @RequestParam(required = false) String link,
                             HttpSession session,
                             RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/";

        Project project = new Project();
        project.setTitle(title);
        project.setDescription(description);
        project.setLink(link);
        project.setUser(user);

        projectRepository.save(project);

        redirectAttributes.addFlashAttribute("success", "🚀 Project added successfully!");
        return "redirect:/welcome";
    }

    // ------------------- SEND MESSAGE -------------------
    @PostMapping("/sendMessage")
    public String sendMessage(@RequestParam String name,
                              @RequestParam String email,
                              @RequestParam(required = false) String phone,
                              @RequestParam(required = false) String twitter,
                              @RequestParam(required = false) String instagram,
                              @RequestParam(required = false) String facebook,
                              @RequestParam String message,
                              HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user != null) {
            Message msg = new Message();
            msg.setName(name);
            msg.setEmail(email);
            msg.setPhone(phone);
            msg.setTwitter(twitter);
            msg.setInstagram(instagram);
            msg.setFacebook(facebook);
            msg.setContent(message);
            msg.setUser(user);
            messageRepository.save(msg);
            model.addAttribute("msg", "Message sent successfully!");
        }
        return "redirect:/welcome";
    }

    @GetMapping("/viewPortfolio")
    public String viewPortfolio(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/";
        }

        // Parse resume
        Portfolio portfolio = parseResume(UPLOAD_DIR + user.getResume());

        // ✅ Fallback to DB values if parsing failed
        if (portfolio.getName() == null || "Not Found".equals(portfolio.getName())) {
            portfolio.setName(user.getUsername());  // or user.getName() if you have a real name field
        }
        if (portfolio.getEmail() == null || "Not Found".equals(portfolio.getEmail())) {
            portfolio.setEmail(user.getEmail());
        }
        if (portfolio.getSkills() == null || "Not Found".equals(portfolio.getSkills())) {
            portfolio.setSkills(user.getSkills());
        }
        if (portfolio.getExperience() == null || "Not Found".equals(portfolio.getExperience())) {
            portfolio.setExperience("No experience added yet.");
        }
        if (portfolio.getEducation() == null || "Not Found".equals(portfolio.getEducation())) {
            portfolio.setEducation("No education details available.");
        }

        // ✅ Profile photo
        if (user.getProfilePhoto() != null) {
            portfolio.setPhotoPath(user.getProfilePhoto());
        }

        // Add to model
        model.addAttribute("user", user);
        model.addAttribute("portfolio", portfolio);

        // Projects
        List<Project> projects = projectRepository.findByUser(user);
        model.addAttribute("projects", projects);

        // Messages
        List<Message> messages = messageRepository.findByUser(user);
        model.addAttribute("messages", messages);

        // Enable export
        session.setAttribute("canExport", true);

        return "PortfolioView";
    }

    // ------------------- EXPORT PORTFOLIO PDF -------------------
    @GetMapping("/exportPortfolioPdf")
    public void exportPortfolioPdf(HttpServletResponse response, HttpSession session) throws IOException {
        User user = (User) session.getAttribute("user");
        Boolean canExport = (Boolean) session.getAttribute("canExport");

        if (user == null) {
            response.sendRedirect("/");
            return;
        }
        if (canExport == null || !canExport) {
            response.sendRedirect("/viewPortfolio");
            return;
        }

        Portfolio portfolio = parseResume(UPLOAD_DIR + user.getResume());

        if (user.getSkills() != null && !user.getSkills().isEmpty()) {
            portfolio.setSkills(user.getSkills());
        }

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=portfolio_summary.pdf");

        PDDocument doc = new PDDocument();
        PDPage page = new PDPage(PDRectangle.A4);
        doc.addPage(page);

        try (PDPageContentStream cs = new PDPageContentStream(doc, page)) {
            cs.beginText();
            cs.setFont(PDType1Font.HELVETICA_BOLD, 12);
            cs.setLeading(14.5f);
            cs.newLineAtOffset(25, 750);

            cs.showText("Portfolio Summary");
            cs.newLine();
            cs.newLine();
            cs.showText("Name: " + portfolio.getName());
            cs.newLine();
            cs.showText("Email: " + portfolio.getEmail());
            cs.newLine();
            cs.showText("Skills: " + portfolio.getSkills());
            cs.newLine();
            cs.showText("Education: " + portfolio.getEducation());
            cs.newLine();
            cs.showText("Experience: " + portfolio.getExperience());
            cs.newLine();
            cs.showText("Word Count: " + portfolio.getWordCount());

            cs.endText();
        }

        doc.save(response.getOutputStream());
        doc.close();
    }

    // ------------------- RESUME PARSER -------------------
    private Portfolio parseResume(String filePath) {
        Portfolio portfolio = new Portfolio();
        try (PDDocument document = PDDocument.load(new File(filePath))) {
            PDFTextStripper stripper = new PDFTextStripper();
            String text = stripper.getText(document);

            portfolio.setName(extractPattern(text, "Name[:\\s]+(.*)"));
            portfolio.setEmail(extractPattern(text, "([a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-.]+)"));
            portfolio.setSkills(extractPattern(text, "Skills[:\\s]+(.*)"));
            portfolio.setEducation(extractPattern(text, "Education[:\\s]+(.*)"));
            portfolio.setExperience(extractPattern(text, "Experience[:\\s]+(.*)"));
            portfolio.setWordCount(text.split("\\s+").length);

        } catch (IOException e) {
            e.printStackTrace();
        }
        return portfolio;
    }

    private String extractPattern(String text, String patternString) {
        Pattern pattern = Pattern.compile(patternString, Pattern.CASE_INSENSITIVE);
        Matcher matcher = pattern.matcher(text);
        if (matcher.find() && matcher.groupCount() >= 1) {
            return matcher.group(1).split("\\n")[0].trim();
        }
        return "Not Found";
    }
}
