package com.sattwyk.sga2_bda.service;

import com.sattwyk.sga2_bda.entity.Author;
import com.sattwyk.sga2_bda.exception.ResourceNotFoundException;
import com.sattwyk.sga2_bda.exception.ValidationException;
import com.sattwyk.sga2_bda.repository.AuthorRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AuthorService {

    private final AuthorRepository authorRepository;

    public AuthorService(AuthorRepository authorRepository) {
        this.authorRepository = authorRepository;
    }

    public List<Author> findAll() {
        return authorRepository.findAll();
    }

    public Author findById(Long id) {
        return authorRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Author not found."));
    }

    public Author save(Author author) {
        if (author.getName() != null) {
            author.setName(author.getName().trim());
        }
        if (author.getEmail() != null) {
            author.setEmail(author.getEmail().trim());
        }
        if (author.getCountry() != null) {
            String country = author.getCountry().trim();
            author.setCountry(country.isEmpty() ? null : country);
        }

        authorRepository.findByEmail(author.getEmail())
                .filter(existing -> author.getId() == null || !existing.getId().equals(author.getId()))
                .ifPresent(existing -> {
                    throw new ValidationException("email", "Email already in use.");
                });

        if (author.getId() != null) {
            Author existing = authorRepository.findById(author.getId())
                    .orElseThrow(() -> new ResourceNotFoundException("Author not found."));
            existing.setName(author.getName());
            existing.setEmail(author.getEmail());
            existing.setCountry(author.getCountry());
            return authorRepository.save(existing);
        }

        return authorRepository.save(author);
    }
}
