package com.sattwyk.sga2_bda.service;

import com.sattwyk.sga2_bda.entity.Author;
import com.sattwyk.sga2_bda.repository.AuthorRepository;
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
class AuthorServiceTest {

    @Mock
    private AuthorRepository authorRepository;

    private AuthorService authorService;

    @BeforeEach
    void setUp() {
        authorService = new AuthorService(authorRepository);
    }

    @Test
    void findByIdReturnsEntity() {
        Author author = new Author();
        author.setId(5L);
        when(authorRepository.findById(5L)).thenReturn(Optional.of(author));

        Author found = authorService.findById(5L);

        assertEquals(5L, found.getId());
        verify(authorRepository).findById(5L);
    }

    @Test
    void findByIdThrowsWhenMissing() {
        when(authorRepository.findById(77L)).thenReturn(Optional.empty());

        RuntimeException ex = assertThrows(RuntimeException.class, () -> authorService.findById(77L));
        assertTrue(ex.getMessage().contains("Author not found"));
    }

    @Test
    void saveDelegatesToRepository() {
        Author author = new Author("Name", "email@example.com", "Country");
        when(authorRepository.save(any(Author.class))).thenAnswer(invocation -> invocation.getArgument(0));

        Author saved = authorService.save(author);

        assertEquals("email@example.com", saved.getEmail());
        verify(authorRepository).save(author);
    }
}
