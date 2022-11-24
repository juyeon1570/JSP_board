use aidev;

create table tb_board(
	b_idx int auto_increment primary key,
    b_userid varchar(20) not null,
    b_name varchar(20) not null,
    b_title varchar(100) not null,
    b_content text not null,
    b_hit int default 0,
    b_regdate datetime default now(),
    b_like int default 0
);
insert into tb_board(b_userid, b_name,b_title,b_content) values('apple','김사과','페이지테스트','😊');
create table tb_reply(
	re_idx int auto_increment primary key,
    re_userid varchar(20) not null,
    re_name varchar(20) not null,
    re_content varchar(2000) not null,
    re_regdate datetime default now(),
    re_boardidx int,
    foreign key(re_boardidx) references tb_board(b_idx) on delete cascade
);

create table tb_like(
		li_idx int auto_increment primary key,
        li_boardidx int,
        foreign key(li_boardidx) references tb_board(b_idx) on delete cascade,
        li_userid varchar(20) not null
);
select * from tb_like;
create table tb_hit(
	hit_idx int auto_increment primary key,
    hit_boardidx int,
    foreign key(hit_boardidx) references tb_board(b_idx) on delete cascade,
    hit_userid varchar(20) not null
);


delete from tb_board where b_title='페이지테스트';


select date_format(b_regdate,'%Y-%m-%d') as newF from tb_board;
select * from tb_board;
update tb_board set b_title='hello' , b_content="🍌🍌🍌" where b_idx=2;

delete from tb_board where b_idx=4;

select * from tb_reply;
select count(*) as cnt from tb_reply where re_boardidx=11;

delete from tb_reply where re_name='김사과';

select b_regdate from tb_board where b_idx=1;

select TIMESTAMPDIFF(DAY, (select b_regdate from tb_board where b_idx=1) ,CURDATE())+1 as isNew;
select TIMESTAMPDIFF(DAY,(select b_regdate from tb_board where b_idx=18),now()) as isNew;


SELECT b_idx, b_title, b_userid, b_name, b_hit,b_regdate,b_like  FROM tb_board LIMIT 0, 10;
select * from tb_board order by b_idx desc limit 0,10;






















