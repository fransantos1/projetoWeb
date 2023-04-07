create table usr (
                    usr_id SERIAL not null,
                    usr_name VARCHAR(255) not null,
                    usr_phone VARCHAR(255)not null,
                    usr_email VARCHAR(255) not null,
                    usr_pass varchar(200) not null, 
					usr_token VARCHAR(255),
                    usr_usrtype_id INT not null,
					
                    primary key (usr_id)
);

create table usrtype (
                    usrtype_id SERIAL not null,
                    usrtype_name VARCHAR(255) not null,
                    primary key (usrtype_id)
);

create table rent (
					rent_id SERIAL not null,
					rent_data_inicio date not null,
					rent_data_final date not null,
					rent_car_id INT not null,
					rent_usr_id INT not null,
					rent_rentstate_id INT not null,
					
					primary key (rent_id)
);

create table rentstate (
                    rentstate_id SERIAL not null,
					rentstate_state VARCHAR(255) not null,
                    primary key (rentstate_id)
);
--FALTA O PERCURSO NA RENT !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

create table repair(
                    repair_id SERIAL not null,
                    repair_started date not null,
                    repair_finished date not null,
                    repair_report VARCHAR(2500) not null,--SUBJECT TO CHANGE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                    repair_car_id INT not null,
                    repair_usr_id INT not null,
                    repair_repairtype_id INT not null,
                    primary key (repair_id)
);
create table repairtype(
                    repairtype_id SERIAL not null,
                    repairtype_type VARCHAR(50),
                    primary key (repairtype_id)
);

create table car (
                    car_id SERIAL not null,
                    car_licenseplate VARCHAR(200),
                    car_brand VARCHAR(200),
                    car_model VARCHAR(200),
                    car_year VARCHAR(200);
                    car_engine VARCHAR(200),
                    car_fuel VARCHAR(200),
                    car_gearbox VARCHAR(200),--???????
                    car_drivetrain VARCHAR(200),
                    car_doors VARCHAR(200),
                    car_seats VARCHAR(200),
                    car_bootcapacity VARCHAR(200),
                    car_equi_ext VARCHAR(200),--MIGHT CHANGE TO ANOTHER TABLE  
                    car_priceday VARCHAR(200),
 
                    car_carstate_id INT not null,
                    car_usr_id INT not null,
                    primary key (car_id)
);

create table carservices(
                    carservices_id SERIAL not null,
                    
                    carservices_type VARCHAR(250) not null,
                    carservices_due date not null,

                    carservices_car_id INT not null,
                    primary key (carservices_id)
);



create table carimage (
                    carimage_id SERIAL not null,
                    carimage_link VARCHAR(500) not null,

                    carimage_car_id INT not null,
                    primary key (carimage_id)
); 
create table carstate (
                    carstate_id SERIAL not null,
                    carstate_state VARCHAR(255),
                    primary key (carstate_id)
);



--usr with usr type
alter table usr add constraint usr_fk_usrtype
            foreign key (usr_usrtype_id) references usrtype(usrtype_id) 
			ON DELETE NO ACTION ON UPDATE NO ACTION;

--rent with car
alter table rent add constraint rent_fk_car
            foreign key (rent_car_id) references car(car_id) 
			ON DELETE NO ACTION ON UPDATE NO ACTION;

--rent with rent state
alter table rent add constraint rent_fk_state
            foreign key (rent_rentstate_id) references rentstate(rentstate_id) 
			ON DELETE NO ACTION ON UPDATE NO ACTION;


--repair with user 
alter table rent add constraint rent_fk_usr
            foreign key (rent_usr_id) references usr(usr_id) 
			ON DELETE NO ACTION ON UPDATE NO ACTION;


--repair with car
alter table repair add constraint repair_fk_car
            foreign key (repair_car_id) references car(car_id) 
			ON DELETE NO ACTION ON UPDATE NO ACTION;

--repair with repair type
alter table repair add constraint repair_fk_repairtype
            foreign key (repair_repairtype_id) references repairtype(repairtype_id) 
			ON DELETE NO ACTION ON UPDATE NO ACTION;

--car with user
alter table car add constraint car_fk_usr
            foreign key (car_usr_id) references usr(usr_id) 
			ON DELETE NO ACTION ON UPDATE NO ACTION;

-- car with state
alter table car add constraint car_fk_state
            foreign key (car_carstate_id) references carstate(carstate_id) 
			ON DELETE NO ACTION ON UPDATE NO ACTION;

--car services with car
alter table carservices add constraint carservices_fk_car
            foreign key (carservices_car_id) references car(car_id) 
			ON DELETE NO ACTION ON UPDATE NO ACTION;

--car image with car
alter table carimage add constraint carimage_fk_car
            foreign key (carimage_car_id) references car(car_id) 
			ON DELETE NO ACTION ON UPDATE NO ACTION;