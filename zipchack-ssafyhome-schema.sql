create table admin
(
    admin_seq  bigint auto_increment comment '관리자 번호'
        primary key,
    admin_pw   varchar(200) not null comment '관리자 비밀번호',
    admin_role varchar(50)  not null comment '관리자 권한'
)
    comment '관리자';

create table category
(
    category_code varchar(10) not null comment 'API에 요청할 카테고리 코드 및 이름'
        primary key,
    category_name varchar(10) not null comment '카테고리명',
    category_type tinyint     not null comment '키워드 및 카테고리 여부'
)
    comment '편의시설 카테고리 모음';

create table dong_code
(
    sido_name  varchar(30) null comment '시도명',
    gugun_name varchar(30) null comment '구군명',
    hdong_name varchar(30) null comment '행정동명',
    hdong_code varchar(10) null comment '행정동코드',
    bdong_name varchar(30) null comment '법정동명',
    bdong_code varchar(10) null comment '법정동코드'
);

create table geometry
(
    dong_name  varchar(30) charset utf8mb3 null comment '동이름',
    dong_code  varchar(10) charset utf8mb3 not null comment '동코드',
    geom       geometry                    null comment '지오메트리 정보',
    center_lng varchar(45) charset utf8mb3 null comment '중심점 경도',
    center_lat varchar(45) charset utf8mb3 null comment '중심점 위도',
    radius     varchar(45) charset utf8mb3 null comment '반경'
);

create table house_info
(
    apt_seq        varchar(20) not null comment '아파트 고유번호',
    sgg_cd         varchar(5)  null comment '시군구 코드',
    umd_cd         varchar(10) null comment '읍면동 코드',
    umd_nm         varchar(20) null comment '읍면동명',
    jibun          varchar(20) null comment '지번',
    road_nm_sgg_cd varchar(20) null comment '도로명 시군구코드',
    road_nm        varchar(20) null comment '도로명',
    road_nm_bonbun varchar(20) null comment '도로명 본번',
    road_nm_bubun  varchar(20) null comment '도로명 부번',
    apt_nm         varchar(50) null comment '아파트명',
    build_year     int         null comment '건축년도',
    latitude       varchar(45) null comment '위도',
    longitude      varchar(45) null comment '경도'
)
    comment '매물 정보';

create table house_deal
(
    deal_seq     varchar(30)   not null comment '매매 번호'
        primary key,
    apt_seq      varchar(20)   not null comment '아파트 번호',
    apt_dong     varchar(40)   null comment '아파트 동',
    floor        varchar(3)    null comment '층수',
    deal_year    int           null comment '거래 연도',
    deal_month   int           null comment '거래 월',
    deal_day     int           null comment '거래 일',
    exclu_use_ar decimal(7, 2) null comment '전용면적',
    deal_amount  varchar(20)   null comment '거래 금액',
    constraint house_deal_house_info_apt_seq_fk
        foreign key (apt_seq) references house_info (apt_seq)
            on update cascade on delete cascade
)
    comment '매매 정보';

create index house_deal_apt_seq_index
    on house_deal (apt_seq);

create table nearest_spot
(
    apt_seq       varchar(20) not null comment '아파트 고유번호',
    category_name varchar(10) not null comment '카테고리명',
    spot_name     varchar(40) null comment '장소명',
    latitude      varchar(45) null comment '위도',
    longitude     varchar(45) null comment '경도',
    primary key (apt_seq, category_name)
);

create index nearest_spot_category_category_code_fk
    on nearest_spot (category_name);

create table notice
(
    notice_seq     bigint auto_increment comment '공지사항 번호'
        primary key,
    notice_title   varchar(100)                        not null comment '공지사항 제목',
    notice_content text                                null comment '공지사항 내용',
    created_at     timestamp default CURRENT_TIMESTAMP not null comment '공지 게시일',
    modified_at    timestamp                           null on update CURRENT_TIMESTAMP comment '공지 최종 수정일'
)
    comment '공지사항';

