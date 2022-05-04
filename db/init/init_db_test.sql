create table kraken_test.user
(
    id      int auto_increment primary key,
    name    varchar(255) null,
    surname varchar(255) null,
    constraint unique_name_surname
        unique (name, surname)
)
    collate = utf8mb4_unicode_ci;


create table kraken_test.account
(
    id             int auto_increment primary key,
    user_id        int         not null,
    routing_number varchar(9)  not null,
    account_number varchar(17) not null,
    constraint fk_user_id
        foreign key (user_id) references kraken_test.user (id),
    constraint unique_routing_number_account_number
        unique (routing_number, account_number)
)
    collate = utf8mb4_unicode_ci;

create index account_user_id_idx
    on kraken_test.account (user_id);

create index account_routing_number_account_number_idx
    on kraken_test.account (routing_number, account_number);


create table kraken_test.import_process
(
    id           varchar(36) primary key,
    started_at   datetime not null,
    completed_at datetime null
)
    collate = utf8mb4_unicode_ci;


create table kraken_test.transaction
(
    id                  varchar(36) primary key,
    import_process_id   varchar(36) not null,
    account_id          int         not null,
    from_routing_number varchar(9)  not null,
    from_account_number varchar(17) not null,
    amount              int         not null,
    currency            varchar(3)  not null,
    constraint fk_account_id
        foreign key (account_id) references kraken_test.account (id),
    constraint fk_t_import_process_id
        foreign key (import_process_id) references kraken_test.import_process (id)
)
    collate = utf8mb4_unicode_ci;

create index account_account_id_idx
    on kraken_test.transaction (account_id);

create index account_id_idx
    on kraken_test.transaction (id);


create table kraken_test.raw_transaction
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
        foreign key (import_process_id) references kraken_test.import_process (id)
)
    collate = utf8mb4_unicode_ci;
