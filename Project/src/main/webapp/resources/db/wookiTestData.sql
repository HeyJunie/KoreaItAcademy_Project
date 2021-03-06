DROP TABLE is_reviewed;
DROP TABLE materials;
DROP TABLE user_interest;
DROP TABLE alarm;
DROP TABLE photo;
DROP TABLE review;
DROP TABLE board_qna;
DROP TABLE board_knowhow_tag;
DROP TABLE comments;
DROP TABLE trainer_qna;
DROP TABLE trainer_info;
DROP TABLE scrap;
DROP TABLE tags;
DROP TABLE board_knowhow;
DROP TABLE meeting_participants;
DROP TABLE meeting;
DROP TABLE exercise;
DROP TABLE users;
DROP TABLE location2;
DROP TABLE location1;

DROP SEQUENCE users_seq;
DROP SEQUENCE meeting_seq;
DROP SEQUENCE meeting_participants_seq;
DROP SEQUENCE board_knowhow_seq;
DROP SEQUENCE scrap_seq;
DROP SEQUENCE trainer_qna_seq;
DROP SEQUENCE comments_seq;
DROP SEQUENCE board_knowhow_tag_seq;
DROP SEQUENCE board_qna_seq;
DROP SEQUENCE review_seq;
DROP SEQUENCE trainer_info_seq;
DROP SEQUENCE photo_seq;
DROP SEQUENCE alarm_seq;
DROP SEQUENCE user_interest_seq;
DROP SEQUENCE materials_seq;
DROP SEQUENCE is_reviewed_seq;

-- 테이블 순서는 관계를 고려하여 한 번에 실행해도 에러가 발생하지 않게 정렬되었습니다.
-- SEQUENCE들
CREATE SEQUENCE users_seq
START WITH 1
INCREMENT BY 1
NOCACHE;

CREATE SEQUENCE meeting_seq
START WITH 1
INCREMENT BY 1
NOCACHE;

CREATE SEQUENCE meeting_participants_seq
START WITH 1
INCREMENT BY 1
NOCACHE;

CREATE SEQUENCE board_knowhow_seq
START WITH 1
INCREMENT BY 1
NOCACHE;

CREATE SEQUENCE scrap_seq
START WITH 1
INCREMENT BY 1
NOCACHE;

CREATE SEQUENCE trainer_qna_seq
START WITH 1
INCREMENT BY 1
NOCACHE;

CREATE SEQUENCE comments_seq
START WITH 1
INCREMENT BY 1
NOCACHE;

CREATE SEQUENCE board_knowhow_tag_seq
START WITH 1
INCREMENT BY 1
NOCACHE;

CREATE SEQUENCE board_qna_seq
START WITH 1
INCREMENT BY 1
NOCACHE;

CREATE SEQUENCE review_seq
START WITH 1
INCREMENT BY 1
NOCACHE;

CREATE SEQUENCE trainer_info_seq
START WITH 1
INCREMENT BY 1
NOCACHE;

CREATE SEQUENCE photo_seq
START WITH 1
INCREMENT BY 1
NOCACHE;

CREATE SEQUENCE alarm_seq
START WITH 1
INCREMENT BY 1
NOCACHE;

CREATE SEQUENCE user_interest_seq
START WITH 1
INCREMENT BY 1
NOCACHE;

CREATE SEQUENCE materials_seq
START WITH 1
INCREMENT BY 1
NOCACHE;

CREATE SEQUENCE is_reviewed_seq
START WITH 1
INCREMENT BY 1
NOCACHE;

-- location1 Table Create SQL
CREATE TABLE location1 (
    location1_no      NUMBER          PRIMARY KEY, 
    location1_name    VARCHAR2(30)    NOT NULL
);

-- location2 Table Create SQL
CREATE TABLE location2 (
    location2_no      NUMBER          PRIMARY KEY, 
    location2_name    VARCHAR2(30)    NOT NULL
);

-- users Table Create SQL
CREATE TABLE users (
    user_no            NUMBER           PRIMARY KEY, 
    email              VARCHAR2(50)     UNIQUE NOT NULL, 
    password           VARCHAR2(50)     NOT NULL, 
    user_separator     NUMBER           NOT NULL, 
    created_at         DATE             NOT NULL, 
    last_login         DATE             NULL, 
    login_count        NUMBER           NOT NULL, 
    login_attempt      NUMBER           NOT NULL, 
    disable            NUMBER           NOT NULL, 
    user_reg_method    VARCHAR2(30)     NOT NULL, 
    user_nickname      VARCHAR2(30)     UNIQUE NOT NULL, 
    user_message       VARCHAR2(40)     NULL, 
    profile_photo      VARCHAR2(100)    NULL, 
    birth_year         NUMBER           NULL, 
    birth_month        NUMBER           NULL, 
    birth_day          NUMBER           NULL, 
    location1_no       NUMBER           REFERENCES location1(location1_no) NOT NULL, 
    location2_no       NUMBER           REFERENCES location2(location2_no) NOT NULL
);

-- exercise Table Create SQL
CREATE TABLE exercise (
    exercise_no      NUMBER          PRIMARY KEY, 
    exercise_name    VARCHAR2(30)    UNIQUE NOT NULL
);

-- meeting Table Create SQL
CREATE TABLE meeting (
    meeting_no           NUMBER            PRIMARY KEY, 
    user_no              NUMBER            REFERENCES users(user_no) ON DELETE CASCADE NOT NULL, 
    meeting_max          NUMBER            NOT NULL, 
    meeting_min          NUMBER            NOT NULL, 
    exercise_no          NUMBER            REFERENCES exercise(exercise_no) NOT NULL, 
    created_at           DATE              NOT NULL, 
    start_gather_date    DATE              NOT NULL, 
    end_gather_date      DATE              NOT NULL, 
    meeting_date         DATE              NOT NULL, 
    location1_no         NUMBER            REFERENCES location1(location1_no) NOT NULL, 
    location2_no         NUMBER            REFERENCES location2(location2_no) NOT NULL, 
    meeting_title        VARCHAR2(100)     NOT NULL, 
    meeting_content      VARCHAR2(4000)    NOT NULL, 
    is_progress          NUMBER            NOT NULL, 
    cancel_reason        VARCHAR2(100)     NULL, 
    on_hide              NUMBER            NOT NULL, 
    detail_location      VARCHAR2(100)     NULL, 
    meeting_hit          NUMBER            NOT NULL
);

-- meeting_participants Table Create SQL
CREATE TABLE meeting_participants (
    participants_no    NUMBER           PRIMARY KEY, 
    meeting_no         NUMBER           REFERENCES meeting(meeting_no) ON DELETE CASCADE NOT NULL, 
    user_no            NUMBER           REFERENCES users(user_no) ON DELETE CASCADE NOT NULL, 
    created_at         DATE             NOT NULL, 
    status             NUMBER           NOT NULL, 
    reject_reason      VARCHAR2(100)    NULL
);

-- board_knowhow Table Create SQL
CREATE TABLE board_knowhow (
    knowhow_no         NUMBER            PRIMARY KEY, 
    knowhow_title      VARCHAR2(100)     NOT NULL, 
    knowhow_content    VARCHAR2(4000)    NOT NULL, 
    created_at         DATE              NOT NULL, 
    user_no            NUMBER            REFERENCES users(user_no) ON DELETE CASCADE NOT NULL, 
    user_separator     NUMBER            NOT NULL, 
    on_hide            NUMBER            NOT NULL, 
    knowhow_hit        NUMBER            NOT NULL
);

-- tags Table Create SQL
CREATE TABLE tags (
    tag_no      NUMBER          PRIMARY KEY, 
    tag_name    VARCHAR2(30)    UNIQUE NOT NULL
);

-- scrap Table Create SQL
CREATE TABLE scrap (
    scrap_no            NUMBER  PRIMARY KEY, 
    user_no             NUMBER  REFERENCES users(user_no) ON DELETE CASCADE NOT NULL, 
    scrap_separator     NUMBER  NOT NULL, 
    scrap_referer_no    NUMBER  NOT NULL, 
    scrap_user_no		NUMBER  REFERENCES users(user_no) ON DELETE CASCADE NOT NULL,
    end_gather_date     DATE    NULL, 
    created_at          DATE    NOT NULL
);

-- trainer_info Table Create SQL
CREATE TABLE trainer_info (
    trainer_no              NUMBER            PRIMARY KEY, 
    user_no                 NUMBER            REFERENCES users(user_no) ON DELETE CASCADE UNIQUE NOT NULL, 
    career                  NUMBER            NOT NULL, 
    trainer_name            VARCHAR2(30)      NOT NULL, 
    certificate_filename    VARCHAR2(50)      NOT NULL, 
    employment              VARCHAR2(100)     NOT NULL, 
    profile                 VARCHAR2(2000)    NOT NULL, 
    created_at              DATE              NOT NULL
);

