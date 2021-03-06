package com.lunatech.library.repository;

import com.lunatech.library.domain.Book;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface BookRepository extends JpaRepository<Book, Long> {

    public List<Book> findByOwner(String owner);

    public Long countByOwner(String owner);
}
