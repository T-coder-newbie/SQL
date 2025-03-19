--VD mau--
--Bai 1--C1
select l.Malop,l.Tenlop
from Lop l left join sinhvien sv 
on l.Malop = sv.Malop
where sv.Malop is null
--C2--
select Malop,Tenlop
from Lop
where Malop not in(Select Malop from Sinhvien)
--Bai 2--
select sv.Masv,sv.Hoten,dt.Diemlan1
from Sinhvien sv inner join Diemthi dt
on sv.Masv = dt.Masv
inner join Monhoc mh
on mh.Mamonhoc = dt.Mamonhoc
where dt.Kihoc = 1 and mh.Sotinchi >= 3 and Noisinh = N'Hưng Yên'
--Bai 3--
select top(3) Mamonhoc,Tenmonhoc,Sotinchi
from Monhoc
order by Sotinchi desc
--Bai 4--
select Malop,[0] as Nữ,[1] as Nam
from(
select sv.Malop,sv.Masv,sv.Gioitinh
from Sinhvien sv) as s
pivot
(count(Masv) for Gioitinh in([0],[1])
) as pvt
order by Malop
--Bai 5--
select l.Malop,l.Tenlop,count(Masv) as SLSV
from Lop l left join Sinhvien sv
on l.Malop = sv.Malop
group by l.Malop,l.Tenlop
--Bai 6--C1
select l.Malop,l.Tenlop,count(Masv) as SLSV
from lop l left join Sinhvien sv 
on l.Malop = sv.Malop
group by l.Malop,l.Tenlop
having count(Masv) >= All (select count(Masv)
                           from Sinhvien
						   group by Malop)
--C2
select top(1) with ties l.Malop,l.Tenlop,count(Masv) as SLSV
from Lop l left join Sinhvien sv
on l.Malop = sv.Malop
group by l.Malop,l.Tenlop
order by count(Masv) desc
-- Bai 7--
select sv.Masv,sv.Hoten,round(sum(dt.Diemlan1*mh.sotinchi)/sum(mh.sotinchi),1) as DiemTbl1
from Sinhvien sv inner join Diemthi dt 
on sv.Masv = dt.Masv
inner join Monhoc mh 
on dt.Mamonhoc = mh.Mamonhoc
group by sv.Masv,sv.Hoten
--Bai 8--
select sv.Hoten,mh.Tenmonhoc,round(sum(dt.Diemlan1*mh.sotinchi)/sum(mh.sotinchi),1)  DiemTBl1
from Sinhvien sv inner join Diemthi dt 
on sv.Masv = dt.Masv
inner join Monhoc mh  
on dt.Mamonhoc = mh.Mamonhoc
group by  sv.Hoten,mh.Tenmonhoc with rollup
----
select 
case when grouping([hoten]) = 1 then 'All sinh vien'
else [hoten]
end as [Họ tên],
case when grouping ([tenmonhoc]) = 1 then 'All mon hoc'
else [tenmonhoc] 
end as [Tên môn],
round(sum(dt.Diemlan1*mh.sotinchi)/sum(mh.sotinchi),1) as DiemTbl1
from Sinhvien sv inner join Diemthi dt 
on sv.Masv = dt.Masv
inner join Monhoc mh 
on dt.Mamonhoc = mh.Mamonhoc
group by Hoten,Tenmonhoc with rollup
---
select 
case when grouping ([tenmonhoc]) = 1 then 'All mon hoc'
else [tenmonhoc] 
end as [Tên môn],
case when grouping([hoten]) = 1 then 'All sinh vien'
else [hoten]
end as [Họ tên],
round(sum(dt.Diemlan1*mh.sotinchi)/sum(mh.sotinchi),1) as DiemTbl1
from Sinhvien sv inner join Diemthi dt 
on sv.Masv = dt.Masv
inner join Monhoc mh 
on dt.Mamonhoc = mh.Mamonhoc
group by Tenmonhoc,Hoten with rollup
----
select 
case when grouping([hoten]) = 1 then 'All sinh vien'
else [hoten]
end as [Họ tên],
case when grouping ([tenmonhoc]) = 1 then 'All mon hoc'
else [tenmonhoc] 
end as [Tên môn],
round(sum(dt.Diemlan1*mh.sotinchi)/sum(mh.sotinchi),1) as DiemTbl1
from Sinhvien sv inner join Diemthi dt 
on sv.Masv = dt.Masv
inner join Monhoc mh 
on dt.Mamonhoc = mh.Mamonhoc
group by Tenmonhoc,Hoten with cube
--Bai 9--
create table Khachhang
(
KhachHang_ID int identity primary key,
Ten nvarchar(100),
Email varchar(100)
)
create table KhachHangLuu
(
KhackHang_ID int,
Ten nvarchar(50),
email varchar(100)
)
go
insert into Khachhang values(N'Ý Lan','ylan@ylan.com')
insert into Khachhang values(N'Tuấn Ngọc','tuanngoc@tuanngoc.com')
insert into Khachhang values(N'Thái Hiền','thaihien@thaihien.com')
insert into KhachHang values(N'Ngọc Hạ','ngocha@ngocha.com')
select *  from Khachhang
--Xoa Khachhang_ID = 4
delete Khachhang
output deleted.* into KhachHangLuu
where KhachHang_ID = 4
--Cập nhật email
update Khachhang
set Email = N'me@thaihien.com'
output deleted.* into KhachHangLuu
where KhachHang_ID = 3

