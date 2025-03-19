use NguyenVanThang_12523081
--Tạo login
exec sp_addlogin sv1,'123456'
exec sp_addlogin sv2,'123456'
exec sp_addlogin sv3,'123456'
exec sp_addlogin gv1,'123456'
exec sp_addlogin gv2,'123456'

--Tạo user 
exec sp_adduser sv1,SinhVien1
exec sp_adduser sv2,SinhVien2
exec sp_adduser sv3,SinhVien3
exec sp_adduser gv1,GiaoVien1
exec sp_adduser gv2,GiaoVien2

--Câu 3.4 Thiết lập quyền hạn cho GiaoVien1 có toàn quyền thao tác trên bảng SINHVIEN
grant all privileges on Sinhvien to GiaoVien1

---revoke all privileges on Sinhvien from GiaoVien1

--Câu 3.5 Thêm user GiaoVien1 và GiaoVien2 vào nhóm giáo viên
--Tạo role 
exec sp_addrole GiaoVien
--Thêm role member 
exec sp_addrolemember GiaoVien,GiaoVien1
exec sp_addrolemember GiaoVien,GiaoVien2

--Câu 3.6 Quyền tạo lập bảng mới
grant create table to GiaoVien

---revoke create rule from GiaoVien
--Câu 3.7 Phân quyền cho SV1 trong CSDL chèn, thêm, đọc
grant insert,select on Khoa to SinhVien1

---revoke insert,select on Khoa from SinhVien1

--Câu 3.8
grant update,delete on Monhoc to SinhVien2
---revoke update,delete on Monhoc from SinhVien2

--Câu 3.9
grant select on Monhoc to SinhVien3
---revoke select on Monhoc from SinhVien3
--Câu 3.10 Đăng nhập user sử dụng quyền không được cấp
--Câu 3.11 Thu hồi quyền
revoke all privileges on Sinhvien from GiaoVien1
revoke create table from GiaoVien
revoke insert,select on Khoa from SinhVien1
revoke update,delete on Monhoc from SinhVien2
revoke select on Monhoc from SinhVien3