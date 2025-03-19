--Bài 10.4--
--Bài 3--


--Bài 4--
--Câu a--
declare @so_luong_sv int
select @so_luong_sv = count(Masv) 
from Sinhvien
if(@so_luong_sv > 100)
begin
  print N'Số lượng sinh viên đã vượt 100!'
end
else
  print N'Số lượng sinh viên hợp lệ'
--Câu b--
select mh.Mamonhoc,mh.Tenmonhoc,N'Tính chất' =
   case 
   when Sotinchi>=6 then N'Thực tập,Đồ án'
   when Sotinchi >=4 and Sotinchi < 6 then N'Cơ sở ngành,chuyên ngành'
   else N'Cơ bản'
   end
from Monhoc mh
--Câu c--
select sv.Masv,sv.Hoten,sum((dt.Diemlan1 * mh.Sotinchi)) / sum((mh.Sotinchi)) as DiemTBl1,N'Xếp loại'=
   case 
   when sum((dt.Diemlan1 * mh.Sotinchi)) / sum((mh.Sotinchi)) >= 9 then N'Xuất sắc'
   when sum((dt.Diemlan1 * mh.Sotinchi)) / sum((mh.Sotinchi)) >= 8 then N'Giỏi'
   when sum((dt.Diemlan1 * mh.Sotinchi)) / sum((mh.Sotinchi)) >= 7 then N'Khá'
   when sum((dt.Diemlan1 * mh.Sotinchi)) / sum((mh.Sotinchi)) >= 6 then N'Trung bình'
   else N'Yếu'
   end 
from Sinhvien sv join Diemthi dt
on sv.Masv = dt.Masv join Monhoc mh
on dt.Mamonhoc = mh.Mamonhoc
where dt.Kihoc = 1
group by sv.Masv,sv.Hoten
order by DiemTBl1 desc
--Câu d--
begin try
   declare @st nvarchar(5)
   select @st = Sotinchi from Monhoc
   print Convert(Datetime, @st)
end try
begin catch 
  print N'Lỗi: ' + cast(Error_message() as nvarchar(50))
  print N'Lỗi ở dòng: ' + cast(Error_Line() as nvarchar(20))
end catch
--Câu e--
create table T1
(
Ma int primary key,
Ten nvarchar(30)
)
declare @i INT = 1;  
declare @ten NVARCHAR(30);  
while @i <= 18
begin
   
    set @ten = N'Bản ghi thứ ' + cast(@i AS NVARCHAR(10));  
    insert into T1 (Ma, Ten) 
	values(@i,@ten)
    set @i = @i + 1;
end
select * from T1
--Câu f--
alter table Khoa
add Diadiem nvarchar(30)
update Khoa 
set Diadiem = 
   case 
    when Makhoa between 1 and 6 then 'CS2'
	when Makhoa between 10 and 20 then 'CS1'
	else 'CS3'
   end
