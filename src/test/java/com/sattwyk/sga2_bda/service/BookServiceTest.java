package com.sattwyk.sga2_bda.service;

import com.sattwyk.sga2_bda.entity.Author;
import com.sattwyk.sga2_bda.entity.Book;
import com.sattwyk.sga2_bda.repository.AuthorRepository;
import com.sattwyk.sga2_bda.repository.BookRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class BookServiceTest {

    @Mock
    private BookRepository bookRepository;

    @Mock
    private AuthorRepository authorRepository;

    private BookService bookService;

    @BeforeEach
    void setUp() {
        bookService = new BookService(bookRepository, authorRepository);
    }

    @Test
    void saveAssignsAuthorAndPersists() {
        Author author = new Author();
        author.setId(1L);
        when(authorRepository.findById(1L)).thenReturn(Optional.of(author));
        when(bookRepository.existsByIsbn("123")).thenReturn(false);
        when(bookRepository.save(any(Book.class))).thenAnswer(invocation -> invocation.getArgument(0));

        Book book = new Book();
        book.setTitle("Test Book");
        book.setIsbn("123");
        Book result = bookService.save(1L, book);

        assertSame(author, result.getAuthor(), "Author should be set on the book before saving");
        verify(authorRepository).findById(1L);
        verify(bookRepository).save(book);
    }

    @Test
    void saveThrowsIfAuthorMissing() {
        when(authorRepository.findById(99L)).thenReturn(Optional.empty());

        Book book = new Book();
        book.setIsbn("123");
        RuntimeException ex = assertThrows(RuntimeException.class, () -> bookService.save(99L, book));
        assertTrue(ex.getMessage().contains("Author not found"));
        verify(bookRepository, never()).save(any(Book.class));
    }

    @Test
    void saveThrowsWhenIsbnAlreadyExistsForNewBook() {
        Author author = new Author();
        author.setId(1L);
        when(authorRepository.findById(1L)).thenReturn(Optional.of(author));
        when(bookRepository.existsByIsbn("dup")).thenReturn(true);

        Book book = new Book();
        book.setTitle("Dup");
        book.setIsbn("dup");

        IllegalArgumentException ex =
                assertThrows(IllegalArgumentException.class, () -> bookService.save(1L, book));
        assertTrue(ex.getMessage().contains("ISBN"));
        verify(bookRepository, never()).save(any(Book.class));
    }

    @Test
    void saveAllowsExistingIsbnForSameBook() {
        Author author = new Author();
        author.setId(1L);
        when(authorRepository.findById(1L)).thenReturn(Optional.of(author));
        when(bookRepository.existsByIsbnAndIdNot("same", 10L)).thenReturn(false);
        when(bookRepository.save(any(Book.class))).thenAnswer(invocation -> invocation.getArgument(0));

        Book book = new Book();
        book.setId(10L);
        book.setTitle("Same");
        book.setIsbn("same");

        Book saved = bookService.save(1L, book);
        assertEquals("same", saved.getIsbn());
        verify(bookRepository).save(book);
    }
}