select * from KhachHangLuu
--Bai 10--
create view View_DSSV
as
SELECT        dbo.Sinhvien.Masv, dbo.Sinhvien.Hoten, dbo.Sinhvien.Ngaysinh, dbo.Sinhvien.Gioitinh, dbo.Sinhvien.Noisinh, dbo.Lop.Tenlop
FROM            dbo.Lop INNER JOIN
                         dbo.Sinhvien ON dbo.Lop.Malop = dbo.Sinhvien.Malop
						 
--Bai 11--
alter view View_DSSV
as
SELECT        dbo.Sinhvien.Masv, dbo.Sinhvien.Hoten, dbo.Sinhvien.Ngaysinh, dbo.Sinhvien.Noisinh, dbo.Lop.Tenlop
FROM            dbo.Lop INNER JOIN
                         dbo.Sinhvien ON dbo.Lop.Malop = dbo.Sinhvien.Malop

--Bai 12--
declare cur_SV cursor
for
select Masv,Hoten,Ngaysinh,Gioitinh,Noisinh
from Sinhvien
open cur_SV
fetch next from cur_SV
while @@FETCH_STATUS = 0

fetch next from cur_SV
close cur_SV
deallocate cur_SV
--Bai 13--
if exists(Select * from sys.databases where name = 'UTE_TEST')
drop database UTE_TEST
go 
create database UTE_TEST
go
use UTE_TEST
create table t1(a int primary key)
create table t2(a int references t1(a))
go
insert into t1 values(1)
insert into t1 values(3)
insert into t1 values(4)
insert into t1 values(6)
go
set xact_abort off
go
begin tran
insert into t2 values(1)
insert into t2 values(2) /*Foreign key error*/
insert into t2 values(3)
commit tran
go
set xact_abort on
go
begin tran
insert into t2 values(4)
insert into t2 values(5) /*Foreign key error*/
insert into t2 values(6)
commit tran
go
----
CREATE TABLE #t2 (
    i INT, 
    CONSTRAINT ck2 CHECK (i <> 2)
)
SET XACT_ABORT OFF
-- SET XACT_ABORT ON
BEGIN TRAN
BEGIN TRY
    INSERT INTO #t2 SELECT 1;
    INSERT INTO #t2 SELECT 3;
    INSERT INTO #t3 SELECT 100 --Bảng t3 không tồn tại
COMMIT
END TRY
BEGIN CATCH
	ROLLBACK TRAN
	DECLARE @ErrorMessage VARCHAR (1800)
	SELECT @ErrorMessage = N'Lỗi: ' + ERROR_MESSAGE()
	RAISERROR (@ErrorMessage, 14, 1)
END CATCH
SELECT * FROM #t2
--Bai tap tu lam--

--Câu 1--
use NguyenVanThang_12523081
select sv.Masv,sv.Hoten,sv.Gioitinh
from SinhVien sv join Diemthi dt 
on sv.Masv = dt.Masv
where sv.Noisinh = N'Hưng Yên' and dt.Diemlan1 is null and dt.Diemlan2 is null
--Câu 2--
with SinhVien_cte as(
select sv.Masv,sv.Hoten,sv.Gioitinh,sv.Noisinh,year(getdate()) - year(sv.Ngaysinh) as Tuoi
from Sinhvien sv join Diemthi dt
on sv.Masv = dt.Masv) 

