﻿CREATE DATABASE NGUYEN_VAN_THANG;
GO
USE NGUYEN_VAN_THANG;
GO 
CREATE TABLE DOCGIA
(MADG CHAR(10) CONSTRAINT Pk_DOCGIA PRIMARY KEY,
HOTEN NVARCHAR(30),
GIOITINH NVARCHAR(5),
NAMSINH INT)
GO
CREATE TABLE LINHVUC
(MALV CHAR(10) CONSTRAINT Pk_LINHVUC PRIMARY KEY,
TENLV NVARCHAR(30))

CREATE TABLE SACH
(MASACH CHAR(10) CONSTRAINT Pk_SACH PRIMARY KEY,
MALV CHAR(10) CONSTRAINT Fk_malv_SACH FOREIGN KEY(MALV) REFERENCES LINHVUC(MALV),
TENSACH NVARCHAR(30),
NAMNXB INT,
TENTG NVARCHAR(30))
GO
CREATE TABLE PHIEUMUON
(MAPM CHAR(10) CONSTRAINT Pk_PHIEUMUON PRIMARY KEY,
MADG CHAR(10) CONSTRAINT Fk_madg_PHIEUMUON FOREIGN KEY(MADG) REFERENCES DOCGIA(MADG),
MASACH CHAR(10) CONSTRAINT Fk_masach_PHIEUMUON FOREIGN KEY(MASACH) REFERENCES SACH(MASACH),
NGAYMUON DATETIME,
NGAYHENTRA DATETIME)

INSERT INTO DOCGIA(MADG,HOTEN,GIOITINH,NAMSINH)
VALUES 
('DG01',N'Nguyễn Văn Thắng',N'Nam',2004),
('DG02',N'Trịnh Công Sơn',N'Nam',1992),
('DG03',N'Hoàng Thuỳ Linh',N'Nữ',1998),
('DG04',N'Phùng Thanh Độ',N'Nam',1996)


INSERT INTO LINHVUC(MALV,TENLV)
VALUES
('CNTT',N'Công nghệ Thông Tin'),
('TK',N'Thiết kế đồ hoạ'),
('KT',N'Kinh tế'),
('TT',N'Toán')

INSERT INTO SACH(MASACH,TENSACH,NAMNXB,TENTG,MALV)
VALUES
('MS01',N'Lập trình cơ bản',2012,N'Nguyễn Văn Thanh','CNTT'),
('MS02',N'Thiết kế 4d',2020,N'Nguyễn Thị Thuỳ','TK'),
('MS03',N'Bài toán kinh tế',2015,N'Nguyễn Công Tuấn','KT'),
('MS04',N'Toán cao cấp',2016,N'Nguyễn Văn Thịnh','TT')
 

INSERT INTO PHIEUMUON(MAPM,MADG,MASACH,NGAYMUON,NGAYHENTRA)
VALUES
('PM01','DG01','MS01','20220523','20220624'),
('PM02','DG02','MS02','20220525','20220630'),
('PM03','DG03','MS03','20220523','20220724'),
('PM04','DG04','MS04','20220323','20220620')


SELECT* FROM DOCGIA
SELECT* FROM SACH
SELECT* FROM LINHVUC
SELECT* FROM PHIEUMUON

SELECT SACH.TENSACH,TENTG,NAMNXB,TENLV
FROM SACH 
INNER JOIN LINHVUC ON SACH.MALV = LINHVUC.MALV
WHERE TENLV = N'Công nghệ Thông Tin';


SELECT DOCGIA.MADG,HOTEN,GIOITINH,NAMSINH
FROM DOCGIA
INNER JOIN PHIEUMUON ON DOCGIA.MADG = PHIEUMUON.MADG
WHERE NGAYHENTRA >= '2022-06-01' AND NGAYHENTRA <= '2022-06-30';


SELECT SACH.MALV,TENLV, COUNT(MASACH) AS TONGSOLUONGSACH
FROM SACH 
INNER JOIN LINHVUC ON SACH.MALV = LINHVUC.MALV
GROUP BY SACH.MALV,TENLV;
