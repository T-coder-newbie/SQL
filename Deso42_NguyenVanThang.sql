create database Deso42_NguyenVanThang
go
use Deso42_NguyenVanThang
go
create table LoaihinhDN(
Maloaihinh char(10) primary key,
Tenloaihinh nvarchar(50) not null
)
go
create table LinhvucKD(
Malinhvuc char(10) primary key,
Tenlinhvuc nvarchar(50) not null
)
go
create table Huyen(
Mahuyen char(10) primary key,
Tenhuyen nvarchar(50) not null unique
)
go
create table Doanhnghiep(
MaDN char(10) primary key,
TenDN nvarchar(100) not null,
Diachi nvarchar(50),
Sodienthoai char(15) unique,
Email char(20),
Masothue char(20) not null unique,
Vondieule decimal not null,
Namthanhlap int,
Mahuyen char(10) foreign key(Mahuyen) references Huyen(Mahuyen),
MaLoaihinh char(10) foreign key(Maloaihinh) references LoaihinhDN(Maloaihinh),
Malinhvuc char(10) foreign key(Malinhvuc) references LinhvucKD(Malinhvuc),
Trangthai nvarchar(20))
go
create table Nguoidaidien (
MaNDD char(10) primary key,
Hoten nvarchar(50) not null,
Ngaysinh date not null,
Gioitinh bit,
Cancuoc char(20) unique,
Sodienthoai char(15) unique,
Email char(20),
Chucvu nvarchar(50) not null,
MaDN char(10) foreign key(MaDN) references Doanhnghiep(MaDN))
go
create table Baocaotaichinh(
Mabaocao char(10) primary key,
Nam int not null,
Doanhthu decimal (18,0) not null,
Loinhuan decimal (18,0),
Solaodong int,
Tongtaisan decimal(18,0) not null,
Thue decimal (18,0),
Ngaybaocao date not null,
MaDN char(10) foreign key(MaDN) references Doanhnghiep(MaDN))
-------------------------------------------------------------
--Ràng buộc kiểm tra vốn điều lệ 
ALTER TABLE Doanhnghiep
ADD CONSTRAINT CHK_VonDieule
CHECK (Vondieule >= 1000000 AND Vondieule <= 10000000000);
--Ràng buộc kiểm tra năm thành lập từ năm 1900 đến năm hiện tại
ALTER TABLE Doanhnghiep ADD CONSTRAINT CK_Namthanhlap CHECK (Namthanhlap BETWEEN 1900 AND YEAR(GETDATE()));
--Ràng buộc kiểm tra việc doanh thu và lợi nhuận phải lớn hơn hoặc bằng 0
ALTER TABLE Baocaotaichinh ADD CONSTRAINT CK_Doanhthu CHECK (Doanhthu >= 0);
ALTER TABLE Baocaotaichinh ADD CONSTRAINT CK_Loinhuan CHECK (Loinhuan >= 0);
--Ràng buộc kiểm tra số lao động không thể nhỏ hơn 0
ALTER TABLE Baocaotaichinh ADD CONSTRAINT CK_Solaodong CHECK (Solaodong >= 0);
--Ràng buộc kiểm tra lợi nhuận không thể lớn hơn doanh thu
ALTER TABLE Baocaotaichinh ADD CONSTRAINT CK_Doanhthu_Loinhuan CHECK (Loinhuan <= Doanhthu);
--------------------------------------------------------------
--Nhập dữ liệu vào các bảng
insert into LoaihinhDN(Maloaihinh,Tenloaihinh)
values('M01',N'Công ty cổ phần'),
('M02',N'Công ty TNHH 1 thành viên'),
('M03',N'Công ty TNHH 2 thành viên trở lên'),
('M04',N'Công ty hợp danh'),
('M05',N'Doanh nghiệp tư nhân')
select * from LoaihinhDN
go
insert into LinhvucKD(Malinhvuc,Tenlinhvuc)
values('L01',N'Công nghiệp'),
('L02',N'Dịch vụ'),
('L03',N'Thương mại'),
('L04',N'Nông nghiệp'),
('L05',N'Công nghệ'),
('L06',N'Năng lượng'),
('L07',N'Bất động sản'),
('L08',N'Tài nguyên thiên nhiên'),
('L09',N'Sản xuất và tiêu dùng'),
('L10',N'Truyền thông'),
('L11',N'Đầu tư và tư vấn'),
('L12',N'Thực phẩm'),
('L13',N'Tài chính và ngân hàng'),
('L14',N'Kỹ thuật và cơ khí')
select * from LinhvucKD
go
insert into Huyen(Mahuyen,Tenhuyen)
values('H01',N'Ân Thi'),
('H02',N'Khoái Châu'),
('H03',N'Kim Động'),
('H04',N'Mỹ Hào'),
('H05',N'Phù Cừ'),
('H06',N'Tiên Lữ'),
('H07',N'TP Hưng Yên'),
('H08',N'Văn Giang'),
('H09',N'Văn Lâm'),
('H10',N'Yên Mỹ')
select * from Huyen
go
insert into Doanhnghiep(MaDN,TenDN,Diachi,Sodienthoai,Email,Masothue,Vondieule,Namthanhlap,Mahuyen,MaLoaihinh,Malinhvuc,Trangthai)
values
('N01',N'Công ty TNHH FAB',N'Mỹ Hào, Hưng Yên','0332324443','fab@gmail.com','0901130607',1200000,2020,'H04','M02','L01',N'Đang hoạt động'),
('N02', N'Công ty cổ phần ARA', N'Ân Thi, Hưng Yên', '0332321111', 'ara@gmail.com', '0901130608', 5000000,2015, 'H01', 'M01', 'L02', N'Đang hoạt động'),
('N03', N'Công ty TNHH YAR', N'Khoái Châu, Hưng Yên', '0332322222', 'yar@gmail.com', '0901130609', 10000000,2018, 'H02', 'M02', 'L03', N'Đang hoạt động'),
('N04', N'Công ty TNHH Phát triển Hưng Yên', N'Kim Động, Hưng Yên', '0332323333', 'phungyen@gmail.com', '0901130610', 2000000,2017, 'H03', 'M03', 'L04', N'Đang hoạt động'),
('N05', N'Công ty hợp danh Hưng Thịnh', N'Mỹ Hào, Hưng Yên', '0332324444', 'hungthinh@gmail.com', '0901130611', 3000000,2016, 'H04', 'M04', 'L05', N'Đang hoạt động'),
('N06', N'Doanh nghiệp tư nhân Minh Tuấn', N'Phù Cừ, Hưng Yên', '0332325555', 'minhtuan@gmail.com', '0901130612', 1500000,2020, 'H05', 'M05', 'L06', N'Đang hoạt động'),
('N07', N'Công ty cổ phần Nam Long', N'Tiên Lữ, Hưng Yên', '0332326666', 'namlong@gmail.com', '0901130613', 7000000,2019, 'H06', 'M01', 'L07', N'Đang hoạt động'),
('N08', N'Công ty TNHH Bắc Sơn', N'TP Hưng Yên', '0332327777', 'bacson@gmail.com', '0901130614', 9000000,2014, 'H07', 'M02', 'L08', N'Đang hoạt động'),
('N09', N'Công ty TNHH Toàn Cầu', N'Văn Giang, Hưng Yên', '0332328888', 'toancau@gmail.com', '0901130615', 4000000,2021, 'H08', 'M02', 'L09', N'Đang hoạt động'),
('N10', N'Công ty hợp danh Thành Công', N'Văn Lâm, Hưng Yên', '0332329999', 'thanhcong@gmail.com', '0901130616', 6000000,2013, 'H09', 'M04', 'L10', N'Đang dừng hoạt động'),
('N11', N'Doanh nghiệp tư nhân Hòa Bình', N'Yên Mỹ, Hưng Yên', '0332320000', 'hoabinh@gmail.com', '0901130617', 2500000,2012, 'H10', 'M05', 'L11', N'Đang hoạt động'),
('N12', N'Công ty TNHH Gia Phát', N'Ân Thi, Hưng Yên', '0332330000', 'giaphat@gmail.com', '0901130618', 8000000,2017, 'H01', 'M02', 'L03', N'Đang hoạt động'),
('N13', N'Công ty cổ phần Đông Á', N'Khoái Châu, Hưng Yên', '0332331111', 'donga@gmail.com', '0901130619', 15000000,2016, 'H02', 'M01', 'L04', N'Đang hoạt động'),
('N14', N'Công ty TNHH Công Nghệ Hưng Yên', N'Kim Động, Hưng Yên', '0332332222', 'cnhungyen@gmail.com', '0901130620', 5000000,2019, 'H03', 'M02', 'L05', N'Đang hoạt động'),
('N15', N'Doanh nghiệp tư nhân Thành Đạt', N'Mỹ Hào, Hưng Yên', '0332333333', 'thanhdat@gmail.com', '0901130621', 2500000,2020, 'H04', 'M05', 'L06', N'Đang dừng hoạt động'),
('N16', N'Công ty hợp danh Toàn Thịnh', N'Phù Cừ, Hưng Yên', '0332334444', 'toanthinh@gmail.com', '0901130622', 6000000,2015, 'H05', 'M04', 'L07', N'Đang hoạt động');
select * from Doanhnghiep
go
insert into Nguoidaidien(MaNDD,Hoten,Ngaysinh,Gioitinh,Cancuoc,Sodienthoai,Email,Chucvu,MaDN)
values
('ND01', N'Nguyễn Văn Thịnh', '1985-06-15', 1, 'CC01', '0332331111', 'thinh@gmail.com', N'Giám đốc', 'N01'),
('ND02', N'Phạm Thị Duyên', '1990-04-20', 0, 'CC02', '0332332222', 'phamthid@gmail.com', N'Trưởng phòng Kinh doanh', 'N02'),
('ND03', N'Trần Minh Công', '1982-11-10', 1, 'CC03', '0332333333', 'tranminhc@gmail.com', N'Giám đốc', 'N03'),
('ND04', N'Lê Thị Dịu', '1978-01-25', 0, 'CC04', '0332334444', 'lethid@gmail.com', N'Giám đốc điều hành', 'N04'),
('ND05', N'Nguyễn Thị Yến', '1986-07-30', 0, 'CC05', '0332335555', 'nguyenthie@gmail.com', N'Phó giám đốc', 'N05'),
('ND06', N'Vũ Hoàng Sơn', '1992-09-12', 1, 'CC06', '0332336666', 'vuhoangs@gmail.com', N'Trưởng phòng nhân sự', 'N06'),
('ND07', N'Hoàng Thị Giang', '1987-02-05', 0, 'CC07', '0332337777', 'hoangthig@gmail.com', N'Giám đốc', 'N07'),
('ND08', N'Phan Minh Hiếu', '1993-03-25', 1, 'CC08', '0332338888', 'phanminhh@gmail.com', N'Trưởng phòng kỹ thuật', 'N08'),
('ND09', N'Nguyễn Minh Hoàng', '1990-12-17', 1, 'CC09', '0332339999', 'nguyenm@gmail.com', N'Giám đốc kinh doanh', 'N09'),
('ND10', N'Trần Thị Thảo', '1988-08-20', 0, 'CC10', '0332340000', 'tranthit@gmail.com', N'Giám đốc điều hành', 'N10'),
('ND11', N'Phạm Minh Khang', '1985-10-10', 1, 'CC11', '0332341111', 'phamminhk@gmail.com', N'Trưởng phòng tài chính', 'N11'),
('ND12', N'Vũ Thị Liễu', '1991-04-15', 0, 'CC12', '0332342222', 'vuthil@gmail.com', N'Trưởng phòng marketing', 'N12'),
('ND13', N'Nguyễn Hoàng Quang', '1983-06-25', 1, 'CC13', '0332343333', 'nguyenq@gmail.com', N'Giám đốc', 'N13'),
('ND14', N'Hoàng Thị Nhung', '1990-05-10', 0, 'CC14', '0332344444', 'hoangthin@gmail.com', N'Giám đốc điều hành', 'N14'),
('ND15', N'Trần Minh Đan', '1987-11-30', 1, 'CC15', '0332345555', 'tranminh@gmail.com', N'Giám đốc', 'N15'),
('ND16', N'Phan Thị Phượng', '1994-01-22', 0, 'CC16', '0332346666', 'phanthip@gmail.com', N'Giám đốc', 'N16');
select * from Nguoidaidien
go
insert into Baocaotaichinh(Mabaocao,Nam,Doanhthu,Loinhuan,Solaodong,Tongtaisan,Thue,Ngaybaocao,MaDN)
values
('BC01', 2020, 12000000, 3000000, 500, 15000000, 2000000, '2020-12-31', 'N01'),
('BC02', 2015, 8000000, 1500000, 300, 10000000, 1500000, '2015-12-31', 'N02'),
('BC03', 2018, 20000000, 5000000, 600, 25000000, 4000000, '2018-12-31', 'N03'),
('BC04', 2017, 15000000, 4000000, 450, 20000000, 2500000, '2017-12-31', 'N04'),
('BC05', 2016, 10000000, 2500000, 400, 12000000, 2000000, '2016-12-31', 'N05'),
('BC06', 2020, 8000000, 2000000, 250, 10000000, 1500000, '2020-12-31', 'N06'),
('BC07', 2019, 18000000, 4000000, 550, 22000000, 3500000, '2019-12-31', 'N07'),
('BC08', 2014, 22000000, 6000000, 700, 27000000, 4500000, '2014-12-31', 'N08'),
('BC09', 2021, 14000000, 3000000, 350, 16000000, 2000000, '2021-12-31', 'N09'),
('BC10', 2013, 10000000, 2500000, 600, 13000000, 1500000, '2013-12-31', 'N10'),
('BC11', 2012, 5000000, 1000000, 250, 8000000, 1000000, '2012-12-31', 'N11'),
('BC12', 2017, 12000000, 3000000, 500, 15000000, 2000000, '2017-12-31', 'N12'),
('BC13', 2016, 25000000, 6000000, 700, 30000000, 5000000, '2016-12-31', 'N13'),
('BC14', 2019, 10000000, 2000000, 450, 15000000, 2000000, '2019-12-31', 'N14'),
('BC15', 2020, 8000000, 1500000, 300, 10000000, 1500000, '2020-12-31', 'N15'),
('BC16', 2015, 12000000, 2500000, 500, 13000000, 2000000, '2015-12-31', 'N16');
select * from Baocaotaichinh
------------------------------------------------------------------------------
--Tạo chỉ mục đơn------
create nonclustered index ix_Hoten on Nguoidaidien(Hoten)
select * from Nguoidaidien with(index = [ix_Hoten])
where Hoten like N'Nguyễn %'
--Tạo chỉ mục phức hợp--
create nonclustered index ix_Hoten_Chucvu on Nguoidaidien(Hoten,Chucvu)
select * from Nguoidaidien with(index = [ix_Hoten_Chucvu])
where Hoten like N'Nguyễn %' and Chucvu = N'Giám đốc'
--Tạo chỉ mục với hệ số điền đầy--
create unique index ix_MaLinhVuc on LinhvucKD(Malinhvuc)
with(fillfactor = 60)
--Tạo chỉ mục toàn văn--
exec sp_fulltext_database 'enable'
create fulltext catalog TenDN_cat
with accent_sensitivity = off
as default
create fulltext index on Doanhnghiep(TenDN)
key index [PK__Doanhngh__2725866FBD77D341] on TenDN_cat
select * from Doanhnghiep
where contains(TenDN,'"TNHH" or "Cổ phần"')
select * from Doanhnghiep
where freetext(TenDN,'TNHH and Hưng Yên')
---------------------------------------------------------------
--Tạo view xem thông tin doanh nghiệp----
create or alter view vw_Doanhnghiep_ThongTin with encryption 
as
select 
    MaDN,
    TenDN,
    Diachi,
    Sodienthoai,
    Email,
    Masothue,
	Vondieule,
    Namthanhlap,
    Mahuyen,
    MaLoaihinh,
    Malinhvuc,
    Trangthai