select svt.Masv,svt.Hoten,svt.Gioitinh,svt.Noisinh,Tuoi
from SinhVien_cte svt join Diemthi dt
on svt.Masv = dt.Masv join Monhoc mh
on dt.Mamonhoc = mh.Mamonhoc
where Tuoi > 18 and mh.Tenmonhoc = N'CSDL' and dt.Diemlan1 > 8
--Câu 3--
select k.*
from Khoa k
join Lop l 
on k.Makhoa = l.Makhoa
join Sinhvien sv 
on l.Malop = sv.Malop
join Diemthi dt 
on sv.Masv = dt.Masv
join Monhoc mh 
on dt.Mamonhoc = mh.Mamonhoc
where mh.Tenmonhoc = N'Hệ quản trị cơ sở dữ liệu'
--Câu 4--
with SinhVien_cte as(
select year(getdate()) - year(sv.Ngaysinh) as Tuoi
from Sinhvien sv 
) 
select top(50) percent Tuoi
from SinhVien_cte
order by Tuoi desc
--Câu 5--
select k.Tenkhoa,k.Makhoa,sv.Hoten,count(Masv) SLSV
from SinhVien sv join Lop l
on sv.Malop = l.Malop
join Khoa k
on l.Makhoa = k.Makhoa
group by k.Tenkhoa,k.Makhoa,sv.Hoten
---ROlLUP
select k.Tenkhoa,k.Makhoa,sv.Hoten,count(Masv) SLSV
from SinhVien sv join Lop l
on sv.Malop = l.Malop
join Khoa k
on l.Makhoa = k.Makhoa
group by k.Tenkhoa,k.Makhoa,sv.Hoten with rollup
--Câu 6--
select a.Masv,a.Hoten,a.Kihoc,a.DiemTBl1,
case
     when a.DiemTBl1 >= 9 then N'Xuất sắc'
	 when a.DiemTBl1 >= 8 then N'Giỏi'
	 when a.DiemTBl1 >= 8 then N'Khá'
	 when a.DiemTBl1 >= 8 then N'Trung Bình'
	 else N'Yếu'
end as Xeploai
from(
select sv.Masv,sv.Hoten,dt.kihoc,round(sum(dt.Diemlan1*mh.sotinchi)/sum(mh.sotinchi),1) as DiemTBl1
from Sinhvien sv join Diemthi dt
on sv.Masv = dt.Masv
join Monhoc mh
on dt.Mamonhoc = mh.Mamonhoc
where dt.Kihoc = 1
group by sv.Masv,sv.Hoten,dt.kihoc) as a
--Câu 7--
with Sinhvien_cte as(
select sv.Masv,sv.Hoten,sv.Noisinh,year(sv.Ngaysinh) as Namsinh,round(sum(dt.Diemlan1*mh.sotinchi)/sum(mh.sotinchi),1) as DiemTBl1
from Sinhvien sv join Diemthi dt
on sv.Masv = dt.Masv
join Monhoc mh
on dt.Mamonhoc = mh.Mamonhoc
group by sv.Masv,sv.Hoten,sv.Ngaysinh,sv.Noisinh)
select Masv,Hoten,Namsinh,DiemTBl1
from Sinhvien_cte
where DiemTBl1 > (select DiemTBl1
                  from Sinhvien_cte
				  where Noisinh  = N'Thái Bình')
--Câu 8--

select sv.Masv,sv.Hoten,dt.Diemlan1
from Sinhvien sv
join Diemthi dt
on sv.Masv = dt.Masv
where dt.Diemlan1 = (select max(dt.Diemlan1) as Diemcaonhat
                    from Diemthi dt join
					Monhoc mh 
					on dt.Mamonhoc = mh.Mamonhoc
					where mh.Tenmonhoc = N'Lập trình C#')
