--Bài 13.3--
--Bài 1--
create trigger trInsSV_LOP
on SinhVien
for insert
as
begin
  update Lop
  set Siso += 1
  where Lop.Malop = (select Malop from inserted)
end
select * from Lop
insert into Sinhvien(Masv,Hoten,Ngaysinh,Gioitinh,Noisinh,Malop)
values('sv05',N'Nguyễn Thị Hoa','1978-12-08',0,N'Hưng Yên','SEK21.3')
--Bài 2--
create trigger TG_DELETELOP 
on Lop
with encryption
for delete
as
begin
 if (@@ROWCOUNT <= 0)
 begin
 print N'Không có lớp nào trong bảng'
 rollback tran
 end
else
begin
     delete from Sinhvien
     where Sinhvien.Malop = (select Malop from deleted)
end
end
delete from Lop
where Malop = 'SEK21.4'
--Bài 3--
create trigger tg_NoupdateHT
on SinhVien
for update
as
 if UPDATE(Hoten)
 begin
 print N'Không được sửa dữ liệu trên cột Hoten'
 rollback tran
 end
 update Sinhvien
 set Hoten = N'Trần Thị Lý'
 where Masv = 'SV01'
--Bài 4--
create trigger Tg_DeleteNoSV
on Lop
instead of delete
as
begin
if(select count(*) from Sinhvien sv,deleted d where sv.Malop = d.Malop) > 0
begin
raiserror(N'Không xoá được',14,1)
rollback tran
end
else
begin
print N'Xoá thành công'
delete from Lop where Malop in(select Malop from deleted) 
end
end
delete from Lop
where Malop = 'SEK21.2'
--Bài 13.4--
--Bài 1--
CREATE OR ALTER TRIGGER Tg_kiem_tra_sv
ON SinhVien
FOR INSERT
AS
BEGIN
    DECLARE @Masv char(10) = (SELECT Masv FROM inserted)
    DECLARE @Hoten nvarchar(20) = (SELECT Hoten FROM inserted)
    DECLARE @Ngaysinh date = (SELECT Ngaysinh FROM inserted)
    DECLARE @Gioitinh tinyint = (SELECT Gioitinh FROM inserted)
    DECLARE @Noisinh nvarchar(20) = (SELECT Noisinh FROM inserted)
    DECLARE @Malop char(10) = (SELECT malop FROM inserted)

    IF(NOT EXISTS(SELECT Malop FROM Lop WHERE Malop = @Malop))
    BEGIN
        PRINT N'Mã lớp không tồn tại: ' + @Malop
        ROLLBACK TRAN
    END
    ELSE IF(@Gioitinh IN (0,1))
    BEGIN
	PRINT N'Insert thành công' 
    END
    ELSE
    BEGIN
        RAISERROR(N'Insert không thành công',16,1)
		rollback tran
    END
END
--ALTER TABLE SinhVien NOCHECK CONSTRAINT ALL
--ALTER TABLE SinhVien CHECK CONSTRAINT ALL
insert into SinhVien(Masv,Hoten,Ngaysinh,Gioitinh,Noisinh,Malop)
values('sv28',N'Nguyễn Văn Hài','1995-12-12',1,N'Hưng Yên','SEK21.3')
--Câu 2--
create or alter trigger Tg_kiem_tra_Malop
on Lop
instead of insert
as 
begin 
     declare @Malop char(10) = (select Malop from inserted)
	 if exists((select Malop from Lop where Malop = @Malop))
	 begin
	 print N'Mã lớp không được trùng :' + @Malop
	 rollback tran
	 return
	 end
	 else
	 INSERT INTO Lop(Malop,Tenlop,Khoa,Hedaotao,Namnhaphoc)
     SELECT Malop,Tenlop,Khoa,Hedaotao,Namnhaphoc FROM inserted
	 print N'Insert thành công'
end
insert into Lop(Malop,Tenlop,Khoa,Hedaotao,Namnhaphoc)
values('ML12',N'Khoa học',22,N'Chính quy',2020) 
--Câu 3--
create trigger tg_Kiemtra_sv 
on Sinhvien
instead of insert
as
begin
    DECLARE @Masv char(10) = (SELECT Masv FROM inserted)
    DECLARE @Hoten nvarchar(20) = (SELECT Hoten FROM inserted)
    DECLARE @Ngaysinh date = (SELECT Ngaysinh FROM inserted)
    DECLARE @Gioitinh tinyint = (SELECT Gioitinh FROM inserted)
    DECLARE @Noisinh nvarchar(20) = (SELECT Noisinh FROM inserted)
    DECLARE @MaLop NVARCHAR(50);
    DECLARE @Count INT;
	--Lấy số sinh viên từng lớp--
    SELECT @Count = COUNT(*)
    FROM SinhVien
    WHERE MaLop = @MaLop;
    IF @Count >= 10
    BEGIN
        PRINT N'Số lượng sinh viên trong lớp vượt quá 10. Không thể thêm.';
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        INSERT INTO SinhVien (MaSV, HoTen, NgaySinh, GioiTinh, NoiSinh, MaLop)
        values(@Masv,@Hoten,@Ngaysinh,@Gioitinh,@Noisinh,@MaLop)
        PRINT N'Thêm sinh viên thành công.';
    END