from
    Doanhnghiep
select * from vw_Doanhnghiep_ThongTin
where Trangthai = N'Đang hoạt động'
-- Thêm một doanh nghiệp mới vào bảng doanhnghiep thông qua view
insert into vw_Doanhnghiep_Thongtin (MaDN, TenDN,Diachi, Sodienthoai, Email, Masothue, Vondieule, Namthanhlap, Mahuyen, MaLoaihinh, Malinhvuc, Trangthai)
values ('N17', N'Công ty TNHH Minh Duy', N'Văn Giang, Hưng Yên', '0332330001', 'minhduy@gmail.com', '0901130623', 1000000, 2021, 'H09', 'M02', 'L01', N'Đang hoạt động');
-- Cập nhật địa chỉ và số điện thoại của doanh nghiệp "công ty tnhh fab"
update vw_Doanhnghiep_ThongTin
set Sodienthoai = '0332334449'
where tendn = N'Công ty TNHH FAB'
-- xóa doanh nghiệp có tên Công ty TNHH Minh Duy
delete from vw_Doanhnghiep_ThongTin
where TenDN = N'Công ty TNHH Minh Duy';
--Tạo view 2 bảng lấy thông tin người đại diện các doanh nghiệp--
create or alter view vw_thongtin_NDD as
select
    dn.MaDN,
    dn.TenDN,
    dn.Masothue,
    dn.Vondieule,
	ndd.MaNDD,
    ndd.Hoten,
    ndd.Chucvu
