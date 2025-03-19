CREATE DATABASE BAITAPMAU;
GO
USE BAITAPMAU
CREATE TABLE LoaiHang
(
LoaiHangID CHAR(10) PRIMARY KEY,
TenLH NVARCHAR(50) UNIQUE
)
EXEC SP_HELP LoaiHang
EXEC sp_helpconstraint LoaiHang
CREATE TABLE NHACC
(NhaCCID CHAR(10) CONSTRAINT P_NhaCC PRIMARY KEY,
TenNCC NVARCHAR(30) NOT NULL,
diachiNCC NVARCHAR(50),
SdtNCC CHAR(11) NOT NULL)

CREATE TABLE MatHang
(
LoaiHangID CHAR(10) FOREIGN KEY REFERENCES
LOAIHANG(LoaiHangID) ON DELETE CASCADE
ON UPDATE CASCADE,
MathangID CHAR(10) PRIMARY KEY,
TenHang NVARCHAR(50),
Dvtinh NVARCHAR(10),
Slton tinyint DEFAULT 0
)
CREATE TABLE KhachHang
(KhachHangID CHAR(10) PRIMARY KEY,
HotenKH NVARCHAR(30),
DiachiKH NVARCHAR(50),
EmailKH CHAR(30), CHECK(EmailKH LIKE '%@%'),
SdtKH CHAR(11) DEFAULT N'Không có')


CREATE TABLE NhanVien
(NhanVienID CHAR(10) PRIMARY KEY,
HotenNV NVARCHAR(30),
GioitinhNV NVARCHAR(50), CHECK (GIOITINHnv IN ('Nam',N'Nữ')),
NgaysinhNV Date, check(year(NgaysinhNV)<2010),
diachiNV NVARCHAR(50),
EmailNv CHAR(30), CHECK(Emailnv LIKE '%@%'),
SdtNV CHAR(11) DEFAULT N'Không có')


CREATE TABLE Donhangnhap
(DonhangnhapID CHAR(10) PRIMARY KEY,
NhanvienID CHAR(10) REFERENCES Nhanvien(NhanvienID)
ON DELETE CASCADE ON UPDATE CASCADE,
NhaCCID CHAR(10) REFERENCES NhaCC(NhaCCID)
ON DELETE CASCADE ON UPDATE CASCADE,
Ngaynhap Datetime, check (Ngaynhap<=Getdate()),
Trietkhaunhap FLOAT DEFAULT 0)


CREATE TABLE Donhangban
(DonhangbanID CHAR(10) PRIMARY KEY,
NhanvienID CHAR(10) REFERENCES Nhanvien(NhanvienID)
ON DELETE CASCADE ON UPDATE CASCADE,
KhachhangID CHAR(10) REFERENCES Khachhang(KhachhangID)
ON DELETE CASCADE ON UPDATE CASCADE,
Ngayban Datetime ,check (Ngayban<=Getdate()),
Trietkhauban FLOAT DEFAULT 0)


CREATE TABLE ChitietDHN 
(DonhangnhapID CHAR(10) NOT NULL REFERENCES
Donhangnhap(DonhangnhapID) ON DELETE CASCADE,
MathangID CHAR(10) NOT NULL REFERENCES Mathang
(mathangID) ON DELETE CASCADE,
Slnhap TINyint, CHECK(Slnhap>0),
DGnhap FLOAT, CHECK (DGnhap>0),
CONSTRAINT P_CTDHN
PRIMARY KEY(DonhangnhapID,MathangID) )


CREATE TABLE ChitietDHB
(DonhangbanID CHAR(10) NOT NULL REFERENCES
Donhangban(DonhangbanID) ON DELETE CASCADE,
MathangID CHAR(10) NOT NULL REFERENCES 
Mathang(MathangID) ON DELETE CASCADE,
Slban TINyint, CHECK(Slban>0),
DGban FLOAT, CHECK (DGban>0),
CONSTRAINT P_CTDHB
PRIMARY KEY(DonhangbanID,MathangID) )



INSERT INTO LoaiHang(LoaiHangID,TenLH)
VALUES ('DH',N'Điều hoà'),('NCD',N'Nồi cơm điện'),('Qc',N'Quạt cây'),('Tv',N'Ti vi'),('Tl',N'Tủ lạnh')

