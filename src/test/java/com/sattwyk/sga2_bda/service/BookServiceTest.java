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
        when(bookRepository.save(any(Book.class))).thenAnswer(invocation -> invocation.getArgument(0));

        Book book = new Book();
        book.setTitle("Test Book");
        Book result = bookService.save(1L, book);

        assertSame(author, result.getAuthor(), "Author should be set on the book before saving");
        verify(authorRepository).findById(1L);
        verify(bookRepository).save(book);
    }

    @Test
    void saveThrowsIfAuthorMissing() {
        when(authorRepository.findById(99L)).thenReturn(Optional.empty());

        Book book = new Book();
        RuntimeException ex = assertThrows(RuntimeException.class, () -> bookService.save(99L, book));
        assertTrue(ex.getMessage().contains("Author not found"));
        verify(bookRepository, never()).save(any(Book.class));
    }
}
