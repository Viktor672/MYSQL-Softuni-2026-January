SET SQL_SAFE_UPDATES = 0;

-- Using Database book_library
-- 01
select title from books
where left(title, 3) = 'The'
order by id asc;

-- 02
update books
set title = replace(title, 'The', '***')
where left(title, 3) = 'The';

select title from books 
where left(title, 3) = '***';

-- 03
select round(sum(cost), 2) as sum from books;

-- 04
select concat(first_name, ' ', last_name) as 'Full Name', timestampdiff(day, born, died) as 'Days Lived' from authors;

-- 05
select title from books
where title like 'Harry Potter%';