package com.sattwyk.sga2_bda.controller;

import com.sattwyk.sga2_bda.entity.Author;
import com.sattwyk.sga2_bda.service.AuthorService;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/authors")
public class AuthorController {

    private final AuthorService authorService;

    public AuthorController(AuthorService authorService) {
        this.authorService = authorService;
    }

    @GetMapping
    public String listAuthors(Model model) {
        model.addAttribute("authors", authorService.findAll());
        model.addAttribute("authorForm", new Author());
        return "authors";
    }

    @PostMapping
    public String createAuthor(@ModelAttribute("authorForm") Author author,
                               RedirectAttributes redirectAttributes) {
        try {
            authorService.save(author);
            redirectAttributes.addFlashAttribute("successMessage", "Author saved successfully.");
        } catch (DataIntegrityViolationException e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Email must be unique.");
        }
        return "redirect:/authors";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Long id, Model model) {
        Author author = authorService.findById(id);
        model.addAttribute("authorForm", author);
        return "edit-author";
    }

    @PostMapping("/update")
    public String updateAuthor(@ModelAttribute("authorForm") Author author,
                               RedirectAttributes redirectAttributes) {
        try {
            authorService.save(author);
            redirectAttributes.addFlashAttribute("successMessage", "Author updated successfully.");
        } catch (DataIntegrityViolationException e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Email must be unique.");
        }
        return "redirect:/authors";
    }
}
