package com.sattwyk.sga2_bda.service;

import com.sattwyk.sga2_bda.entity.Author;
import com.sattwyk.sga2_bda.entity.Book;
import com.sattwyk.sga2_bda.repository.AuthorRepository;
import com.sattwyk.sga2_bda.repository.BookAuthorView;
import com.sattwyk.sga2_bda.repository.BookRepository;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BookService {

    private final BookRepository bookRepository;
    private final AuthorRepository authorRepository;

    public BookService(BookRepository bookRepository,
                       AuthorRepository authorRepository) {
        this.bookRepository = bookRepository;
        this.authorRepository = authorRepository;
    }

    public List<Book> findAll() {
        return bookRepository.findAll();
    }

    public Book findById(Long id) {
        return bookRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Book not found"));
    }

    public Book save(Long authorId, Book book) {
        if (book.getIsbn() == null || book.getIsbn().trim().isEmpty()) {
            throw new IllegalArgumentException("ISBN is required.");
        }
        String normalizedIsbn = book.getIsbn().trim();
        book.setIsbn(normalizedIsbn);

        Author author = authorRepository.findById(authorId)
                .orElseThrow(() -> new RuntimeException("Author not found"));
        book.setAuthor(author);

        boolean isbnExists = (book.getId() == null)
                ? bookRepository.existsByIsbn(normalizedIsbn)
                : bookRepository.existsByIsbnAndIdNot(normalizedIsbn, book.getId());
        if (isbnExists) {
            throw new IllegalArgumentException("ISBN must be unique");
        }

        try {
            return bookRepository.save(book);
        } catch (DataIntegrityViolationException e) {
            throw e;
        }
    }

    public List<BookAuthorView> findAllBooksWithAuthors() {
        return bookRepository.findAllBooksWithAuthors();
    }
}