-- trainer_qna Table Create SQL
CREATE TABLE trainer_qna (
    trainer_qna_no          NUMBER            PRIMARY KEY, 
    question_user_no        NUMBER            REFERENCES users(user_no) ON DELETE CASCADE NOT NULL, 
    trainer_user_no         NUMBER            REFERENCES trainer_info(user_no) ON DELETE CASCADE NOT NULL, 
    trainer_qna_title       VARCHAR2(100)     NOT NULL, 
    trainer_qna_content     VARCHAR2(2000)    NOT NULL, 
    created_at              DATE              NOT NULL, 
    is_published            NUMBER            NOT NULL, 
    is_answered             NUMBER            NOT NULL, 
    trainer_qna_answered    varchar2(2000)    NULL, 
    answered_date           DATE              NULL, 
    on_hide                 NUMBER            NOT NULL
);

-- comment Table Create SQL
CREATE TABLE comments (
    comment_no             NUMBER            PRIMARY KEY, 
    comment_referer_sep    NUMBER            NOT NULL, 
    comment_referer_no     NUMBER            NOT NULL,
    board_user_no		   NUMBER			 REFERENCES users(user_no) ON DELETE CASCADE NOT NULL,
    user_no                NUMBER            REFERENCES users(user_no) ON DELETE CASCADE NOT NULL, 
    comment_content        varchar2(1000)    NOT NULL, 
    created_at             DATE              NOT NULL, 
    on_hide                NUMBER            NOT NULL
);

-- board_knowhow_tag Table Create SQL
CREATE TABLE board_knowhow_tag (
    knowhow_tag_no    NUMBER    PRIMARY KEY, 
    knowhow_no        NUMBER    REFERENCES board_knowhow(knowhow_no) ON DELETE CASCADE NOT NULL, 
    tag_no            NUMBER    REFERENCES tags(tag_no) NOT NULL
);

-- board_qna Table Create SQL
CREATE TABLE board_qna (
    board_qna_no         NUMBER            PRIMARY KEY, 
    board_qna_title      VARCHAR2(100)     NOT NULL, 
    board_qna_content    VARCHAR2(4000)    NOT NULL, 
    user_no              NUMBER            REFERENCES users(user_no) ON DELETE CASCADE NOT NULL, 
    created_at           DATE              NOT NULL, 
    is_resolved          NUMBER            NOT NULL, 
    resolved_date        DATE              NULL, 
    on_hide              NUMBER            NOT NULL
);

-- review Table Create SQL
CREATE TABLE review (
    review_no         NUMBER            PRIMARY KEY, 
    target_user_no    NUMBER            REFERENCES users(user_no) ON DELETE CASCADE NOT NULL, 
    score             NUMBER            NOT NULL, 
    meeting_no        NUMBER            REFERENCES meeting(meeting_no) ON DELETE CASCADE NOT NULL, 
    content           VARCHAR2(1000)    NOT NULL, 
    created_at        DATE              NOT NULL, 
    on_hide           NUMBER            NOT NULL, 
    writer_user_no    NUMBER            REFERENCES users(user_no) ON DELETE CASCADE NOT NULL
);

-- photo Table Create SQL
CREATE TABLE photo (
    photo_no             NUMBER           PRIMARY KEY, 
    photo_referer_sep    NUMBER           NOT NULL, 
    photo_referer_no     NUMBER           NOT NULL, 
    user_no				 NUMBER			  REFERENCES users(user_no) ON DELETE CASCADE NOT NULL,
    photo_filename       VARCHAR2(100)    NOT NULL, 
    created_at           DATE             NOT NULL, 
    on_hide              NUMBER           NOT NULL
);

-- alarm Table Create SQL
CREATE TABLE alarm (
    alarm_no            NUMBER           PRIMARY KEY, 
    alarm_separator     NUMBER           NOT NULL, 
    alarm_referer_no    NUMBER           NOT NULL, 
    alarm_content       VARCHAR2(500)    NOT NULL, 
    status              NUMBER           NOT NULL, 
    created_at          DATE             NOT NULL,
    user_no				NUMBER			 REFERENCES users(user_no) ON DELETE CASCADE NOT NULL
);

-- user_interest Table Create SQL
CREATE TABLE user_interest (
    user_interest_no    NUMBER    PRIMARY KEY, 
    user_no             NUMBER    REFERENCES users(user_no) ON DELETE CASCADE NOT NULL, 
    exercise_no         NUMBER    REFERENCES exercise(exercise_no) NOT NULL
);

-- materials Table Create SQL
CREATE TABLE materials (
    materials_no      NUMBER          PRIMARY KEY, 
    meeting_no        NUMBER          REFERENCES meeting(meeting_no) ON DELETE CASCADE NOT NULL, 
    materials_name    VARCHAR2(30)    NOT NULL, 
    created_at        DATE            NOT NULL
);

-- is_reviewed Table Create SQL
CREATE TABLE is_reviewed (
    is_reviewed_no    NUMBER    PRIMARY KEY, 
    meeting_no        NUMBER    REFERENCES meeting(meeting_no) ON DELETE CASCADE NOT NULL, 
    target_user_no    NUMBER    REFERENCES users(user_no) ON DELETE CASCADE NOT NULL, 
    writer_user_no    NUMBER    REFERENCES users(user_no) ON DELETE CASCADE NOT NULL, 
    status            NUMBER    NOT NULL
);

INSERT ALL
-- 태그인덱스
INTO tags (tag_no, tag_name) VALUES (0, '족구')
INTO tags (tag_no, tag_name) VALUES (1, '축구')
INTO tags (tag_no, tag_name) VALUES (2, '농구')
INTO tags (tag_no, tag_name) VALUES (3, '볼링')
INTO tags (tag_no, tag_name) VALUES (4, '크로스핏')
INTO tags (tag_no, tag_name) VALUES (5, '스피닝')
INTO tags (tag_no, tag_name) VALUES (6, '댄스')
INTO tags (tag_no, tag_name) VALUES (7, '요가')
INTO tags (tag_no, tag_name) VALUES (8, '명상')
INTO tags (tag_no, tag_name) VALUES (9, '다이어트정보')
INTO tags (tag_no, tag_name) VALUES (10, '건강정보')
INTO tags (tag_no, tag_name) VALUES (11, '식단정보')
-- 운동인덱스
INTO exercise (exercise_no, exercise_name) VALUES (0, '족구')
INTO exercise (exercise_no, exercise_name) VALUES (1, '축구')
INTO exercise (exercise_no, exercise_name) VALUES (2, '농구')
INTO exercise (exercise_no, exercise_name) VALUES (3, '볼링')
INTO exercise (exercise_no, exercise_name) VALUES (4, '크로스핏')
INTO exercise (exercise_no, exercise_name) VALUES (5, '스피닝')
INTO exercise (exercise_no, exercise_name) VALUES (6, '댄스')
INTO exercise (exercise_no, exercise_name) VALUES (7, '요가')
INTO exercise (exercise_no, exercise_name) VALUES (8, '명상')
-- 지역(시,도) 인덱스
INTO location1 (location1_no, location1_name) VALUES (0, '서울특별시')
INTO location1 (location1_no, location1_name) VALUES (1, '인천광역시')
INTO location1 (location1_no, location1_name) VALUES (2, '경기도')
-- 지역(시,군,구) 인덱스
INTO location2 (location2_no, location2_name) VALUES (0, '강남구')
INTO location2 (location2_no, location2_name) VALUES (1, '강동구')
INTO location2 (location2_no, location2_name) VALUES (2, '강북구')
INTO location2 (location2_no, location2_name) VALUES (3, '강서구')
INTO location2 (location2_no, location2_name) VALUES (4, '관악구')
INTO location2 (location2_no, location2_name) VALUES (5, '광진구')
INTO location2 (location2_no, location2_name) VALUES (6, '구로구')
INTO location2 (location2_no, location2_name) VALUES (7, '금천구')
INTO location2 (location2_no, location2_name) VALUES (8, '노원구')
INTO location2 (location2_no, location2_name) VALUES (9, '도봉구')
INTO location2 (location2_no, location2_name) VALUES (10, '동대문구')
INTO location2 (location2_no, location2_name) VALUES (11, '동작구')
INTO location2 (location2_no, location2_name) VALUES (12, '마포구')
INTO location2 (location2_no, location2_name) VALUES (13, '서대문구')
INTO location2 (location2_no, location2_name) VALUES (14, '서초구')
INTO location2 (location2_no, location2_name) VALUES (15, '성동구')
INTO location2 (location2_no, location2_name) VALUES (16, '성북구')
INTO location2 (location2_no, location2_name) VALUES (17, '송파구')
INTO location2 (location2_no, location2_name) VALUES (18, '양천구')
INTO location2 (location2_no, location2_name) VALUES (19, '영등포구')
INTO location2 (location2_no, location2_name) VALUES (20, '용산구')
INTO location2 (location2_no, location2_name) VALUES (21, '은평구')
INTO location2 (location2_no, location2_name) VALUES (22, '종로구')
INTO location2 (location2_no, location2_name) VALUES (23, '중구')
INTO location2 (location2_no, location2_name) VALUES (24, '중랑구')
INTO location2 (location2_no, location2_name) VALUES (25, '계양구')
INTO location2 (location2_no, location2_name) VALUES (26, '남구')
INTO location2 (location2_no, location2_name) VALUES (27, '남동구')
INTO location2 (location2_no, location2_name) VALUES (28, '동구')
INTO location2 (location2_no, location2_name) VALUES (29, '부평구')
INTO location2 (location2_no, location2_name) VALUES (30, '서구')
INTO location2 (location2_no, location2_name) VALUES (31, '연수구')
INTO location2 (location2_no, location2_name) VALUES (32, '중구')
INTO location2 (location2_no, location2_name) VALUES (33, '강화군')
INTO location2 (location2_no, location2_name) VALUES (34, '옹진군')
INTO location2 (location2_no, location2_name) VALUES (35, '고양시')
INTO location2 (location2_no, location2_name) VALUES (36, '과천시')
INTO location2 (location2_no, location2_name) VALUES (37, '광명시')
INTO location2 (location2_no, location2_name) VALUES (38, '광주시')
INTO location2 (location2_no, location2_name) VALUES (39, '구리시')
INTO location2 (location2_no, location2_name) VALUES (40, '군포시')
INTO location2 (location2_no, location2_name) VALUES (41, '김포시')
INTO location2 (location2_no, location2_name) VALUES (42, '남양주시')
INTO location2 (location2_no, location2_name) VALUES (43, '동두천시')
INTO location2 (location2_no, location2_name) VALUES (44, '부천시')
INTO location2 (location2_no, location2_name) VALUES (45, '성남시')
INTO location2 (location2_no, location2_name) VALUES (46, '수원시')
INTO location2 (location2_no, location2_name) VALUES (47, '시흥시')
INTO location2 (location2_no, location2_name) VALUES (48, '안산시')
INTO location2 (location2_no, location2_name) VALUES (49, '안성시')
INTO location2 (location2_no, location2_name) VALUES (50, '안양시')
INTO location2 (location2_no, location2_name) VALUES (51, '양주시')
INTO location2 (location2_no, location2_name) VALUES (52, '오산시')
INTO location2 (location2_no, location2_name) VALUES (53, '용인시')
INTO location2 (location2_no, location2_name) VALUES (54, '의왕시')
INTO location2 (location2_no, location2_name) VALUES (55, '의정부시')
INTO location2 (location2_no, location2_name) VALUES (56, '이천시')
INTO location2 (location2_no, location2_name) VALUES (57, '파주시')
INTO location2 (location2_no, location2_name) VALUES (58, '평택시')
INTO location2 (location2_no, location2_name) VALUES (59, '포천시')
INTO location2 (location2_no, location2_name) VALUES (60, '하남시')
INTO location2 (location2_no, location2_name) VALUES (61, '화성시')
INTO location2 (location2_no, location2_name) VALUES (62, '가평군')
INTO location2 (location2_no, location2_name) VALUES (63, '양평군')
INTO location2 (location2_no, location2_name) VALUES (64, '여주군')
INTO location2 (location2_no, location2_name) VALUES (65, '연천군')
SELECT * FROM DUAL;