from
    Doanhnghiep dn
left join 
    Nguoidaidien ndd on dn.MaDN = ndd.MaDN;
select * from vw_thongtin_NDD
INSERT INTO vw_thongtin_NDD (MaDN, TenDN,Masothue, Vondieule,MaNDD, Hoten,Chucvu)
VALUES
('N20', N'Công ty TNHH Gia Lâm','0353535235',12000000,'ND20',N'Nguyễn Văn Dương',N'Giám đốc');
----------------------------------------------------------------------------
DELETE FROM vw_thongtin_NDD
WHERE MaDN = 'N20'
----------------------------------------------------------------------------
UPDATE vw_thongtin_NDD
SET Vondieule = 10000000
WHERE MaDN = 'N16'
--Tạo view trên 3 bảng lấy doang thu và người đại diện các doanh nghiệp
CREATE OR ALTER VIEW vw_thongtin_taichinh AS
SELECT 
    dn.MaDN,
    dn.TenDN,
    dn.Masothue,
    dn.Vondieule,
	dn.Namthanhlap,
	ndd.MaNDD,
    ndd.Hoten,
    ndd.Chucvu,
    bct.Mabaocao, 
    bct.Nam, 
    bct.Doanhthu, 
    bct.Tongtaisan, 
    bct.Ngaybaocao
