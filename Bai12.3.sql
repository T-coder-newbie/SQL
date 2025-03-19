--VD Mẫu 12.3--
--Bài 1: Mở CSDL QLSV, viết thủ tục lưu tính tổng 10 số nguyên đầu tiên
--Cách 1--
create proc sp_Tong10
as
begin
declare @tong int,@i int
set @tong = 0
set @i = 1
while @i <= 10
begin
set @tong += @i
set @i = @i + 1
end
print N'Tổng của 10 số nguyên đầu tiên là: ' + cast(@tong as nvarchar(20))
end
exec sp_Tong10
drop proc sp_Tong10
--Cách 2-
CREATE PROC SP_tong10ts(@n int)
AS
BEGIN
DECLARE @tong int, @i int
SET @tong=0
SET @i=1
WHILE @i<=@n
BEGIN
SET @tong=@tong+@i
SET @i=@i+1
END
PRINT N'Tổng của n số nguyên đầu tiên là: '+cast(@tong as char(3))
ENDEXEC SP_tong10ts 12
EXEC SP_tong10ts 10
drop proc SP_tong10ts
--Bài 2: Mở CSDL QLSV, viết thủ tục hiện thị thông tin về các sinh viên và về các lớp có trong CSDL
use NguyenVanThang_12523081
create proc sp_select
as
begin
select * from Lop
select * from Sinhvien
end
exec sp_select
drop proc  sp_select
--Bài 3 Mở CSDL QLSV, viết thủ tục thêm thông tin sinh viên vào bảng sinh viên. Biết rằng, thông tin của sinh viên cần nhập được nhận từ các giá trị thông qua các tham số.
CREATE PROC SP_ThemSinhVien
@mssv nvarchar(10),
@hoTen nvarchar(30),
@ngaysinh smalldatetime,
@gioitinh bit,
@noisinh nvarchar(30),
@maLop nvarchar(10)
AS
BEGIN
IF(EXISTS(SELECT * FROM SinhVien s WHERE s.masv = @mssv))
BEGIN
PRINT N'Mã số sinh viên ' + @mssv + N' đã tồn tại'
RETURN -1
END
IF(NOT EXISTS(SELECT * FROM Lop L WHERE L.malop = @maLop))
BEGIN
PRINT N'Mã số lớp ' + @maLop + N' chưa tồn tại'
RETURN -1
END
INSERT INTO SinhVien(masv, hoten, ngaySinh,
gioitinh,noisinh, maLop)
VALUES(@mssv, @hoTen, @ngaysinh, @gioitinh,@noisinh,
@maLop)
RETURN 0 /* procedure tự trả về 0 nếu không RETURN */
END
GO
EXEC SP_ThemSinhVien 'sv10', N'Nguyễn Văn A', '1997/09/08',0, N'Thái Bình', 'SEK18.6'
select * from Sinhvien
drop proc SP_ThemSinhVien
--Bài 4: Mở CSDL QLSV, viết thủ tục tính tổng 2 số.
CREATE PROCEDURE sp_Conghaiso ( 
 @a INT, 
 @b INT, 
 @c INT OUTPUT) 
 AS 
 BEGIN
 SELECT @c=@a+@b
 END
DECLARE @tong INT 
SELECT @tong=0 
EXECUTE sp_Conghaiso 100, 180, @tong OUTPUT
SELECT @tong 
DROP PROC sp_Conghaiso
--Bài 5 Mở CSDL QLSV, viết thủ tục để tính số lượng sinh viên của mỗi lớp (mặc định là lớp có mã ‘SEK21.2’)
CREATE PROC Soluong_Phong_Default 
@TSMalop nvarchar (10)='SEK21.2',
@SLSV int OUTPUT
AS
SELECT @SLSV = COUNT (MASV)
FROM lop LEFT JOIN sinhvien 
ON lop.malop =sinhvien.malop 
WHERE LOP.malop=@TSMalop 
GO
-- Gọi thủ tục:
DECLARE @dem INT;
SELECT @dem =0
--trường hợp nhận giá trị của tham số mặc định:
EXEC Soluong_Phong_Default @SLSV= @dem OUTPUT
select @dem as SLSV
--Lời gọi với một giá trị khác của tham số:
declare @dem int
EXEC Soluong_Phong_Default 'SEK18.1', @dem OUTPUT
SELECT @dem SLSV
drop proc Soluong_Phong_Default 
--Bài 6 Viết thủ tục lấy ra danh sách sinh viên theo mã lớp
CREATE PROC spDanhSachSinhVien
@maLop varchar(10)
 WITH ENCRYPTION