INSERT INTO MatHang(LoaiHangID,MathangID,TenHang,Dvtinh,Slton)
VALUES ('DH','dhp1220',N'Điều hoà Panasonic 1200','Cái',40)
INSERT INTO MatHang(LoaiHangID,MathangID,TenHang,Dvtinh,Slton)
VALUES ('TL','tllg10020',N'Tủ lạnh LG100l','Cái',30)
INSERT INTO MatHang(LoaiHangID,MathangID,TenHang,Dvtinh,Slton)
VALUES ('TL','tls16519',N'Tủ lạnh sam sung 165l','Cái',20)
INSERT INTO MatHang(LoaiHangID,MathangID,TenHang,Dvtinh,Slton)
VALUES ('TL','tls26519',N'Tủ lạnh sam sung 265l','Cái',10)
INSERT INTO MatHang(LoaiHangID,MathangID,TenHang,Dvtinh,Slton)
VALUES ('TV','tvs2120',N'Ti vi sam sung 21 inch','Cái',30)
INSERT INTO MatHang(LoaiHangID,MathangID,TenHang,Dvtinh,Slton)
VALUES ('TV','tvs5420',N'Ti vi sam sung 54 inch','Cái',60)
INSERT INTO MatHang(LoaiHangID,MathangID,TenHang,Dvtinh,Slton)
VALUES ('TV','tvs6020',N'Ti vi sam sung 60 inch','Cái',NULL)

INSERT INTO NHACC(NhaCCID,TenNCC,diachiNCC,SdtNCC)
VALUES ('ccfu',N'Funiki Điện lạnh Minh Ngọc',N'Hai Bà Trưng, Hà Nội',2459278679)
INSERT INTO NHACC(NhaCCID,TenNCC,diachiNCC,SdtNCC)
VALUES ('cclg','LG Group',N'Thanh Trì,Hà Nội',2450278679)
INSERT INTO NHACC(NhaCCID,TenNCC,diachiNCC,SdtNCC)
VALUES ('ccpa','Panasonic Group',N'Thanh Xuân,Hà Nội',2456678789)
INSERT INTO NHACC(NhaCCID,TenNCC,diachiNCC,SdtNCC)
VALUES ('ccsa','SamSung Group',N'Thuận Thành,Bắc Ninh',2256678789)
INSERT INTO NHACC(NhaCCID,TenNCC,diachiNCC,SdtNCC)
VALUES ('ccvi','Vinawind Group',N'Cầu Giấy,Hà Nội',2489278679)

INSERT INTO KhachHang(KhachHangID,HotenKH,DiachiKH,EmailKH,SdtKH)
VALUES ('KH01',N'Trần Thị Liễu',N'Yên Mỹ,Hưng Yên','lieutt@gmail.com',0987567888)
INSERT INTO KhachHang(KhachHangID,HotenKH,DiachiKH,EmailKH,SdtKH)
VALUES ('KH02',N'Nguyễn Văn Quỳnh',N'Mê Linh,Hà Nội','QuynhNV@gmail.com',0987567888)
INSERT INTO KhachHang(KhachHangID,HotenKH,DiachiKH,EmailKH,SdtKH)
VALUES ('KH03',N'Vũ Thị Minh',N'Cẩm Giàng,Hải Dương','MinhVT@gmail.com',0945567123)
INSERT INTO KhachHang(KhachHangID,HotenKH,DiachiKH,EmailKH,SdtKH)
VALUES ('KH04',N'Trịnh Thị Lan',N'Mỹ Hào,Hưng Yên','LanTT@gmail.com',0345556777)
INSERT INTO KhachHang(KhachHangID,HotenKH,DiachiKH,EmailKH,SdtKH)
VALUES ('KH05',N'Trần Thanh Thuý',N'Mỹ Hào,Hưng Yên','Thuythanh@gmail.com',0345556154)

INSERT INTO NhanVien(NhanVienID,HotenNV,GioitinhNV,NgaysinhNV,diachiNV,EmailNv,SdtNV)
VALUES ('NV01',N'Mai Thị Hoa',N'Nữ','19990909',N'Mỹ Hào,Hưng Yên','HoaMH09@gmail.com',0981890898)
INSERT INTO NhanVien(NhanVienID,HotenNV,GioitinhNV,NgaysinhNV,diachiNV,EmailNv,SdtNV)
VALUES ('NV02',N'Trần Tuấn Lập',N'Nam','19800109',N'Yên Mỹ,Hưng Yên','lapTT@gmail.com',0904898998)
INSERT INTO NhanVien(NhanVienID,HotenNV,GioitinhNV,NgaysinhNV,diachiNV,EmailNv,SdtNV)
VALUES ('NV03',N'Nguyễn Văn An',N'Nam','19900903',N'Ba Vì,Hà Tây','Annguyen09@gmail.com',0984890005)
INSERT INTO NhanVien(NhanVienID,HotenNV,GioitinhNV,NgaysinhNV,diachiNV,EmailNv,SdtNV)
VALUES ('NV04',N'Vũ Mai Liên',N'Nữ','19900505',N'TP Hải Dương,Hải Dương','MaiLien05@gmail.com',0996890777)
INSERT INTO NhanVien(NhanVienID,HotenNV,GioitinhNV,NgaysinhNV,diachiNV,EmailNv,SdtNV)
VALUES ('NV05',N'Cao Thị Thu',N'Nữ','19890507',N'Cầu Giấy,Hà Nội','Thucao05@gmail.com',0976890123)