END
insert into Sinhvien(MaSV, HoTen, NgaySinh, GioiTinh, NoiSinh, MaLop)
values('sv30',N'Nguyễn Văn Đá','1993-12-12',1,N'Hưng Yên','SEK21.3')
--Câu 4--
create trigger Tg_Kiemtra_Monhoc
on Diemthi
After Insert, Update
As
Begin
    If Exists (Select i.MaSV, i.KiHoc From inserted i
			   Group By i.MaSV, i.KiHoc
               Having ( Select Count(Distinct d.Mamonhoc)
						From DiemThi d
						Where d.MaSV = i.MaSV 
						And d.KiHoc = i.KiHoc 
						And (d.DiemLan1 Is Not Null Or d.DiemLan2 Is Not Null)) > 6)
    Begin
        Rollback Tran
        Print N'Một SV k được học quá 6 môn trong một kỳ học'
    End
End
insert Diemthi(Mamonhoc,Masv,Kihoc,Diemlan1,Diemlan2)
values('MH008','SV001',1,8,9)
Go
--Câu 5--
create or alter trigger tg_xoa_thong_tin_khoa
on Khoa
instead of delete
as
begin
    declare @Makhoa char(10) = (select Makhoa from deleted)

	delete from Lop
	where Makhoa = @Makhoa
	delete from Khoa 
	where Makhoa = @Makhoa
	print N'Xoá thành công'
	select * from deleted
end
delete from Khoa 
where Makhoa = 5
--Câu 7--
create or alter trigger tg_thay_doi_malop 
on lop
after update
as
begin
     declare @Malopcu char(10) = (select malop from deleted)
	 declare @Malopmoi char(10) = (select malop from inserted)
	 update lop
	 set Malop = @Malopmoi
	 where Malop = @Malopcu
	 update Sinhvien
	 set Malop = @Malopmoi
	 where Malop = @Malopcu
end
select * from Lop
select * from SinhVien
update Lop
set Malop = 'ML008'
where Malop = 'ML08'
--Câu 9--
CREATE OR ALTER TRIGGER Tg_KiemTraMaMonHoc
ON MonHoc
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM inserted
        WHERE LEFT(Mamonhoc, 2) <> 'MH'
    )
    BEGIN
        PRINT N'Mã môn học phải bắt đầu bằng "MH".';
        ROLLBACK TRANSACTION; 
        RETURN
    END

    
    INSERT INTO MonHoc (Mamonhoc, Tenmonhoc,Sotinchi)
    SELECT Mamonhoc, Tenmonhoc,Sotinchi
    FROM inserted;
END;
GO
insert into Monhoc(Mamonhoc,Tenmonhoc,Sotinchi)
values ('MH011',N'Công nghệ thông tin',2)
--Câu 10--
CREATE OR ALTER TRIGGER Tg_KiemTraMaMonHoc
ON MonHoc
INSTEAD OF INSERT
AS
BEGIN
   
    IF EXISTS (
        SELECT 1 
        FROM inserted
        WHERE LEFT(Mamonhoc, 2) <> 'MH'
    )
    BEGIN
        PRINT N'Mã môn học phải bắt đầu bằng "MH".';
        ROLLBACK TRANSACTION; 
        RETURN; 
    END

   
    IF EXISTS (
        SELECT 1 
        FROM inserted i
        JOIN MonHoc m ON i.Mamonhoc = m.Mamonhoc
    )
    BEGIN
        PRINT N'Mã môn học đã tồn tại.';
        ROLLBACK TRANSACTION; 
        RETURN; 
    END

   
    INSERT INTO MonHoc (Mamonhoc, Tenmonhoc,Sotinchi)
    SELECT Mamonhoc, Tenmonhoc,Sotinchi
    FROM inserted;