AS
BEGIN
IF(NOT EXISTS(SELECT * FROM SINHVIEN S WHERE 
S.malop = @maLop))
BEGIN
PRINT N'Mã số lớp ' + @maLop + N' chưa tồn 
tại'
RETURN -1
END
SELECT * FROM sinhvien s WHERE S.malop = @maLop
/*procedure luôn trả về 0 nếu không RETURN*/
END
GO
exec spDanhSachSinhVien 'ML02'
drop proc spDanhSachSinhVien
--Bài 7 Viết hàm tính số lượng sinh viên của một lớp. Biết rằng, hàm có tham số truyền vào là mã lớp.
CREATE FUNCTION Fn_Soluong_SV ( @tsMaLOP NVARCHAR (10)
)
RETURNS int
AS
BEGIN
DECLARE @SLsv int;
SELECT @SLsv = COUNT (masv)
FROM SinhVien
WHERE Malop=@tsMalop 
RETURN (@SLsv)
END
--Su dung ham (Ham xuat hien trong bieu thuc)
SELECT dbo.Fn_Soluong_sv('SEK21.4');
--Hoặc sử dụng trong một biểu thức truy vấn:
SELECT Malop, count (masv) as slsv 
FROM sinhvien 
GROUP BY malop
HAVING count(masv) > dbo.Fn_Soluong_sv('SEK21.4')
drop function Fn_Soluong_sv
--Bài 8 Viết hàm có tham số truyền vào là mã lớp và trả ra thông tin là danh sách sinh viên thuộc lớp đó. Biết rằng, thông tin hiển thị gồm: MaSv, hoten, Ngaysinh.
IF object_id(' Fn_DSsv_lop ','FN') IS NOT NULL
DROP FUNCTION Fn_DSsv_lop
GO
CREATE FUNCTION Fn_DSsv_lop (@tsMaLOP NVARCHAR (10))
RETURNS TABLE
AS
RETURN
(SELECT Masv, HoTen, NgaySinh
FROM sinhVien
WHERE Malop=@tsMalop )
GO
-- Su dung ham tra ket qua bang nhu la TABLE
SELECT *
FROM Fn_DSsv_lop('SEK21.3')
drop function Fn_DSsv_lop
/*Bài 9 : Viết hàm thông kê số lượng sinh viên của mỗi lớp của một khóa. Biết rằng, hàm trả
ra các thông tin là danh sách các lớp của khóa tương ứng gồm: Malop, tenlop, slsv (đây 
là cột phải tính toán).*/
CREATE FUNCTION Fn_thongkeSV_LOP (@khoa smallint)
RETURNS @bangtk TABLE
(Malop NVarCHAR(10),
tenlop NvarCHAR(30),
slsv tinyint)
BEGIN
IF @KHOA =0
INSERT INTO @bangtk 
SELECT LOP.MALOP, tenlop, COUNT(MASV)
FROM LOP INNER JOIN sinhVien
ON LOP.MALOP=SINHVIEN.MALOP
GROUP BY LOP.MALOP, tenlop
ELSE
INSERT INTO @bangtk 
SELECT LOP.MALOP, tenlop, COUNT(MASV)
FROM LOP INNER JOIN sinhVien
ON LOP.MALOP=SINHVIEN.MALOP
WHERE khoa=@khoa 
GROUP BY LOP.MALOP, tenlop
RETURN
END
--Lời gọi hàm:
SELECT * FROM Fn_thongkeSV_LOP (22)--tồn tại khóa học
SELECT * FROM Fn_thongkeSV_LOP (1) --–- không tồn tại khóa học

