CREATE DATABASE INVENTARIO;
USE INVENTARIO;

CREATE TABLE OPAL(
opal int primary key, 
recompensas int
);

CREATE TABLE SLIME(
slime int primary key,
coinsR int,
slimeR int,
opal int,
foreign key(opal) references OPAL(opal)
);

CREATE TABLE MUMU(
mumu int primary key,
coinsR int,
milk int,
opal int,
foreign key(opal) references OPAL(opal)
);

CREATE TABLE POMPOM(
pompom int primary key,
coinsR int,
opal int,
foreign key(opal) references OPAL(opal)
);

CREATE TABLE ARMAZEM(
armazem int primary key,
opal int,
slime int,
mumu int,
pompom int,
foreign key(opal) references OPAL(opal),
foreign key(slime) references SLIME(slime),
foreign key(mumu) references MUMU(mumu),
foreign key(pompom) references POMPOM(pompom)
);

