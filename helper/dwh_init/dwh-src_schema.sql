

CREATE SCHEMA pacbookstore AUTHORIZATION pg_database_owner;

--
-- Name: address; Type: TABLE; Schema: pacbookstore; Owner: postgres
--

CREATE TABLE pacbookstore.address (
    address_id integer NOT NULL,
    street_number character varying(10),
    street_name character varying(200),
    city character varying(100),
    country_id integer,
    CONSTRAINT pk_address PRIMARY KEY (address_id)
);

--
-- Name: address_status; Type: TABLE; Schema: pacbookstore; Owner: postgres
--

CREATE TABLE pacbookstore.address_status (
    status_id integer NOT NULL,
    address_status character varying(30),
    CONSTRAINT pk_addr_status PRIMARY KEY (status_id)
);


--
-- Name: author; Type: TABLE; Schema: pacbookstore; Owner: postgres
--

CREATE TABLE pacbookstore.author (
    author_id integer NOT NULL,
    author_name character varying(400),
    CONSTRAINT pk_author PRIMARY KEY (author_id)
);


--
-- Name: book; Type: TABLE; Schema: pacbookstore; Owner: postgres
--

CREATE TABLE pacbookstore.book (
    book_id integer NOT NULL,
    title character varying(400),
    isbn13 character varying(13),
    language_id integer,
    num_pages integer,
    publication_date date,
    publisher_id integer,
    CONSTRAINT pk_book PRIMARY KEY (book_id)
);

--
-- Name: book_author; Type: TABLE; Schema: pacbookstore; Owner: postgres
--

CREATE TABLE pacbookstore.book_author (
    book_id integer NOT NULL,
    author_id integer NOT NULL,
    CONSTRAINT pk_bookauthor PRIMARY KEY (book_id, author_id)
);

--
-- Name: book_language; Type: TABLE; Schema: pacbookstore; Owner: postgres
--

CREATE TABLE pacbookstore.book_language (
    language_id integer NOT NULL,
    language_code character varying(8),
    language_name character varying(50),
    CONSTRAINT pk_language PRIMARY KEY (language_id)
);


--
-- Name: country; Type: TABLE; Schema: pacbookstore; Owner: postgres
--

CREATE TABLE pacbookstore.country (
    country_id integer NOT NULL,
    country_name character varying(200),
    CONSTRAINT pk_country PRIMARY KEY (country_id)
);


--
-- Name: cust_order; Type: TABLE; Schema: pacbookstore; Owner: postgres
--

CREATE TABLE pacbookstore.cust_order (
    order_id integer NOT NULL,
    order_date timestamp without time zone,
    customer_id integer,
    shipping_method_id integer,
    dest_address_id integer,
    CONSTRAINT pk_custorder PRIMARY KEY (order_id)
);


--
-- Name: customer; Type: TABLE; Schema: pacbookstore; Owner: postgres
--

CREATE TABLE pacbookstore.customer (
    customer_id integer NOT NULL,
    first_name character varying(200),
    last_name character varying(200),
    email character varying(350),
    CONSTRAINT pk_customer PRIMARY KEY (customer_id)
);


--
-- Name: customer_address; Type: TABLE; Schema: pacbookstore; Owner: postgres
--

CREATE TABLE pacbookstore.customer_address (
    customer_id integer NOT NULL,
    address_id integer NOT NULL,
    status_id integer,
    CONSTRAINT pk_custaddr PRIMARY KEY (customer_id, address_id)
);


--
-- Name: order_history; Type: TABLE; Schema: pacbookstore; Owner: postgres
--

CREATE TABLE pacbookstore.order_history (
    history_id integer NOT NULL,
    order_id integer,
    status_id integer,
    status_date timestamp without time zone,
    CONSTRAINT pk_orderhist PRIMARY KEY (history_id)
);


--
-- Name: order_line; Type: TABLE; Schema: pacbookstore; Owner: postgres
--

CREATE TABLE pacbookstore.order_line (
    line_id integer NOT NULL,
    order_id integer,
    book_id integer,
    price numeric(5,2),
    CONSTRAINT pk_orderline PRIMARY KEY (line_id)
);


--
-- Name: order_status; Type: TABLE; Schema: pacbookstore; Owner: postgres
--

CREATE TABLE pacbookstore.order_status (
    status_id integer NOT NULL,
    status_value character varying(20),
    CONSTRAINT pk_orderstatus PRIMARY KEY (status_id)
);


--
-- Name: publisher; Type: TABLE; Schema: pacbookstore; Owner: postgres
--

CREATE TABLE pacbookstore.publisher (
    publisher_id integer NOT NULL,
    publisher_name character varying(400),
    CONSTRAINT pk_publisher PRIMARY KEY (publisher_id)
);


--
-- Name: shipping_method; Type: TABLE; Schema: pacbookstore; Owner: postgres
--

CREATE TABLE pacbookstore.shipping_method (
    method_id integer NOT NULL,
    method_name character varying(100),
    cost numeric(6,2),
    CONSTRAINT pk_shipmethod PRIMARY KEY (method_id)
);
 