--Bài 12.4--
--Bài 2--
create proc sp_slsv @Makhoa int
as
begin 
    select count(Masv)
	from Sinhvien sv join 
	Lop l on sv.Malop = l.Malop
	where l.Makhoa = @Makhoa
end
exec sp_slsv 13
drop proc sp_slsv
----
create proc sp_slsv_theo_lop @Makhoa int
as
begin 
     select count(Malop)
	 from Lop
	 where Makhoa = @Makhoa
end
exec sp_slsv_theo_lop 1
drop proc sp_slsv_theo_lop
--Bài 3--
create proc sp_tinh_diem_tb @Masv char(10)
as
begin
    select round(sum(dt.Diemlan1*mh.sotinchi) / sum(mh.Sotinchi),1) from
	Sinhvien sv join Diemthi dt
	on sv.Masv = dt.Masv
	join Monhoc mh 
	on dt.Mamonhoc = mh.Mamonhoc
	where sv.Masv = @Masv and dt.Kihoc = 1
end
exec sp_tinh_diem_tb 'SV001'
drop proc sp_tinh_diem_tb
--Câu 4--
create proc sp_hien_thi_sv @Makhoa int,@Khoahoc smallint
as
begin
   select sv.*
   from Khoa k join Lop l
   on k.Makhoa = l.Makhoa
   join Sinhvien sv
   on sv.Malop = l.Malop
   where k.Makhoa = @Makhoa and l.Khoa = @Khoahoc
end
exec sp_hien_thi_sv 3,21
drop proc sp_hien_thi_sv
--Câu 9--
alter proc sp_nhap_thong_tin @Mamonhoc char(10),@Masv char(10),@kihoc smallint,@Diemlan1 float,@Diemlan2 float
as
begin
   if(not exists(select sv.*,dt.* from Sinhvien sv join Diemthi dt on sv.Masv = dt.Masv
   where sv.Masv = @Masv and dt.Mamonhoc = @Mamonhoc))
   begin
   print N'Không tồn tại mã sinh viên và mã môn học: ' + @Masv + @Mamonhoc
   return -1
   end
   else
   begin
   insert into Diemthi(Mamonhoc,Masv,Kihoc,Diemlan1,Diemlan2)
   values (@Mamonhoc,@Masv,@kihoc,@Diemlan1,@Diemlan2)
   print N'Đã nhập thành công mã sinh viên: ' + @Masv
   return 0
   end
end
exec sp_nhap_thong_tin 'MH004','SV004',2,8.5,9.5
drop proc sp_nhap_thong_tin
select * from Diemthi
--Câu 10--
create proc sp_xoa_sv @Masv char(10)
as
begin 
  delete from Sinhvien 
  where Masv = @Masv
end
exec sp_xoa_sv 'SV010'
--Câu 11--
create or alter proc sp_cap_nhat @Tenkhoa nvarchar(20)
as
begin 
   select * from Khoa where Tenkhoa = @Tenkhoa
   update Khoa
   set Diadiem = 'CS2'
   where Tenkhoa = @Tenkhoa
   select * from Khoa where Tenkhoa = @Tenkhoa
