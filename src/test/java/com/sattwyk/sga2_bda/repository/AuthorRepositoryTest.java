package com.sattwyk.sga2_bda.repository;

import com.sattwyk.sga2_bda.entity.Author;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

@DataJpaTest
class AuthorRepositoryTest {

    @Autowired
    private AuthorRepository authorRepository;

    @Test
    void findByEmailReturnsMatchFromSeedData() {
        Optional<Author> author = authorRepository.findByEmail("a1@example.com");

        assertTrue(author.isPresent());
        assertEquals("Author One", author.get().getName());
    }
}
