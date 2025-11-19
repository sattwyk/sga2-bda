package com.sattwyk.sga2_bda.controller;

import com.sattwyk.sga2_bda.entity.Book;
import com.sattwyk.sga2_bda.repository.BookAuthorView;
import com.sattwyk.sga2_bda.service.AuthorService;
import com.sattwyk.sga2_bda.service.BookService;
import jakarta.validation.Valid;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/books")
public class BookController {

    private final BookService bookService;
    private final AuthorService authorService;

    public BookController(BookService bookService,
                          AuthorService authorService) {
        this.bookService = bookService;
        this.authorService = authorService;
    }

    @GetMapping
    public String listBooks(Model model) {
        model.addAttribute("books", bookService.findAll());
        model.addAttribute("bookForm", new Book());
        model.addAttribute("authors", authorService.findAll());
        return "books";
    }

    @PostMapping
    public String createBook(@Valid @ModelAttribute("bookForm") Book book,
                             BindingResult bindingResult,
                             @RequestParam("authorId") Long authorId,
                             RedirectAttributes redirectAttributes,
                             Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("books", bookService.findAll());
            model.addAttribute("authors", authorService.findAll());
            model.addAttribute("validationErrors", bindingResult.getAllErrors());
            return "books";
        }
        try {
            bookService.save(authorId, book);
            redirectAttributes.addFlashAttribute("successMessage", "Book saved successfully.");
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        } catch (DataIntegrityViolationException e) {
            redirectAttributes.addFlashAttribute("errorMessage", "ISBN must be unique.");
        }
        return "redirect:/books";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Long id, Model model) {
        Book book = bookService.findById(id);
        model.addAttribute("bookForm", book);
        model.addAttribute("authors", authorService.findAll());
        return "edit-book";
    }

    @PostMapping("/update")
    public String updateBook(@Valid @ModelAttribute("bookForm") Book book,
                             BindingResult bindingResult,
                             @RequestParam("authorId") Long authorId,
                             RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Validation failed. Please correct the fields.");
            return "redirect:/books/edit/" + book.getId();
        }
        try {
            bookService.save(authorId, book);
            redirectAttributes.addFlashAttribute("successMessage", "Book updated successfully.");
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        } catch (DataIntegrityViolationException e) {
            redirectAttributes.addFlashAttribute("errorMessage", "ISBN must be unique.");
        }
        return "redirect:/books";
    }

    @GetMapping("/with-authors")
    public String listBooksWithAuthors(Model model) {
        List<BookAuthorView> list = bookService.findAllBooksWithAuthors();
        model.addAttribute("booksWithAuthors", list);
        return "book-with-authors";
    }
}
