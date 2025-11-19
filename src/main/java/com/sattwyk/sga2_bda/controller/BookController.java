package com.sattwyk.sga2_bda.controller;

import com.sattwyk.sga2_bda.entity.Author;
import com.sattwyk.sga2_bda.entity.Book;
import com.sattwyk.sga2_bda.exception.ResourceNotFoundException;
import com.sattwyk.sga2_bda.exception.ValidationException;
import com.sattwyk.sga2_bda.repository.BookAuthorView;
import com.sattwyk.sga2_bda.service.AuthorService;
import com.sattwyk.sga2_bda.service.BookService;
import jakarta.validation.Valid;
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
        prepareBookFormModel(model);
        return "books";
    }

    @PostMapping
    public String createBook(@Valid @ModelAttribute("bookForm") Book book,
                             BindingResult bindingResult,
                             Model model,
                             RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors()) {
            prepareBookFormModel(model);
            return "books";
        }
        try {
            bookService.save(book);
            redirectAttributes.addFlashAttribute("successMessage", "Book saved successfully.");
            return "redirect:/books";
        } catch (ValidationException e) {
            rejectField(bindingResult, e);
            prepareBookFormModel(model);
            return "books";
        } catch (ResourceNotFoundException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/books";
        }
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        try {
            Book book = bookService.findById(id);
            if (book.getAuthor() == null) {
                book.setAuthor(new Author());
            }
            model.addAttribute("bookForm", book);
            model.addAttribute("authors", authorService.findAll());
            return "edit-book";
        } catch (ResourceNotFoundException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/books";
        }
    }

    @PostMapping("/update")
    public String updateBook(@Valid @ModelAttribute("bookForm") Book book,
                             BindingResult bindingResult,
                             Model model,
                             RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("authors", authorService.findAll());
            return "edit-book";
        }
        try {
            bookService.save(book);
            redirectAttributes.addFlashAttribute("successMessage", "Book updated successfully.");
            return "redirect:/books";
        } catch (ValidationException e) {
            rejectField(bindingResult, e);
            model.addAttribute("authors", authorService.findAll());
            return "edit-book";
        } catch (ResourceNotFoundException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/books";
        }
    }

    @GetMapping("/with-authors")
    public String listBooksWithAuthors(Model model) {
        List<BookAuthorView> list = bookService.findAllBooksWithAuthors();
        model.addAttribute("booksWithAuthors", list);
        return "book-with-authors";
    }

    private void prepareBookFormModel(Model model) {
        Book form = (Book) model.getAttribute("bookForm");
        if (form == null) {
            form = new Book();
        }
        if (form.getAuthor() == null) {
            form.setAuthor(new Author());
        }
        model.addAttribute("bookForm", form);
        model.addAttribute("books", bookService.findAll());
        model.addAttribute("authors", authorService.findAll());
    }

    private void rejectField(BindingResult bindingResult, ValidationException e) {
        if (e.getFieldName() != null) {
            bindingResult.rejectValue(e.getFieldName(), "invalid", e.getMessage());
        } else {
            bindingResult.reject("bookForm", e.getMessage());
        }
    }
}