--
-- Name: address fk_addr_ctry; Type: FK CONSTRAINT; Schema: pacbookstore; Owner: postgres
--

ALTER TABLE ONLY pacbookstore.address
    ADD CONSTRAINT fk_addr_ctry FOREIGN KEY (country_id) REFERENCES pacbookstore.country(country_id);


--
-- Name: book_author fk_ba_author; Type: FK CONSTRAINT; Schema: pacbookstore; Owner: postgres
--

ALTER TABLE ONLY pacbookstore.book_author
    ADD CONSTRAINT fk_ba_author FOREIGN KEY (author_id) REFERENCES pacbookstore.author(author_id);


--
-- Name: book_author fk_ba_book; Type: FK CONSTRAINT; Schema: pacbookstore; Owner: postgres
--

ALTER TABLE ONLY pacbookstore.book_author
    ADD CONSTRAINT fk_ba_book FOREIGN KEY (book_id) REFERENCES pacbookstore.book(book_id);


--
-- Name: book fk_book_lang; Type: FK CONSTRAINT; Schema: pacbookstore; Owner: postgres
--

ALTER TABLE ONLY pacbookstore.book
    ADD CONSTRAINT fk_book_lang FOREIGN KEY (language_id) REFERENCES pacbookstore.book_language(language_id);


--
-- Name: book fk_book_pub; Type: FK CONSTRAINT; Schema: pacbookstore; Owner: postgres
--

ALTER TABLE ONLY pacbookstore.book
    ADD CONSTRAINT fk_book_pub FOREIGN KEY (publisher_id) REFERENCES pacbookstore.publisher(publisher_id);


--
-- Name: customer_address fk_ca_addr; Type: FK CONSTRAINT; Schema: pacbookstore; Owner: postgres
--

ALTER TABLE ONLY pacbookstore.customer_address
    ADD CONSTRAINT fk_ca_addr FOREIGN KEY (address_id) REFERENCES pacbookstore.address(address_id);


--
-- Name: customer_address fk_ca_cust; Type: FK CONSTRAINT; Schema: pacbookstore; Owner: postgres
--

ALTER TABLE ONLY pacbookstore.customer_address
    ADD CONSTRAINT fk_ca_cust FOREIGN KEY (customer_id) REFERENCES pacbookstore.customer(customer_id);


--
-- Name: order_history fk_oh_order; Type: FK CONSTRAINT; Schema: pacbookstore; Owner: postgres
--

ALTER TABLE ONLY pacbookstore.order_history
    ADD CONSTRAINT fk_oh_order FOREIGN KEY (order_id) REFERENCES pacbookstore.cust_order(order_id);


--
-- Name: order_history fk_oh_status; Type: FK CONSTRAINT; Schema: pacbookstore; Owner: postgres
--

ALTER TABLE ONLY pacbookstore.order_history
    ADD CONSTRAINT fk_oh_status FOREIGN KEY (status_id) REFERENCES pacbookstore.order_status(status_id);


--
-- Name: order_line fk_ol_book; Type: FK CONSTRAINT; Schema: pacbookstore; Owner: postgres
--

ALTER TABLE ONLY pacbookstore.order_line
    ADD CONSTRAINT fk_ol_book FOREIGN KEY (book_id) REFERENCES pacbookstore.book(book_id);


--
-- Name: order_line fk_ol_order; Type: FK CONSTRAINT; Schema: pacbookstore; Owner: postgres
--

ALTER TABLE ONLY pacbookstore.order_line
    ADD CONSTRAINT fk_ol_order FOREIGN KEY (order_id) REFERENCES pacbookstore.cust_order(order_id);


--
-- Name: cust_order fk_order_addr; Type: FK CONSTRAINT; Schema: pacbookstore; Owner: postgres
--

ALTER TABLE ONLY pacbookstore.cust_order
    ADD CONSTRAINT fk_order_addr FOREIGN KEY (dest_address_id) REFERENCES pacbookstore.address(address_id);


--
-- Name: cust_order fk_order_cust; Type: FK CONSTRAINT; Schema: pacbookstore; Owner: postgres
--

ALTER TABLE ONLY pacbookstore.cust_order
    ADD CONSTRAINT fk_order_cust FOREIGN KEY (customer_id) REFERENCES pacbookstore.customer(customer_id);


--
-- Name: cust_order fk_order_ship; Type: FK CONSTRAINT; Schema: pacbookstore; Owner: postgres
--

ALTER TABLE ONLY pacbookstore.cust_order
    ADD CONSTRAINT fk_order_ship FOREIGN KEY (shipping_method_id) REFERENCES pacbookstore.shipping_method(method_id);


--
-- Name: customer_address fkey_status_add; Type: FK CONSTRAINT; Schema: pacbookstore; Owner: postgres
--

ALTER TABLE ONLY pacbookstore.customer_address
    ADD CONSTRAINT fkey_status_add FOREIGN KEY (status_id) REFERENCES pacbookstore.address_status(status_id);




