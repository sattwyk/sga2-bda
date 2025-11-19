package com.sattwyk.sga2_bda.service;

import com.sattwyk.sga2_bda.entity.Author;
import com.sattwyk.sga2_bda.exception.ResourceNotFoundException;
import com.sattwyk.sga2_bda.exception.ValidationException;
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

        ResourceNotFoundException ex = assertThrows(ResourceNotFoundException.class, () -> authorService.findById(77L));
        assertTrue(ex.getMessage().contains("Author not found"));
    }

    @Test
    void saveDelegatesToRepository() {
        Author author = new Author("Name", "email@example.com", "Country");
        when(authorRepository.findByEmail("email@example.com")).thenReturn(Optional.empty());
        when(authorRepository.save(any(Author.class))).thenAnswer(invocation -> invocation.getArgument(0));

        Author saved = authorService.save(author);

        assertEquals("email@example.com", saved.getEmail());
        verify(authorRepository).save(author);
    }

    @Test
    void saveThrowsWhenEmailExistsOnAnotherAuthor() {
        Author existing = new Author("Existing", "email@example.com", "Country");
        existing.setId(99L);
        when(authorRepository.findByEmail("email@example.com")).thenReturn(Optional.of(existing));

        Author author = new Author("Name", "email@example.com", "Country");

        ValidationException ex = assertThrows(ValidationException.class, () -> authorService.save(author));
        assertEquals("email", ex.getFieldName());
    }

    @Test
    void updateAuthorMergesIntoExistingEntity() {
        Author existing = new Author("Existing", "old@example.com", "Old");
        existing.setId(5L);
        when(authorRepository.findByEmail("new@example.com")).thenReturn(Optional.empty());
        when(authorRepository.findById(5L)).thenReturn(Optional.of(existing));
        when(authorRepository.save(existing)).thenReturn(existing);

        Author update = new Author("Updated", "new@example.com", "NewCountry");
        update.setId(5L);

        Author saved = authorService.save(update);

        assertEquals("Updated", saved.getName());
        assertEquals("new@example.com", saved.getEmail());
        assertEquals("NewCountry", saved.getCountry());
        verify(authorRepository).save(existing);
    }
}
