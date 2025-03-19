USE QLVT_NguyenVanThang12523081
EXEC sp_addlogin thang4,'123456'
EXEC sp_adduser  thang4,thang4

-- Cap quyen 
GRANT SELECT, UPDATE ON NhanVien
TO thang4
-- Huy quyen 
REVOKE SELECT, UPDATE ON NhanVien
FROM thang4
-- Sao luu
BACKUP DATABASE QLVT_NguyenVanThang12523081 TO DISK = 'C:\backup\QLVT_NguyenVanThang12523081.bak'
RESTORE DATABASE QLVT_NguyenVanThang12523081 FROM DISK= 'C:\backup\QLVT_NguyenVanThang12523081.bak'