end
exec sp_cap_nhat N'Công nghệ thông tin'
select * from Khoa
--Câu 12--
create proc sp_sobd_tudong 
as
begin
CREATE TABLE Sobaodanh (
    SBD VARCHAR(10) PRIMARY KEY,
    Masv CHAR(10),
    Hoten NVARCHAR(20),
    Ngaysinh DATE
);
    DECLARE @Masv CHAR(10);
    DECLARE @Hoten NVARCHAR(20);
    DECLARE @Ngaysinh DATE;
    DECLARE @SBD VARCHAR(10);
    DECLARE @Dem INT = 1;

    -- Khai báo con trỏ để duyệt qua danh sách sinh viên
    DECLARE student_cursor CURSOR FOR 
    SELECT Masv, Hoten, Ngaysinh FROM Sinhvien ORDER BY Masv;

    OPEN student_cursor;

    FETCH NEXT FROM student_cursor INTO @Masv, @Hoten, @Ngaysinh;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Tạo số báo danh
        SET @SBD = 'SBD' + CAST(@Dem AS VARCHAR(10));

        -- Chèn số báo danh vào bảng Sobaodanh
        INSERT INTO Sobaodanh (SBD, Masv, Hoten, Ngaysinh)
        VALUES (@SBD, @Masv, @Hoten, @Ngaysinh);

        -- Tăng số đếm
        SET @Dem = @Dem + 1;

        FETCH NEXT FROM student_cursor INTO @Masv, @Hoten, @Ngaysinh;
    END

    CLOSE student_cursor;
    DEALLOCATE student_cursor;
END;

exec sp_sobd_tudong 
select * from Sobaodanh 
--Câu 13--
create proc sp_nhap_du_lieu @Mamonhoc char(20),@Tenmonhoc nvarchar(20),@Sotinchi int
as
begin
    if(exists(select * from Monhoc where Mamonhoc = @Mamonhoc))
	begin
	print N'Mã môn học đã tồn tại: ' + @Mamonhoc
	return -1
	end
	if left(@Mamonhoc, 2) = 'MH' and ISNUMERIC(SUBSTRING(@Mamonhoc, 3, 6)) = 1
    begin
        insert into Monhoc (Mamonhoc,Tenmonhoc,Sotinchi)
        values (@Mamonhoc, @Tenmonhoc,@Sotinchi);
        print N'Nhập dữ liệu thành công cho môn học: ' + @Mamonhoc;
    end
    else
    begin
        print N'Mã môn học không hợp lệ: ' + @Mamonhoc;
        return -1
    end
end
exec sp_nhap_du_lieu 'MH000007',N'Lập trình',4
--Viết hàm--
--Câu 1--
CREATE FUNCTION fn_tinhgiaithua (@n INT)
RETURNS BIGINT
AS
BEGIN
    DECLARE @result BIGINT = 1;
    DECLARE @i INT;

    -- Kiểm tra nếu n âm
    IF @n < 0
    BEGIN
        RETURN NULL; -- Giai thừa không xác định cho số âm
    END

    -- Tính giai thừa
    SET @i = 1;
    WHILE @i <= @n
    BEGIN
        SET @result = @result * @i;
        SET @i = @i + 1;
    END

    RETURN @result;
END;
select dbo.fn_tinhgiaithua(5) as Ketqua
--Câu 3--
create function fn_slsv (@Makhoa int)
returns int
as 
begin
   declare @Slsv int
   select @Slsv = count(Masv)
   from Sinhvien sv join Lop l
   on sv.Malop = l.Malop
   where l.Makhoa = @Makhoa
   return @Slsv
end
select dbo.fn_slsv(3) as SLSV

drop function fn_slsv
--Câu 4--
create function fn_xem_thong_tin(@Makhoa int,@Malop char(10))
returns table 
as
   return(select sv.Masv,sv.Hoten,datediff(year,Ngaysinh,getdate()) as Tuoi
   from Lop l join Sinhvien sv on l.Malop = sv.Malop
   where l.Makhoa = @Makhoa and sv.Malop = @Malop)
select * from dbo.fn_xem_thong_tin(17,'TK10.4')
--Câu 5--
--Câu 6--
create function fn_xem_danh_sach(@Malop char(10))
returns table 
as
   return(select sv.* from Sinhvien sv join Lop l on sv.Malop = l.Malop
   where l.Malop = @Malop)
   select * from dbo.fn_xem_danh_sach('ML03')

                     
    
