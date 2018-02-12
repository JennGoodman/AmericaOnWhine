/*******************************************************************************
   America On Whine Initial Database Installation and reset Script - Version 1
   Script: 1801 AmericaOnWhine Initial Setup.sql
   Description: Creates and populates the AmericaOnWhine database.
   DB Server: Oracle
   Author: Jenn Goodman
********************************************************************************/

/*******************************************************************************
   Drop Tables if they exist
********************************************************************************/

drop table aow_user cascade constraints;
drop table aow_tag cascade constraints;
drop table aow_country cascade constraints;
drop table aow_type cascade constraints;
drop table aow_sub_type cascade constraints;
drop table aow_brand cascade constraints;
drop table aow_inventory cascade constraints;
drop table aow_inventory_audit cascade constraints;
drop table aow_transaction cascade constraints;
drop table aow_inventory_tag cascade constraints;

/*******************************************************************************
   Drop Sequences if they exist
********************************************************************************/

drop sequence aow_user_seq;
drop sequence aow_tag_seq;
drop sequence aow_country_seq;
drop sequence aow_type_seq;
drop sequence aow_sub_type_seq;
drop sequence aow_brand_seq;
drop sequence aow_inventory_seq;
drop sequence aow_inventory_audit_seq;
drop sequence aow_transaction_seq;
drop sequence aow_inventory_tag_seq;

/*******************************************************************************
   Create Tables
********************************************************************************/

create table aow_user (
    id          number(6)       primary key,
    username    varchar2(50)    unique not null,
    password    varchar2(50)    not null,
    email       varchar2(50)    unique not null,
    role        number(1)       not null,
    active      number(1)       not null,
    cancelled   number(1)       not null
);
create table aow_tag (
    id          number(6)       primary key,
    tag         varchar2(25)    not null
);
create table aow_country (
    id          number(6)       primary key,
    abbrev      varchar2(2)     unique not null,
    country     varchar2(50)    unique not null
);
create table aow_type (
    id          number(6)       primary key,
    type        varchar2(50)    unique not null
);
create table aow_sub_type (
    id          number(6)       primary key,
    type_id     number(6)       not null references aow_type(id),
    sub_type    varchar2(50)    unique not null
);
create table aow_brand (
    id          number(6)       primary key,
    brand       varchar2(50)    unique not null
);
create table aow_inventory (
    id          number(6)       primary key,
    name        varchar2(50)    not null,
    brand_id    number(6)       not null references aow_brand(id),
    user_id     number(6)       not null references aow_user(id),
    country_id  number(6)       not null references aow_country(id),
    sub_type_id number(6)       not null references aow_sub_type(id),
    volume      number(5,2)     not null,
    year        number(4)       not null,
    price       number(8,2)     not null,
    quantity    number(6)       not null,
    submitted   Date            not null,
    description varchar2(256),
    image_url   varchar2(256)
);
create table aow_inventory_audit (
    id              number(6)   primary key,
    old_id          number(6),
    new_id          number(6),
    old_name        varchar2(50),
    new_name        varchar2(50),
    old_brand_id    number(6),
    new_brand_id    number(6),
    old_user_id     number(6),
    new_user_id     number(6),
    old_country_id  number(6),
    new_country_id  number(6),
    old_sub_type_id number(6),
    new_sub_type_id number(6),
    new_volume      number(5,2),
    old_volume      number(5,2),
    old_year        number(4),
    new_year        number(4),
    old_price       number(8,2),
    new_price       number(8,2),
    new_quantity    number(6),
    old_quantity    number(6),
    old_submitted   date,
    new_submitted   date,
    old_description varchar2(256),
    new_description varchar2(256),
    old_image_url   varchar2(256),
    new_image_url   varchar2(256)
);
create table aow_transaction (
    id                  number(6)   primary key,
    order_number        number(6)   not null,
    inventory_id        number(6)   not null references aow_inventory(id),
    quantity            number(3)   not null,
    user_id             number(6)   not null references aow_user(id),
    rating              number(1)   not null,
    transaction_date    date        not null,
    comments            varchar2(2000)
);
create table aow_inventory_tag (
    inventory_id    number(6) references aow_inventory(id),
    tag_id          number(6) references aow_tag(id),
    constraint inv_tag primary key(inventory_id, tag_id)
);