INSERT INTO Donhangnhap(DonhangnhapID,NhanvienID,NhaCCID,Ngaynhap,Trietkhaunhap)
VALUES ('DN01','NV01','ccsa','20200803',0.25)
INSERT INTO Donhangnhap(DonhangnhapID,NhanvienID,NhaCCID,Ngaynhap,Trietkhaunhap)
VALUES ('DN02','NV02','ccpa','20200102',0.25)
INSERT INTO Donhangnhap(DonhangnhapID,NhanvienID,NhaCCID,Ngaynhap,Trietkhaunhap)
VALUES ('DN03','NV03','ccsa','20200202',0)
INSERT INTO Donhangnhap(DonhangnhapID,NhanvienID,NhaCCID,Ngaynhap,Trietkhaunhap)
VALUES ('DN04','NV04','cclg','20200315',0)

INSERT INTO ChitietDHN(DonhangnhapID,MathangID,Slnhap,DGnhap)
VALUES ('DN01','tvs2120',100,10000000)
INSERT INTO ChitietDHN(DonhangnhapID,MathangID,Slnhap,DGnhap)
VALUES ('DN01','tvs5420',50,20000000)
INSERT INTO ChitietDHN(DonhangnhapID,MathangID,Slnhap,DGnhap)
VALUES ('DN01','tvs6020',40,20000000)
INSERT INTO ChitietDHN(DonhangnhapID,MathangID,Slnhap,DGnhap)
VALUES ('DN02','tls16519',100,3000000)
INSERT INTO ChitietDHN(DonhangnhapID,MathangID,Slnhap,DGnhap)
VALUES ('DN02','tls26519',50,5000000)
INSERT INTO ChitietDHN(DonhangnhapID,MathangID,Slnhap,DGnhap)
VALUES ('DN03','dhp1220',40,2580000)
INSERT INTO ChitietDHN(DonhangnhapID,MathangID,Slnhap,DGnhap)
VALUES ('DN04','tllg10020',40,4500000)

INSERT INTO Donhangban(DonhangbanID,NhanvienID,KhachhangID,Ngayban,Trietkhauban)
VALUES ('DB01','NV05','KH01','20200813',0)
INSERT INTO Donhangban(DonhangbanID,NhanvienID,KhachhangID,Ngayban,Trietkhauban)
VALUES ('DB02','NV05','KH01','20200811',0)
INSERT INTO Donhangban(DonhangbanID,NhanvienID,KhachhangID,Ngayban,Trietkhauban)
VALUES ('DB03','NV04','KH02','20200812',0)
INSERT INTO Donhangban(DonhangbanID,NhanvienID,KhachhangID,Ngayban,Trietkhauban)
VALUES ('DB04','NV04','KH04','20200813',0)
INSERT INTO Donhangban(DonhangbanID,NhanvienID,KhachhangID,Ngayban,Trietkhauban)
VALUES ('DB05','NV01','KH03','20200805',0)

INSERT INTO ChitietDHB(DonhangbanID,MathangID,Slban,DGban)
VALUES ('DB01','dhp1220',2,3000000)
INSERT INTO ChitietDHB(DonhangbanID,MathangID,Slban,DGban)
VALUES ('DB01','tllg10020',1,5000000)
INSERT INTO ChitietDHB(DonhangbanID,MathangID,Slban,DGban)
VALUES ('DB02','dhp1220',3,3000000)
INSERT INTO ChitietDHB(DonhangbanID,MathangID,Slban,DGban)
VALUES ('DB02','tllg10020',2,5000000)
INSERT INTO ChitietDHB(DonhangbanID,MathangID,Slban,DGban)
VALUES ('DB02','tvs2120',2,11000000)
INSERT INTO ChitietDHB(DonhangbanID,MathangID,Slban,DGban)
VALUES ('DB03','tvs6020',1,21000000)
INSERT INTO ChitietDHB(DonhangbanID,MathangID,Slban,DGban)
VALUES ('DB04','dhp1220',1,3000000)