create table population
(
    adm_cd                 char(40) not null comment '행정구역코드',
    dong_code              text     null comment '동코드',
    city_name              text     null comment '도시명',
    tot_ppltn              text     null comment '총인구수',
    ppltn_dnsty            text     null comment '인구밀도',
    aged_child_idx         text     null comment '노령화지수',
    corp_cnt               text     null comment '기업체수',
    tot_house              text     null comment '총가구수',
    age_under20_population int      null comment '20세미만 인구수',
    age_2030_population    int      null comment '20-30대 인구수',
    age_4060_population    int      null comment '40-60대 인구수',
    age_over70_population  int      null comment '70세이상 인구수'
);

create table spot
(
    spot_seq  bigint      not null comment '장소 번호'
        primary key,
    spot_name varchar(40) null comment '장소 이름',
    spot_type varchar(20) not null comment '장소 분류',
    sgg_cd    varchar(5)  null comment '시군구 코드',
    umd_cd    varchar(5)  null comment '읍면동 코드',
    umd_nm    varchar(20) null comment '읍면동 이름',
    jibun     varchar(40) null comment '지번',
    road_nm   varchar(20) null comment '새주소',
    latitude  varchar(45) null comment '위도',
    longitude varchar(45) null comment '경도'
)
    comment '장소';

create table user
(
    user_seq        bigint auto_increment comment '회원 번호'
        primary key,
    user_id         varchar(100)                        not null comment '회원 아이디',
    user_pw         varchar(200)                        null comment '회원 비밀번호',
    user_email      varchar(100)                        null comment '회원 이메일',
    user_name       varchar(50)                         not null comment '회원 이름',
    user_phone      varchar(11)                         null comment '회원 전화번호',
    user_zipcode    varchar(10)                         null comment '회원 우편번호',
    user_address    varchar(200)                        null comment '회원 주소',
    user_address2   varchar(200)                        null comment '회원 상세 주소',
    social_type     tinyint                             not null comment '소설 로그인 여부',
    social_platform varchar(50)                         null comment '소셜 플랫폼 종류',
    created_at      timestamp default CURRENT_TIMESTAMP not null comment '생성일',
    constraint user_pk
        unique (user_id)
)
    comment '회원';

create table custom_spot
(
    spot_seq  bigint auto_increment comment '사용자 정의 장소 번호'
        primary key,
    spot_name varchar(40) null comment '장소 이름',
    jibun     varchar(10) null comment '지번',
    road_nm   varchar(20) null comment '새주소',
    latitude  varchar(45) null comment '위도',
    longitude varchar(45) null comment '경도',
    user_seq  bigint      null comment '회원 번호',
    constraint custom_spot_user_user_seq_fk
        foreign key (user_seq) references user (user_seq)
            on update cascade on delete cascade
)
    comment '사용자 정의 장소';

create table favorite_house
(
    user_seq bigint      not null comment '회원 번호',
    apt_seq  varchar(20) not null comment '매물 번호',
    primary key (user_seq, apt_seq),
    constraint favorite_house_user_user_seq_fk
        foreign key (user_seq) references user (user_seq)
            on update cascade on delete cascade
)
    comment '관심 매물';

create index favorite_house_apt_seq_index
    on favorite_house (apt_seq);

create table favorite_spot
(
    dong_code varchar(10) not null comment '동 코드',
    user_seq  bigint      not null comment '회원 번호',
    primary key (user_seq, dong_code),
    constraint favorite_spot_user_user_seq_fk
        foreign key (user_seq) references user (user_seq)
            on update cascade on delete cascade
)
    comment '관심 지역';

create table house_review
(
    apt_seq        varchar(20)                         not null comment '매물 번호',
    user_seq       bigint                              not null comment '회원 번호',
    review_title   varchar(100)                        not null comment '평가 제목',
    review_rate    int                                 not null comment '평점',
    review_content text                                null comment '평가 상세',
    created_at     timestamp default CURRENT_TIMESTAMP null comment '평가 작성일',
    modified_at    timestamp                           null on update CURRENT_TIMESTAMP comment '평가 수정일',
    primary key (apt_seq, user_seq),
    constraint house_review_user_user_seq_fk
        foreign key (user_seq) references user (user_seq)
            on update cascade on delete cascade
)
    comment '매물에 대한 평가';

