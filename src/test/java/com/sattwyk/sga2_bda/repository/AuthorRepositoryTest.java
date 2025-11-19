package com.sattwyk.sga2_bda.repository;

import com.sattwyk.sga2_bda.entity.Author;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.test.context.jdbc.Sql;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

@DataJpaTest(properties = "spring.sql.init.mode=never")
@Sql("/data.sql")
class AuthorRepositoryTest {

    @Autowired
    private AuthorRepository authorRepository;

    @Test
    void findByEmailReturnsMatchFromSeedData() {
        Optional<Author> author = authorRepository.findByEmail("jk.rowling@hogwarts.com");

        assertTrue(author.isPresent());
        assertEquals("J.K. Rowling", author.get().getName());
    }
}