SELECT*FROM LoaiHang
SELECT*FROM MatHang
SELECT*FROM NHACC
SELECT*FROM KhachHang
SELECT*FROM NhanVien
SELECT*FROM Donhangnhap
SELECT*FROM ChitietDHN
SELECT*FROM Donhangban
SELECT*FROM ChitietDHB
SELECT DonhangbanID,MatHangID,SLBan,DGBan
FROM ChitietDHB
WHERE DGBan > 5000000
SELECT KhachHangID,HoTenKH,DiaChiKH
FROM KhachHang
WHERE HotenKH LIKE N'Trần %'

SELECT T.NhanVienID,T.HotenNV,T.GioitinhNV
FROM NhanVien T
WHERE T.HotenNV LIKE N'% Hoa'

SELECT T.NhanVienID,T.HotenNV,T.GioitinhNV
FROM NhanVien T
WHERE RIGHT (T.HotenNV,3) = N'Hoa'

SELECT T.NhanVienID,T.HotenNV,T.GioitinhNV,NamsinhNV = YEAR(NgaysinhNV)
FROM NhanVien T
WHERE T.HotenNV LIKE N'% Hoa'



SELECT T.NhanVienID,T.HotenNV
FROM NhanVien T
WHERE NhanVienID = 'NV01' OR T.NhanVienID = 'NV02'

SELECT T.NhanVienID,T.HotenNV
FROM NhanVien T
WHERE NhanVienID IN ('NV01','NV02')


SELECT T.NhanVienID,T.HotenNV,NamsinhNV = YEAR(T.NgaysinhNV)
FROM NhanVien T
WHERE T.diachiNV LIKE N'%Hưng Yên'
ORDER BY NamsinhNV--Sap xep nam sinh tang dan


SELECT T.NhanVienID,T.HotenNV,NamsinhNV = YEAR(T.NgaysinhNV),T.GioitinhNV
FROM NhanVien T INNER JOIN Donhangban DB ON T.NhanVienID = DB.NhanvienID
WHERE DB.Ngayban = '2020-08-11'

SELECT T.NhanVienID,T.HotenNV,NamsinhNV = YEAR(T.NgaysinhNV),T.GioitinhNV
FROM NhanVien T, Donhangban DB
WHERE T.NhanVienID = DB.NhanvienID
AND DB.Ngayban = '2020-08-11'

SELECT DISTINCT T.NhaCCID,T.TenNCC,T.diachiNCC
FROM NHACC T INNER JOIN Donhangnhap DN
ON T.NhaCCID = DN.NhaCCID
INNER JOIN ChitietDHN CT
ON DN.DonhangnhapID = CT.DonhangnhapID
WHERE CT.DGnhap > 3000000

SELECT T.NhaCCID,T.TenNCC,DN.NhaCCID,DN.DonhangnhapID,DN.Ngaynhap
FROM NHACC T LEFT JOIN Donhangnhap DN
ON T.NhaCCID = DN.NhaCCID


SELECT T.NhaCCID,T.TenNCC,DN.NhaCCID,DN.DonhangnhapID,DN.Ngaynhap
FROM NHACC T LEFT JOIN Donhangnhap DN
ON T.NhaCCID = DN.NhaCCID
WHERE DN.NhaCCID IS NULL 

  SELECT LoaiHang.LoaiHangID,LoaiHang.TenLH INTO LHtam
  FROM LoaiHang
  SELECT L.LoaiHangID,L.TenLH
  FROM LHtam L
  UNION 
  SELECT T.LoaiHangID,T.TenLH
  FROM LoaiHang T 


  --
  SELECT L.LoaiHangID,L.TenLH
  FROM LHtam L
  INTERSECT 
  SELECT T.LoaiHangID,T.TenLH
  FROM LoaiHang T 

SELECT T.LoaiHangID,T.TenLH
  FROM LoaiHang T
  EXCEPT
  SELECT L.LoaiHangID,L.TenLH
  FROM LHtam L

  SELECT TT.KhachHangID,TT.HotenKH,CT.Slban,CT.DGban,ThanhTien = Slban * DGban
  FROM KhachHang TT inner join Donhangban DB ON
  TT.KhachHangID = DB.KhachhangID
  inner join ChitietDHB CT
  ON DB.DonhangbanID = CT.DonhangbanID

  
