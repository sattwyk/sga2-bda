package com.sattwyk.sga2_bda.controller;

import com.sattwyk.sga2_bda.entity.Author;
import com.sattwyk.sga2_bda.exception.ResourceNotFoundException;
import com.sattwyk.sga2_bda.exception.ValidationException;
import com.sattwyk.sga2_bda.service.AuthorService;
import jakarta.validation.Valid;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
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
        if (!model.containsAttribute("authorForm")) {
            model.addAttribute("authorForm", new Author());
        }
        model.addAttribute("authors", authorService.findAll());
        return "authors";
    }

    @PostMapping
    public String createAuthor(@Valid @ModelAttribute("authorForm") Author author,
                               BindingResult bindingResult,
                               Model model,
                               RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("authors", authorService.findAll());
            return "authors";
        }
        try {
            authorService.save(author);
            redirectAttributes.addFlashAttribute("successMessage", "Author saved successfully.");
            return "redirect:/authors";
        } catch (ValidationException e) {
            bindingResult.rejectValue(e.getFieldName(), "invalid", e.getMessage());
            model.addAttribute("authors", authorService.findAll());
            return "authors";
        }
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        try {
            Author author = authorService.findById(id);
            model.addAttribute("authorForm", author);
            return "edit-author";
        } catch (ResourceNotFoundException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/authors";
        }
    }

    @PostMapping("/update")
    public String updateAuthor(@Valid @ModelAttribute("authorForm") Author author,
                               BindingResult bindingResult,
                               Model model,
                               RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("authorForm", author);
            return "edit-author";
        }
        try {
            authorService.save(author);
            redirectAttributes.addFlashAttribute("successMessage", "Author updated successfully.");
            return "redirect:/authors";
        } catch (ValidationException e) {
            bindingResult.rejectValue(e.getFieldName(), "invalid", e.getMessage());
            model.addAttribute("authorForm", author);
            return "edit-author";
        } catch (ResourceNotFoundException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/authors";
        }
    }
}