--Câu 9--
with SinhVien_cte as(
select sv.Masv,sv.Hoten,dt.kihoc,round(sum(dt.Diemlan1*mh.sotinchi)/sum(mh.sotinchi),1) as DiemTBl1
from Sinhvien sv join Diemthi dt
on sv.Masv = dt.Masv
join Monhoc mh
on dt.Mamonhoc = mh.Mamonhoc
where dt.Kihoc = 1
group by sv.Masv,sv.Hoten,dt.kihoc)
select Masv,Hoten,DiemTBl1
from SinhVien_cte
where DiemTBl1 = (select max(DiemTBl1)
                  from SinhVien_cte
				  where Kihoc = 1)
--Câu 10--
with Namsinh_cte as(
select sv.Hoten,sv.Malop,year(getdate()) - year(sv.Ngaysinh) as Tuoi
from Sinhvien sv )
select top (5) Hoten,Tuoi
from Namsinh_cte cte join Lop l
on cte.Malop = l.Malop
where l.Makhoa = N'CNTT'
order by Tuoi asc
--Câu 11--
SELECT sv.Masv,sv.Hoten,sv.Ngaysinh,sv.Gioitinh,sv.Noisinh
FROM SinhVien sv
WHERE sv.Masv IN (
    SELECT sv.Masv
    FROM Sinhvien sv 
	join Diemthi dt
	on sv.Masv = dt.Masv
    WHERE Diemlan1 < 5 OR Diemlan2 < 5 )
--Câu 12--
SELECT sv.maSV, sv.Hoten,count(dt.Mamonhoc) as SLMH
FROM SinhVien sv
JOIN Diemthi dt ON sv.Masv = dt.Masv
GROUP BY sv.maSV, sv.Hoten
HAVING COUNT(dt.Mamonhoc) = (SELECT COUNT(*) as SLMH FROM MonHoc)
--Câu 13--
select Tenmonhoc,Sotinchi,
dense_rank() over (order by Sotinchi desc) as [Dense_rank]
from Monhoc
--
select Tenmonhoc,Sotinchi,
row_number() over (order by Sotinchi desc) as [Row_number]
from Monhoc
--
select Tenmonhoc,Sotinchi,
rank() over (order by Sotinchi desc) as [Rank]
from Monhoc
--Câu 14--
select Makhoa,[0] as Nữ,[1] as Nam
from(
select k.Tenkhoa,k.Makhoa,sv.Hoten,sv.Masv,sv.Gioitinh
from SinhVien sv join Lop l
on sv.Malop = l.Malop
join Khoa k
on l.Makhoa = k.Makhoa
) as BangNguon
pivot
(
count(Masv) for Gioitinh in([0],[1])
) as pvt
--Câu 15--
SELECT DATEADD(day, 10, '2024-12-01');
SELECT GETDATE();
SELECT DATEDIFF(day, '2024-01-01', '2024-12-01');
SELECT DATEPART(year, '2024-12-01');
SELECT CONVERT(varchar, GETDATE());
SELECT CAST(GETDATE() AS DATE);
BEGIN TRY
    -- Câu lệnh gây lỗi, ví dụ: chia cho 0
    SELECT 1 / 0;
END TRY
BEGIN CATCH
    -- Trả về thông báo lỗi
    SELECT ERROR_MESSAGE() AS ErrorMessage;
	SELECT ERROR_NUMBER() AS ErrorNumber;
	SELECT ERROR_SEVERITY() AS SeverityLevel;
	SELECT ERROR_STATE() AS ErrorState;
	SELECT ERROR_LINE() AS ErrorLine;
	SELECT ERROR_PROCEDURE() AS ErrorProcedure;
