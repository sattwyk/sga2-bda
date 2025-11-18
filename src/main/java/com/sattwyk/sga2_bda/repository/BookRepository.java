package com.sattwyk.sga2_bda.repository;

import com.sattwyk.sga2_bda.entity.Book;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface BookRepository extends JpaRepository<Book, Long> {

    @Query("SELECT b.title AS title, a.name AS authorName " +
           "FROM Book b INNER JOIN b.author a")
    List<BookAuthorView> findAllBooksWithAuthors();
}