/*******************************************************************************
   Create Primary Key Unique Indexes
********************************************************************************/

create sequence aow_user_seq;
create sequence aow_tag_seq;
create sequence aow_country_seq;
create sequence aow_type_seq;
create sequence aow_sub_type_seq;
create sequence aow_brand_seq;
create sequence aow_inventory_seq;
create sequence aow_inventory_audit_seq;
create sequence aow_transaction_seq;
create sequence aow_inventory_tag_seq;

/*******************************************************************************
   Create Triggers
********************************************************************************/

create or replace trigger aow_inventory_audit_trig
before insert on aow_inventory for each row
begin
    if INSERTING then
        insert into aow_inventory_audit (
            id,
            new_id,
            new_name,
            new_brand_id,
            new_user_id,
            new_country_id,
            new_sub_type_id,
            new_volume,
            new_year,
            new_price,
            new_quantity,
            new_submitted,
            new_description,
            new_image_url
        ) values (
            aow_inventory_audit_seq.nextVal,
            :new.id,
            :new.name,
            :new.brand_id,
            :new.user_id,
            :new.country_id,
            :new.sub_type_id,
            :new.volume,
            :new.year,
            :new.price,
            :new.quantity,
            :new.submitted,
            :new.description,
            :new.image_url
        );
    elsif UPDATING then
        insert into aow_inventory_audit (
            id,
            new_id,             old_id,
            new_name,           old_name,
            new_brand_id,       old_brand_id,
            new_user_id,        old_user_id,
            new_country_id,     old_country_id,
            new_sub_type_id,    old_sub_type_id,
            new_volume,         old_volume,
            new_year,           old_year,
            new_price,          old_price,
            new_quantity,       old_quantity,
            new_submitted,      old_submitted,
            new_description,    old_description,
            new_image_url,      old_image_url
        ) values (
            aow_inventory_audit_seq.nextVal,
            :new.id,            :old.id,
            :new.name,          :old.name,
            :new.brand_id,      :old.brand_id,
            :new.user_id,       :old.user_id,
            :new.country_id,    :old.country_id,
            :new.volume,        :old.volume,
            :new.sub_type_id,   :old.sub_type_id,
            :new.year,          :old.year,
            :new.price,         :old.price,
            :new.quantity,      :old.quantity,
            :new.submitted,     :old.submitted,
            :new.description,   :old.description,
            :new.image_url,     :old.image_url
        );
    end if;
end;
/
/*******************************************************************************
   Create Views
********************************************************************************/

create or replace view aow_inventory_view as (
    select i.id, name, brand, user_id, country, sub_type, volume, year, price, quantity, submitted, description, image_url
        from aow_inventory i
            join aow_brand b
                on b.id = i.brand_id
            join aow_country c
                on c.id = i.country_id
            join aow_sub_type st
                on st.id = i.sub_type_id
);

/*******************************************************************************
   Populate Tables
********************************************************************************/

insert into aow_user (id, username, password, email, role, active, cancelled) values (1, 'admin', 'admin', 'admin@admin.net', 0, 1, 0);
insert into aow_user (id, username, password, email, role, active, cancelled) values (2, 'retailer', 'retailer', 'retailer@retailer.net', 1, 1, 0);
insert into aow_user (id, username, password, email, role, active, cancelled) values (3, 'customer', 'customer', 'customer@customer.net', 2, 1, 0);

