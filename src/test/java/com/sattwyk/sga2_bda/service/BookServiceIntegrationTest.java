package com.sattwyk.sga2_bda.service;

import com.sattwyk.sga2_bda.entity.Book;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import static org.junit.jupiter.api.Assertions.assertThrows;

@SpringBootTest
@Transactional
class BookServiceIntegrationTest {

    @Autowired
    private BookService bookService;

    @Test
    void creatingBookWithExistingIsbnFails() {
        Book duplicate = new Book();
        duplicate.setTitle("Duplicate HP");
        duplicate.setIsbn("978-0747532699");

        assertThrows(IllegalArgumentException.class,
                () -> bookService.save(1L, duplicate));
    }

    @Test
    void creatingTwoBooksWithSameFreshIsbnFailsOnSecondAttempt() {
        Book first = new Book();
        first.setTitle("New Title");
        first.setIsbn("111-unique-test");
        bookService.save(1L, first);

        Book duplicate = new Book();
        duplicate.setTitle("Another Title");
        duplicate.setIsbn("111-unique-test");

        assertThrows(IllegalArgumentException.class,
                () -> bookService.save(1L, duplicate));
    }
}
