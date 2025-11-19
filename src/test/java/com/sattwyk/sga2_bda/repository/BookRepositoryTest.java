package com.sattwyk.sga2_bda.repository;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.test.context.jdbc.Sql;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@DataJpaTest(properties = "spring.sql.init.mode=never")
@Sql("/data.sql")
class BookRepositoryTest {

    @Autowired
    private BookRepository bookRepository;

    @Test
    void findAllBooksWithAuthorsReturnsJoinedRows() {
        List<BookAuthorView> results = bookRepository.findAllBooksWithAuthors();

        assertEquals(10, results.size(), "Seed data should return 10 joined rows");
        assertTrue(results.stream().anyMatch(r ->
                        "Harry Potter and the Sorcerer's Stone".equals(r.getTitle()) &&
                                "J.K. Rowling".equals(r.getAuthorName())),
                "Joined projection should include book titles with matching author names");
    }
}