-- 관리자 1, 일반유저 35, 트레이너 3
INSERT INTO USERS values (users_seq.nextval, 'ziziza93@naver.com', 1111, 0, SYSDATE, SYSDATE, 100, 0, 0, 'kakao', '본계정', '관리자입니다', null, null, null, null, 0, 0);
INSERT INTO USERS values (users_seq.nextval, 'admin@letsports.com', 1111, 0, SYSDATE, SYSDATE, 100, 0, 0, 'kakao', '관리자', '관리자입니다', null, null, null, null, 0, 0);
INSERT INTO USERS values (users_seq.nextval, 'user1@letsports.com', 1111, 2, SYSDATE, SYSDATE, 1, 0, 0, 'naver', '메롱', '잘부탁드려요', null, null, null, null, 0, 0);
INSERT INTO USERS values (users_seq.nextval, 'user2@letsports.com', 1111, 2, SYSDATE, SYSDATE, 1, 0, 0, 'kakao', '글쎄요', '잘부탁드려요', null, null, null, null, 0, 0);
INSERT INTO USERS values (users_seq.nextval, 'user3@letsports.com', 1111, 2, SYSDATE, SYSDATE, 1, 0, 0, 'naver', '접니다', '잘부탁드려요', null, null, null, null, 0, 0);
INSERT INTO USERS values (users_seq.nextval, 'user4@letsports.com', 1111, 2, SYSDATE, SYSDATE, 1, 0, 0, 'google', '운동마니아', '잘부탁드려요', null, null, null, null, 0, 0);
INSERT INTO USERS values (users_seq.nextval, 'user5@letsports.com', 1111, 2, SYSDATE, SYSDATE, 1, 0, 0, 'facebook', '농구조아', '잘부탁드려요', null, null, null, null, 0, 0);
INSERT INTO USERS values (users_seq.nextval, 'user6@letsports.com', 1111, 2, SYSDATE, SYSDATE, 1, 0, 0, 'local', '야구만세', '잘부탁드려요', null, null, null, null, 0, 0);
INSERT INTO USERS values (users_seq.nextval, 'user7@letsports.com', 1111, 2, SYSDATE, SYSDATE, 1, 0, 0, 'naver', '신난당', '잘부탁드려요', null, null, null, null, 0, 0);
INSERT INTO USERS values (users_seq.nextval, 'user8@letsports.com', 1111, 2, SYSDATE, SYSDATE, 1, 0, 0, 'kakao', '나니고레', '잘부탁드려요', null, null, null, null, 0, 0);
INSERT INTO USERS values (users_seq.nextval, 'user9@letsports.com', 1111, 2, SYSDATE, SYSDATE, 1, 0, 0, 'naver', '무슨서비스지', '잘부탁드려요', null, null, null, null, 0, 0);
INSERT INTO USERS values (users_seq.nextval, 'user10@letsports.com', 1111, 2, SYSDATE, SYSDATE, 1, 0, 0, 'google', '심심해', '잘부탁드려요', null, null, null, null, 0, 0);
INSERT INTO USERS values (users_seq.nextval, 'user11@letsports.com', 1111, 2, SYSDATE, SYSDATE, 1, 0, 0, 'facebook', '머슬킹', '잘부탁드려요', null, null, null, null, 0, 0);
INSERT INTO USERS values (users_seq.nextval, 'user12@letsports.com', 1111, 2, SYSDATE, SYSDATE, 1, 0, 0, 'local', '머슬마니아', '잘부탁드려요', null, null, null, null, 0, 0);
INSERT INTO USERS values (users_seq.nextval, 'user13@letsports.com', 1111, 2, SYSDATE, SYSDATE, 1, 0, 0, 'naver', '술술마니아', '잘부탁드려요', null, null, null, null, 0, 0);
INSERT INTO USERS values (users_seq.nextval, 'user14@letsports.com', 1111, 2, SYSDATE, SYSDATE, 1, 0, 0, 'kakao', '머술쓰', '잘부탁드려요', null, null, null, null, 0, 0);
INSERT INTO USERS values (users_seq.nextval, 'user15@letsports.com', 1111, 2, SYSDATE, SYSDATE, 1, 0, 0, 'naver', '마님하이', '잘부탁드려요', null, null, null, null, 0, 0);
INSERT INTO USERS values (users_seq.nextval, 'user16@letsports.com', 1111, 2, SYSDATE, SYSDATE, 1, 0, 0, 'google', '마늘맨', '잘부탁드려요', null, null, null, null, 0, 0);
INSERT INTO USERS values (users_seq.nextval, 'user17@letsports.com', 1111, 2, SYSDATE, SYSDATE, 1, 0, 0, 'facebook', '당근맨', '잘부탁드려요', null, null, null, null, 0, 0);
INSERT INTO USERS values (users_seq.nextval, 'user18@letsports.com', 1111, 2, SYSDATE, SYSDATE, 1, 0, 0, 'local', '당근좋아', '잘부탁드려요', null, null, null, null, 0, 0);
INSERT INTO USERS values (users_seq.nextval, 'user19@letsports.com', 1111, 2, SYSDATE, SYSDATE, 1, 0, 0, 'naver', '가지좋아', '잘부탁드려요', null, null, null, null, 0, 0);
INSERT INTO USERS values (users_seq.nextval, 'user20@letsports.com', 1111, 2, SYSDATE, SYSDATE, 1, 0, 0, 'kakao', '씐난다', '잘부탁드려요', null, null, null, null, 0, 0);
INSERT INTO USERS values (users_seq.nextval, 'user21@letsports.com', 1111, 2, SYSDATE, SYSDATE, 1, 0, 0, 'naver', 'kinggu', '잘부탁드려요', null, null, null, null, 0, 0);
INSERT INTO USERS values (users_seq.nextval, 'user22@letsports.com', 1111, 2, SYSDATE, SYSDATE, 1, 0, 0, 'google', '캥거루맨', '잘부탁드려요', null, null, null, null, 0, 0);
INSERT INTO USERS values (users_seq.nextval, 'user23@letsports.com', 1111, 2, SYSDATE, SYSDATE, 1, 0, 0, 'facebook', '캉캉이', '잘부탁드려요', null, null, null, null, 0, 0);
INSERT INTO USERS values (users_seq.nextval, 'user24@letsports.com', 1111, 2, SYSDATE, SYSDATE, 1, 0, 0, 'local', '좋아요', '잘부탁드려요', null, null, null, null, 0, 0);
INSERT INTO USERS values (users_seq.nextval, 'user25@letsports.com', 1111, 2, SYSDATE, SYSDATE, 1, 0, 0, 'naver', '그냥좋아', '잘부탁드려요', null, null, null, null, 0, 0);
INSERT INTO USERS values (users_seq.nextval, 'user26@letsports.com', 1111, 2, SYSDATE, SYSDATE, 1, 0, 0, 'kakao', '울지마', '잘부탁드려요', null, null, null, null, 0, 0);
INSERT INTO USERS values (users_seq.nextval, 'user27@letsports.com', 1111, 2, SYSDATE, SYSDATE, 1, 0, 0, 'naver', '슬퍼하쥐망', '잘부탁드려요', null, null, null, null, 0, 0);
INSERT INTO USERS values (users_seq.nextval, 'user28@letsports.com', 1111, 2, SYSDATE, SYSDATE, 1, 0, 0, 'google', '운동하자', '잘부탁드려요', null, null, null, null, 0, 0);
INSERT INTO USERS values (users_seq.nextval, 'user29@letsports.com', 1111, 2, SYSDATE, SYSDATE, 1, 0, 0, 'facebook', '같이할래', '잘부탁드려요', null, null, null, null, 0, 0);
INSERT INTO USERS values (users_seq.nextval, 'user30@letsports.com', 1111, 2, SYSDATE, SYSDATE, 1, 0, 0, 'local', '같이하자구', '잘부탁드려요', null, null, null, null, 0, 0);
INSERT INTO USERS values (users_seq.nextval, 'user31@letsports.com', 1111, 2, SYSDATE, SYSDATE, 1, 0, 0, 'naver', '같이해용', '잘부탁드려요', null, null, null, null, 0, 0);
INSERT INTO USERS values (users_seq.nextval, 'user32@letsports.com', 1111, 2, SYSDATE, SYSDATE, 1, 0, 0, 'kakao', '하기시러', '잘부탁드려요', null, null, null, null, 0, 0);
INSERT INTO USERS values (users_seq.nextval, 'user33@letsports.com', 1111, 2, SYSDATE, SYSDATE, 1, 0, 0, 'kakao', '나는조타', '잘부탁드려요', null, null, null, null, 0, 0);
INSERT INTO USERS values (users_seq.nextval, 'user34@letsports.com', 1111, 2, SYSDATE, SYSDATE, 1, 0, 0, 'local', '나는실타', '잘부탁드려요', null, null, null, null, 0, 0);
INSERT INTO USERS values (users_seq.nextval, 'user35@letsports.com', 1111, 2, SYSDATE, SYSDATE, 1, 0, 0, 'naver', '굿굿맨', '잘부탁드려요', null, null, null, null, 0, 0);
INSERT INTO USERS values (users_seq.nextval, 'trainer1@letsports.com', 1111, 1, SYSDATE, SYSDATE, 1, 0, 0, 'naver', '쫑트', '잘부탁드려요', null, null, null, null, 0, 0);
INSERT INTO USERS values (users_seq.nextval, 'trainer2@letsports.com', 1111, 1, SYSDATE, SYSDATE, 1, 0, 0, 'kakao', '킹트', '잘부탁드려요', null, null, null, null, 0, 0);
INSERT INTO USERS values (users_seq.nextval, 'trainer3@letsports.com', 1111, 1, SYSDATE, SYSDATE, 1, 0, 0, 'naver', '홍트', '잘부탁드려요', null, null, null, null, 0, 0);
INSERT INTO trainer_info values (trainer_info_seq.nextval, 38, 1, '강철종', '트레이너자격증', '신촌센터', '안녕하세요. 반갑습니다. 잘부탁드립니다.', SYSDATE);
INSERT INTO trainer_info values (trainer_info_seq.nextval, 39, 7, '김갑수', '트레이너자격증', '영등포센터', '안녕하세요. 반갑습니다. 잘부탁드립니다.', SYSDATE);
INSERT INTO trainer_info values (trainer_info_seq.nextval, 40, 10, '홍백현', '트레이너자격증', '강남센터', '안녕하세요. 반갑습니다. 잘부탁드립니다.', SYSDATE);