END CATCH;
--Hàm xếp hạng--
select Tenmonhoc,Sotinchi,
row_number() over (order by Sotinchi desc) as [Row_number],
dense_rank() over (order by Sotinchi desc) as [Dense_rank],
rank() over (order by Sotinchi desc) as [Rank],
ntile(3) over (order by Sotinchi desc) as [NtileRank]
from Monhoc
--Hàm trên dữ liệu kiểu số--
SELECT ABS(-10) AS AbsoluteValue;
SELECT CEILING(12.3) AS CeilingValue; 
SELECT FLOOR(12.7) AS FloorValue; 
SELECT ROUND(123.4567, 2) AS RoundedValue;  -- Kết quả: 123.46
SELECT SQRT(16) AS SqrtValue;  -- Kết quả: 4
SELECT ISNULL(NULL, 0);
SELECT ISNUMERIC('123') AS Result;  -- Kết quả: 1
--Hàm xử lí chuỗi kí tự--
SELECT LEN('Hello') AS StringLength;  -- Kết quả: 5
SELECT LTRIM('   Hello') AS TrimmedValue;  -- Kết quả: 'Hello'
SELECT RTRIM('Hello   ') AS TrimmedValue;  -- Kết quả: 'Hello'
SELECT TRIM('   Hello   ') AS TrimmedValue;  -- Kết quả: 'Hello'
SELECT SUBSTRING('Hello World', 1, 5) AS SubstringValue;  -- Kết quả: 'Hello'
SELECT REPLACE('Hello World', 'World', 'SQL') AS ReplacedValue;  -- Kết quả: 'Hello SQL'
SELECT CONCAT('Hello', ' ', 'World') AS ConcatenatedValue;  -- Kết quả: 'Hello World'
SELECT CONCAT_WS('-', '2024', '12', '09') AS ConcatenatedValue;  -- Kết quả: '2024-12-09'
SELECT UPPER('hello') AS UpperCaseValue;  -- Kết quả: 'HELLO'
SELECT LOWER('HELLO') AS LowerCaseValue;  -- Kết quả: 'hello'
--Câu 16--
create view w_cau1
as 
select sv.Hoten,sv.Gioitinh,mh.Tenmonhoc,dt.Diemlan1
from Sinhvien sv join 
Diemthi dt 
on sv.Masv = dt.Masv
join Monhoc mh
on mh.Mamonhoc = dt.Mamonhoc
--Câu 17--
alter view w_cau1
as 
select sv.Hoten,sv.Gioitinh,dt.Diemlan1
from Sinhvien sv join 
Diemthi dt 
on sv.Masv = dt.Masv
--Câu 18--
create view w_cau3
as
select mh.Mamonhoc,count(dt.Masv) as SLSV
from Diemthi dt
join Monhoc mh
on dt.Mamonhoc = mh.Mamonhoc
group by mh.Mamonhoc
--Câu 19--
create view w_cau4
as 
select l.Malop,l.Tenlop,count(sv.Masv) SLSV
from Lop l
join Sinhvien sv
on l.Malop = sv.Malop
group by l.Malop,l.Tenlop
--Câu 20--
create view w_cau5
as 
select sv.Hoten
from Sinhvien sv
join Diemthi dt
on sv.Masv = dt.Masv
where dt.Diemlan1 is null and dt.Diemlan2 is null
--Câu 21--
 create view View_Ttkhoa 
 as 
 select Makhoa,Tenkhoa,Diadiem
 from Khoa 
select * from View_Ttkhoa 
update View_Ttkhoa 
set Diadiem = 'CS3'
where Makhoa in(13,15,16)
--Câu 22--
DECLARE @Masv NVARCHAR(50), @HoTen NVARCHAR(100), @GioiTinh NVARCHAR(10),
        @NgaySinh DATE, @NoiSinh NVARCHAR(100), @MaLop NVARCHAR(50);
DECLARE cur_SV CURSOR FOR
SELECT Masv, HoTen, GioiTinh, NgaySinh, NoiSinh, MaLop
FROM Sinhvien;
OPEN cur_SV;
FETCH NEXT FROM cur_SV INTO @Masv, @HoTen, @GioiTinh, @NgaySinh, @NoiSinh, @MaLop;
PRINT N'Sinh viên đầu tiên: ' + @Masv + ' ' + @HoTen + ' ' + @GioiTinh + ' ' + 
      CONVERT(NVARCHAR, @NgaySinh, 103) + ' ' + @NoiSinh + ' ' + @MaLop; 
WHILE @@FETCH_STATUS = 0
BEGIN
    FETCH NEXT FROM cur_SV INTO @Masv, @HoTen, @GioiTinh, @NgaySinh, @NoiSinh, @MaLop;
END
PRINT N'Sinh viên cuối cùng: ' + @Masv + ' ' + @HoTen + ' ' + @GioiTinh + ' ' + 
      CONVERT(NVARCHAR, @NgaySinh, 103) + ' ' + @NoiSinh + ' ' + @MaLop;
