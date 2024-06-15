--1) Relação de filmes (incluir todos os atributos da tabela film apenas) de nacionalidade alemã (language)
SELECT
	*
FROM film
WHERE language_id = 6;

--2) Faturamento total (amount) recebido agrupado por nacionalidade (lingua) do filme (mostrar código da lingua, nome da lingua e valor total) em ordem descendente
SELECT
	l.language_id,
	l.name,
	SUM(p.amount) total
FROM payment p
INNER JOIN rental r ON p.rental_id = r.rental_id
INNER JOIN inventory i ON r.inventory_id = i.inventory_id
INNER JOIN film f ON i.film_id = f.film_id
INNER JOIN dbo.language l ON f.language_id = l.language_id
GROUP BY l.language_id, l.name
ORDER BY total DESC;


--3) Relação dos 10 filmes mais locados (quantas vezes) (mostrar film_id e title e a quantidade de locações realizadas por filme)
SELECT TOP 10
	f.film_id,
	f.title,
	COUNT(r.rental_id) AS tenancy_numbers
FROM rental r
INNER JOIN inventory i ON r.inventory_id = i.inventory_id
INNER JOIN film f ON i.film_id = f.film_id
GROUP BY f.film_id, f.title
ORDER BY tenancy_numbers DESC;

--4) Mostrar o número de filmes locados por cada funcionário (staff). A consulta deve mostrar o id do funcionário, o nome e a contagem de filmes que realizou a locação
SELECT
	s.staff_id,
	s.first_name,
	s.last_name,
	COUNT(r.rental_id) AS film_numbers
FROM rental r
INNER JOIN staff s ON r.staff_id = s.staff_id
GROUP BY s.staff_id, s.first_name, s.last_name;

--5) Usando junção natural à esquerda, verificar se existe algum cliente que não fez nenhuma locação no mês 05/2005 (customer x rental)
	SELECT
		c.customer_id,
		c.first_name,
		c.last_name
	FROM customer c
	LEFT JOIN rental r ON r.customer_id = c.customer_id AND r.rental_date BETWEEN '2005-05-01' AND '2005-05-31'
	WHERE r.customer_id IS NULL
	GROUP BY c.customer_id, r.rental_date, c.first_name, c.last_name;

--6) Relação de cópias (inventory) existentes por filme. Mostrar o id do filme, o título e a contagem de cópias em ordem de título
SELECT
	f.film_id,
	f.title,
	COUNT(i.inventory_id) AS copy_numbers
FROM inventory i
INNER JOIN film f ON i.film_id = f.film_id
WHERE i.film_id = f.film_id
GROUP BY f.film_id, f.title
ORDER BY f.title;

--7) Relação de clientes que moram nos Estados Unidos que alugaram filmes de nacionalidade francesa
--(mostrar todos os campos da tabela customers em ordem de nome)
SELECT
	c.*
FROM customer c
INNER JOIN rental r ON c.customer_id = r.customer_id
INNER JOIN inventory i ON r.inventory_id = i.inventory_id
INNER JOIN film f ON i.film_id = f.film_id AND f.language_id = 5
INNER JOIN address a ON c.address_id = a.address_id
INNER JOIN city ct ON a.city_id = ct.city_id AND ct.country_id = 103
GROUP BY c.customer_id, c.store_id, c.store_id, c.first_name, c.last_name, c.email, c.address_id, c.activebool, c.create_date, c.last_update, c.active
ORDER BY c.first_name;

--8) Mostrar o nome de todos os clientes que fizeram mais de 5 locações em ordem alfabética. Dica: pesquise sobre a cláusula having
SELECT
	c.first_name,
	c.last_name
FROM customer c
INNER JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.first_name, c.last_name
HAVING COUNT(r.customer_id) > 5
ORDER BY c.first_name;

--9) Mostrar o número de cópias de filmes por loja (inventory e store) em ordem crescente da contagem
SELECT
	s.store_id,
	COUNT(i.inventory_id) AS film_numbers
FROM inventory i
INNER JOIN store s ON i.store_id = s.store_id
GROUP BY s.store_id
ORDER BY COUNT(i.inventory_id); -- ASC é redundante;

--10) Nome dos clientes que moram na América Latina em ordem alfabética
SELECT
	c.first_name,
	c.last_name,
	co.country_id,
	co.country
FROM customer c
INNER JOIN address a ON c.address_id = a.address_id
INNER JOIN city ct ON a.city_id = ct.city_id
INNER JOIN country co ON ct.country_id = co.country_id
    AND (co.country LIKE 'Argentina' OR co.country LIKE 'Bolivia' OR co.country LIKE 'Brazil'
    OR co.country LIKE 'Chile' OR co.country LIKE 'Colombia' OR co.country LIKE 'Ecuador'
    OR co.country LIKE 'French Guiana' OR co.country LIKE 'Mexico' OR co.country LIKE 'Paraguay'
    OR co.country LIKE 'Peru' OR co.country LIKE 'Puerto Rico' OR co.country LIKE 'Venezuela')
ORDER BY c.first_name;