-- 모임3 / 게시글12 / 15질문과답변
INSERT INTO MEETING values (meeting_seq.nextval, 1, 10, 6, 0, SYSDATE, SYSDATE, SYSDATE, SYSDATE, 0, 1, '족구합시다.', '족구하면 얼마나 좋게요~!? 다같이 합시다.', 0, null, 0, null, 0);
INSERT INTO board_knowhow VALUES (board_knowhow_seq.nextval, '하하하하', '이러쿵저러ㅇ쿵', SYSDATE, 1, 0, 0, 0);
INSERT INTO board_qna VALUES (board_qna_seq.nextval, '도움을 주세요', '내용ㅇㅇㅇ', 15, SYSDATE, 0, NULL, 0);
INSERT INTO board_qna VALUES (board_qna_seq.nextval, '으아아아 살려주세요', '내용ㅇㅇㅇ', 14, SYSDATE, 0, NULL, 0);
INSERT INTO board_knowhow VALUES (board_knowhow_seq.nextval, '저건저겁니다', '이러쿵저러ㅇ쿵', SYSDATE, 3, 2, 0, 0);
INSERT INTO MEETING values (meeting_seq.nextval, 2, 8, 4, 3, SYSDATE, SYSDATE, SYSDATE, SYSDATE, 0, 1, '볼링합시다.', '볼링하면 얼마나 좋게요~!? 다같이 합시다.', 0, null, 0, null, 0);
INSERT INTO board_knowhow VALUES (board_knowhow_seq.nextval, '아시겠어요?', '이러쿵저러ㅇ쿵', SYSDATE, 4, 2, 0, 0);
INSERT INTO board_knowhow VALUES (board_knowhow_seq.nextval, '넹', '이러쿵저러ㅇ쿵', SYSDATE, 40, 1, 0, 0);
INSERT INTO board_qna VALUES (board_qna_seq.nextval, '오늘저녁은 뭐죠', '내용ㅇㅇㅇ', 3, SYSDATE, 0, NULL, 0);
INSERT INTO board_knowhow VALUES (board_knowhow_seq.nextval, '그랬구나', '이러쿵저러ㅇ쿵', SYSDATE, 38, 1, 0, 0);
INSERT INTO board_qna VALUES (board_qna_seq.nextval, '어제 뭐먹었어요', '내용ㅇㅇㅇ', 4, SYSDATE, 0, NULL, 0);
INSERT INTO board_knowhow VALUES (board_knowhow_seq.nextval, '알았어요', '이러쿵저러ㅇ쿵', SYSDATE, 39, 1, 0, 0);
INSERT INTO board_qna VALUES (board_qna_seq.nextval, '내일 뭐해요?', '내용ㅇㅇㅇ', 6, SYSDATE, 0, NULL, 0);
INSERT INTO board_qna VALUES (board_qna_seq.nextval, '오늘 공부할거에요?', '내용ㅇㅇㅇ', 5, SYSDATE, 0, NULL, 0);
INSERT INTO board_knowhow VALUES (board_knowhow_seq.nextval, '놀까말까', '이러쿵저러ㅇ쿵', SYSDATE, 8, 2, 0, 0);
INSERT INTO board_qna VALUES (board_qna_seq.nextval, '심심한가요?', '내용ㅇㅇㅇ', 5, SYSDATE, 0, NULL, 0);
INSERT INTO MEETING values (meeting_seq.nextval, 3, 12, 10, 1, SYSDATE, SYSDATE, SYSDATE, SYSDATE, 0, 1, '축구합시다.', '축구하면 얼마나 좋게요~!? 다같이 합시다.', 0, null, 0, null, 0);
INSERT INTO board_qna VALUES (board_qna_seq.nextval, '이건 뭐ㅔ요?', '내용ㅇㅇㅇ', 5, SYSDATE, 0, NULL, 0);
INSERT INTO board_qna VALUES (board_qna_seq.nextval, '놀곳 알려주세요', '내용ㅇㅇㅇ', 4, SYSDATE, 0, NULL, 0);
INSERT INTO board_knowhow VALUES (board_knowhow_seq.nextval, '그렇구나', '이러쿵저러ㅇ쿵', SYSDATE, 9, 2, 0, 0);
INSERT INTO board_qna VALUES (board_qna_seq.nextval, '다이어트 방법 알려주세요', '내용ㅇㅇㅇ', 3, SYSDATE, 0, NULL, 0);
INSERT INTO board_knowhow VALUES (board_knowhow_seq.nextval, '이야야아아아아', '이러쿵저러ㅇ쿵', SYSDATE, 7, 2, 0, 0);
INSERT INTO board_knowhow VALUES (board_knowhow_seq.nextval, '나는천재다', '이러쿵저러ㅇ쿵', SYSDATE, 6, 2, 0, 0);
INSERT INTO board_qna VALUES (board_qna_seq.nextval, '어떻게해야하죠', '내용ㅇㅇㅇ', 8, SYSDATE, 0, NULL, 0);
INSERT INTO board_qna VALUES (board_qna_seq.nextval, '질문게시판이죠?', '내용ㅇㅇㅇ', 33, SYSDATE, 0, NULL, 0);
INSERT INTO board_knowhow VALUES (board_knowhow_seq.nextval, '이건이거고', '이러쿵저러ㅇ쿵', SYSDATE, 2, 0, 0, 0);
INSERT INTO board_qna VALUES (board_qna_seq.nextval, '거기 119인가요?', '내용ㅇㅇㅇ', 23, SYSDATE, 0, NULL, 0);
INSERT INTO board_qna VALUES (board_qna_seq.nextval, '경찰아저씨 도와주세요', '내용ㅇㅇㅇ', 21, SYSDATE, 0, NULL, 0);
INSERT INTO board_knowhow VALUES (board_knowhow_seq.nextval, '후후후후후', '이러쿵저러ㅇ쿵', SYSDATE, 5, 2, 0, 0);
INSERT INTO board_qna VALUES (board_qna_seq.nextval, '살려주세요', '내용ㅇㅇㅇ', 22, SYSDATE, 0, NULL, 0);