insert into aow_country (id, abbrev, country) values (1, 'AF', 'Afghanistan');
insert into aow_country (id, abbrev, country) values (2, 'AL', 'Albania');
insert into aow_country (id, abbrev, country) values (3, 'DZ', 'Algeria');
insert into aow_country (id, abbrev, country) values (4, 'DS', 'American Samoa');
insert into aow_country (id, abbrev, country) values (5, 'AD', 'Andorra');
insert into aow_country (id, abbrev, country) values (6, 'AO', 'Angola');
insert into aow_country (id, abbrev, country) values (7, 'AI', 'Anguilla');
insert into aow_country (id, abbrev, country) values (8, 'AQ', 'Antarctica');
insert into aow_country (id, abbrev, country) values (9, 'AG', 'Antigua and Barbuda');
insert into aow_country (id, abbrev, country) values (10, 'AR', 'Argentina');
insert into aow_country (id, abbrev, country) values (11, 'AM', 'Armenia');
insert into aow_country (id, abbrev, country) values (12, 'AW', 'Aruba');
insert into aow_country (id, abbrev, country) values (13, 'AU', 'Australia');
insert into aow_country (id, abbrev, country) values (14, 'AT', 'Austria');
insert into aow_country (id, abbrev, country) values (15, 'AZ', 'Azerbaijan');
insert into aow_country (id, abbrev, country) values (16, 'BS', 'Bahamas');
insert into aow_country (id, abbrev, country) values (17, 'BH', 'Bahrain');
insert into aow_country (id, abbrev, country) values (18, 'BD', 'Bangladesh');
insert into aow_country (id, abbrev, country) values (19, 'BB', 'Barbados');
insert into aow_country (id, abbrev, country) values (20, 'BY', 'Belarus');
insert into aow_country (id, abbrev, country) values (21, 'BE', 'Belgium');
insert into aow_country (id, abbrev, country) values (22, 'BZ', 'Belize');
insert into aow_country (id, abbrev, country) values (23, 'BJ', 'Benin');
insert into aow_country (id, abbrev, country) values (24, 'BM', 'Bermuda');
insert into aow_country (id, abbrev, country) values (25, 'BT', 'Bhutan');
insert into aow_country (id, abbrev, country) values (26, 'BO', 'Bolivia');
insert into aow_country (id, abbrev, country) values (27, 'BA', 'Bosnia and Herzegovina');
insert into aow_country (id, abbrev, country) values (28, 'BW', 'Botswana');
insert into aow_country (id, abbrev, country) values (29, 'BV', 'Bouvet Island');
insert into aow_country (id, abbrev, country) values (30, 'BR', 'Brazil');
insert into aow_country (id, abbrev, country) values (31, 'IO', 'British Indian Ocean Territory');
insert into aow_country (id, abbrev, country) values (32, 'BN', 'Brunei Darussalam');
insert into aow_country (id, abbrev, country) values (33, 'BG', 'Bulgaria');
insert into aow_country (id, abbrev, country) values (34, 'BF', 'Burkina Faso');
insert into aow_country (id, abbrev, country) values (35, 'BI', 'Burundi');
insert into aow_country (id, abbrev, country) values (36, 'KH', 'Cambodia');
insert into aow_country (id, abbrev, country) values (37, 'CM', 'Cameroon');
insert into aow_country (id, abbrev, country) values (38, 'CA', 'Canada');
insert into aow_country (id, abbrev, country) values (39, 'CV', 'Cape Verde');
insert into aow_country (id, abbrev, country) values (40, 'KY', 'Cayman Islands');
insert into aow_country (id, abbrev, country) values (41, 'CF', 'Central African Republic');
insert into aow_country (id, abbrev, country) values (42, 'TD', 'Chad');
insert into aow_country (id, abbrev, country) values (43, 'CL', 'Chile');
insert into aow_country (id, abbrev, country) values (44, 'CN', 'China');
insert into aow_country (id, abbrev, country) values (45, 'CX', 'Christmas Island');
insert into aow_country (id, abbrev, country) values (46, 'CC', 'Cocos (Keeling) Islands');
insert into aow_country (id, abbrev, country) values (47, 'CO', 'Colombia');
insert into aow_country (id, abbrev, country) values (48, 'KM', 'Comoros');
insert into aow_country (id, abbrev, country) values (49, 'CG', 'Congo');
insert into aow_country (id, abbrev, country) values (50, 'CK', 'Cook Islands');
insert into aow_country (id, abbrev, country) values (51, 'CR', 'Costa Rica');
insert into aow_country (id, abbrev, country) values (52, 'HR', 'Croatia (Hrvatska)');
insert into aow_country (id, abbrev, country) values (53, 'CU', 'Cuba');
insert into aow_country (id, abbrev, country) values (54, 'CY', 'Cyprus');
insert into aow_country (id, abbrev, country) values (55, 'CZ', 'Czech Republic');
insert into aow_country (id, abbrev, country) values (56, 'DK', 'Denmark');
insert into aow_country (id, abbrev, country) values (57, 'DJ', 'Djibouti');
insert into aow_country (id, abbrev, country) values (58, 'DM', 'Dominica');
insert into aow_country (id, abbrev, country) values (59, 'DO', 'Dominican Republic');
insert into aow_country (id, abbrev, country) values (60, 'TP', 'East Timor');
insert into aow_country (id, abbrev, country) values (61, 'EC', 'Ecuador');
insert into aow_country (id, abbrev, country) values (62, 'EG', 'Egypt');
insert into aow_country (id, abbrev, country) values (63, 'SV', 'El Salvador');
insert into aow_country (id, abbrev, country) values (64, 'GQ', 'Equatorial Guinea');
insert into aow_country (id, abbrev, country) values (65, 'ER', 'Eritrea');
insert into aow_country (id, abbrev, country) values (66, 'EE', 'Estonia');
insert into aow_country (id, abbrev, country) values (67, 'ET', 'Ethiopia');
insert into aow_country (id, abbrev, country) values (68, 'FK', 'Falkland Islands (Malvinas)');
insert into aow_country (id, abbrev, country) values (69, 'FO', 'Faroe Islands');
insert into aow_country (id, abbrev, country) values (70, 'FJ', 'Fiji');
insert into aow_country (id, abbrev, country) values (71, 'FI', 'Finland');
insert into aow_country (id, abbrev, country) values (72, 'FR', 'France');
insert into aow_country (id, abbrev, country) values (73, 'FX', 'France, Metropolitan');
insert into aow_country (id, abbrev, country) values (74, 'GF', 'French Guiana');
insert into aow_country (id, abbrev, country) values (75, 'PF', 'French Polynesia');
insert into aow_country (id, abbrev, country) values (76, 'TF', 'French Southern Territories');
insert into aow_country (id, abbrev, country) values (77, 'GA', 'Gabon');
insert into aow_country (id, abbrev, country) values (78, 'GM', 'Gambia');
insert into aow_country (id, abbrev, country) values (79, 'GE', 'Georgia');
insert into aow_country (id, abbrev, country) values (80, 'DE', 'Germany');
insert into aow_country (id, abbrev, country) values (81, 'GH', 'Ghana');
insert into aow_country (id, abbrev, country) values (82, 'GI', 'Gibraltar');
insert into aow_country (id, abbrev, country) values (83, 'GK', 'Guernsey');
insert into aow_country (id, abbrev, country) values (84, 'GR', 'Greece');
insert into aow_country (id, abbrev, country) values (85, 'GL', 'Greenland');
insert into aow_country (id, abbrev, country) values (86, 'GD', 'Grenada');
insert into aow_country (id, abbrev, country) values (87, 'GP', 'Guadeloupe');
insert into aow_country (id, abbrev, country) values (88, 'GU', 'Guam');
insert into aow_country (id, abbrev, country) values (89, 'GT', 'Guatemala');
insert into aow_country (id, abbrev, country) values (90, 'GN', 'Guinea');
insert into aow_country (id, abbrev, country) values (91, 'GW', 'Guinea-Bissau');
insert into aow_country (id, abbrev, country) values (92, 'GY', 'Guyana');
insert into aow_country (id, abbrev, country) values (93, 'HT', 'Haiti');
insert into aow_country (id, abbrev, country) values (94, 'HM', 'Heard and Mc Donald Islands');
insert into aow_country (id, abbrev, country) values (95, 'HN', 'Honduras');
insert into aow_country (id, abbrev, country) values (96, 'HK', 'Hong Kong');
insert into aow_country (id, abbrev, country) values (97, 'HU', 'Hungary');
insert into aow_country (id, abbrev, country) values (98, 'IS', 'Iceland');
insert into aow_country (id, abbrev, country) values (99, 'IN', 'India');
insert into aow_country (id, abbrev, country) values (100, 'IM', 'Isle of Man');
insert into aow_country (id, abbrev, country) values (101, 'ID', 'Indonesia');
insert into aow_country (id, abbrev, country) values (102, 'IR', 'Iran (Islamic Republic of)');
insert into aow_country (id, abbrev, country) values (103, 'IQ', 'Iraq');
insert into aow_country (id, abbrev, country) values (104, 'IE', 'Ireland');
insert into aow_country (id, abbrev, country) values (105, 'IL', 'Israel');
insert into aow_country (id, abbrev, country) values (106, 'IT', 'Italy');
insert into aow_country (id, abbrev, country) values (107, 'CI', 'Ivory Coast');
insert into aow_country (id, abbrev, country) values (108, 'JE', 'Jersey');
insert into aow_country (id, abbrev, country) values (109, 'JM', 'Jamaica');
insert into aow_country (id, abbrev, country) values (110, 'JP', 'Japan');
insert into aow_country (id, abbrev, country) values (111, 'JO', 'Jordan');
insert into aow_country (id, abbrev, country) values (112, 'KZ', 'Kazakhstan');
insert into aow_country (id, abbrev, country) values (113, 'KE', 'Kenya');
insert into aow_country (id, abbrev, country) values (114, 'KI', 'Kiribati');
insert into aow_country (id, abbrev, country) values (115, 'KP', 'Korea, Democratic People''s Republic of');
insert into aow_country (id, abbrev, country) values (116, 'KR', 'Korea, Republic of');
insert into aow_country (id, abbrev, country) values (117, 'XK', 'Kosovo');
insert into aow_country (id, abbrev, country) values (118, 'KW', 'Kuwait');
insert into aow_country (id, abbrev, country) values (119, 'KG', 'Kyrgyzstan');
insert into aow_country (id, abbrev, country) values (120, 'LA', 'Lao People''s Democratic Republic');
insert into aow_country (id, abbrev, country) values (121, 'LV', 'Latvia');
insert into aow_country (id, abbrev, country) values (122, 'LB', 'Lebanon');
insert into aow_country (id, abbrev, country) values (123, 'LS', 'Lesotho');
insert into aow_country (id, abbrev, country) values (124, 'LR', 'Liberia');
insert into aow_country (id, abbrev, country) values (125, 'LY', 'Libyan Arab Jamahiriya');
insert into aow_country (id, abbrev, country) values (126, 'LI', 'Liechtenstein');
insert into aow_country (id, abbrev, country) values (127, 'LT', 'Lithuania');
insert into aow_country (id, abbrev, country) values (128, 'LU', 'Luxembourg');
insert into aow_country (id, abbrev, country) values (129, 'MO', 'Macau');
insert into aow_country (id, abbrev, country) values (130, 'MK', 'Macedonia');
insert into aow_country (id, abbrev, country) values (131, 'MG', 'Madagascar');
insert into aow_country (id, abbrev, country) values (132, 'MW', 'Malawi');
insert into aow_country (id, abbrev, country) values (133, 'MY', 'Malaysia');
insert into aow_country (id, abbrev, country) values (134, 'MV', 'Maldives');
insert into aow_country (id, abbrev, country) values (135, 'ML', 'Mali');
insert into aow_country (id, abbrev, country) values (136, 'MT', 'Malta');
insert into aow_country (id, abbrev, country) values (137, 'MH', 'Marshall Islands');
insert into aow_country (id, abbrev, country) values (138, 'MQ', 'Martinique');
insert into aow_country (id, abbrev, country) values (139, 'MR', 'Mauritania');
insert into aow_country (id, abbrev, country) values (140, 'MU', 'Mauritius');
insert into aow_country (id, abbrev, country) values (141, 'TY', 'Mayotte');
insert into aow_country (id, abbrev, country) values (142, 'MX', 'Mexico');
insert into aow_country (id, abbrev, country) values (143, 'FM', 'Micronesia, Federated States of');
insert into aow_country (id, abbrev, country) values (144, 'MD', 'Moldova, Republic of');
insert into aow_country (id, abbrev, country) values (145, 'MC', 'Monaco');
insert into aow_country (id, abbrev, country) values (146, 'MN', 'Mongolia');
insert into aow_country (id, abbrev, country) values (147, 'ME', 'Montenegro');
insert into aow_country (id, abbrev, country) values (148, 'MS', 'Montserrat');
insert into aow_country (id, abbrev, country) values (149, 'MA', 'Morocco');
insert into aow_country (id, abbrev, country) values (150, 'MZ', 'Mozambique');
insert into aow_country (id, abbrev, country) values (151, 'MM', 'Myanmar');
insert into aow_country (id, abbrev, country) values (152, 'NA', 'Namibia');
insert into aow_country (id, abbrev, country) values (153, 'NR', 'Nauru');
insert into aow_country (id, abbrev, country) values (154, 'NP', 'Nepal');
insert into aow_country (id, abbrev, country) values (155, 'NL', 'Netherlands');
insert into aow_country (id, abbrev, country) values (156, 'AN', 'Netherlands Antilles');
insert into aow_country (id, abbrev, country) values (157, 'NC', 'New Caledonia');
insert into aow_country (id, abbrev, country) values (158, 'NZ', 'New Zealand');
insert into aow_country (id, abbrev, country) values (159, 'NI', 'Nicaragua');
insert into aow_country (id, abbrev, country) values (160, 'NE', 'Niger');
insert into aow_country (id, abbrev, country) values (161, 'NG', 'Nigeria');
insert into aow_country (id, abbrev, country) values (162, 'NU', 'Niue');
insert into aow_country (id, abbrev, country) values (163, 'NF', 'Norfolk Island');
insert into aow_country (id, abbrev, country) values (164, 'MP', 'Northern Mariana Islands');
insert into aow_country (id, abbrev, country) values (165, 'NO', 'Norway');
insert into aow_country (id, abbrev, country) values (166, 'OM', 'Oman');
insert into aow_country (id, abbrev, country) values (167, 'PK', 'Pakistan');
insert into aow_country (id, abbrev, country) values (168, 'PW', 'Palau');
insert into aow_country (id, abbrev, country) values (169, 'PS', 'Palestine');
insert into aow_country (id, abbrev, country) values (170, 'PA', 'Panama');
insert into aow_country (id, abbrev, country) values (171, 'PG', 'Papua New Guinea');
insert into aow_country (id, abbrev, country) values (172, 'PY', 'Paraguay');
insert into aow_country (id, abbrev, country) values (173, 'PE', 'Peru');
insert into aow_country (id, abbrev, country) values (174, 'PH', 'Philippines');
insert into aow_country (id, abbrev, country) values (175, 'PN', 'Pitcairn');
insert into aow_country (id, abbrev, country) values (176, 'PL', 'Poland');
insert into aow_country (id, abbrev, country) values (177, 'PT', 'Portugal');
insert into aow_country (id, abbrev, country) values (178, 'PR', 'Puerto Rico');
insert into aow_country (id, abbrev, country) values (179, 'QA', 'Qatar');
insert into aow_country (id, abbrev, country) values (180, 'RE', 'Reunion');
insert into aow_country (id, abbrev, country) values (181, 'RO', 'Romania');
insert into aow_country (id, abbrev, country) values (182, 'RU', 'Russian Federation');
insert into aow_country (id, abbrev, country) values (183, 'RW', 'Rwanda');
insert into aow_country (id, abbrev, country) values (184, 'KN', 'Saint Kitts and Nevis');
insert into aow_country (id, abbrev, country) values (185, 'LC', 'Saint Lucia');
insert into aow_country (id, abbrev, country) values (186, 'VC', 'Saint Vincent and the Grenadines');
insert into aow_country (id, abbrev, country) values (187, 'WS', 'Samoa');
insert into aow_country (id, abbrev, country) values (188, 'SM', 'San Marino');
insert into aow_country (id, abbrev, country) values (189, 'ST', 'Sao Tome and Principe');
insert into aow_country (id, abbrev, country) values (190, 'SA', 'Saudi Arabia');
insert into aow_country (id, abbrev, country) values (191, 'SN', 'Senegal');
insert into aow_country (id, abbrev, country) values (192, 'RS', 'Serbia');
insert into aow_country (id, abbrev, country) values (193, 'SC', 'Seychelles');
insert into aow_country (id, abbrev, country) values (194, 'SL', 'Sierra Leone');
insert into aow_country (id, abbrev, country) values (195, 'SG', 'Singapore');
insert into aow_country (id, abbrev, country) values (196, 'SK', 'Slovakia');
insert into aow_country (id, abbrev, country) values (197, 'SI', 'Slovenia');
insert into aow_country (id, abbrev, country) values (198, 'SB', 'Solomon Islands');
insert into aow_country (id, abbrev, country) values (199, 'SO', 'Somalia');
insert into aow_country (id, abbrev, country) values (200, 'ZA', 'South Africa');
insert into aow_country (id, abbrev, country) values (201, 'GS', 'South Georgia South Sandwich Islands');
insert into aow_country (id, abbrev, country) values (202, 'ES', 'Spain');
insert into aow_country (id, abbrev, country) values (203, 'LK', 'Sri Lanka');
insert into aow_country (id, abbrev, country) values (204, 'SH', 'St. Helena');
insert into aow_country (id, abbrev, country) values (205, 'PM', 'St. Pierre and Miquelon');
insert into aow_country (id, abbrev, country) values (206, 'SD', 'Sudan');
insert into aow_country (id, abbrev, country) values (207, 'SR', 'Suriname');
insert into aow_country (id, abbrev, country) values (208, 'SJ', 'Svalbard and Jan Mayen Islands');
insert into aow_country (id, abbrev, country) values (209, 'SZ', 'Swaziland');
insert into aow_country (id, abbrev, country) values (210, 'SE', 'Sweden');
insert into aow_country (id, abbrev, country) values (211, 'CH', 'Switzerland');
insert into aow_country (id, abbrev, country) values (212, 'SY', 'Syrian Arab Republic');
insert into aow_country (id, abbrev, country) values (213, 'TW', 'Taiwan');
insert into aow_country (id, abbrev, country) values (214, 'TJ', 'Tajikistan');
insert into aow_country (id, abbrev, country) values (215, 'TZ', 'Tanzania, United Republic of');
insert into aow_country (id, abbrev, country) values (216, 'TH', 'Thailand');
insert into aow_country (id, abbrev, country) values (217, 'TG', 'Togo');
insert into aow_country (id, abbrev, country) values (218, 'TK', 'Tokelau');
insert into aow_country (id, abbrev, country) values (219, 'TO', 'Tonga');
insert into aow_country (id, abbrev, country) values (220, 'TT', 'Trinidad and Tobago');
insert into aow_country (id, abbrev, country) values (221, 'TN', 'Tunisia');
insert into aow_country (id, abbrev, country) values (222, 'TR', 'Turkey');
insert into aow_country (id, abbrev, country) values (223, 'TM', 'Turkmenistan');
insert into aow_country (id, abbrev, country) values (224, 'TC', 'Turks and Caicos Islands');
insert into aow_country (id, abbrev, country) values (225, 'TV', 'Tuvalu');
insert into aow_country (id, abbrev, country) values (226, 'UG', 'Uganda');
insert into aow_country (id, abbrev, country) values (227, 'UA', 'Ukraine');
insert into aow_country (id, abbrev, country) values (228, 'AE', 'United Arab Emirates');
insert into aow_country (id, abbrev, country) values (229, 'GB', 'United Kingdom');
insert into aow_country (id, abbrev, country) values (230, 'US', 'United States');
insert into aow_country (id, abbrev, country) values (231, 'UM', 'United States minor outlying islands');
insert into aow_country (id, abbrev, country) values (232, 'UY', 'Uruguay');
insert into aow_country (id, abbrev, country) values (233, 'UZ', 'Uzbekistan');
insert into aow_country (id, abbrev, country) values (234, 'VU', 'Vanuatu');
insert into aow_country (id, abbrev, country) values (235, 'VA', 'Vatican City State');
insert into aow_country (id, abbrev, country) values (236, 'VE', 'Venezuela');
insert into aow_country (id, abbrev, country) values (237, 'VN', 'Vietnam');
insert into aow_country (id, abbrev, country) values (238, 'VG', 'Virgin Islands (British)');
insert into aow_country (id, abbrev, country) values (239, 'VI', 'Virgin Islands (U.S.)');
insert into aow_country (id, abbrev, country) values (240, 'WF', 'Wallis and Futuna Islands');
insert into aow_country (id, abbrev, country) values (241, 'EH', 'Western Sahara');
insert into aow_country (id, abbrev, country) values (242, 'YE', 'Yemen');
insert into aow_country (id, abbrev, country) values (243, 'ZR', 'Zaire');
insert into aow_country (id, abbrev, country) values (244, 'ZM', 'Zambia');
insert into aow_country (id, abbrev, country) values (245, 'ZW', 'Zimbabwe');