CLOSE cur_SV;
DEALLOCATE cur_SV;
--Câu 23--
DECLARE @Masv NVARCHAR(50), @Diemcaonhat DECIMAL(5,2);
DECLARE cur_cau7 CURSOR FOR
SELECT sv.Masv, MAX(dt.Diemlan1) AS Diemcaonhat
FROM Sinhvien sv
JOIN Diemthi dt ON sv.Masv = dt.Masv
GROUP BY sv.Masv;
OPEN cur_cau7;
FETCH NEXT FROM cur_cau7 INTO @Masv, @Diemcaonhat;
WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT N'Mã sinh viên: ' + @Masv + N' - Điểm thi cao nhất lần 1: ' + CONVERT(NVARCHAR, @Diemcaonhat);
    FETCH NEXT FROM cur_cau7 INTO @Masv, @Diemcaonhat;
END
CLOSE cur_cau7;
DEALLOCATE cur_cau7;
--Câu 24--
DECLARE @Soluong INT;
DECLARE @MaLop NVARCHAR(50);
DECLARE cur_Siso CURSOR FOR
SELECT MaLop, COUNT(Masv) AS SLSV
FROM Sinhvien
GROUP BY MaLop;
OPEN cur_Siso;
FETCH NEXT FROM cur_Siso INTO @MaLop, @Soluong;
WHILE @@FETCH_STATUS = 0
BEGIN
    UPDATE Lop
    SET siso = @Soluong
    WHERE MaLop = @MaLop;
    FETCH NEXT FROM cur_Siso INTO @MaLop, @Soluong;
END
CLOSE cur_Siso;
DEALLOCATE cur_Siso;
select * from Lop
--Câu 25--
DECLARE @Masv NVARCHAR(50), @DiemTbl1 DECIMAL(5, 2), @XepLoai NVARCHAR(20);
DECLARE cur_SinhVien CURSOR FOR
SELECT sv.Masv,
       ROUND(SUM(dt.Diemlan1 * mh.Sotinchi) / SUM(mh.Sotinchi), 1) AS DiemTbl1
FROM Sinhvien sv
JOIN Diemthi dt ON sv.Masv = dt.Masv
join Monhoc mh 
on mh.Mamonhoc = dt.Mamonhoc
GROUP BY sv.Masv;
OPEN cur_SinhVien;
FETCH NEXT FROM cur_SinhVien INTO @Masv, @DiemTbl1;
WHILE @@FETCH_STATUS = 0
BEGIN
    IF @DiemTbl1 < 5
        SET @XepLoai = N'Yếu';
    ELSE IF @DiemTbl1 >= 5 AND @DiemTbl1 < 7
        SET @XepLoai = N'Trung bình';
    ELSE IF @DiemTbl1 >= 7 AND @DiemTbl1 < 8
        SET @XepLoai = N'Khá';
    ELSE
        SET @XepLoai = N'Giỏi';
    UPDATE Sinhvien
    SET xepLoai = @XepLoai
    WHERE Masv = @Masv;
    FETCH NEXT FROM cur_SinhVien INTO @Masv, @DiemTbl1;
END
CLOSE cur_SinhVien;
DEALLOCATE cur_SinhVien;
select * from Sinhvien
--Câu 26--
DECLARE @MaLop NVARCHAR(50);
DECLARE @TenLop NVARCHAR(100);
DECLARE @SiSo INT;
SET @MaLop = 'ML01';    -- Mã lớp
SET @TenLop = 'Lập trình SQL'; -- Tên lớp
SET @SiSo = 30;      
BEGIN TRY
    BEGIN TRANSACTION;
    IF EXISTS (SELECT 1 FROM Lop WHERE MaLop = @MaLop)
    BEGIN
        PRINT N'Mã lớp đã tồn tại. Không thể thêm mới lớp.';
        ROLLBACK TRANSACTION;  
        RETURN;
    END
    INSERT INTO Lop (MaLop, TenLop, SiSo)
    VALUES (@MaLop, @TenLop, @SiSo);
    IF @SiSo <= 0
    BEGIN
        PRINT N'Sĩ số phải là một số dương.';
        ROLLBACK TRANSACTION;  
        RETURN;
    END
    COMMIT TRANSACTION;
    PRINT N'Lớp đã được thêm thành công.';

END TRY
BEGIN CATCH
    PRINT N'Có lỗi xảy ra: ' + ERROR_MESSAGE();
    ROLLBACK TRANSACTION;
END CATCH;












   