-- 댓글 65개
INSERT INTO comments VALUES (comments_seq.nextval, 1, 14, 21, 29, '하였으며, 있으며, 이상이 우는 생의 얼마나 인류의 운다. 용감하고 쓸쓸한 우리 인간의 일월과 두손을 생명을 것이다. 끓는 할지라도 너의 새 청춘을 꾸며 많이 그들에게 그리하였는가? 따뜻한 이상의 끓는 이성은 작고 듣는다. 그들은 유소년에게서 곳으로 살았으며, 갑 이것이다.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 0, 5, 38, 20, '뛰노는 얼음에 끓는 목숨을 살았으며, 이상의 길지 예가 없는 보라. 청춘의 그들은 것은 얼마나 풍부하게 얼음에 때문이다. 돋고, 보이는 끓는 눈에 이상이 이 사람은 봄바람이다. 피고 긴지라 소금이라 가지에 하는 쓸쓸하랴? 천하를 하여도 어디 거선의 쓸쓸하랴?', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 1, 12, 33, 11, '속에 구할 따뜻한 얼마나 끓는다. 찾아다녀도, 두기 수 그리하였는가? 피는 얼음에 이것이야말로 천고에 그와 행복스럽고 운다. 같이, 많이 그들은 고동을 보이는 원질이 거친 영락과 생의 보라. 보내는 뼈 그들은 끓는 가는 원대하고, 피에 뭇 꽃이 피다. 석가는 고행을 이상 이것은 미묘한 교향악이다. 군영과 피는 가는 것이다.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 1, 9, 4, 4, '이상의 반짝이는 영락과 황금시대다. 천고에 인류의 구하기 작고 가치를 생의 과실이 봄바람이다. 품에 현저하게 웅대한 있다. 없으면 안고, 가치를 바이며, 사는가 이것이다. 끓는 얼마나 얼음 있는 설레는 광야에서 생생하며, 같이, 그들을 황금시대다. 방지하는 예가 봄날의 산야에 발휘하기 청춘의 그림자는 오직 때문이다. 같은 위하여 실로 생생하며, 끓는다.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 1, 12, 33, 16, '시들어 그러므로 대고, 평화스러운 생생하며, 청춘에서만 그들의 약동하다. 속잎나고, 희망의 그들에게 따뜻한 굳세게 천고에 청춘에서만 날카로우나 그리하였는가? 그러므로 풀이 때까지 이상은 두기 그들은 철환하였는가? 실로 사랑의 영락과 더운지라 힘차게 목숨이 이상을 사막이다. 이것은 같이 사람은 부패뿐이다. 주는 없으면 대중을 풀밭에 속에서 위하여서 만물은 사막이다. 봄날의 이상이 천자만홍이 보이는 이상 그들의 만물은 수 그리하였는가?', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 2, 1, 1, 12, '심장의 우리 거친 수 방지하는 내는 우리의 천지는 웅대한 봄바람이다. 피어나기 위하여서 청춘에서만 수 반짝이는 인생을 구하기 기관과 사는가 봄바람이다. 용기가 대한 풍부하게 힘차게 피다. 두기 오아이스도 인간이 고동을 하는 인간의 있는 이 영락과 칼이다. 가는 오아이스도 스며들어 별과 청춘의 피어나기 소담스러운 품으며, 따뜻한 것이다.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 1, 9, 4, 30, '끓는 인생을 열락의 무엇을 있을 뼈 보이는 사막이다. 인도하겠다는 온갖 가진 피에 이것이다. 꽃 살았으며, 웅대한 눈이 거친 있는 현저하게 우리 온갖 것이다. 온갖 밥을 간에 인생에 이상의 우리 것이다. 피어나기 오아이스도 이상, 천지는 피고 돋고, 설산에서 피가 때에, 철환하였는가? 우리 불어 열락의 봄바람이다.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 1, 2, 14, 27, '풍부하게 피부가 청춘의 두손을 위하여 때까지 전인 끝에 위하여, 부패뿐이다. 가치를 이 길을 위하여, 생생하며, 수 가슴이 위하여서, 뿐이다. 옷을 찬미를 커다란 넣는 있으랴? 이상의 장식하는 우리는 인생의 것은 석가는 구하기 끓는 아니다. 하였으며, 그들은 그들은 위하여서 뛰노는 인생의 피어나는 품에 전인 있는가? 이상 이것을 관현악이며, 그러므로 품고 내는 낙원을 쓸쓸하랴? 대한 봄바람을 동산에는 심장은 교향악이다.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 0, 5, 38, 40, '바로 공자는 인생에 무엇이 위하여 듣기만 하여도 간에 그들은 것이다. 뛰노는 만천하의 가장 인간이 별과 꾸며 할지니, 청춘에서만 이상을 쓸쓸하랴? 얼마나 사라지지 그들의 길을 모래뿐일 힘차게 피어나는 행복스럽고 꾸며 철환하였는가? 얼마나 모래뿐일 얼마나 사막이다. 무한한 목숨을 않는 굳세게 이상, 바로 말이다. 속에 용기가 목숨을 가치를 구하지 원대하고, 사는가 보라. 것은 생생하며, 없으면 뜨고, 품으며, 이것이다.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 1, 2, 14, 15, '때에, 같이 시들어 과실이 것은 칼이다. 커다란 뛰노는 끓는 뜨거운지라, 많이 피다. 행복스럽고 고동을 이상의 보라. 스며들어 보내는 끝까지 이상의 이상을 영락과 것이다. 얼음에 만물은 살 있다. 유소년에게서 크고 있을 웅대한 때문이다.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 2, 1, 1, 32, '군영과 용기가 가치를 곳으로 투명하되 이것은 수 피는 그들은 보라. 가지에 투명하되 그것을 인생을 창공에 황금시대다. 몸이 것이다.보라, 없으면, 것이다. 구하기 길을 심장의 것이다. 오직 심장은 청춘 피어나는 그들에게 목숨이 이것이다.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 0, 3, 4, 3, '위하여, 위하여 뼈 가지에 위하여 품고 것이다. 품었기 설레는 그들의 부패를 피가 속잎나고, 위하여서. 같으며, 불어 그들은 간에 것이다. 그들은 우리 뜨거운지라, 실로 심장의 뿐이다. 피고, 전인 얼마나 품었기 오아이스도 뿐이다. 거친 소금이라 이는 미인을 간에 목숨을 듣기만 아름다우냐? 그들의 어디 심장은 쓸쓸한 군영과 청춘이 이것이다.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 1, 2, 14, 8, '따뜻한 동력은 않는 낙원을 그들의 철환하였는가? 있으며, 인간이 것은 싹이 이상은 끝에 예수는 있으랴? 같이, 노래하며 예수는 못하다 힘있다. 보이는 돋고, 청춘 있는 고행을 이것이야말로 맺어, 아름답고 이상은 있다. 것은 청춘의 넣는 위하여 우리 피다. 고행을 우리는 보이는 싹이 길을 목숨을 꽃이 그리하였는가? 이상 이상의 얼마나 두기 할지라도 찾아다녀도, 광야에서 있는가?', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 1, 14, 21, 37, '같이, 때에, 얼마나 불러 사막이다. 온갖 피에 청춘에서만 있다. 군영과 그들에게 있는 이것은 온갖 귀는 뜨고, 뛰노는 것이다. 오아이스도 없는 예수는 이 것이다. 싹이 인생의 고행을 심장의 피다.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 0, 8, 9, 24, '무엇이 하였으며, 붙잡아 인간은 이상, 풀밭에 끓는 부패뿐이다. 든 뭇 청춘을 인생에 평화스러운 봄바람이다. 천고에 두기 위하여서, 산야에 청춘 어디 청춘의 가지에 그들은 있으랴? 온갖 인생에 귀는 것이다. 노래하며 황금시대의 이것이야말로 고동을 되려니와, 것이다. 황금시대를 그들에게 그러므로 그들은 예수는 과실이 얼마나 끓는 힘있다.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 0, 3, 4, 13, '아름답고 못할 이상 사막이다. 이는 속잎나고, 곳으로 주며, 끓는다. 봄날의 주는 용감하고 반짝이는 부패뿐이다. 있는 노년에게서 트고, 방지하는 안고, 그들은 풀밭에 되려니와, 그들의 것이다. 이상의 두손을 위하여서, 노래하며 이는 있는가?', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 1, 9, 4, 31, '역사를 어디 그들의 천자만홍이 같이, 얼음 보라. 살았으며, 내려온 영락과 광야에서 불어 사막이다. 남는 얼음과 따뜻한 가슴이 곳이 되려니와, 것이다. 튼튼하며, 풀이 반짝이는 때까지 교향악이다. 꾸며 것이 뭇 영원히 보는 품으며, 같은 풍부하게 위하여, 봄바람이다.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 1, 2, 14, 21, '그들은 바이며, 보이는 천지는 불러 현저하게 천고에 열락의 피가 아름다우냐? 모래뿐일 날카로우나 가는 피가 그들의 봄바람이다. 동력은 충분히 귀는 시들어 뿐이다. 목숨이 그들의 때에, 노래하며 피어나기 것이다. 거친 미묘한 희망의 날카로우나 심장의 위하여서. 원질이 얼음 우리 끝까지 낙원을 이 영원히 하는 끓는다.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 0, 10, 6, 3, '피에 사라지지 사는가 위하여 물방아 인간이 약동하다. 뜨거운지라, 같으며, 위하여 되는 인생에 사막이다. 되는 수 든 있는 옷을 이상은 이상, 부패뿐이다. 것은 용감하고 피에 무엇을 뜨고, 것이다. 그들의 유소년에게서 우리는 우리 보이는 듣는다. 보는 생의 이상의 속에 미묘한 피고 무엇이 만천하의 낙원을 운다. 쓸쓸한 안고, 싶이 역사를 어디 목숨을 따뜻한 꾸며 사막이다.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 1, 2, 14, 21, '할지라도 피는 피가 트고, 이상의 위하여, 황금시대를 것이다. 것은 생명을 싹이 보내는 앞이 이상을 더운지라 풀이 이것이다. 타오르고 없으면 가진 것이다. 싶이 인간의 그들의 꽃이 내려온 원질이 무엇을 이상이 쓸쓸하랴? 가지에 그들의 천하를 이상은 그들에게 칼이다. 두손을 부패를 찾아 사랑의 위하여, 날카로우나 아름답고 능히 위하여서.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 1, 14, 21, 35, '얼마나 일월과 공자는 가진 주는 불어 뼈 시들어 봄바람이다. 못할 열매를 청춘에서만 이는 가지에 아니한 얼마나 놀이 이상을 피다. 가치를 보이는 방황하였으며, 관현악이며, 능히 바이며, 아니더면, 끓는 위하여서, 봄바람이다. 귀는 동산에는 청춘의 꾸며 어디 하는 봄날의 피다. 눈에 봄바람을 피에 이 때문이다.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 0, 1, 1, 26, '구하기 만물은 이상 그들을 아니한 그들은 많이 기관과 이는 교향악이다. 가치를 못할 인생의 길지 천고에 커다란 싶이 끝까지 쓸쓸하랴? 그들에게 청춘의 얼마나 아니다. 낙원을 따뜻한 맺어, 하는 무한한 없는 이상, 아름다우냐? 꽃이 어디 내려온 노래하며 철환하였는가?', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 0, 5, 38, 24, '같이, 거선의 천하를 봄바람이다. 옷을 꽃 주는 우는 전인 눈에 목숨이 두손을 운다. 이상이 튼튼하며, 속잎나고, 얼마나 바이며, 넣는 보라. 긴지라 인생에 피에 전인 돋고, 뿐이다. 이상이 커다란 관현악이며, 아름다우냐? 맺어, 사람은 남는 실로 불어 인도하겠다는 불러 전인 사막이다.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 1, 14, 21, 16, '붙잡아 우리 별과 동력은 구하지 것이다. 과실이 소리다.이것은 없으면 뛰노는 피가 소금이라 낙원을 무엇을 없는 사막이다. 많이 우리의 그들에게 내려온 것이다. 인생의 내는 행복스럽고 교향악이다. 옷을 내려온 방지하는 교향악이다.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 2, 1, 1, 20, '안고, 끓는 가치를 우리 트고, 크고 얼음 때문이다. 일월과 오직 천자만홍이 구하지 때까지 어디 황금시대의 사람은 보배를 끓는다. 우리 방지하는 풍부하게 봄바람이다. 이것은 사라지지 어디 그들은 동력은 청춘이 자신과 황금시대를 것이다. 노년에게서 하였으며, 사라지지 곳이 있는 무엇이 심장은 동산에는 있다. 거친 청춘의 품으며, 것이다. 부패를 방황하여도, 인류의 황금시대다.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 0, 1, 1, 9, '창공에 관현악이며, 일월과 따뜻한 노래하며 같으며, 이것을 그들은 봄바람이다. 그들은 가는 뛰노는 우리 사람은 있는 못할 따뜻한 두기 사막이다. 뭇 하는 않는 대중을 석가는 지혜는 위하여, 불어 가는 사막이다. 착목한는 그들은 불어 오직 있으며, 피가 있으랴? 인생을 보이는 심장의 찬미를 철환하였는가? 동산에는 가치를 풍부하게 새가 보는 너의 실현에 밥을 아름다우냐? 것은 군영과 속잎나고, 속에서 광야에서 우리의 우리의 영락과 용기가 것이다.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 1, 12, 33, 34, '평화스러운 투명하되 위하여 말이다. 청춘의 얼음에 별과 노래하며 방지하는 있는 두기 교향악이다. 있음으로써 눈이 무엇이 끓는 인간은 찾아다녀도, 풀이 어디 듣는다. 품으며, 보이는 청춘의 눈이 같이 속잎나고, 그들의 이상은 기관과 아니다. 광야에서 풀이 인생을 위하여서 것이다.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 1, 12, 33, 33, '피가 때에, 할지니, 크고 있으랴? 있는 넣는 이상은 방황하였으며, 대고, 없으면, 이상을 약동하다. 기쁘며, 인생에 생명을 황금시대의 실현에 것이다. 하는 불러 하였으며, 황금시대를 뭇 위하여 봄바람을 과실이 그들의 철환하였는가? 소리다.이것은 가는 같으며, 만물은 방황하였으며, 품으며, 밝은 귀는 바로 그리하였는가? 그와 창공에 가치를 별과 내려온 부패뿐이다. 대한 따뜻한 그들에게 불러 대중을 많이 속잎나고, 있는 쓸쓸하랴?', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 1, 6, 5, 12, '원질이 너의 못할 우리의 이성은 인간의 창공에 현저하게 그들의 것이다. 이상 우리의 속에 군영과 피고 얼음 바로 품고 천자만홍이 철환하였는가? 풍부하게 위하여, 몸이 교향악이다. 위하여 풀이 가는 구하지 철환하였는가? 우리 청춘 만물은 피부가 위하여, 용기가 우는 긴지라 청춘 아름다우냐? 시들어 공자는 가는 끝까지 할지니, 역사를 불어 거친 위하여 약동하다.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 1, 12, 33, 36, '대한 힘차게 이상을 오직 곳이 인간은 긴지라 운다. 황금시대의 피어나는 못할 지혜는 있으랴? 인간의 이상을 기관과 것이다. 싶이 목숨이 인도하겠다는 이상의 영원히 이것이다. 있음으로써 인간은 소담스러운 위하여 끓는다.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 0, 11, 2, 6, '그것을 현저하게 반짝이는 우리 끓는 보배를 같으며, 타오르고 붙잡아 말이다. 고동을 웅대한 아름답고 발휘하기 힘차게 것이다. 황금시대를 목숨을 심장은 하는 만물은 듣는다. 불어 하였으며, 풀이 따뜻한 두기 찾아 같은 시들어 사막이다. 가치를 인도하겠다는 얼마나 이상을 내려온 귀는 인생을 현저하게 칼이다. 그것을 용기가 많이 소리다.이것은 그들에게 쓸쓸하랴? 있는 청춘의 같이, 길을 철환하였는가?', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 1, 9, 4, 17, '수 없으면, 이상의 같이 교향악이다. 인생에 길을 풀밭에 꽃이 우리 없는 피가 못할 뜨거운지라, 황금시대다. 피가 기관과 생명을 자신과 동력은 오아이스도 교향악이다. 뜨고, 뼈 얼마나 행복스럽고 청춘에서만 튼튼하며, 우는 싶이 새가 봄바람이다. 같은 사람은 이 품에 풀이 심장은 작고 봄바람이다. 고행을 할지라도 피에 있음으로써 가치를 바이며, 기쁘며, 이상, 방황하였으며, 봄바람이다. 가장 품고 고행을 가는 할지니, 창공에 아름답고 심장의 그리하였는가?', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 0, 5, 38, 19, '어디 너의 청춘에서만 가치를 소리다.이것은 위하여서. 청춘에서만 가치를 인간의 새가 힘차게 심장은 지혜는 구하지 소리다.이것은 것이다. 생생하며, 하는 예가 같은 철환하였는가? 청춘의 그들의 같으며, 아름다우냐? 고행을 천지는 품으며, 있음으로써 끓는 뛰노는 때문이다. 어디 때에, 미인을 이것이다.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 1, 14, 21, 17, '과실이 그들의 예수는 그것을 미묘한 꽃이 이것이다. 불어 날카로우나 이성은 거친 귀는 두기 방황하여도, 따뜻한 듣는다. 가슴이 하여도 날카로우나 만천하의 불어 발휘하기 끓는다. 피어나는 풍부하게 끓는 것이다. 미인을 하여도 기관과 뜨고, 이상의 교향악이다. 따뜻한 든 관현악이며, 속잎나고, 길지 무엇을 낙원을 것이다. 어디 꽃이 그와 듣기만 것은 이것이야말로 갑 있다.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 2, 2, 2, 25, '열락의 그들은 싶이 설레는 같은 있음으로써 무엇을 피가 타오르고 것이다. 있을 미인을 아니더면, 봄바람이다. 거선의 뜨거운지라, 위하여서 봄바람을 인생을 영락과 있음으로써 옷을 것이다. 우리는 웅대한 청춘의 있으랴? 때에, 만물은 쓸쓸한 기쁘며, 이는 있을 품고 것이다. 예가 위하여서 소담스러운 길지 때까지 구할 품에 있다. 곧 그것은 전인 위하여서.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 1, 9, 4, 7, '고행을 미묘한 눈에 이성은 이상의 예수는 있으며, 생생하며, 않는 힘있다. 같지 원질이 무엇을 새 가장 부패뿐이다. 않는 천하를 할지니, 불어 보이는 살았으며, 뿐이다. 튼튼하며, 크고 피고, 황금시대다. 따뜻한 이상의 기관과 웅대한 것이다. 그림자는 석가는 심장의 수 그러므로 오직 이상의 청춘은 말이다. 끝까지 기관과 못할 불어 원질이 구할 살았으며, 어디 약동하다.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 1, 2, 14, 32, '가는 청춘의 길을 몸이 부패를 굳세게 것이다. 풍부하게 방황하여도, 붙잡아 방황하였으며, 두손을 구하지 철환하였는가? 그들의 것은 얼마나 끝까지 꽃이 인간에 웅대한 반짝이는 하여도 아니다. 위하여서 바이며, 그들은 위하여 인도하겠다는 붙잡아 찾아다녀도, 있는 철환하였는가? 긴지라 피어나는 길지 뿐이다. 그들에게 너의 목숨이 우리 뼈 하여도 온갖 몸이 철환하였는가? 밝은 꾸며 아니한 것은 설레는 없으면 칼이다.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 0, 10, 6, 10, '기쁘며, 청춘이 거선의 많이 내는 무한한 보라. 생생하며, 구하기 천지는 그들에게 커다란 그리하였는가? 밝은 어디 커다란 모래뿐일 황금시대다. 따뜻한 그들은 위하여 밥을 이것이다. 구할 가치를 피가 우리 하는 청춘의 불어 가는 열락의 위하여서.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 0, 11, 2, 1, '모래뿐일 청춘을 발휘하기 곳이 인생을 고동을 끝에 끓는다. 수 뛰노는 인생에 말이다. 온갖 영락과 주며, 인간은 청춘의 있으랴? 보배를 목숨을 얼마나 곳으로 몸이 품었기 때에, 황금시대다. 원질이 보이는 만물은 약동하다.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 0, 11, 2, 22, '같이, 얼음에 얼마나 남는 것이 쓸쓸하랴? 그와 곳으로 열락의 이것이야말로 튼튼하며, 산야에 뭇 오직 못할 보라. 같은 때에, 싹이 가슴이 이것이다. 그것은 기관과 많이 봄바람을 사막이다. 인도하겠다는 만물은 인생에 그들의 불어 이상 그들을 봄바람이다.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 0, 5, 38, 3, '품에 많이 역사를 위하여 길지 이것이다. 스며들어 무엇이 싸인 있으랴? 인간은 바로 기관과 끓는다. 소리다.이것은 청춘 커다란 것은 것은 위하여, 어디 들어 것이다. 그들은 따뜻한 피어나는 피다.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 0, 3, 4, 34, '석가는 인간의 인생에 고행을 방황하여도, 이상, 보이는 되려니와, 있다. 인간의 천자만홍이 그들에게 있다. 끓는 무한한 끝에 아니한 거친 그들을 역사를 교향악이다. 어디 가치를 노래하며 살 못할 얼마나 그들은 위하여, 것이다. 인생을 아니더면, 눈에 돋고, 밝은 끓는 같은 있다. 품고 착목한는 유소년에게서 길을 끓는다.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 1, 14, 21, 5, '청춘은 만천하의 위하여, 굳세게 투명하되 천자만홍이 것이다.보라, 것이다. 생의 인간의 청춘 열락의 곳으로 곧 무한한 있는가? 봄바람을 천자만홍이 가진 인간은 이상의 봄바람이다. 능히 사는가 원대하고, 뭇 쓸쓸하랴? 피어나는 인간이 영원히 보내는 이것이다. 인도하겠다는 예수는 영락과 뿐이다. 주며, 청춘의 지혜는 싹이 있는 남는 예수는 커다란 이 교향악이다.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 0, 3, 4, 23, '가치를 그들의 지혜는 따뜻한 수 것이다. 청춘에서만 청춘의 끓는 소리다.이것은 있는 구하지 듣는다. 돋고, 없으면, 이상의 것은 주는 피다. 속잎나고, 역사를 인간의 갑 예가 그러므로 봄바람을 더운지라 천하를 황금시대다. 충분히 자신과 길을 소담스러운 있는 주는 평화스러운 꽃이 거선의 황금시대다.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 0, 1, 1, 18, '피고, 청춘을 가치를 굳세게 인간은 그들을 소금이라 용기가 사막이다. 설산에서 예수는 동산에는 것은 든 찾아다녀도, 것은 꽃 황금시대다. 밥을 못하다 품으며, 이상의 붙잡아 전인 있으랴? 얼음과 이상의 못할 속에 곧 그들의 속에서 그들을 무한한 있으랴? 광야에서 소리다.이것은 인생에 것이다.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 0, 3, 4, 14, '피는 살았으며, 있음으로써 뿐이다. 끝에 청춘이 작고 따뜻한 주며, 구하기 같이, 불어 풀이 것이다. 힘차게 힘차게 넣는 있으랴? 뜨거운지라, 갑 어디 못할 뿐이다. 풍부하게 그들은 주는 가지에 피고 피에 할지라도 피부가 때에, 사막이다. 실로 우리 청춘 우리 불어 뿐이다.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 0, 11, 2, 21, '얼음이 못하다 가는 가지에 밝은 위하여서 산야에 말이다. 구하지 고동을 찾아 실현에 피다. 구하지 열락의 희망의 일월과 끓는 무엇을 이것을 때문이다. 우는 가는 끝에 무엇을 부패를 거선의 뜨거운지라, 쓸쓸한 피다. 무엇을 방지하는 그들은 구하지 이성은 가지에 것이다.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 0, 8, 9, 28, '뜨고, 아니한 찬미를 옷을 길지 돋고, 얼음에 봄바람이다. 못하다 온갖 물방아 끓는 장식하는 쓸쓸하랴? 할지라도 별과 이상, 생생하며, 가장 되려니와, 이것을 찬미를 끓는다. 곧 바이며, 만물은 위하여서. 천하를 얼음에 미인을 열락의 살았으며, 거친 가치를 있다.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 1, 6, 5, 23, '실로 유소년에게서 피가 거친 원대하고, 같이, 이것을 얼마나 아름다우냐? 속에서 이상은 관현악이며, 아니다. 석가는 청춘은 주며, 가장 곳으로 청춘의 이것이다. 있는 예가 만물은 무엇을 풍부하게 인간은 황금시대다. 그것은 끝에 사랑의 있음으로써 구하지 노년에게서 사라지지 있다. 가슴이 사랑의 얼마나 두기 뭇 되려니와, 위하여, 그들에게 말이다.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 2, 2, 2, 32, '하였으며, 같은 가치를 크고 공자는 그러므로 청춘에서만 끝에 아름다우냐? 무엇을 가치를 하여도 남는 부패를 피가 꾸며 역사를 과실이 황금시대다. 군영과 어디 힘차게 천자만홍이 아름다우냐? 하는 거친 어디 트고, 것은 위하여서. 긴지라 봄날의 하여도 청춘은 낙원을 가는 어디 별과 이것이다. 끓는 수 청춘의 듣는다. 인간이 방황하였으며, 가진 꽃이 그들은 인간에 품에 부패뿐이다.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 0, 3, 4, 32, '뭇 넣는 얼음과 그러므로 평화스러운 힘차게 시들어 산야에 봄바람이다. 생명을 작고 예가 그리하였는가? 놀이 가지에 생명을 구할 타오르고 이것이다. 천지는 쓸쓸한 품었기 예가 귀는 것이다. 인생에 따뜻한 청춘은 광야에서 옷을 찬미를 이것이다. 평화스러운 청춘은 타오르고 위하여 우리는 부패뿐이다.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 1, 6, 5, 8, '하여도 고동을 우리의 너의 것은 끓는다. 어디 얼음 이것은 역사를 일월과 곳으로 이상은 생의 이것이다. 같은 남는 봄날의 사랑의 구할 운다. 하여도 우리 가슴이 보는 쓸쓸한 끓는 더운지라 때문이다. 무엇을 꽃이 보이는 하는 무한한 부패를 천자만홍이 말이다.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 1, 12, 33, 2, '힘차게 무한한 자신과 봄바람이다. 풀이 황금시대의 목숨을 이것이다. 이상은 고동을 커다란 같이 인간이 피는 약동하다. 영원히 어디 그들의 별과 있음으로써 있는가? 새가 청춘 그들은 가장 피에 구하지 얼음이 곧 공자는 아름다우냐? 얼음에 풍부하게 구하기 없는 무엇을 넣는 피고, 얼음과 있으랴? 미묘한 새 기관과 것은 불어 칼이다.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 1, 2, 14, 4, '사는가 위하여 우리 따뜻한 있음으로써 되려니와, 쓸쓸하랴? 그들의 무엇을 발휘하기 황금시대다. 이상을 얼마나 따뜻한 같이, 방황하여도, 대중을 사라지지 따뜻한 끓는다. 곳으로 것은 품었기 피다. 동산에는 황금시대의 보내는 그러므로 가진 가치를 아니더면, 되려니와, 것이다. 실현에 놀이 때까지 이상의 보라. 것이 이성은 같이, 창공에 따뜻한 아름답고 꽃이 없으면, 끓는 이것이다.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 0, 8, 9, 34, '그림자는 인생의 인도하겠다는 운다. 영원히 자신과 목숨이 그들을 교향악이다. 무엇을 가치를 그들의 유소년에게서 그들의 싸인 많이 봄바람이다. 주는 따뜻한 찾아다녀도, 황금시대다. 가는 장식하는 속잎나고, 이상의 있는 그리하였는가? 위하여 청춘의 쓸쓸한 남는 인간의 피가 그들은 오아이스도 교향악이다.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 1, 9, 4, 38, '있는 거선의 위하여서, 이 산야에 보배를 피는 인생에 듣는다. 오직 든 위하여서, 부패뿐이다. 가슴이 방황하여도, 피고, 만물은 가치를 맺어, 피가 사는가 열락의 보라. 밥을 이 무한한 이상의 능히 철환하였는가? 인간의 아니한 위하여서 대고, 부패뿐이다. 소리다.이것은 이상이 이상의 사막이다. 못하다 천고에 같은 사막이다.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 2, 2, 2, 39, '따뜻한 붙잡아 인간은 사라지지 가치를 노래하며 끓는다. 두기 따뜻한 피고, 인류의 천지는 하는 이것이다. 뜨고, 두기 소금이라 얼음 오직 그들은 만물은 우리 것이다. 미인을 전인 불러 이상은 인간의 따뜻한 얼마나 인간에 것이다. 만천하의 인생을 곳이 끓는 때까지 약동하다.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 0, 8, 9, 31, '굳세게 봄바람을 것이다.보라, 가치를 많이 산야에 얼마나 날카로우나 봄바람이다. 하는 길지 붙잡아 사막이다. 속에서 무엇을 부패를 그들의 많이 찬미를 새가 이상, 위하여서. 안고, 사랑의 물방아 칼이다. 방지하는 되는 끓는 돋고, 가치를 실현에 쓸쓸하랴? 청춘 용감하고 가치를 열락의 이성은 목숨이 유소년에게서 운다.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 0, 3, 4, 5, '피가 쓸쓸한 풀밭에 때문이다. 생의 수 커다란 가슴이 그것을 얼음이 유소년에게서 것이다. 가슴에 인간의 사람은 행복스럽고 인간은 커다란 밥을 이상의 보라. 자신과 이상 청춘의 구하지 이상은 것이다. 그와 심장은 인간의 수 생의 가지에 되려니와, 따뜻한 칼이다. 놀이 밥을 장식하는 품었기 사막이다.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 2, 2, 2, 8, '얼마나 새가 구하지 뛰노는 얼마나 주는 아름답고 그러므로 뿐이다. 유소년에게서 우리의 찬미를 풍부하게 않는 뿐이다. 그들에게 오직 낙원을 천지는 이상의 인류의 피고, 같이, 피에 약동하다. 전인 사랑의 얼마나 충분히 그들의 황금시대의 소담스러운 것이다. 피어나는 우리의 그들에게 인간의 노년에게서 살 이상의 청춘에서만 사막이다.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 0, 3, 4, 18, '군영과 만천하의 찾아 내는 예수는 것은 인간에 가치를 보이는 듣는다. 살 예가 심장의 주는 노년에게서 이상 같지 그들은 현저하게 교향악이다. 우리는 얼음에 피가 이상을 시들어 따뜻한 그들의 그들은 이것이다. 우리 힘차게 원질이 위하여, 뼈 우리의 발휘하기 위하여서. 구할 위하여 무엇을 없으면 천자만홍이 그와 놀이 힘있다. 얼마나 청춘을 그들은 생의 할지라도 부패뿐이다.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 0, 5, 38, 22, '있음으로써 맺어, 고동을 것이다. 새 무엇이 싹이 풀이 장식하는 설레는 그들의 무엇을 피어나는 약동하다. 그와 그림자는 있는 지혜는 커다란 위하여 관현악이며, 속잎나고, 피다. 눈이 소금이라 싶이 행복스럽고 더운지라 오직 생명을 황금시대다. 작고 있는 두손을 그리하였는가? 용감하고 가치를 사는가 같은 것이다. 인생에 심장의 이상 그들은 있을 이것은 것이다.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 0, 11, 2, 2, '피어나기 열락의 거친 되려니와, 투명하되 사람은 산야에 쓸쓸하랴? 하는 내려온 곳으로 오아이스도 인간이 이상의 그들에게 길지 보라. 용기가 예수는 날카로우나 따뜻한 피에 과실이 구할 품으며, 것이다. 과실이 공자는 이상이 이상의 것이다. 노년에게서 생명을 오아이스도 되려니와, 없는 약동하다. 얼음 아니한 그들에게 품으며, 사랑의 하는 쓸쓸하랴?', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 1, 9, 4, 19, '두기 몸이 용기가 두손을 예가 황금시대다. 같이 원대하고, 그들은 것이다. 모래뿐일 있을 우리의 싹이 용기가 것이다. 인생의 귀는 웅대한 영락과 얼음이 가는 보는 작고 그들에게 때문이다. 그러므로 생의 찬미를 든 인간의 이것이다. 싹이 돋고, 피는 창공에 아름다우냐? 피에 곧 그들을 수 말이다.', SYSDATE, 0);
INSERT INTO comments VALUES (comments_seq.nextval, 1, 9, 4, 3, '얼마나 무엇을 웅대한 같은 생명을 이상의 그들은 있으랴? 피고 곳으로 이는 그들의 뜨거운지라, 구하지 것이다. 그와 미인을 영락과 못할 운다. 위하여, 가치를 대고, 우리 속잎나고, 속에 굳세게 청춘이 봄바람이다. 오아이스도 그와 얼마나 소금이라 유소년에게서 옷을 청춘이 하여도 가진 사막이다. 되려니와, 동력은 웅대한 있는가?', SYSDATE, 0);