END;
GO
insert into Monhoc (Mamonhoc,Tenmonhoc,Sotinchi)
values ('MH001',N'Kĩ thuật',4)
--Bài tập về nhà--
create database QLDTKH
go
use QLDTKH
create table SinhVien(
Masv char(10) primary key,
Hoten nvarchar(20),
Diachi nvarchar(30),
Lop char(10))
create table Detai(
MaDT char(10) primary key,
TenDT nvarchar(20))
create table SinhVien_Detai(
Masv char(10) foreign key references SinhVien(Masv),
MaDT char(10) foreign key references Detai(MaDT),
primary key(Masv,MaDT))
create table Hocvi(
MaHV char(10) primary key,
TenHV nvarchar(20))
create table Giaovien(
MaGV char(10) primary key,
Hoten nvarchar(20),
Diachi nvarchar(20),
MaHV char(10) foreign key references HocVi(MaHV))
create table GiaoVien_Detai(
MaGV char(10) foreign key references GiaoVien(MaGV),
MaDT char(10) foreign key references Detai(MaDT),
primary key(MaGV,MaDT))
create table KetQua(
Masv char(10) foreign key references SinhVien(Masv),
MaDT char(10) foreign key references Detai(MaDT),
Diem float)
-- Chèn bản ghi vào bảng SinhVien
INSERT INTO SinhVien (Masv, Hoten, Diachi, Lop) VALUES
('SV001', N'Nguyễn Văn An', N'Hà Nội', 'CNTT01'),
('SV002', N'Trần Thị Bảo', N'Hồ Chí Minh', 'CNTT02'),
('SV003', N'Phạm Văn Cấc', N'Da Nang', 'CNTT01'),
('SV004', N'Nguyễn Văn Dương', N'Hải Phòng', 'CNTT03'),
('SV005', N'Trần Thị Yến', N'Đà Lạt', 'CNTT02');

-- Chèn bản ghi vào bảng Detai
INSERT INTO Detai (MaDT, TenDT) VALUES
('DT001', N'Đề Tài 1'),
('DT002', N'Đề Tài 2'),
('DT003', N'Đề Tài 3'),
('DT004', N'Đề Tài 4'),
('DT005', N'Đề Tài 5');

-- Chèn bản ghi vào bảng SinhVien_Detai
INSERT INTO SinhVien_Detai (Masv, MaDT) VALUES
('SV001', 'DT001'),
('SV001', 'DT002'),
('SV002', 'DT001'),
('SV003', 'DT003'),
('SV004', 'DT004'),
('SV005', 'DT005'),
('SV002', 'DT002'),
('SV003', 'DT001'),
('SV004', 'DT003'),
('SV005', 'DT004');

-- Chèn bản ghi vào bảng Hocvi
INSERT INTO Hocvi (MaHV, TenHV) VALUES
('HV001', N'Tiến Sĩ'),
('HV002', N'Thạc sĩ'),
('HV003', N'Cử Nhân');

-- Chèn bản ghi vào bảng Giaovien
INSERT INTO Giaovien (MaGV, Hoten, Diachi, MaHV) VALUES
('GV001', N'Nguyễn Văn Anh', N'Hà Nội', 'HV001'),
('GV002', N'Trần Thị Trân', N'Hồ Chí Minh', 'HV002'),
('GV003', N'Phạm Văn Thành', N'Thanh Hoá', 'HV003');

-- Chèn bản ghi vào bảng GiaoVien_Detai
INSERT INTO GiaoVien_Detai (MaGV, MaDT) VALUES
('GV001', 'DT001'),
('GV002', 'DT002'),
('GV003', 'DT003'),
('GV001', 'DT004'),
('GV002', 'DT005');

-- Chèn bản ghi vào bảng KetQua
INSERT INTO KetQua (Masv, MaDT, Diem) VALUES
('SV001', 'DT001', 8.5),
('SV001', 'DT002', 9.0),
('SV002', 'DT001', 7.5),
('SV003', 'DT003', 8.0),
('SV004', 'DT004', 6.5),
('SV005', 'DT005', 9.5),
('SV002', 'DT002', 8.0),
('SV003', 'DT001', 7.0),
('SV004', 'DT003', 8.5),
('SV005', 'DT004', 9.0);
--Câu 1--
create trigger tg_Hocvi
on Hocvi
instead of delete
as
begin
    if(exists(select d.MaHV from deleted d,Giaovien gv where d.MaHV = gv.MaHV))
	begin
	print N'Không thể xoá học vị này'
	rollback tran
	return
	end
end
--Câu 2--
create trigger tg_Xoa_sv
on SinhVien
instead of delete
as
begin
    declare @Masv char(10) = (select Masv from deleted)
	delete from SinhVien_Detai
	where Masv = @Masv
	delete from SinhVien
	where Masv = @Masv
end
