--VD Mẫu--
--In ra các số nguyên lẻ từ 1 đến 10
declare @t1 int
set @t1 = 1
while(@t1 < 10)
begin
   print @t1 -- print N'Số cần in :' + cast(@t1 as nvarchar(11))--
   set @t1 = @t1 + 2
end
go
--VD2--
declare @so_luong int
select @so_luong = count(Masv)
from Sinhvien
where Noisinh = N'Hưng Yên'
if(@so_luong >= 10)
 select Masv,Hoten,Gioitinh
 from Sinhvien
 where Noisinh = N'Hưng Yên'
 else
select Masv,Hoten,Gioitinh
from Sinhvien
--VD3--
use QLSP
create table hanghoa
(Mahang char(10) primary key,
Tenhang nvarchar(30)
)
go
create table hoadon
(Mahoadon char(10) primary key,
Tenhoadon nvarchar(30)
)
go
create table hoadonban
(Mahoadon char(10) foreign key references hoadon(Mahoadon),
Mahang char(10) foreign key references hanghoa(Mahang),
trigiaban int,
primary key(Mahoadon,Mahang)
)
go
create table hoadonmua
(Mahoadon char(10) foreign key references hoadon(Mahoadon),
Mahang char(10) foreign key references hanghoa(Mahang),
trigiamua int,
primary key(Mahoadon,Mahang)
)
INSERT INTO hanghoa (Mahang, Tenhang) VALUES 
('HH001', N'Hàng hóa 1'),
('HH002', N'Hàng hóa 2'),
('HH003', N'Hàng hóa 3'),
('HH004', N'Hàng hóa 4'),
('HH005', N'Hàng hóa 5');
INSERT INTO hoadon (Mahoadon, Tenhoadon) VALUES 
('HD001', N'Hóa đơn 1'),
('HD002', N'Hóa đơn 2'),
('HD003', N'Hóa đơn 3'),
('HD004', N'Hóa đơn 4'),
('HD005', N'Hóa đơn 5');
INSERT INTO hoadonban (Mahoadon, Mahang, Trigiaban) VALUES 
('HD001', 'HH001', 100000),
('HD001', 'HH002', 150000),
('HD002', 'HH003', 200000),
('HD003', 'HH004', 250000),
('HD004', 'HH005', 300000);
INSERT INTO hoadonmua (Mahoadon, Mahang, Trigiamua) VALUES 
('HD001', 'HH001', 90000),
('HD002', 'HH002', 140000),
('HD003', 'HH003', 190000),
('HD004', 'HH004', 240000),
('HD005', 'HH005', 290000);

IF EXISTS (SELECT trigiaban FROM hoadonban WHERE trigiaban > 50000)
BEGIN
    UPDATE hoadonban 
    SET trigiaban = trigiaban - trigiaban * 0.2;
END

DECLARE @lon_nhat int
SELECT @lon_nhat = MAX(trigiamua) FROM hoadonmua;

WHILE (@lon_nhat < 80000)
BEGIN
    UPDATE hoadonmua 
    SET trigiamua = trigiamua + trigiamua * 0.2;
END
select * from hoadonban
--VD4--
Select Masv,Hoten,Gioitinh =
    case
	  when Gioitinh = 0 then N'Nữ'
	  else 'Nam'
	end
from Sinhvien