FROM 
    Doanhnghiep dn
 JOIN 
    Nguoidaidien ndd ON dn.MaDN = ndd.MaDN
 JOIN 
    Baocaotaichinh bct ON dn.MaDN = bct.MaDN;
SELECT * FROM vw_thongtin_taichinh

insert into vw_thongtin_taichinh(MaDN,TenDN,Masothue,Vondieule,Namthanhlap,MaNDD,Hoten,Chucvu,Mabaocao,Nam,Doanhthu,Tongtaisan,Ngaybaocao)
values('N22',N'Công ty Dương Châu','0424424443',10000000,2020,'ND22',N'Cao Thành An',N'Giám đốc','BC22',2022,12000000,20000000,'2020-12-12')

DELETE FROM vw_thongtin_taichinh
WHERE MaDN = 'N22'

UPDATE vw_thongtin_taichinh
SET Chucvu = N'Trưởng phòng'
WHERE MaDN = 'N22'
--Truy vấn toán tử nâng cao và sử dụng các cấu trúc điều khiển--
--Lấy ra tất cả các doanh nghiệp có trạng thái đang hoạt động và vốn điều lệ > 10000000
select * from Doanhnghiep
where Trangthai = N'Đang hoạt động'
and Vondieule > 10000000
--Lấy ra họ tên và chức vụ là 'giám đốc' của các doanh nghiệp có mã N01,N03,N07
select Hoten,Chucvu
from Nguoidaidien
where Chucvu = N'Giám đốc' and MaDN in('N01','N03','N07')
-- Lấy 10% doanh nghiệp có vốn điều lệ cao nhất từ ​​​​bảng Doanhnghiep--
select top(10) percent MaDN, TenDN, Vondieule
from Doanhnghiep
order by Vondieule desc
--Tìm ra 3 doanh nghiệp có doanh thu lớn nhất trong năm 2020--
select top 3 with ties
dn.MaDN,dn.TenDN,bc.Doanhthu
from Doanhnghiep dn
inner join Baocaotaichinh bc
on dn.MaDN = bc.MaDN
where bc.Nam = 2020
order by bc.Doanhthu desc
--Tìm ra các doanh nghiệp có lợi nhuận lớn hơn 3 triệu đồng và số lao động lớn hơn 300, đồng thời hiển thị thông tin về tên doanh nghiệp, tên người đại diện, và tên huyện của doanh nghiệp đó.--
select dn.TenDN,ndd.Hoten,h.Tenhuyen
from Doanhnghiep dn
inner join Baocaotaichinh bc
on dn.MaDN = bc.MaDN
left join Nguoidaidien ndd
on dn.MaDN = ndd.MaDN
inner join Huyen h
on dn.Mahuyen = h.Mahuyen
where bc.Loinhuan > 3000000 and bc.Solaodong > 300
--Phân loại các công ty theo số lao động (Ít, Trung bình, Nhiều).
SELECT dn.TenDN, bc.Solaodong,
       CASE
           WHEN Solaodong < 100 THEN N'Ít'
           WHEN Solaodong BETWEEN 100 AND 500 THEN N'Trung bình'
           ELSE N'Nhiều'
       END AS Nhanluc
