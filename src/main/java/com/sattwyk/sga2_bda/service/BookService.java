package com.sattwyk.sga2_bda.service;

import com.sattwyk.sga2_bda.entity.Author;
import com.sattwyk.sga2_bda.entity.Book;
import com.sattwyk.sga2_bda.exception.ResourceNotFoundException;
import com.sattwyk.sga2_bda.exception.ValidationException;
import com.sattwyk.sga2_bda.repository.AuthorRepository;
import com.sattwyk.sga2_bda.repository.BookAuthorView;
import com.sattwyk.sga2_bda.repository.BookRepository;
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
                .orElseThrow(() -> new ResourceNotFoundException("Book not found."));
    }

    public Book save(Book book) {
        if (book.getAuthor() == null || book.getAuthor().getId() == null) {
            throw new ValidationException("author.id", "Author is required.");
        }

        Author author = authorRepository.findById(book.getAuthor().getId())
                .orElseThrow(() -> new ResourceNotFoundException("Author not found."));
        book.setAuthor(author);

        if (book.getIsbn() == null || book.getIsbn().trim().isEmpty()) {
            throw new ValidationException("isbn", "ISBN is required.");
        }
        String normalizedIsbn = book.getIsbn().trim();
        book.setIsbn(normalizedIsbn);

        boolean isbnExists = (book.getId() == null)
                ? bookRepository.existsByIsbn(normalizedIsbn)
                : bookRepository.existsByIsbnAndIdNot(normalizedIsbn, book.getId());
        if (isbnExists) {
            throw new ValidationException("isbn", "ISBN must be unique.");
        }

        if (book.getTitle() != null) {
            book.setTitle(book.getTitle().trim());
        }

        return bookRepository.save(book);
    }

    public List<BookAuthorView> findAllBooksWithAuthors() {
        return bookRepository.findAllBooksWithAuthors();
    }
}