SELECT T.NhanVienID,T.HotenNV
FROM NhanVien T
WHERE T.NhanVienID IN (SELECT NhanVienID
FROM Donhangban
WHERE Ngayban = '2020-08-13' )

SELECT NhanVienID,HoTenNV
FROM NhanVien 
WHERE NhanVienID IN (SELECT NhanVienID FROM Donhangban WHERE Ngayban <'2020-08-13')



SELECT NhanVienID,HotenNV
FROM NhanVien nv
WHERE EXISTS ( SELECT NhanVienID FROM Donhangban dhb WHERE dhb.NhanvienID = nv.NhanVienID AND Ngayban <'2020-08-13')

SELECT dhb.DonhangbanID,MatHangID,SLBan,DGBan
FROM Donhangban dhb INNER JOIN ChiTietDHB ctdhb
ON dhb.DonHangBanID = ctdhb.DonhangbanID
WHERE Slban>= ALL (SELECT Slban FROM ChitietDHB)


SELECT nv.HoTenNV
FROM NhanVien AS nv,
(SELECT NhanVienID FROM Donhangban WHERE Ngayban = '2020-08-11') As Temp
WHERE nv.NhanVienID = Temp.NhanvienID


SELECT MatHangID,TenHang
FROM MatHang
ORDER BY (SELECT TenLH FROM LoaiHang
WHERE LoaiHang.LoaiHangID = MatHang.LoaiHangID)


UPDATE Donhangnhap
SET ChietkhauNhap = 0.25
WHERE DonhangnhapID IN (SELECT DonhangnhapID FROM ChitietDHB WHERE SLNhap>=100)


SELECT slmathang = COUNT(MatHangID),SltonTB = AVG(Slton)
FROM MatHang


SELECT Tongtienban = SUM(Slban * DGban)
FROM Donhangban b INNER JOIN ChitietDHB ct
ON B.DonhangbanID = CT.DonhangbanID
WHERE b.Ngayban ='2020-08-13'


SELECT LoaiHangID,TongTon = SUM(Slton)
FROM MatHang 
GROUP BY LoaiHangID


SELECT L.LoaiHangID,TongTon = SUM(Slton)
FROM LoaiHang L INNER JOIN MatHang M
ON l.LoaiHangID = m.LoaiHangID
GROUP BY L.LoaiHangID

--1
SELECT L.LoaiHangID,TongTon = SUM(Slton)
FROM LoaiHang L LEFT JOIN MatHang M
ON l.LoaiHangID = m.LoaiHangID
GROUP BY L.LoaiHangID

--2
SELECT L.LoaiHangID,TenLH,TongTon = SUM(Slton)
FROM LoaiHang L LEFT JOIN MatHang M
ON l.LoaiHangID = m.LoaiHangID
GROUP BY L.LoaiHangID,TenLH
--1
SELECT LoaiHangID,TongTon = SUM(Slton)
FROM MatHang
GROUP BY LoaiHangID
HAVING LoaiHangID = 'DH'
--2
SELECT LoaiHangID,TongTon = SUM(Slton)
FROM MatHang
WHERE LoaiHangID = 'DH'
GROUP BY LoaiHangID


SELECT L.LoaiHangID,TenLH,TongTon = SUM(Slton)
FROM LoaiHang L INNER JOIN MatHang M
ON l.LoaiHangID = m.LoaiHangID
GROUP BY L.LoaiHangID,TenLH
HAVING SUM(Slton) >= 40


SELECT L.LoaiHangID,TenLH,TongTon = SUM(Slton)
FROM LoaiHang L INNER JOIN MatHang M
ON l.LoaiHangID = m.LoaiHangID
GROUP BY L.LoaiHangID,TenLH
HAVING SUM(Slton) >= ALL
( SELECT SUM(Slton) FROM MatHang GROUP BY LoaiHangID)

SELECT L.LoaiHangID,TenLH,TongTon = SUM(Slton)
FROM LoaiHang L LEFT JOIN MatHang M
ON l.LoaiHangID = m.LoaiHangID
GROUP BY L.LoaiHangID,TenLH
HAVING SUM(Slton) <= ALL
( SELECT SUM(Slton) FROM MatHang GROUP BY LoaiHangID)

SELECT dhb.DonhangbanID,TongTien = SUM(Slban*DGban)
FROM Donhangban dhb LEFT JOIN ChitietDHB ctdhb
ON dhb.DonhangbanID = ctdhb.DonhangbanID
GROUP BY dhb.DonhangbanID








