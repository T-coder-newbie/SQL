create database NguyenVanThang
use NguyenVanThang
create table Phong(
MaPhong char(10) primary key,
SoPhong char(10),
LoaiPhong nvarchar(20),
SucChua tinyint,
Dongia_phong decimal,
Trangthai nvarchar(20))
go
create table KhachHang(
MaKH char(10) primary key,
HoTen nvarchar(30),
NamSinh date,
SoDienThoai char(15),
Diachi nvarchar(30))
go
create table DatPhong(
MaDatPhong char(10) primary key,
MaKH char(10) foreign key references KhachHang(MaKH),
MaPhong char(10) foreign key references Phong(MaPhong),
NgayNhanPhong date,
NgayTraPhong date,
NgayDat date)
go
create table NhanVien(
MaNhanVien char(10) primary key,
HoTen nvarchar(30),
Ngaysinh date,
SoDienThoai char(15),
Email char(20))
go
create table DichVu(
MaDichVu char(10) primary key,
TenDichVu nvarchar(30),
DonGiaDV decimal,
MoTa nvarchar(50))
go
create table SuDungDichVu(
MaSuDung char(10) primary key,
MaDatPhong char(10) foreign key references DatPhong(MaDatPhong),
MaDichVu char(10) foreign key references DichVu(MaDichVu),
SoLuong int)
go
create table BangThanhToan(
MaThanhToan char(10),
MaDatPhong char(10) foreign key references DatPhong(MaDatPhong),
MaNhanVien char(10) foreign key references NhanVien(MaNhanVien),
Primary key(MaThanhToan,MaDatPhong,MaNhanVien),
NgayThanhToan date)

insert into Phong(MaPhong,SoPhong,LoaiPhong,SucChua,Dongia_phong,Trangthai)
values('MP01','012',N'Phòng Nhỏ',2,20000,N'Đã đặt'),
('MP02','013',N'Phòng Vừa',3,30000,N'Đã đặt'),
('MP03','014',N'Phòng VIP',5,50000,N'Đã đặt'),
('MP04','015',N'Phòng VIP1',5,50000,N'Đang trống'),
('MP05','016',N'Phòng VIP2',5,50000,N'Đang trống')


go
insert into KhachHang(MaKH,HoTen,NamSinh,SoDienThoai,Diachi)
values('KH01',N'Nguyễn Văn Thắng','2004-04-28','0121313344',N'Hưng Yên'),
('KH02',N'Nguyễn Thị Hương','2000-05-28','0121343434',N'Hải Dương'),
('KH03',N'Nguyễn Duy Thuấn','2004-12-28','0121313345',N'Hưng Yên')
go
insert into DatPhong(MaDatPhong,MaKH,MaPhong,NgayNhanPhong,NgayTraPhong,NgayDat)
values('DP01','KH01','MP01','2022-12-12','2022-12-20','2022-11-21'),
('DP02','KH02','MP02','2022-12-24','2022-12-30','2022-12-21'),
('DP03','KH03','MP03','2022-12-23','2022-12-29','2022-11-30')
go
insert into NhanVien(MaNhanVien,HoTen,Ngaysinh,SoDienThoai,Email)
values('NV01',N'Nguyễn Lan Hường','2004-12-12','022131333','huong@gmail.com'),
('NV02',N'Nguyễn Minh Thông','2003-12-12','024131333','thong@gmail.com'),
('NV03',N'Bùi Ngọc Tài','2003-12-10','025131333','tai@gmail.com')
go
insert into DichVu(MaDichVu,TenDichVu,DonGiaDV,MoTa)
values('DV01',N'Giặt là',2000,N'Không'),
('DV02',N'Lau nhà',1000,N'Không'),
('DV03',N'Rửa chén',3000,N'Không')
insert into SuDungDichVu(MaSuDung,MaDatPhong,MaDichVu,SoLuong)
values('SD01','DP01','DV01',2),
('SD02','DP02','DV02',2),
('SD03','DP03','DV03',2)
go
insert into BangThanhToan(MaThanhToan,MaDatPhong,MaNhanVien,NgayThanhToan)
values('TT01','DP01','NV01','2022-12-20'),
('TT02','DP02','NV02','2022-12-30'),
('TT03','DP03','NV03','2022-12-29')
select * from Phong
select * from KhachHang

