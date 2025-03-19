go
use NguyenVanThang_12523081
--Câu 4.1 Tạo một bảng SVtam từ bảng sinh viên(thiết lập lại khoá chính là Masv)
select * into SVtam from Sinhvien
--Thiết lập lại khoá chính
alter table SVtam
add constraint PK_SVtam primary key(Masv)
--Câu 4.2 Tạo chỉ mục nonclustered trên cột Hoten
create nonclustered index iX_hoten on SinhVien(Hoten)
--Câu 4.3 tạo chỉ mục nonclustered phức hợp trên hai cột hoten và noisinh
create nonclustered index ix_hoten_noisinh on SinhVien(Hoten,Noisinh)
--Câu 4.4 xem lại chỉ mục có trên bảng SinhVien
exec sp_helpindex SinhVien
--Câu 4.5 tìm kiếm thông tin sinh viên có họ Nguyễn bằng cách sử dụng chỉ mục được tạo trong câu 2
select * from SinhVien with(index([iX_hoten]))
where Hoten like N'Nguyễn%'
--Câu 4.6 Tìm kiếm thông tin các sinh viên có tên 'Thắng' và nơi sinh ở 'Nha Trang' bằng cách sử dụng chỉ mục được tạo trong câu 3
select * from SinhVien With (index = Ix_Hoten_NoiSinh)
where HoTen like N'% Thắng' and NoiSinh = N'Nha Trang'
--Câu 4.7 Xóa các chỉ mục được tạo
Drop index SinhVien.ix_hoten
Drop index SinhVien.ix_hoten_noiSinh
--Câu 4.8 Xóa các ràng buộc chính khỏi bảng SVtam
ALTER TABLE SVtam
DROP CONSTRAINT [PK_SVtam]

--Câu 4.9 Tạo lại khóa chính trên bảng svtam, trong quá trình tạo khóa chính sử dụng tuỳ chọn
--NonClustered để SQL Server không tạo chỉ mục Clustered trên chỉ mục khóa chính 
--(vì mặc định khi tạo khóa chính SQL sẽ tự động tạo chỉ mục Clustered trên cột khóa)
ALTER TABLE SVtam
ADD CONSTRAINT PK_SVtam PRIMARY KEY NONCLUSTERED (MaSV);
-- Câu 4.10 Tạo chỉ mục Clustered và Unique trên cột MaSV với hệ số điền đầy đủ bằng 60
create unique clustered index ix_MaSv on Svtam(MaSV)
with (fillfactor = 60)
--Câu 4.11 Thiết lập chỉ mục toàn văn trên cột hoten
exec sp_fulltext_database 'enable'
create fulltext catalog HT_cat with accent_sensitivity = off
as default 
 
create fulltext index on SVtam(Hoten)
key index [PK_SVtam] on HT_cat
--Câu 4.12 Tìm tất cả  tên sinh viên chứa từ Văn hoặc Nguyễn
select Hoten from SVtam
where contains(Hoten,'"Văn" or "Nguyễn"')
select Hoten from SVtam
where freetext(Hoten,'Văn Nguyễn')
select Hoten from SVtam
where contains(Hoten, 'near((Nguyễn,Anh),1)')