FROM Baocaotaichinh bc inner join Doanhnghiep dn 
on bc.MaDN = dn.MaDN
--Lấy doanh nghiệp có ít nhất 1 báo cáo tài chính và đúng 1 người đại diện--
with ndd_cte as(
select dn.MaDN,count(MaNDD) as SLNDD
from Nguoidaidien ndd
inner join Doanhnghiep dn
on ndd.MaDN = dn.MaDN
group by dn.MaDN)
select dn.MaDN,dn.TenDN,SLNDD
from ndd_cte
inner join Doanhnghiep dn on ndd_cte.MaDN = dn.MaDN
where SLNDD = 1
and exists ( select 1 from Baocaotaichinh bc where bc.MaDN = dn.MaDN)
--kiểm tra xem có doanh nghiệp nào có doanh thu dưới 10 triệu --
begin try
       if exists( select 1 from Baocaotaichinh where Doanhthu < 10000000)
       begin
	   select dn.MaDN, dn.TenDN, bc.Doanhthu, bc.Nam
       from Doanhnghiep dn
       inner join Baocaotaichinh bc on dn.MaDN = bc.MaDN
       where bc.Doanhthu < 10000000
	   end
	   else
	   print N'Không doanh nghiệp nào doanh thu dưới 10 triệu'
end try
begin catch
       print N'Lỗi :' + Error_Message()
end catch
--lấy 3 doanh nghiệp có doanh thu cao nhất theo từng năm--
WITH Xeploai_cte AS (
    SELECT 
        bc.MaDN,
        dn.TenDN,
        bc.Nam,
        bc.Doanhthu,
        RANK() OVER (PARTITION BY bc.Nam ORDER BY bc.Doanhthu DESC) AS XepLoai
    FROM Baocaotaichinh bc
    INNER JOIN Doanhnghiep dn ON bc.MaDN = dn.MaDN
)
SELECT MaDN, TenDN, Nam, Doanhthu, XepLoai
FROM Xeploai_cte
WHERE XepLoai <= 3
ORDER BY Nam, XepLoai
--Lấy doanh thu của các doanh nghiệp theo từng năm.   
SELECT *
FROM (
    SELECT 
        bc.MaDN, 
        dn.TenDN, 
        bc.Nam, 
        bc.Doanhthu
    FROM Baocaotaichinh bc
    JOIN Doanhnghiep dn ON bc.MaDN = dn.MaDN
) AS Bangnguon
PIVOT (
    SUM(Doanhthu) FOR Nam IN ([2012], [2013], [2014], [2015], [2016], [2017], [2018], [2019], [2020], [2021])
) AS PivotTable;
--Viết các thủ tục--
--Thủ tục chèn dữ liệu vào bảng Nguoidaidien--
create or alter proc sp_insert 
@MaNND char(10),
@Hoten nvarchar(50),
@Ngaysinh date,
@Gioitinh bit,
@Cancuoc char(20),
@Sodienthoai char(15),
@Email char(20),
@Chucvu nvarchar(50),
@MaDN char(10)
as
begin
    if exists(select MaNDD from Nguoidaidien where MaNDD = @MaNND)
	begin
	print N'Mã đã tồn tại: ' + cast(@MaNND as nvarchar(20))
	return -1
	end
	if not exists(select MaDN from Doanhnghiep where MaDN = @MaDN)
	begin
	print N'Mã không tồn tại :' + cast(@MaDN as nvarchar(20))
	return -1
	end
	else
	begin
	insert into Nguoidaidien(MaNDD,Hoten,Ngaysinh,Gioitinh,Cancuoc,Sodienthoai,Email,Chucvu,MaDN)
	values(@MaNND,@Hoten,@Ngaysinh,@Gioitinh,@Cancuoc,@Sodienthoai,@Email,@Chucvu,@MaDN)
	print N'Insert thành công'
	return 0
	end
end
--Không chạy được do lỗi về khoá chính 
sp_insert 'ND15',N'Trần Minh Tuấn','1982-12-31',1,'0332040080','0923224442','tuan@gmail.com',N'Trưởng phòng','N16'
--Không chạy được do lỗi về khoá ngoại
sp_insert 'ND25',N'Trần Minh Tuấn','1982-12-31',1,'0332040080','0923224442','tuan@gmail.com',N'Trưởng phòng','N17'
---Chạy thành công--
sp_insert 'ND25',N'Trần Minh Tuấn','1982-12-31',1,'0332040080','0923224442','tuan@gmail.com',N'Trưởng phòng','N16'
--Thủ tục xoá dữ liệu từ bảng Nguoidaidien
create or alter proc sp_delete
@MaNDD char(10)
as
begin
    if not exists(select MaNDD from Nguoidaidien where MaNDD = @MaNDD)
	begin
	print N'Mã không tồn tại :' + cast(@MaNDD as nvarchar(20)) + N'không thể xoá'
	return -1
	end
	else
	begin
	delete from Nguoidaidien
	where MaNDD = @MaNDD
	print N'Xoá thành công mã :' + cast(@MaNDD as nvarchar(20))
	return 0
	end
