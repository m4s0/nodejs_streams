create table kraken.user
(
    id      int auto_increment primary key,
    name    varchar(255) null,
    surname varchar(255) null,
    constraint unique_name_surname
        unique (name, surname)
)
    collate = utf8mb4_unicode_ci;


create table kraken.account
(
    id             int auto_increment primary key,
    user_id        int         not null,
    routing_number varchar(9)  not null,
    account_number varchar(17) not null,
    constraint fk_user_id
        foreign key (user_id) references kraken.user (id),
    constraint unique_routing_number_account_number
        unique (routing_number, account_number)
)
    collate = utf8mb4_unicode_ci;

create index account_user_id_idx
    on kraken.account (user_id);

create index account_routing_number_account_number_idx
    on kraken.account (routing_number, account_number);


create table kraken.import_process
(
    id           varchar(36) primary key,
    started_at   datetime not null,
    completed_at datetime null
)
    collate = utf8mb4_unicode_ci;


create table kraken.transaction
(
    id                  varchar(36) primary key,
    import_process_id   varchar(36) not null,
    account_id          int         not null,
    from_routing_number varchar(9)  not null,
    from_account_number varchar(17) not null,
    amount              int         not null,
    currency            varchar(3)  not null,
    constraint fk_account_id
        foreign key (account_id) references kraken.account (id),
    constraint fk_t_import_process_id
        foreign key (import_process_id) references kraken.import_process (id)
)
    collate = utf8mb4_unicode_ci;

create index account_account_id_idx
    on kraken.transaction (account_id);

create index account_id_idx
    on kraken.transaction (id);


create table kraken.raw_transaction
(
    id                  varchar(36) primary key,
    import_process_id   varchar(36) not null,
    from_routing_number varchar(9)  not null,
    from_account_number varchar(17) not null,
    to_routing_number   varchar(9)  not null,
    to_account_number   varchar(17) not null,
    amount              int         not null,
    currency            varchar(3)  not null,
    constraint fk_rt_import_process_id
        foreign key (import_process_id) references kraken.import_process (id)
)
    collate = utf8mb4_unicode_ci;


INSERT INTO kraken.user (id, name, surname)
VALUES (1, 'Jadzia', 'Dax');
INSERT INTO kraken.user (id, name, surname)
VALUES (2, 'James', 'T. Kirk');
INSERT INTO kraken.user (id, name, surname)
VALUES (3, 'Jean-Luc', 'Picard');
INSERT INTO kraken.user (id, name, surname)
VALUES (4, 'Jonathan', 'Archer');
INSERT INTO kraken.user (id, name, surname)
VALUES (5, 'Leonard', 'McCoy');
INSERT INTO kraken.user (id, name, surname)
VALUES (6, 'Montgomery', 'Scott');
INSERT INTO kraken.user (id, name, surname)
VALUES (7, 'Spock', null);
INSERT INTO kraken.user (id, name, surname)
VALUES (8, 'Wesley', 'Crusher');


INSERT INTO kraken.account (id, user_id, routing_number, account_number)
VALUES (1, 1, '11000015', '6622085487');
INSERT INTO kraken.account (id, user_id, routing_number, account_number)
VALUES (2, 2, '21001208', '18423486');
INSERT INTO kraken.account (id, user_id, routing_number, account_number)
VALUES (3, 3, '21001208', '1691452698');
INSERT INTO kraken.account (id, user_id, routing_number, account_number)
VALUES (4, 4, '11000015', '3572176408');
INSERT INTO kraken.account (id, user_id, routing_number, account_number)
VALUES (5, 5, '11000015', '8149516692');
INSERT INTO kraken.account (id, user_id, routing_number, account_number)
VALUES (6, 6, '11000015', '7438979785');
INSERT INTO kraken.account (id, user_id, routing_number, account_number)
VALUES (7, 7, '11000015', '1690537988');
INSERT INTO kraken.account (id, user_id, routing_number, account_number)
VALUES (8, 7, '21001208', '1690537989');
INSERT INTO kraken.account (id, user_id, routing_number, account_number)
VALUES (9, 8, '11000015', '6018423486');