--Câu 4--
exec sp_fulltext_database 'enable'
create fulltext catalog IdxNV
with accent_sensitivity = off
as default
create fulltext index on NhanVien(HoTen)
key index [PK__NhanVien__77B2CA47A635C415] on IdxNV
select * from NhanVien
where contains(HoTen,'"Nguyen" or "Bui"')
select * from NhanVien
where freetext(HoTen,'Nguyen Bui')
--Câu 5--
select a.MaThanhToan,a.MaDatPhong,a.Soluongphongdadat,sum(a.Dongia_phong*Songay) as Tongtienphong
from(
select btt.MaThanhToan,dp.MaDatPhong,p.Dongia_phong,count(dp.Maphong) as Soluongphongdadat,datediff(dd,dp.NgayNhanPhong,dp.NgayTraPhong) as Songay
from BangThanhToan btt
right join DatPhong dp 
on btt.MaDatPhong = dp.MaDatPhong
join Phong p
on dp.MaPhong = p.MaPhong
group by  btt.MaThanhToan,dp.MaDatPhong,dp.Maphong,dp.NgayNhanPhong,dp.NgayTraPhong,p.Dongia_phong) as a
group by a.MaThanhToan,a.MaDatPhong,a.Soluongphongdadat,a.Dongia_phong,a.Songay
--Câu 6--
Select top 1 MaNhanVien,HoTen,Ngaysinh,SoDienThoai,Email,datediff(yyyy,Ngaysinh,getdate()) as Tuoi 
from NhanVien
--Câu 7--
select top 1 p.*,count(p.Maphong) as SLDat from DatPhong dp
join KhachHang kh
on dp.MaKH = kh.MaKH
right join Phong p
on dp.MaPhong = p.MaPhong
group by p.MaPhong,p.SoPhong,p.LoaiPhong,p.SucChua,p.Dongia_phong,p.Trangthai
order by SLDat desc
--Câu 8--
create proc sp_nhap @Masudung char(10),@Madatphong char(10),@Madichvu char(10),@Soluong int
as
begin
    if exists(select MaSuDung from SuDungDichVu where MaSuDung = @Masudung)
	begin
	print N'Mã đã tồn tại: ' + cast(@Masudung as nvarchar(20))
	return -1
	end
	if not exists(select MaDatPhong from SuDungDichVu where MaDatPhong = @Madatphong)
	begin
	print N'Mã không tồn tại: ' + cast(@Madatphong as nvarchar(20))
	return -1
	end
	if not exists(select MaDichVu from SuDungDichVu where MaDichVu = @Madichvu)
	begin
	print N'Mã không tồn tại: ' + cast(@Madichvu as nvarchar(20))
	return -1
	end
	else
	begin
	insert into SuDungDichVu(MaSuDung,MaDatPhong,MaDichVu,SoLuong)
	values(@Masudung,@Madatphong,@Madichvu,@Soluong)
	print N'Insert thành công'
	end
end
sp_nhap 'SD06','DP01','DV01',3
--Câu 9--
CREATE or alter TRIGGER trg_CheckRoomStatus
ON DatPhong
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @MaPhong CHAR(10);
    DECLARE @TrangThai NVARCHAR(50);

    SELECT @MaPhong = MaPhong FROM INSERTED;
    SELECT @TrangThai = TrangThai FROM Phong WHERE MaPhong = @MaPhong;
    IF @TrangThai = N'Đang trống'
    BEGIN
        INSERT INTO DatPhong (MaDatPhong, MaKH, MaPhong, NgayNhanPhong, NgayTraPhong, NgayDat)
        SELECT MaDatPhong, MaKH, MaPhong, NgayNhanPhong, NgayTraPhong, NgayDat
        FROM INSERTED;
    END
    ELSE
    BEGIN
        PRINT N'Phòng không trống, không thể đặt phòng: ' + @MaPhong;
		rollback;
    END
END;
--Không được-
INSERT INTO DatPhong (MaDatPhong, MaKH, MaPhong, NgayNhanPhong, NgayTraPhong, NgayDat)
VALUES ('DP04', 'KH02', 'MP03', '2023-01-01', '2023-01-10', '2022-12-20');
--Chạy được
INSERT INTO DatPhong (MaDatPhong, MaKH, MaPhong, NgayNhanPhong, NgayTraPhong, NgayDat)
VALUES ('DP04', 'KH02', 'MP05', '2023-01-01', '2023-01-10', '2022-12-20');