end
--Không xoá được do không tồn tại mã-
sp_delete 'ND18'
--Xoá thành công--
sp_delete 'ND25'
--Thủ tục cập nhật dữ liệu trong bảng người đại diện--
create or alter proc sp_update
@MaNND char(10),
@Hoten nvarchar(50),
@Ngaysinh date,
@Gioitinh bit,
@Cancuoc char(20),
@Sodienthoai char(15),
@Email char(20),
@Chucvu nvarchar(50),
@MaDN char(10)
as
begin
    if not exists(select MaNDD from Nguoidaidien where MaNDD = @MaNND)
	begin
	print N'Mã không tồn tại: ' + cast(@MaNND as nvarchar(20))
	return -1
	end
	if not exists(select MaDN from Nguoidaidien where MaDN = @MaDN)
	begin
	raiserror(N'Không tồn tại mã doanh nghiệp',16,1)
	return -1
	end
	else
	begin
	update Nguoidaidien
    set
            Hoten = @Hoten,
            Ngaysinh = @Ngaysinh,
            Gioitinh = @Gioitinh,
            Cancuoc = @Cancuoc,
            Sodienthoai = @Sodienthoai,
            Email = @Email,
            Chucvu = @Chucvu,
            MaDN = @MaDN
            where MaNDD = @MaNND
	print N'Cập nhật thành công'
	return 0
	end
end
--Cập nhật thất bại--
sp_update 'ND18',N'Trần Minh Tuấn','1982-12-31',1,'0332040080','0923224442','tuan@gmail.com',N'Giám đốc','N16'
--Cập nhật thất bại do lỗi khoá ngoại--
sp_update 'ND25',N'Trần Minh Tuấn','1982-12-31',1,'0332040080','0923224442','tuan@gmail.com',N'Giám đốc','N18'
--Cập nhật thành công--
sp_update 'ND25',N'Trần Minh Tuấn','1982-12-31',1,'0332040080','0923224442','tuan@gmail.com',N'Giám đốc','N16'
--Thủ tục thực hiện chức năng tìm kiếm--
--Lấy ra thông tin NDD theo mã-- 
create or alter proc sp_search
@MaNDD char(10)
as
begin
   if not exists(select MaNDD from Nguoidaidien where MaNDD = @MaNDD)
   begin
   throw 50000,'Mã không tồn tại', 1
   end
   select * from Nguoidaidien
   where MaNDD = @MaNDD
end
--Không chạy được do không tìm thấy--
sp_search 'ND18'
--Chạy thành công--
sp_search 'ND16'
--Thủ tục thực hiện thống kê,tính toán--
create or alter proc sp_count
@MaDN char(10)
as
begin
   if not exists(select MaDN from Doanhnghiep where MaDN = @MaDN)
   begin
   throw 50000,'Mã không tồn tại', 1
   end
   select count(*) as SoLuongNguoiDaiDien
   from Nguoidaidien
   where MaDN = @MaDN;
end
--Không chạy được--
sp_count 'N18'
--Chạy được--
sp_count 'N16'
--Tạo hàm trả về giá trị--
create function fn_Songuoidaidien(@MaDN char(10))
returns int
as
begin
    declare @Soluong int
	if not exists(select MaDN from Doanhnghiep where MaDN = @MaDN)
    begin
	throw 50000,'Mã không tồn tại', 1
    return -1
    end
	select @SoLuong = count(*)
    from Nguoidaidien
    where MaDN = @MaDN
	return @Soluong;
end
select dbo.fn_Songuoidaidien('N16') as Soluong
--Tạo hàm trả về giá trị kiểu bảng--
create function fn_table(@MaDN char(10))
returns table
as
    return (select * from Doanhnghiep
	        where MaDN = @MaDN)
