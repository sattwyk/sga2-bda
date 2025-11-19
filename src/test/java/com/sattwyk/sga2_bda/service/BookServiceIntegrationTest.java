package com.sattwyk.sga2_bda.service;

import com.sattwyk.sga2_bda.entity.Author;
import com.sattwyk.sga2_bda.entity.Book;
import com.sattwyk.sga2_bda.exception.ValidationException;
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
        Author author = new Author();
        author.setId(1L);
        duplicate.setAuthor(author);
        duplicate.setTitle("Duplicate HP");
        duplicate.setIsbn("978-0747532699");

        assertThrows(ValidationException.class,
                () -> bookService.save(duplicate));
    }

    @Test
    void creatingTwoBooksWithSameFreshIsbnFailsOnSecondAttempt() {
        Book first = new Book();
        Author firstAuthor = new Author();
        firstAuthor.setId(1L);
        first.setAuthor(firstAuthor);
        first.setTitle("New Title");
        first.setIsbn("111-unique-test");
        bookService.save(first);

        Book duplicate = new Book();
        Author secondAuthor = new Author();
        secondAuthor.setId(1L);
        duplicate.setAuthor(secondAuthor);
        duplicate.setTitle("Another Title");
        duplicate.setIsbn("111-unique-test");

        assertThrows(ValidationException.class,
                () -> bookService.save(duplicate));
    }
}