insert into aow_brand (id, brand) values (1, 'Barefoot');
insert into aow_brand (id, brand) values (2, 'Max''s Favorites');
insert into aow_brand (id, brand) values (3, 'H');
insert into aow_brand (id, brand) values (4, 'Golden Boy');
insert into aow_brand (id, brand) values (5, 'HooKed');
insert into aow_brand (id, brand) values (6, 'My Wine');

insert into aow_type (id, type) values (1, 'White');
insert into aow_type (id, type) values (2, 'Red');
insert into aow_type (id, type) values (3, 'Rose');

insert into aow_sub_type (id, type_id, sub_type) values (1, 1, 'Moscato');
insert into aow_sub_type (id, type_id, sub_type) values (2, 2, 'Merlot');
insert into aow_sub_type (id, type_id, sub_type) values (3, 3, 'Rose');

insert into aow_inventory (id, name, brand_id, user_id, country_id, sub_type_id, volume, year, price, quantity, submitted, description) 
    values (1, 'Barefoot Moscato', 1, 1, 1, 1, 1.5, 2017, 8.99, 5, sysdate, 'It''s good Wine Bront!');
insert into aow_inventory (id, name, brand_id, user_id, country_id, sub_type_id, volume, year, price, quantity, submitted, description) 
    values (2, 'Barefoot Rose', 1, 1, 1, 2, 1.5, 2017, 8.99, 6, sysdate, 'It''s good Wine Bront!');
insert into aow_inventory (id, name, brand_id, user_id, country_id, sub_type_id, volume, year, price, quantity, submitted, description) 
    values (3, 'Barefoot Merlot', 1, 1, 3, 1, 1.5, 2017, 8.99, 100, sysdate, 'It''s good Wine Bront!');

insert into aow_transaction (id, order_number, inventory_id, quantity, user_id, rating, transaction_date, comments) 
    values (1, 1, 1, 1, 2, 1, sysdate, 'Comments? Your wine sucks!');
insert into aow_transaction (id, order_number, inventory_id, quantity, user_id, rating, transaction_date, comments) 
    values (2, 1, 2, 1, 2, 3, sysdate, 'Comments? Your wine sucks!');
insert into aow_transaction (id, order_number, inventory_id, quantity, user_id, rating, transaction_date, comments) 
    values (3, 1, 3, 1, 2, 2, sysdate, 'Comments? Your wine sucks!');

-- Jenn Rocks!