--Chạy trả về dữ liệu bảng--
select * from dbo.fn_table('N16')
--Tạo trigger insert--
create or alter trigger tg_insert
on Nguoidaidien
after insert
as
begin
    declare @MaNDD char(10) = (select MaNDD from inserted)
	declare @Hoten nvarchar(50) = (select Hoten from inserted)
	declare @Ngaysinh date = (select Ngaysinh from inserted)
	declare @Gioitinh tinyint = (select Gioitinh from inserted)
	declare @Cancuoc char(20) = (select Cancuoc from inserted)
	declare @Sodienthoai char(15) = (select Sodienthoai from inserted)
	declare @MaDN char(10) = (select MaDN from inserted)
	if exists (select 1 from Nguoidaidien where MaNDD = @MaNDD and MaNDD <> (select MaNDD from inserted))
	begin
	print N'Mã đã tồn tại :' + cast(@MaNDD as nvarchar(20))
	rollback
	return
	end
	if not exists (select MaDN from DoanhNghiep where MaDN = @MaDN)
    begin
        print N'Mã Doanh Nghiệp không tồn tại :' + cast(@MaDN as nvarchar(20))
        rollback
        return
    end
	if len(@Hoten) = 0
    begin
        print N'Họ tên không được để trống'
        rollback
        return
    end
	if @Ngaysinh >= getdate() or @Ngaysinh < '1900-01-01'
    begin
        print N'Ngày sinh không hợp lệ: ' + cast(@Ngaysinh as nvarchar(20))
        rollback
        return
    end
	if @Gioitinh not in (0, 1)
    begin
        print N'Giới tính không hợp lệ: ' + cast(@Gioitinh as nvarchar(20))
        rollback
        return
    end
	if len(@Sodienthoai) != 10 
	begin
        print N'Số điện thoại không hợp lệ: ' + cast(@Sodienthoai as nvarchar(20))
        rollback
        return
    end
	if exists (select Sodienthoai from Nguoidaidien where Sodienthoai = @Sodienthoai and Sodienthoai <> (select Sodienthoai from inserted))
    begin
        print N'Số điện thoại đã tồn tại: ' + cast(@Sodienthoai as nvarchar(20))
        rollback
        return
    end
	if len(@Cancuoc) != 10
    begin
        print N'Căn cước không hợp lệ: ' + cast(@Cancuoc as nvarchar(20))
        rollback
        return
    end
	if exists (select Cancuoc from Nguoidaidien where Cancuoc = @Cancuoc and CanCuoc <> (select Cancuoc from inserted))
    begin
        print N'Căn cước đã tồn tại: ' + cast(@Cancuoc as nvarchar(20))
        rollback
        return
    end
	print N'Insert thành công'

end
insert into Nguoidaidien(MaNDD,Hoten,Ngaysinh,Gioitinh,Cancuoc,Sodienthoai,Email,Chucvu,MaDN)
values
('ND40',N'Trần Minh Vương','1980-12-31',1,'0332040083','0876666666','vuong@gmail.com',N'Trưởng phòng','N16')
--Tạo trigger update--
create or alter trigger tg_update
on Nguoidaidien
instead of update
as
begin
    
    declare @MaNDD char(10) = (select MaNDD from inserted)
    declare @Hoten nvarchar(50) = (select Hoten from inserted)
    declare @Ngaysinh date = (select Ngaysinh from inserted)
    declare @Gioitinh tinyint = (select Gioitinh from inserted)
    declare @Cancuoc char(20) = (select Cancuoc from inserted)
    declare @Sodienthoai char(15) = (select Sodienthoai from inserted)
    declare @MaDN char(10) = (select MaDN from inserted)
    if exists (select MaNDD from Nguoidaidien where MaNDD = @MaNDD and MaNDD != (select MaNDD from deleted))
    begin
        print N'Mã đã tồn tại :' + cast(@MaNDD as nvarchar(20))
        rollback
        return
    end
    if not exists (select MaDN from DoanhNghiep where MaDN = @MaDN)
    begin
        print N'Mã Doanh Nghiệp không tồn tại :' + cast(@MaDN as nvarchar(20))
        rollback
        return
    end
    if len(@Hoten) = 0
    begin
        print N'Họ tên không được để trống'
        rollback
        return
    end
    if @Ngaysinh >= getdate() or @Ngaysinh < '1900-01-01'
    begin
        print N'Ngày sinh không hợp lệ: ' + cast(@Ngaysinh as nvarchar(20))
        rollback
        return
    end
    
    -- Validate Gioitinh
    if @Gioitinh not in (0, 1)
    begin
        print N'Giới tính không hợp lệ: ' + cast(@Gioitinh as nvarchar(20))
        rollback
        return
    end
    if len(@Sodienthoai) != 10 
    begin
        print N'Số điện thoại không hợp lệ: ' + cast(@Sodienthoai as nvarchar(20))
        rollback
        return
    end
    if exists (select 1 from Nguoidaidien where Sodienthoai = @Sodienthoai and Sodienthoai != (select Sodienthoai from deleted))
    begin
        print N'Số điện thoại đã tồn tại: ' + cast(@Sodienthoai as nvarchar(20))
        rollback
        return
    end
    if len(@Cancuoc) != 10
    begin
        print N'Căn cước không hợp lệ: ' + cast(@Cancuoc as nvarchar(20))
        rollback
        return
    end
    if exists (select 1 from Nguoidaidien where Cancuoc = @Cancuoc and Cancuoc != (select Cancuoc from deleted))
    begin
        print N'Căn cước đã tồn tại: ' + cast(@Cancuoc as nvarchar(20))
        rollback
        return
    end
    update Nguoidaidien
    set MaDN = @MaDN, Hoten = @Hoten, Ngaysinh = @Ngaysinh, Gioitinh = @Gioitinh, 
        Cancuoc = @Cancuoc, Sodienthoai = @Sodienthoai
    where MaNDD = @MaNDD

    print N'Update thành công'
end

update Nguoidaidien
set Chucvu = N'Giám đốc'
where MaNDD = 'ND40'
--Tạo trigger xoá--
create or alter trigger tg_delete
on Nguoidaidien
after delete
as
begin
    declare @MaNDD char(10) = (select MaNDD from deleted)
	if not exists (select MaNDD from Nguoidaidien where MaNDD = @MaNDD)
	begin
	print N'Mã người đại diện không tồn tại'
	rollback
	return end
    print N'Xóa thành công Mã Người Đại Diện: ' + cast(@MaNDD as nvarchar(20))
end

delete from Nguoidaidien
where MaNDD = 'ND40'

--Tạo trigger instead of--
create or alter trigger tg_insert_insteadof
on Nguoidaidien
instead of insert
as
begin
    declare @MaNDD char(10) = (select MaNDD from inserted)
	declare @Hoten nvarchar(50) = (select Hoten from inserted)
	declare @Ngaysinh date = (select Ngaysinh from inserted)
	declare @Gioitinh tinyint = (select Gioitinh from inserted)
	declare @Cancuoc char(20) = (select Cancuoc from inserted)
	declare @Sodienthoai char(15) = (select Sodienthoai from inserted)
	declare @MaDN char(10) = (select MaDN from inserted)
	if exists (select MaNDD from Nguoidaidien where MaNDD = @MaNDD)
	begin
	print N'Mã đã tồn tại :' + cast(@MaNDD as nvarchar(20))
	rollback
	return
	end
	if not exists (select MaDN from DoanhNghiep where MaDN = @MaDN)
    begin
        print N'Mã Doanh Nghiệp không tồn tại :' + cast(@MaDN as nvarchar(20))
        rollback
        return
    end
	if len(@Hoten) = 0
    begin
        print N'Họ tên không được để trống'
        rollback
        return
    end
	if @Ngaysinh >= getdate() or @Ngaysinh < '1900-01-01'
    begin
        print N'Ngày sinh không hợp lệ: ' + cast(@Ngaysinh as nvarchar(20))
        rollback
        return
    end
	if @Gioitinh not in (0, 1)
    begin
        print N'Giới tính không hợp lệ: ' + cast(@Gioitinh as nvarchar(20))
        rollback
        return
    end
	if len(@Sodienthoai) != 10 
	begin
        print N'Số điện thoại không hợp lệ: ' + cast(@Sodienthoai as nvarchar(20))
        rollback
        return
    end
	if exists (select Sodienthoai from Nguoidaidien where Sodienthoai = @Sodienthoai)
    begin
        print N'Số điện thoại đã tồn tại: ' + cast(@Sodienthoai as nvarchar(20))
        rollback
        return
    end
	if len(@Cancuoc) != 10
    begin
        print N'Căn cước không hợp lệ: ' + cast(@Cancuoc as nvarchar(20))
        rollback
        return
    end
	if exists (select Sodienthoai from Nguoidaidien where Cancuoc = @Cancuoc)
    begin
        print N'Căn cước đã tồn tại: ' + cast(@Cancuoc as nvarchar(20))
        rollback
        return
    end
	else
	begin
	insert into Nguoidaidien
    select * from inserted
    print N'Insert thành công'
	end
end
insert into Nguoidaidien(MaNDD,Hoten,Ngaysinh,Gioitinh,Cancuoc,Sodienthoai,Email,Chucvu,MaDN)
values
('ND55',N'Trần Minh Thọ','1980-12-31',1,'0332040755','0923224643','tho@gmail.com',N'Trưởng phòng','N08')
--Tạo trigger instead of--
create or alter trigger tg_instead_of_delete
on Nguoidaidien
instead of delete
as 
begin
    DECLARE @MaNDD char(10) = (SELECT MaNDD FROM deleted)
    IF NOT EXISTS (SELECT 1 FROM Nguoidaidien WHERE MaNDD = @MaNDD)
    BEGIN
        PRINT N'Mã người đại diện không tồn tại: ' + CAST(@MaNDD as nvarchar(20))
    END
    ELSE
    BEGIN
        DELETE FROM Nguoidaidien WHERE MaNDD = @MaNDD
        PRINT N'Xóa thành công: ' + CAST(@MaNDD as nvarchar(20))
    END
END
delete from Nguoidaidien
where MaNDD = 'ND35'
--Trigger dây chuyền--
create or alter trigger tg_instead_of_delete_Doanhnghiep
on Doanhnghiep
INSTEAD OF DELETE
AS
BEGIN
    -- Xóa bản ghi liên quan trong bảng Nguoidaidien
    DELETE FROM Nguoidaidien
    WHERE MaDN IN (SELECT MaDN FROM deleted);

    -- Xóa bản ghi liên quan trong bảng Baocaotaichinh
    DELETE FROM Baocaotaichinh
    WHERE MaDN IN (SELECT MaDN FROM deleted);
    
    -- Cuối cùng xóa bản ghi trong bảng Doanhnghiep
    DELETE FROM Doanhnghiep
    WHERE MaDN IN (SELECT MaDN FROM deleted);
    
    PRINT N'Xóa doanh nghiệp và các bản ghi liên quan thành công';
END;
delete from Doanhnghiep
where MaDN = 'N16'
--Tạo trigger tự động cập nhật--
ALTER TABLE Doanhnghiep
ADD Ngaychinhsua DATETIME
CREATE OR ALTER TRIGGER tg_update_ngaybaocao
ON Baocaotaichinh
AFTER INSERT, UPDATE
AS
BEGIN
    UPDATE Doanhnghiep
    SET Ngaychinhsua = GETDATE()
    WHERE MaDN IN (SELECT MaDN FROM inserted);
END;
UPDATE Baocaotaichinh
SET Doanhthu = 13000000
WHERE MaDN = 'N01';
select * from Doanhnghiep

