USE [master]
GO
/****** Object:  Database [BanDoAnNhanh]    Script Date: 11/1/2023 2:52:52 PM ******/
CREATE DATABASE [BanDoAnNhanh]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BanDoAnNhanh', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS02\MSSQL\DATA\BanDoAnNhanh.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'BanDoAnNhanh_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS02\MSSQL\DATA\BanDoAnNhanh_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [BanDoAnNhanh] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BanDoAnNhanh].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BanDoAnNhanh] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BanDoAnNhanh] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BanDoAnNhanh] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BanDoAnNhanh] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BanDoAnNhanh] SET ARITHABORT OFF 
GO
ALTER DATABASE [BanDoAnNhanh] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [BanDoAnNhanh] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BanDoAnNhanh] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BanDoAnNhanh] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BanDoAnNhanh] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BanDoAnNhanh] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BanDoAnNhanh] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BanDoAnNhanh] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BanDoAnNhanh] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BanDoAnNhanh] SET  ENABLE_BROKER 
GO
ALTER DATABASE [BanDoAnNhanh] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BanDoAnNhanh] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BanDoAnNhanh] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BanDoAnNhanh] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BanDoAnNhanh] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BanDoAnNhanh] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BanDoAnNhanh] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BanDoAnNhanh] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [BanDoAnNhanh] SET  MULTI_USER 
GO
ALTER DATABASE [BanDoAnNhanh] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BanDoAnNhanh] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BanDoAnNhanh] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BanDoAnNhanh] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [BanDoAnNhanh] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [BanDoAnNhanh] SET QUERY_STORE = OFF
GO
USE [BanDoAnNhanh]
GO
/****** Object:  UserDefinedFunction [dbo].[splitstring]    Script Date: 11/1/2023 2:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[splitstring] ( @stringToSplit VARCHAR(MAX), @character varchar(10) )
RETURNS
 @returnList TABLE ([Name] [nvarchar] (500))
AS
BEGIN

 DECLARE @name NVARCHAR(255)
 DECLARE @pos INT

 WHILE CHARINDEX(@character, @stringToSplit) > 0
 BEGIN
  SELECT @pos  = CHARINDEX(',', @stringToSplit)  
  SELECT @name = SUBSTRING(@stringToSplit, 1, @pos-1)

  INSERT INTO @returnList 
  SELECT @name

  SELECT @stringToSplit = SUBSTRING(@stringToSplit, @pos+1, LEN(@stringToSplit)-@pos)
 END

 INSERT INTO @returnList
 SELECT @stringToSplit

 RETURN
END

GO
/****** Object:  Table [dbo].[DC_PhuongXa]    Script Date: 11/1/2023 2:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DC_PhuongXa](
	[ID_PhuongXa] [int] NOT NULL,
	[TenPhuongXa] [nvarchar](250) NULL,
	[ID_QuanHuyen] [int] NULL,
	[Created_Date] [datetime] NULL,
	[Created_By] [nvarchar](50) NULL,
	[Modified_Date] [datetime] NULL,
	[Modified_By] [nvarchar](50) NULL,
	[Delete_Mark] [bit] NULL,
 CONSTRAINT [PK_DC_PhuongXa] PRIMARY KEY CLUSTERED 
(
	[ID_PhuongXa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DC_QuanHuyen]    Script Date: 11/1/2023 2:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DC_QuanHuyen](
	[ID_QuanHuyen] [int] NOT NULL,
	[ID_TinhThanh] [int] NULL,
	[TenQuanHuyen] [nvarchar](250) NULL,
	[Created_Date] [datetime] NULL,
	[Created_By] [nvarchar](50) NULL,
	[Modified_Date] [datetime] NULL,
	[Modified_By] [nvarchar](50) NULL,
	[Delete_Mark] [bit] NULL,
 CONSTRAINT [PK_DC_QuanHuyen] PRIMARY KEY CLUSTERED 
(
	[ID_QuanHuyen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DC_TinhThanh]    Script Date: 11/1/2023 2:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DC_TinhThanh](
	[ID_TinhThanh] [int] NOT NULL,
	[TenTinhThanh] [nvarchar](250) NULL,
	[Created_Date] [datetime] NULL,
	[Created_By] [nvarchar](50) NULL,
	[Modified_Date] [datetime] NULL,
	[Modified_By] [nvarchar](50) NULL,
	[Delete_Mark] [bit] NULL,
 CONSTRAINT [PK_DC_TinhThanh] PRIMARY KEY CLUSTERED 
(
	[ID_TinhThanh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DM_ChucDanh]    Script Date: 11/1/2023 2:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DM_ChucDanh](
	[ID_ChucDanh] [int] IDENTITY(1,1) NOT NULL,
	[TenChucDanh] [nvarchar](250) NULL,
	[Created_Date] [datetime] NULL,
	[Created_By] [nvarchar](50) NULL,
	[Modified_Date] [datetime] NULL,
	[Modified_By] [nvarchar](50) NULL,
	[Delete_Mark] [bit] NULL,
 CONSTRAINT [PK_DM_ChucDanh] PRIMARY KEY CLUSTERED 
(
	[ID_ChucDanh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DM_KhuyenMai]    Script Date: 11/1/2023 2:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DM_KhuyenMai](
	[ID_KhuyenMai] [int] IDENTITY(1,1) NOT NULL,
	[MaKhuyenMai] [varchar](50) NULL,
	[TienGiamGia] [money] NULL,
	[MoTa] [nvarchar](500) NULL,
	[HieuLucTu] [datetime] NULL,
	[HieuLucDen] [datetime] NULL,
	[Create_Date] [datetime] NULL,
	[Create_By] [varchar](50) NULL,
	[Modified_Date] [datetime] NULL,
	[Modified_By] [varchar](50) NULL,
	[Delete_Mark] [bit] NULL,
 CONSTRAINT [PK_DM_KhuyenMai] PRIMARY KEY CLUSTERED 
(
	[ID_KhuyenMai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DM_MonAn]    Script Date: 11/1/2023 2:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DM_MonAn](
	[ID_MonAn] [bigint] IDENTITY(1,1) NOT NULL,
	[ID_MonAnPhanLoai] [int] NULL,
	[ID_MonAnTrangThai] [int] NULL,
	[TenMonAn] [nvarchar](max) NULL,
	[HinhAnhTheHien] [nvarchar](250) NULL,
	[DanhGia] [int] NULL,
	[DonGia] [float] NULL,
	[MaGiamGia] [varchar](50) NULL,
	[MoTa] [nvarchar](max) NULL,
	[Create_Date] [datetime] NULL,
	[Create_By] [varchar](50) NULL,
	[Modified_Date] [datetime] NULL,
	[Modified_By] [varchar](50) NULL,
	[Delete_Mark] [bit] NULL,
 CONSTRAINT [PK_DM_DoAn] PRIMARY KEY CLUSTERED 
(
	[ID_MonAn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DM_MonAn_NguyenLieu]    Script Date: 11/1/2023 2:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DM_MonAn_NguyenLieu](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ID_MonAn] [int] NULL,
	[ID_NguyenLieu] [int] NULL,
	[Create_Date] [datetime] NULL,
	[Create_By] [varchar](50) NULL,
	[Modified_Date] [datetime] NULL,
	[Modified_By] [varchar](50) NULL,
	[Delete_Mark] [bit] NULL,
 CONSTRAINT [PK_DM_MonAn_NguyenLieu] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DM_MonAn_PhanLoai]    Script Date: 11/1/2023 2:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DM_MonAn_PhanLoai](
	[ID_MonAnPhanLoai] [int] IDENTITY(1,1) NOT NULL,
	[TenMonAnPhanLoai] [nvarchar](250) NULL,
	[Created_Date] [datetime] NULL,
	[Created_By] [nvarchar](50) NULL,
	[Modified_Date] [datetime] NULL,
	[Modified_By] [nvarchar](50) NULL,
	[Delete_Mark] [bit] NULL,
 CONSTRAINT [PK_DM_MonAn_PhanLoai] PRIMARY KEY CLUSTERED 
(
	[ID_MonAnPhanLoai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DM_MonAn_TrangThai]    Script Date: 11/1/2023 2:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DM_MonAn_TrangThai](
	[ID_MonAnTrangThai] [int] NOT NULL,
	[TenTrangThai] [nvarchar](250) NULL,
	[MoTa] [nvarchar](500) NULL,
	[Created_Date] [datetime] NULL,
	[Created_By] [nvarchar](50) NULL,
	[Modified_Date] [datetime] NULL,
	[Modified_By] [nvarchar](50) NULL,
	[Delete_Mark] [bit] NULL,
 CONSTRAINT [PK_DM+MonAn_TrangThai] PRIMARY KEY CLUSTERED 
(
	[ID_MonAnTrangThai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DM_NguyenLieu]    Script Date: 11/1/2023 2:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DM_NguyenLieu](
	[ID_NguyenLieu] [int] IDENTITY(1,1) NOT NULL,
	[TenNguyenLieu] [nvarchar](250) NULL,
	[Created_Date] [datetime] NULL,
	[Created_By] [nvarchar](50) NULL,
	[Modified_Date] [datetime] NULL,
	[Modified_By] [nvarchar](50) NULL,
	[Delete_Mark] [bit] NULL,
 CONSTRAINT [PK_DM_NguyenLieu] PRIMARY KEY CLUSTERED 
(
	[ID_NguyenLieu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DM_NhaCungCap]    Script Date: 11/1/2023 2:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DM_NhaCungCap](
	[ID_NhaCungCap] [int] IDENTITY(1,1) NOT NULL,
	[MaNhaCungCap] [varchar](50) NULL,
	[TenNhaCungCap] [nvarchar](500) NULL,
	[SoDienThoai] [varchar](15) NULL,
	[Email] [nvarchar](50) NULL,
	[ID_TinhThanh] [int] NULL,
	[ID_QuanHuyen] [int] NULL,
	[ID_PhuongXa] [int] NULL,
	[SoNha] [nvarchar](250) NULL,
	[DiaChi] [nvarchar](500) NULL,
	[Create_Date] [datetime] NULL,
	[Create_By] [varchar](50) NULL,
	[Modified_Date] [datetime] NULL,
	[Modified_By] [varchar](50) NULL,
	[Delete_Mark] [bit] NULL,
 CONSTRAINT [PK_DM_NhaCungCap] PRIMARY KEY CLUSTERED 
(
	[ID_NhaCungCap] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DM_TaiKhoan]    Script Date: 11/1/2023 2:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DM_TaiKhoan](
	[ID_TaiKhoan] [int] IDENTITY(1,1) NOT NULL,
	[TenDangNhap] [varchar](100) NULL,
	[MatKhau] [nvarchar](100) NULL,
	[TenDayDu] [nvarchar](250) NULL,
	[IsKhachHang] [bit] NULL,
	[GioiTinh] [varchar](50) NULL,
	[IsLock] [bit] NULL,
	[Email] [nvarchar](250) NULL,
	[SoDienThoai] [varchar](20) NULL,
	[SoNha] [nvarchar](250) NULL,
	[ID_ChucDanh] [int] NULL,
	[ID_TinhThanh] [int] NULL,
	[ID_QuanHuyen] [int] NULL,
	[ID_PhuongXa] [int] NULL,
	[Created_Date] [datetime] NULL,
	[Created_By] [nvarchar](50) NULL,
	[Modified_Date] [datetime] NULL,
	[Modified_By] [nvarchar](50) NULL,
	[Delete_Mark] [bit] NULL,
 CONSTRAINT [PK_DM_Account] PRIMARY KEY CLUSTERED 
(
	[ID_TaiKhoan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DonHang]    Script Date: 11/1/2023 2:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DonHang](
	[ID_DonHang] [bigint] IDENTITY(1,1) NOT NULL,
	[MaDonHang] [varchar](50) NULL,
	[ID_TaiKhoan] [int] NULL,
	[ID_MonAn] [bigint] NULL,
	[SoLuong] [float] NULL,
	[DonGia] [float] NULL,
	[ThanhTien] [float] NULL,
	[ID_TrangThai_DonHang] [int] NULL,
	[Created_Date] [datetime] NULL,
	[Created_By] [varchar](50) NULL,
	[Modified_Date] [datetime] NULL,
	[Modified_By] [varchar](50) NULL,
	[Delete_Mark] [bit] NULL,
 CONSTRAINT [PK_GioHang_ChuaThanhToan] PRIMARY KEY CLUSTERED 
(
	[ID_DonHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DonHang_TrangThai]    Script Date: 11/1/2023 2:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DonHang_TrangThai](
	[ID_TrangThai] [int] IDENTITY(1,1) NOT NULL,
	[TenTrangThai] [nvarchar](250) NULL,
	[Created_Date] [datetime] NULL,
	[Created_By] [nvarchar](50) NULL,
	[Modified_Date] [datetime] NULL,
	[Modified_By] [nvarchar](50) NULL,
	[Delete_Mark] [bit] NULL,
 CONSTRAINT [PK_GioHang_TrangThai] PRIMARY KEY CLUSTERED 
(
	[ID_TrangThai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThanhToan_DonHang]    Script Date: 11/1/2023 2:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThanhToan_DonHang](
	[ID_ThanhToan] [bigint] IDENTITY(1,1) NOT NULL,
	[ID_TaiKhoan] [int] NOT NULL,
	[ID_HinhThuc_ThanhToan] [int] NULL,
	[ID_KhuyenMai] [int] NULL,
	[MaVanChuyen] [varchar](50) NULL,
	[NguoiNhan_HoTen] [nvarchar](250) NULL,
	[NguoiNhan_SoDienThoai] [nvarchar](15) NULL,
	[TongTienDonHang] [float] NULL,
	[IsThanhToan] [bit] NULL,
	[SoNha] [nvarchar](250) NULL,
	[DiaChiNhanHang] [nvarchar](500) NULL,
	[ID_TinhThanh] [int] NULL,
	[ID_QuanHuyen] [int] NULL,
	[ID_PhuongXa] [int] NULL,
	[GhiChu] [nvarchar](500) NULL,
	[Created_Date] [datetime] NULL,
	[Created_By] [nvarchar](50) NULL,
	[Modified_Date] [datetime] NULL,
	[Modified_By] [nvarchar](50) NULL,
	[Delete_Mark] [bit] NULL,
 CONSTRAINT [PK_ThanhToan_DonHang] PRIMARY KEY CLUSTERED 
(
	[ID_ThanhToan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThanhToan_DonHang_ChiTiet]    Script Date: 11/1/2023 2:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThanhToan_DonHang_ChiTiet](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ID_ThanhToan] [bigint] NULL,
	[ID_DonHang] [bigint] NULL,
	[Created_Date] [datetime] NULL,
	[Created_By] [varchar](50) NULL,
	[Modified_Date] [datetime] NULL,
	[Modified_By] [varchar](50) NULL,
	[Delete_Mark] [bit] NULL,
 CONSTRAINT [PK_ThanhToan_DonHang_ChiTiet] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThanhToan_HinhThuc_ThanhToan]    Script Date: 11/1/2023 2:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThanhToan_HinhThuc_ThanhToan](
	[ID_HinhThuc_ThanhToan] [int] IDENTITY(1,1) NOT NULL,
	[TenHinhThucThanhToan] [nvarchar](250) NULL,
	[Created_Date] [datetime] NULL,
	[Created_By] [nvarchar](50) NULL,
	[Modified_Date] [datetime] NULL,
	[Modified_By] [nvarchar](50) NULL,
	[Delete_Mark] [bit] NULL,
 CONSTRAINT [PK_ThanhToan_HinhThuc_ThanhToan] PRIMARY KEY CLUSTERED 
(
	[ID_HinhThuc_ThanhToan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DC_PhuongXa] ADD  CONSTRAINT [DF_DC_PhuongXa_Created_Date]  DEFAULT (getdate()) FOR [Created_Date]
GO
ALTER TABLE [dbo].[DC_PhuongXa] ADD  CONSTRAINT [DF_DC_PhuongXa_Delete_Mark]  DEFAULT ((0)) FOR [Delete_Mark]
GO
ALTER TABLE [dbo].[DC_QuanHuyen] ADD  CONSTRAINT [DF_DC_QuanHuyen_Created_Date]  DEFAULT (getdate()) FOR [Created_Date]
GO
ALTER TABLE [dbo].[DC_QuanHuyen] ADD  CONSTRAINT [DF_DC_QuanHuyen_Delete_Mark]  DEFAULT ((0)) FOR [Delete_Mark]
GO
ALTER TABLE [dbo].[DC_TinhThanh] ADD  CONSTRAINT [DF_DC_TinhThanh_Created_Date]  DEFAULT (getdate()) FOR [Created_Date]
GO
ALTER TABLE [dbo].[DC_TinhThanh] ADD  CONSTRAINT [DF_DC_TinhThanh_Delete_Mark]  DEFAULT ((0)) FOR [Delete_Mark]
GO
ALTER TABLE [dbo].[DM_ChucDanh] ADD  CONSTRAINT [DF_DM_ChucDanh_Created_Date]  DEFAULT (getdate()) FOR [Created_Date]
GO
ALTER TABLE [dbo].[DM_ChucDanh] ADD  CONSTRAINT [DF_DM_ChucDanh_Delete_Mark]  DEFAULT ((0)) FOR [Delete_Mark]
GO
ALTER TABLE [dbo].[DM_KhuyenMai] ADD  CONSTRAINT [DF_DM_KhuyenMai_Create_Date]  DEFAULT (getdate()) FOR [Create_Date]
GO
ALTER TABLE [dbo].[DM_KhuyenMai] ADD  CONSTRAINT [DF_DM_KhuyenMai_Modified_Date]  DEFAULT (getdate()) FOR [Modified_Date]
GO
ALTER TABLE [dbo].[DM_KhuyenMai] ADD  CONSTRAINT [DF_DM_KhuyenMai_Delete_Mark]  DEFAULT ((0)) FOR [Delete_Mark]
GO
ALTER TABLE [dbo].[DM_MonAn] ADD  CONSTRAINT [DF_DM_DoAn_Create_Date]  DEFAULT (getdate()) FOR [Create_Date]
GO
ALTER TABLE [dbo].[DM_MonAn] ADD  CONSTRAINT [DF_DM_DoAn_Modified_Date]  DEFAULT (getdate()) FOR [Modified_Date]
GO
ALTER TABLE [dbo].[DM_MonAn] ADD  CONSTRAINT [DF_DM_DoAn_Delete_Mark]  DEFAULT ((0)) FOR [Delete_Mark]
GO
ALTER TABLE [dbo].[DM_MonAn_NguyenLieu] ADD  CONSTRAINT [DF_DM_MonAn_NguyenLieu_Create_Date]  DEFAULT (getdate()) FOR [Create_Date]
GO
ALTER TABLE [dbo].[DM_MonAn_NguyenLieu] ADD  CONSTRAINT [DF_DM_MonAn_NguyenLieu_Modified_Date]  DEFAULT (getdate()) FOR [Modified_Date]
GO
ALTER TABLE [dbo].[DM_MonAn_NguyenLieu] ADD  CONSTRAINT [DF_DM_MonAn_NguyenLieu_Delete_Mark]  DEFAULT ((0)) FOR [Delete_Mark]
GO
ALTER TABLE [dbo].[DM_MonAn_PhanLoai] ADD  CONSTRAINT [DF_DM_MonAn_PhanLoai_Created_Date]  DEFAULT (getdate()) FOR [Created_Date]
GO
ALTER TABLE [dbo].[DM_MonAn_PhanLoai] ADD  CONSTRAINT [DF_DM_MonAn_PhanLoai_Modified_Date]  DEFAULT (getdate()) FOR [Modified_Date]
GO
ALTER TABLE [dbo].[DM_MonAn_PhanLoai] ADD  CONSTRAINT [DF_DM_MonAn_PhanLoai_Delete_Mark]  DEFAULT ((0)) FOR [Delete_Mark]
GO
ALTER TABLE [dbo].[DM_MonAn_TrangThai] ADD  CONSTRAINT [DF_DM_MonAn_TrangThai_Created_Date]  DEFAULT (getdate()) FOR [Created_Date]
GO
ALTER TABLE [dbo].[DM_MonAn_TrangThai] ADD  CONSTRAINT [DF_DM_MonAn_TrangThai_Delete_Mark]  DEFAULT ((0)) FOR [Delete_Mark]
GO
ALTER TABLE [dbo].[DM_NguyenLieu] ADD  CONSTRAINT [DF_DM_NguyenLieu_Created_Date]  DEFAULT (getdate()) FOR [Created_Date]
GO
ALTER TABLE [dbo].[DM_NguyenLieu] ADD  CONSTRAINT [DF_DM_NguyenLieu_Modified_Date]  DEFAULT (getdate()) FOR [Modified_Date]
GO
ALTER TABLE [dbo].[DM_NguyenLieu] ADD  CONSTRAINT [DF_DM_NguyenLieu_Delete_Mark]  DEFAULT ((0)) FOR [Delete_Mark]
GO
ALTER TABLE [dbo].[DM_NhaCungCap] ADD  CONSTRAINT [DF_DM_NhaCungCap_Create_Date]  DEFAULT (getdate()) FOR [Create_Date]
GO
ALTER TABLE [dbo].[DM_NhaCungCap] ADD  CONSTRAINT [DF_DM_NhaCungCap_Modified_Date]  DEFAULT (getdate()) FOR [Modified_Date]
GO
ALTER TABLE [dbo].[DM_NhaCungCap] ADD  CONSTRAINT [DF_DM_NhaCungCap_Delete_Mark]  DEFAULT ((0)) FOR [Delete_Mark]
GO
ALTER TABLE [dbo].[DM_TaiKhoan] ADD  CONSTRAINT [DF_DM_TaiKhoan_IsKhachHang]  DEFAULT ((0)) FOR [IsKhachHang]
GO
ALTER TABLE [dbo].[DM_TaiKhoan] ADD  CONSTRAINT [DF_DM_TaiKhoan_GioiTinh]  DEFAULT ('NAM') FOR [GioiTinh]
GO
ALTER TABLE [dbo].[DM_TaiKhoan] ADD  CONSTRAINT [DF_DM_Account_Created_Date]  DEFAULT (getdate()) FOR [Created_Date]
GO
ALTER TABLE [dbo].[DM_TaiKhoan] ADD  CONSTRAINT [DF_DM_Account_Delete_Mark]  DEFAULT ((0)) FOR [Delete_Mark]
GO
ALTER TABLE [dbo].[DonHang] ADD  CONSTRAINT [DF_GioHang_ChuaThanhToan_Create_Date]  DEFAULT (getdate()) FOR [Created_Date]
GO
ALTER TABLE [dbo].[DonHang] ADD  CONSTRAINT [DF_GioHang_ChuaThanhToan_Modified_Date]  DEFAULT (getdate()) FOR [Modified_Date]
GO
ALTER TABLE [dbo].[DonHang] ADD  CONSTRAINT [DF_GioHang_ChuaThanhToan_Delete_Mark]  DEFAULT ((0)) FOR [Delete_Mark]
GO
ALTER TABLE [dbo].[DonHang_TrangThai] ADD  CONSTRAINT [DF_GioHang_TrangThai_Created_Date]  DEFAULT (getdate()) FOR [Created_Date]
GO
ALTER TABLE [dbo].[DonHang_TrangThai] ADD  CONSTRAINT [DF_GioHang_TrangThai_Delete_Mark]  DEFAULT ((0)) FOR [Delete_Mark]
GO
ALTER TABLE [dbo].[ThanhToan_DonHang] ADD  CONSTRAINT [DF_ThanhToan_DonHang_Created_Date]  DEFAULT (getdate()) FOR [Created_Date]
GO
ALTER TABLE [dbo].[ThanhToan_DonHang] ADD  CONSTRAINT [DF_ThanhToan_DonHang_Delete_Mark]  DEFAULT ((0)) FOR [Delete_Mark]
GO
ALTER TABLE [dbo].[ThanhToan_DonHang_ChiTiet] ADD  CONSTRAINT [DF_ThanhToan_DonHang_ChiTiet_Created_Date]  DEFAULT (getdate()) FOR [Created_Date]
GO
ALTER TABLE [dbo].[ThanhToan_DonHang_ChiTiet] ADD  CONSTRAINT [DF_ThanhToan_DonHang_ChiTiet_Modified_Date]  DEFAULT (getdate()) FOR [Modified_Date]
GO
ALTER TABLE [dbo].[ThanhToan_DonHang_ChiTiet] ADD  CONSTRAINT [DF_ThanhToan_DonHang_ChiTiet_Delete_Mark]  DEFAULT ((0)) FOR [Delete_Mark]
GO
ALTER TABLE [dbo].[DC_PhuongXa]  WITH CHECK ADD  CONSTRAINT [FK_DC_PhuongXa_DC_QuanHuyen] FOREIGN KEY([ID_QuanHuyen])
REFERENCES [dbo].[DC_QuanHuyen] ([ID_QuanHuyen])
GO
ALTER TABLE [dbo].[DC_PhuongXa] CHECK CONSTRAINT [FK_DC_PhuongXa_DC_QuanHuyen]
GO
ALTER TABLE [dbo].[DC_PhuongXa]  WITH CHECK ADD  CONSTRAINT [FK_QuanHuyen] FOREIGN KEY([ID_QuanHuyen])
REFERENCES [dbo].[DC_QuanHuyen] ([ID_QuanHuyen])
GO
ALTER TABLE [dbo].[DC_PhuongXa] CHECK CONSTRAINT [FK_QuanHuyen]
GO
ALTER TABLE [dbo].[DC_QuanHuyen]  WITH CHECK ADD  CONSTRAINT [FK_DC_QuanHuyen_DC_TinhThanh] FOREIGN KEY([ID_TinhThanh])
REFERENCES [dbo].[DC_TinhThanh] ([ID_TinhThanh])
GO
ALTER TABLE [dbo].[DC_QuanHuyen] CHECK CONSTRAINT [FK_DC_QuanHuyen_DC_TinhThanh]
GO
ALTER TABLE [dbo].[DC_QuanHuyen]  WITH CHECK ADD  CONSTRAINT [FK_TinhThanh] FOREIGN KEY([ID_TinhThanh])
REFERENCES [dbo].[DC_TinhThanh] ([ID_TinhThanh])
GO
ALTER TABLE [dbo].[DC_QuanHuyen] CHECK CONSTRAINT [FK_TinhThanh]
GO
ALTER TABLE [dbo].[DM_TaiKhoan]  WITH CHECK ADD  CONSTRAINT [FK_ChucDanh] FOREIGN KEY([ID_ChucDanh])
REFERENCES [dbo].[DM_ChucDanh] ([ID_ChucDanh])
GO
ALTER TABLE [dbo].[DM_TaiKhoan] CHECK CONSTRAINT [FK_ChucDanh]
GO
ALTER TABLE [dbo].[DM_TaiKhoan]  WITH CHECK ADD  CONSTRAINT [FK_DM_ChucDanh] FOREIGN KEY([ID_ChucDanh])
REFERENCES [dbo].[DM_ChucDanh] ([ID_ChucDanh])
GO
ALTER TABLE [dbo].[DM_TaiKhoan] CHECK CONSTRAINT [FK_DM_ChucDanh]
GO
ALTER TABLE [dbo].[ThanhToan_DonHang_ChiTiet]  WITH CHECK ADD FOREIGN KEY([ID_DonHang])
REFERENCES [dbo].[DonHang] ([ID_DonHang])
GO
ALTER TABLE [dbo].[ThanhToan_DonHang_ChiTiet]  WITH CHECK ADD  CONSTRAINT [FK__ThanhToan__ID_Th__25C68D63] FOREIGN KEY([ID_ThanhToan])
REFERENCES [dbo].[ThanhToan_DonHang] ([ID_ThanhToan])
GO
ALTER TABLE [dbo].[ThanhToan_DonHang_ChiTiet] CHECK CONSTRAINT [FK__ThanhToan__ID_Th__25C68D63]
GO
/****** Object:  StoredProcedure [dbo].[ComboboxHinhThucThanhToan]    Script Date: 11/1/2023 2:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ComboboxHinhThucThanhToan]
AS
BEGIN
    SELECT ID_HinhThuc_ThanhToan ID,
	TenHinhThucThanhToan [Value]
	FROM dbo.ThanhToan_HinhThuc_ThanhToan
	WHERE Delete_Mark = 0
END
GO
/****** Object:  StoredProcedure [dbo].[ComboboxPhuongXa]    Script Date: 11/1/2023 2:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ComboboxPhuongXa]
@ID_QuanHuyen INT = 0
AS
BEGIN
    SELECT  ID_PhuongXa ID,
			TenPhuongXa [Value]
	FROM dbo.DC_PhuongXa
	WHERE Delete_Mark = 0 
	AND ID_QuanHuyen = @ID_QuanHuyen
END
GO
/****** Object:  StoredProcedure [dbo].[ComboboxQuanHuyen]    Script Date: 11/1/2023 2:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ComboboxQuanHuyen]
@ID_TinhThanh INT = 0
AS
BEGIN
    SELECT  ID_QuanHuyen ID,
			TenQuanHuyen [Value]
	FROM dbo.DC_QuanHuyen
	WHERE Delete_Mark = 0 
	AND ID_TinhThanh = @ID_TinhThanh
END
GO
/****** Object:  StoredProcedure [dbo].[ComboboxTinhThanh]    Script Date: 11/1/2023 2:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ComboboxTinhThanh]
AS
BEGIN
    SELECT  ID_TinhThanh ID,
			TenTinhThanh [Value]
	FROM dbo.DC_TinhThanh
	WHERE Delete_Mark = 0 
END
GO
/****** Object:  StoredProcedure [dbo].[DM_KhuyenMai_Delete]    Script Date: 11/1/2023 2:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[DM_KhuyenMai_Delete]
    @ListID NVARCHAR(MAX) = '',
	@NguoiCapNhat VARCHAR(50) = ''
AS
BEGIN
	DECLARE @Table TABLE (ID INT);
	INSERT INTO @Table SELECT * FROM dbo.splitstring(@ListID, ',')

	UPDATE dbo.DM_KhuyenMai SET 
	Modified_By = @NguoiCapNhat,
	Modified_Date = GETDATE(),
	Delete_Mark = 1
	WHERE ID_KhuyenMai IN (SELECT ID FROM @Table)
	
	SELECT 1 re
END
GO
/****** Object:  StoredProcedure [dbo].[DM_KhuyenMai_Get_By_MaKhuyenMai]    Script Date: 11/1/2023 2:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[DM_KhuyenMai_Get_By_MaKhuyenMai] 
@MaKhuyenMai VARCHAR(50) = ''
AS
BEGIN
    SELECT ID_KhuyenMai,
           MaKhuyenMai,
		   TienGiamGia,
           MoTa 
	FROM dbo.DM_KhuyenMai 
	WHERE Delete_Mark = 0
	AND UPPER(MaKhuyenMai) = UPPER(@MaKhuyenMai)
	AND GETDATE() BETWEEN HieuLucTu AND HieuLucDen
END
GO
/****** Object:  StoredProcedure [dbo].[DM_KhuyenMai_GetList]    Script Date: 11/1/2023 2:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[DM_KhuyenMai_GetList]
AS
BEGIN
    SELECT ID_KhuyenMai,
           MaKhuyenMai,
           HieuLucTu,
           HieuLucDen,
           MoTa 
	FROM dbo.DM_KhuyenMai 
	WHERE Delete_Mark = 0
END
GO
/****** Object:  StoredProcedure [dbo].[DM_KhuyenMai_Insert_Or_Update]    Script Date: 11/1/2023 2:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[DM_KhuyenMai_Insert_Or_Update]
@ID_KhuyenMai INT = 0,
@MaKhuyenMai  varchar(50) = '',
@MoTa  nvarchar(500) = N'',
@HieuLucTu  DATETIME = NULL,
@HieuLucDen  DATETIME = NULL,
@NguoiCapNhat VARCHAR(50) = ''
AS
BEGIN
	IF(@ID_KhuyenMai > 0)
	BEGIN
	    UPDATE dbo.DM_KhuyenMai SET	
		MaKhuyenMai = @MaKhuyenMai,
		MoTa= @MoTa,
		HieuLucTu = @HieuLucTu,
		HieuLucDen = @HieuLucDen,
		Modified_By = @NguoiCapNhat,
		Modified_Date = GETDATE()
		WHERE ID_KhuyenMai = @ID_KhuyenMai

		SELECT @ID_KhuyenMai ID_KhuyenMai
	END
	ELSE
	BEGIN
		DECLARE @table TABLE(ID INT)
	    INSERT INTO dbo.DM_KhuyenMai
		(
			MaKhuyenMai,
			MoTa,
			HieuLucTu,
			HieuLucDen,
			Create_Date,
			Create_By,
			Modified_Date,
			Modified_By,
			Delete_Mark
		)
		OUTPUT Inserted.ID_KhuyenMai INTO @table
		VALUES
		(   @MaKhuyenMai,        -- MaKhuyenMai - varchar(50)
			@MoTa,       -- MoTa - nvarchar(500)
			@HieuLucTu, -- HieuLucTu - datetime
			@HieuLucDen, -- HieuLucDen - datetime
			GETDATE(), -- Create_Date - datetime
			@NguoiCapNhat,        -- Create_By - varchar(50)
			GETDATE(), -- Modified_Date - datetime
			@NguoiCapNhat,        -- Modified_By - varchar(50)
			0       -- Delete_Mark - bit
		)
		SELECT TOP 1 ID FROM @table
	END
END
GO
/****** Object:  StoredProcedure [dbo].[DM_MonAn_Delete]    Script Date: 11/1/2023 2:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[DM_MonAn_Delete]
    @ListID NVARCHAR(MAX) = '',
	@NguoiCapNhat VARCHAR(50) = ''
AS
BEGIN
	DECLARE @Table TABLE (ID INT);
	INSERT INTO @Table SELECT * FROM dbo.splitstring(@ListID, ',')

	UPDATE dbo.DM_MonAn SET 
	Modified_By = @NguoiCapNhat,
	Modified_Date = GETDATE(),
	Delete_Mark = 1
	WHERE ID_MonAn IN (SELECT ID FROM @Table)
	
	SELECT 1 re
END
GO
/****** Object:  StoredProcedure [dbo].[DM_MonAn_Get_By_ID]    Script Date: 11/1/2023 2:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[DM_MonAn_Get_By_ID] 
@ID_MonAn INT = 0
AS
BEGIN
    SELECT a.ID_MonAn, 
	a.ID_MonAnPhanLoai, 
	b.TenTrangThai, 
	a.ID_MonAnTrangThai, 
	c.ID_MonAnPhanLoai, 
	c.TenMonAnPhanLoai, 
	a.TenMonAn, 
	a.DonGia, 
	CASE WHEN ISNULL(a.HinhAnhTheHien , N'') <> N'' THEN  N'https://localhost:44346/' + a.HinhAnhTheHien ELSE N'' END HinhAnhTheHien,
	a.DanhGia, 
	--a.MaGiamGia, 
	a.MoTa, 
	(STUFF((select ', ' + TenNguyenLieu 
	FROM DM_NguyenLieu WHERE  Delete_Mark = 0 AND ID_NguyenLieu IN (SELECT ID_NguyenLieu FROM DM_MonAn_NguyenLieu WHERE Delete_Mark = 0 AND ID_MonAn = a.ID_MonAn AND a.Delete_Mark = 0) 
	for xml path ('')), 1, 1, '')) TenNguyenLieu,
	N'Nhuệ Giang, Tây Mỗ, Nam Từ Liêm, Hà Nội'  NoiSanXuat,
	CASE WHEN a.ID_MonAnTrangThai = 1 THEN 1 ELSE 0 END isOrder
	FROM DM_MonAn a 
	LEFT JOIN DM_MonAn_TrangThai b ON b.ID_MonAnTrangThai = a.ID_MonAnTrangThai AND b.Delete_Mark = 0
	LEFT JOIN DM_MonAn_PhanLoai c ON c.ID_MonAnPhanLoai = a.ID_MonAnPhanLoai AND c.Delete_Mark = 0
	WHERE a.Delete_Mark = 0 
	AND (@ID_MonAn = 0 OR  a.ID_MonAn = @ID_MonAn)
END
GO
/****** Object:  StoredProcedure [dbo].[DM_MonAn_GetList]    Script Date: 11/1/2023 2:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[DM_MonAn_GetList]
@ID_MonAnTrangThai INT = 0,
@ID_MonAnPhanLoai INT = 0,
@TenMonAn NVARCHAR(MAX) = N''
AS
BEGIN
    SELECT a.ID_MonAn, 
	a.ID_MonAnPhanLoai, 
	b.TenTrangThai, 
	a.ID_MonAnTrangThai, 
	c.ID_MonAnPhanLoai, 
	c.TenMonAnPhanLoai, 
	a.TenMonAn, 
	a.DonGia, 
	CASE WHEN ISNULL(a.HinhAnhTheHien , N'') <> N'' THEN  N'https://localhost:44346/' + a.HinhAnhTheHien ELSE N'' END HinhAnhTheHien,
	a.DanhGia, 
	--a.MaGiamGia, 
	a.MoTa, 
	(STUFF((select ', ' + TenNguyenLieu 
	FROM DM_NguyenLieu WHERE  Delete_Mark = 0 AND ID_NguyenLieu IN (SELECT ID_NguyenLieu FROM DM_MonAn_NguyenLieu WHERE Delete_Mark = 0 AND ID_MonAn = a.ID_MonAn AND a.Delete_Mark = 0) 
	for xml path ('')), 1, 1, '')) TenNguyenLieu 
	FROM DM_MonAn a 
	LEFT JOIN DM_MonAn_TrangThai b ON b.ID_MonAnTrangThai = a.ID_MonAnTrangThai AND b.Delete_Mark = 0
	LEFT JOIN DM_MonAn_PhanLoai c ON c.ID_MonAnPhanLoai = a.ID_MonAnPhanLoai AND c.Delete_Mark = 0
	WHERE a.Delete_Mark = 0 
	AND (@ID_MonAnTrangThai = 0 OR @ID_MonAnTrangThai = a.ID_MonAnTrangThai)
	AND (@ID_MonAnPhanLoai = 0 OR @ID_MonAnPhanLoai = a.ID_MonAnPhanLoai)
	AND (@TenMonAn = '' OR a.TenMonAn LIKE N'%' + @TenMonAn + N'%')
END
GO
/****** Object:  StoredProcedure [dbo].[DM_MonAn_Insert_Or_Update]    Script Date: 11/1/2023 2:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[DM_MonAn_Insert_Or_Update]
@ID_MonAn INT = 0,
@ID_MonAnPhanLoai INT = 0,
@ID_MonAnTrangThai INT = 0,
@TenMonAn NVARCHAR(MAX) = N'',
@HinhAnhTheHien NVARCHAR(250) = N'',
@DonGia FLOAT = 0,
@MaGiamGia VARCHAR(50) = '',
@MoTa NVARCHAR(MAX) = N'',
@NguoiCapNhat VARCHAR(50) = ''
AS
BEGIN
	IF(@ID_MonAn > 0)
	BEGIN
	    UPDATE dbo.DM_MonAn SET
		ID_MonAnPhanLoai = @ID_MonAnPhanLoai,
		ID_MonAnTrangThai = @ID_MonAnTrangThai,
		TenMonAn = @TenMonAn,
		DonGia = @DonGia,
		MoTa = @MoTa,
		Modified_Date= GETDATE(),
		Modified_By = @NguoiCapNhat
		WHERE ID_MonAn = @ID_MonAn

		SELECT @ID_MonAn AS ID_MonAn
	END
	ELSE
	BEGIN
		DECLARE @table TABLE(ID INT);

	    INSERT INTO dbo.DM_MonAn
		(
			ID_MonAnPhanLoai,
			ID_MonAnTrangThai,
			TenMonAn,
			DanhGia,
			DonGia,
			MaGiamGia,
			MoTa,
			Create_Date,
			Create_By,
			Modified_Date,
			Modified_By,
			Delete_Mark
		)
		OUTPUT Inserted.ID_MonAn INTO @table
		VALUES
		(   @ID_MonAnPhanLoai,         -- ID_MonAnPhanLoai - int
			@ID_MonAnTrangThai,         -- ID_MonAnTrangThai - int
			@TenMonAn,       -- TenMonAn - nvarchar(250)
			5,         -- DanhGia - int
			@DonGia,       -- DonGia - float
			@MaGiamGia,	-- MaGiamGia - varchar(50)
			@MoTa,       -- MoTa - nvarchar(500)
			GETDATE(), -- Create_Date - datetime
			@NguoiCapNhat,        -- Create_By - varchar(50)
			GETDATE(), -- Modified_Date - datetime
			@NguoiCapNhat,        -- Modified_By - varchar(50)
			0       -- Delete_Mark - bit
		)
		SELECT TOP 1 ID FROM @table
	END
END
GO
/****** Object:  StoredProcedure [dbo].[DM_MonAn_NguyenLieu_Delete]    Script Date: 11/1/2023 2:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[DM_MonAn_NguyenLieu_Delete]
    @ListID NVARCHAR(MAX) = '',
	@NguoiCapNhat VARCHAR(50) = ''
AS
BEGIN
	DECLARE @Table TABLE (ID INT);
	INSERT INTO @Table SELECT * FROM dbo.splitstring(@ListID, ',')

	UPDATE dbo.DM_MonAn_NguyenLieu SET 
	Modified_By = @NguoiCapNhat,
	Modified_Date = GETDATE(),
	Delete_Mark = 1
	WHERE ID IN (SELECT ID FROM @Table)
	
	SELECT 1 re
END
GO
/****** Object:  StoredProcedure [dbo].[DM_MonAn_NguyenLieu_Get_By_ID_MonAn]    Script Date: 11/1/2023 2:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[DM_MonAn_NguyenLieu_Get_By_ID_MonAn]
@ID_MonAn INT = 0
AS
BEGIN
    SELECT ID, 
	ID_NguyenLieu 
	FROM dbo.DM_MonAn_NguyenLieu
	WHERE Delete_Mark = 0 AND ID_MonAn = @ID_MonAn
END

GO
/****** Object:  StoredProcedure [dbo].[DM_MonAn_NguyenLieu_Insert_Or_Update]    Script Date: 11/1/2023 2:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROC [dbo].[DM_MonAn_NguyenLieu_Insert_Or_Update]
@ID INT = 0,
@ID_MonAn INT = 0,
@ID_NguyenLieu INT = 0,
@NguoiCapNhat VARCHAR(50) = ''
AS
BEGIN
    IF(@ID > 0)
		BEGIN 
			UPDATE dbo.DM_MonAn_NguyenLieu SET
			ID_MonAn = @ID_MonAn,
			ID_NguyenLieu = @ID_NguyenLieu,
			Modified_Date= GETDATE(),
			Modified_By = @NguoiCapNhat
			WHERE ID = @ID

			SELECT @ID AS ID
		END  
	ELSE 
		BEGIN 
			DECLARE @table TABLE(ID INT)

			INSERT INTO dbo.DM_MonAn_NguyenLieu
			(
			    ID_MonAn,
			    ID_NguyenLieu,
			    Create_Date,
			    Create_By,
			    Modified_Date,
			    Modified_By,
			    Delete_Mark
			)
			OUTPUT Inserted.ID INTO @table
			VALUES
			(   @ID_MonAn,         -- ID_MonAn - int
			    @ID_NguyenLieu,         -- ID_NguyenLieu - int
			    GETDATE(), -- Create_Date - datetime
			    @NguoiCapNhat,        -- Create_By - varchar(50)
			    GETDATE(), -- Modified_Date - datetime
			    @NguoiCapNhat,        -- Modified_By - varchar(50)
			    0       -- Delete_Mark - bit
			)
			SELECT TOP 1 ID FROM @table
		END
END
GO
/****** Object:  StoredProcedure [dbo].[DM_MonAn_Update_File_Path]    Script Date: 11/1/2023 2:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[DM_MonAn_Update_File_Path]
@ID_MonAn INT = 0,
@url NVARCHAR(250) = N''
AS
BEGIN
    UPDATE dbo.DM_MonAn SET
	HinhAnhTheHien = @url
	WHERE ID_MonAn = @ID_MonAn

	SELECT @ID_MonAn AS ID_MonAn
END
GO
/****** Object:  StoredProcedure [dbo].[DM_NguyenLieu_Insert_Or_Update]    Script Date: 11/1/2023 2:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[DM_NguyenLieu_Insert_Or_Update]
@ID_NguyenLieu INT = 0,
@TenNguyenLieu NVARCHAR(250) = N'',
@NguoiCapNhat VARCHAR(50) = ''
AS
BEGIN
	IF(@ID_NguyenLieu > 0)
	BEGIN
	    UPDATE dbo.DM_NguyenLieu SET
		TenNguyenLieu = @TenNguyenLieu,
		Modified_Date = GETDATE(),
		Modified_By = GETDATE()
		WHERE ID_NguyenLieu = @ID_NguyenLieu
	END
	ELSE
	BEGIN
	    INSERT INTO dbo.DM_NguyenLieu
		(
			TenNguyenLieu,
			Created_Date,
			Created_By,
			Modified_Date,
			Modified_By,
			Delete_Mark
		)
		VALUES
		(   @TenNguyenLieu,       -- TenNguyenLieu - nvarchar(250)
			GETDATE(), -- Created_Date - datetime
			@NguoiCapNhat,       -- Created_By - nvarchar(50)
			GETDATE(), -- Modified_Date - datetime
			@NguoiCapNhat,       -- Modified_By - nvarchar(50)
			0       -- Delete_Mark - bit
		)
	END

	SELECT 1 AS re
END
GO
/****** Object:  StoredProcedure [dbo].[DM_NhaCungCap_Delete]    Script Date: 11/1/2023 2:52:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[DM_NhaCungCap_Delete]
	@ListID NVARCHAR(MAX) = ''
AS
BEGIN
	DECLARE @Table TABLE (ID INT);
	INSERT INTO @Table SELECT * FROM dbo.splitstring(@ListID, ',')
	UPDATE dbo.DM_NhaCungCap
	SET Delete_Mark = 1
	WHERE ID_NhaCungCap IN (SELECT id FROM @Table)
	
	SELECT 1 re
END
GO
/****** Object:  StoredProcedure [dbo].[DM_NhaCungCap_GetList]    Script Date: 11/1/2023 2:52:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[DM_NhaCungCap_GetList]
AS
BEGIN
    SELECT t.ID_NhaCungCap,
           t.MaNhaCungCap,
           t.TenNhaCungCap,
           t.SoDienThoai,
           t.Email,
           t.SoNha,
           th.TenTinhThanh,
           qh.TenQuanHuyen,
           xp.TenPhuongXa,
           t.DiaChi
	FROM dbo.DM_NhaCungCap t
	LEFT JOIN dbo.DC_TinhThanh th ON th.ID_TinhThanh = t.ID_TinhThanh 
	LEFT JOIN dbo.DC_QuanHuyen qh ON qh.ID_QuanHuyen = t.ID_QuanHuyen
	LEFT JOIN dbo.DC_PhuongXa xp ON xp.ID_PhuongXa = t.ID_PhuongXa
	WHERE t.Delete_Mark = 0
END
GO
/****** Object:  StoredProcedure [dbo].[DM_NhaCungCap_Insert_Or_Update]    Script Date: 11/1/2023 2:52:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[DM_NhaCungCap_Insert_Or_Update]
@ID_NhaCungCap INT = 0,
@MaNhaCungCap VARCHAR(50) = '',
@TenNhaCungCap NVARCHAR(500) = N'',
@SoDienThoai VARCHAR(15) = '',
@Email NVARCHAR(50) = N'',
@ID_TinhThanh INT  = 0,
@ID_QuanHuyen INT = 0,
@ID_PhuongXa INT = 0,
@SoNha NVARCHAR(250) = N'',
@DiaChi NVARCHAR(500) = N'',
@NguoiCapNhat VARCHAR(50) = ''
AS
BEGIN
	IF(@ID_NhaCungCap > 0)
	BEGIN
	    UPDATE dbo.DM_NhaCungCap SET 
		MaNhaCungCap = @MaNhaCungCap,
		TenNhaCungCap = @TenNhaCungCap,
		SoDienThoai = @SoDienThoai,
		Email = @Email,
		ID_TinhThanh = @ID_TinhThanh,
		ID_QuanHuyen = @ID_QuanHuyen,
		ID_PhuongXa = @ID_PhuongXa,
		SoNha = @SoNha,
		DiaChi = @DiaChi,
		Modified_By = @NguoiCapNhat,
		Modified_Date = GETDATE()
		WHERE ID_NhaCungCap = @ID_NhaCungCap
	END
	ELSE
	BEGIN
	    INSERT INTO dbo.DM_NhaCungCap
		(
			MaNhaCungCap,
			TenNhaCungCap,
			SoDienThoai,
			Email,
			ID_TinhThanh,
			ID_QuanHuyen,
			ID_PhuongXa,
			SoNha,
			DiaChi,
			Create_Date,
			Create_By,
			Modified_Date,
			Modified_By,
			Delete_Mark
		)
		VALUES
		(   @MaNhaCungCap,        -- MaNhaCungCap - varchar(50)
			@TenNhaCungCap,       -- TenNhaCungCap - nvarchar(500)
			@SoDienThoai,        -- SoDienThoai - varchar(15)
			@Email,       -- Email - nvarchar(50)
			@ID_TinhThanh,         -- ID_TinhThanh - int
			@ID_QuanHuyen,         -- ID_QuanHuyen - int
			@ID_PhuongXa,         -- ID_PhuongXa - int
			@SoNha,       -- SoNha - nvarchar(250)
			@DiaChi,       -- DiaChi - nvarchar(500)
			GETDATE(), -- Create_Date - datetime
			@NguoiCapNhat,        -- Create_By - varchar(50)
			GETDATE(), -- Modified_Date - datetime
			@NguoiCapNhat,        -- Modified_By - varchar(50)
			0       -- Delete_Mark - bit
			)
	END

	SELECT 1 AS re	
END
GO
/****** Object:  StoredProcedure [dbo].[DM_TaiKhoan_Delete]    Script Date: 11/1/2023 2:52:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[DM_TaiKhoan_Delete]
	@ListID NVARCHAR(MAX) = '',
	@NguoiCapNhat VARCHAR(50) = ''
AS
BEGIN
	DECLARE @Table TABLE (ID INT);
	INSERT INTO @Table SELECT * FROM dbo.splitstring(@ListID, ',')
	UPDATE dbo.DM_TaiKhoan SET 
	Modified_By = @NguoiCapNhat,
	Modified_Date = GETDATE(),
	Delete_Mark = 1
	WHERE ID_TaiKhoan IN (SELECT id FROM @Table)
	
	SELECT 1 re
END
GO
/****** Object:  StoredProcedure [dbo].[DM_TaiKhoan_DoiMatKhau]    Script Date: 11/1/2023 2:52:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[DM_TaiKhoan_DoiMatKhau] 
@ID_TaiKhoan INT = 0,
@MatKhauCu NVARCHAR(100) = N'',
@MatKhauMoi NVARCHAR(100) = N''
AS
BEGIN
    DECLARE @flag BIT = CAST(1 AS BIT),
			@msg NVARCHAR(MAX) = N'Tác vụ thực hiện thành công!',
			@value BIGINT = 0
	
	DECLARE @NguoiCapNhat VARCHAR(50) = ISNULL((SELECT TenDangNhap FROM dbo.DM_TaiKhoan WHERE Delete_Mark = 0 AND ID_TaiKhoan = @ID_TaiKhoan),'');
	IF(ISNULL((SELECT MatKhau FROM dbo.DM_TaiKhoan WHERE Delete_Mark = 0 AND ID_TaiKhoan = @ID_TaiKhoan), N'') <> @MatKhauCu)
	BEGIN
		SET @flag = 0; SET @msg = N'Mật khẩu cũ không đúng!'; SET @value = 0;
	END
	ELSE
	BEGIN
	    UPDATE dbo.DM_TaiKhoan SET
		MatKhau = @MatKhauMoi,
		Modified_Date = GETDATE(),
		Modified_By = @NguoiCapNhat
		WHERE ID_TaiKhoan = @ID_TaiKhoan

		SET @value = @ID_TaiKhoan
	END
	
	SELECT  @flag AS flag, 
			@msg AS msg,
			@value AS [value]
END
GO
/****** Object:  StoredProcedure [dbo].[DM_TaiKhoan_Get_By_ID]    Script Date: 11/1/2023 2:52:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[DM_TaiKhoan_Get_By_ID] 
@ID_TaiKhoan INT = 0
AS
BEGIN
    SELECT *,
		t.SoNha + N', ' + t.TenPhuongXa + N', ' + t.TenQuanHuyen + N','  + t.TenTinhThanh AS DiaChi
	FROM (
		SELECT 
		ISNULL(tk.ID_TaiKhoan, 0) ID_TaiKhoan,
		ISNULL(tk.TenDayDu, N'') TenDayDu,
		ISNULL(tk.TenDangNhap, '') TenDangNhap,
		ISNULL(tk.SoDienThoai, '') SoDienThoai,
		ISNULL(tk.Email, N'') Email,
		CASE WHEN ISNULL(tk.IsLock, 0) = 0 THEN N'Đã khóa'
			ELSE N'Hoạt động'
		END TrangThai,
		CASE WHEN ISNULL(tk.GioiTinh, '') = 'NAM' THEN N'Nam' 
			 WHEN ISNULL(tk.GioiTinh, '') = 'NU' THEN N'Nữ'
			 ELSE N'Khác'
		END TenGioiTinh,
		ISNULL(tk.ID_ChucDanh, 0) ID_ChucDanh,
		ISNULL(cd.TenChucDanh, N'') TenChucDanh,
		ISNULL(tk.SoNha, N'') SoNha,
		ISNULL(tk.ID_TinhThanh, 0) ID_TinhThanh,
		ISNULL(tt.TenTinhThanh, N'') TenTinhThanh,
		ISNULL(tk.ID_QuanHuyen,0) ID_QuanHuyen,
		ISNULL(qh.TenQuanHuyen, N'') TenQuanHuyen,
		ISNULL(tk.ID_PhuongXa, 0) ID_PhuongXa,
		ISNULL(px.TenPhuongXa, N'') TenPhuongXa
		FROM dbo.DM_TaiKhoan tk
		LEFT JOIN dbo.DM_ChucDanh cd ON cd.ID_ChucDanh = tk.ID_ChucDanh AND cd.Delete_Mark = 0
		LEFT JOIN dbo.DC_TinhThanh tt ON tt.ID_TinhThanh = tk.ID_TinhThanh AND tt.Delete_Mark = 0
		LEFT JOIN dbo.DC_QuanHuyen qh ON qh.ID_QuanHuyen = tk.ID_QuanHuyen AND qh.Delete_Mark = 0
		LEFT JOIN dbo.DC_PhuongXa px ON px.ID_PhuongXa = tk.ID_PhuongXa AND px.Delete_Mark = 0
		WHERE tk.Delete_Mark = 0
	) AS t
	WHERE t.ID_TaiKhoan = @ID_TaiKhoan
END
GO
/****** Object:  StoredProcedure [dbo].[DM_TaiKhoan_Get_InFo_By_TenDangNhap]    Script Date: 11/1/2023 2:52:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[DM_TaiKhoan_Get_InFo_By_TenDangNhap]
@TenDangNhap NVARCHAR(50) = ''
AS
BEGIN
	DECLARE @ID_TaiKhoan INT = ISNULL((SELECT ID_TaiKhoan FROM dbo.DM_TaiKhoan WHERE Delete_Mark = 0 AND TenDangNhap =  @TenDangNhap),0);
	DECLARE @SoLuongDonDaDat INT = ISNULL((SELECT COUNT(*) FROM dbo.DonHang dh
	WHERE dh.Delete_Mark = 0 
	AND dh.ID_TaiKhoan = @ID_TaiKhoan
	AND dh.ID_TrangThai_DonHang = 1),0)

    SELECT @SoLuongDonDaDat AS SoLuongDonDaDat,
	* FROM dbo.DM_TaiKhoan
	WHERE TenDangNhap = @TenDangNhap AND Delete_Mark = 0
END
GO
/****** Object:  StoredProcedure [dbo].[DM_TaiKhoan_GetList]    Script Date: 11/1/2023 2:52:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[DM_TaiKhoan_GetList]
@ID_TaiKhoan INT = 0,
@TenDayDu NVARCHAR(MAX) = N'',
@TenDangNhap NVARCHAR(MAX) = N'',
@IsLock INT = 0,
@IsKhachHang INT = 0
AS
BEGIN
	SELECT *,
		t.SoNha + N', ' + t.TenPhuongXa + N', ' + t.TenQuanHuyen + N','  + t.TenTinhThanh AS DiaChi
	FROM (
		SELECT 
		ISNULL(tk.ID_TaiKhoan, 0) ID_TaiKhoan,
		ISNULL(tk.TenDayDu, N'') TenDayDu,
		ISNULL(tk.TenDangNhap, '') TenDangNhap,
		ISNULL(tk.SoDienThoai, '') SoDienThoai,
		ISNULL(tk.Email, N'') Email,
		tk.IsLock,
		tk.IsKhachHang,
		CASE WHEN ISNULL(tk.IsKhachHang, 0) = 0 THEN N'Nhân viên'
			ELSE N'Khách hàng'
		END AS Roles,
		CASE WHEN ISNULL(tk.IsLock, 0) = 0 THEN N'Đã khóa'
			ELSE N'Hoạt động'
		END TrangThai,
		tk.GioiTinh,
		CASE WHEN ISNULL(tk.GioiTinh, '') = 'NAM' THEN N'Nam' 
			 WHEN ISNULL(tk.GioiTinh, '') = 'NU' THEN N'Nữ'
			 ELSE N'Khác'
		END TenGioiTinh,
		ISNULL(tk.ID_ChucDanh, 0) ID_ChucDanh,
		ISNULL(cd.TenChucDanh, N'') TenChucDanh,
		ISNULL(tk.SoNha, N'') SoNha,
		ISNULL(tk.ID_TinhThanh, 0) ID_TinhThanh,
		ISNULL(tt.TenTinhThanh, N'') TenTinhThanh,
		ISNULL(tk.ID_QuanHuyen,0) ID_QuanHuyen,
		ISNULL(qh.TenQuanHuyen, N'') TenQuanHuyen,
		ISNULL(tk.ID_PhuongXa, 0) ID_PhuongXa,
		ISNULL(px.TenPhuongXa, N'') TenPhuongXa
		FROM dbo.DM_TaiKhoan tk
		LEFT JOIN dbo.DM_ChucDanh cd ON cd.ID_ChucDanh = tk.ID_ChucDanh AND cd.Delete_Mark = 0
		LEFT JOIN dbo.DC_TinhThanh tt ON tt.ID_TinhThanh = tk.ID_TinhThanh AND tt.Delete_Mark = 0
		LEFT JOIN dbo.DC_QuanHuyen qh ON qh.ID_QuanHuyen = tk.ID_QuanHuyen AND qh.Delete_Mark = 0
		LEFT JOIN dbo.DC_PhuongXa px ON px.ID_PhuongXa = tk.ID_PhuongXa AND px.Delete_Mark = 0
		WHERE tk.Delete_Mark = 0 AND
		tk.IsKhachHang = 0
	) AS t
	WHERE (@ID_TaiKhoan = 0 OR t.ID_TaiKhoan = @ID_TaiKhoan)
	AND (ISNULL(@TenDayDu, N'') = N'' OR t.TenDayDu LIKE N'%' + @TenDayDu + N'%')
	AND (ISNULL(@TenDangNhap, '') = '' OR t.TenDangNhap LIKE N'%' + @TenDangNhap + N'%')
	AND (@IsLock = -1 OR t.IsLock = @IsLock)
	AND (@IsKhachHang = -1 OR t.IsKhachHang = @IsKhachHang)
END
GO
/****** Object:  StoredProcedure [dbo].[DM_TaiKhoan_GetList_KhachHang]    Script Date: 11/1/2023 2:52:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[DM_TaiKhoan_GetList_KhachHang]
@ID_TaiKhoan INT = 0,
@TenDayDu NVARCHAR(MAX) = N'',
@TenDangNhap NVARCHAR(MAX) = N'',
@IsLock INT = 0
AS
BEGIN
	SELECT *,
		t.SoNha + N', ' + t.TenPhuongXa + N', ' + t.TenQuanHuyen + N','  + t.TenTinhThanh AS DiaChi
	FROM (
		SELECT 
		ISNULL(tk.ID_TaiKhoan, 0) ID_TaiKhoan,
		ISNULL(tk.TenDayDu, N'') TenDayDu,
		ISNULL(tk.TenDangNhap, '') TenDangNhap,
		ISNULL(tk.SoDienThoai, '') SoDienThoai,
		ISNULL(tk.Email, N'') Email,
		CASE WHEN ISNULL(tk.IsLock, 0) = 0 THEN N'Đã khóa'
			ELSE N'Hoạt động'
		END TrangThai,
		tk.GioiTinh,
		CASE WHEN ISNULL(tk.GioiTinh, '') = 'NAM' THEN N'Nam' 
			 WHEN ISNULL(tk.GioiTinh, '') = 'NU' THEN N'Nữ'
			 ELSE N'Khác'
		END TenGioiTinh,
		ISNULL(tk.ID_ChucDanh, 0) ID_ChucDanh,
		ISNULL(cd.TenChucDanh, N'') TenChucDanh,
		ISNULL(tk.SoNha, N'') SoNha,
		ISNULL(tk.ID_TinhThanh, 0) ID_TinhThanh,
		ISNULL(tt.TenTinhThanh, N'') TenTinhThanh,
		ISNULL(tk.ID_QuanHuyen,0) ID_QuanHuyen,
		ISNULL(qh.TenQuanHuyen, N'') TenQuanHuyen,
		ISNULL(tk.ID_PhuongXa, 0) ID_PhuongXa,
		ISNULL(px.TenPhuongXa, N'') TenPhuongXa
		FROM dbo.DM_TaiKhoan tk
		LEFT JOIN dbo.DM_ChucDanh cd ON cd.ID_ChucDanh = tk.ID_ChucDanh AND cd.Delete_Mark = 0
		LEFT JOIN dbo.DC_TinhThanh tt ON tt.ID_TinhThanh = tk.ID_TinhThanh AND tt.Delete_Mark = 0
		LEFT JOIN dbo.DC_QuanHuyen qh ON qh.ID_QuanHuyen = tk.ID_QuanHuyen AND qh.Delete_Mark = 0
		LEFT JOIN dbo.DC_PhuongXa px ON px.ID_PhuongXa = tk.ID_PhuongXa AND px.Delete_Mark = 0
		WHERE tk.Delete_Mark = 0 AND
		tk.IsKhachHang = 1
	) AS t
	WHERE (@ID_TaiKhoan = 0 OR t.ID_TaiKhoan = @ID_TaiKhoan)
	AND (@TenDayDu = N'' OR t.TenDayDu LIKE N'%' + @TenDayDu + N'%')
	AND (@TenDangNhap = '' OR t.TenDangNhap LIKE '%' + @TenDangNhap + '%')
END
GO
/****** Object:  StoredProcedure [dbo].[DM_TaiKhoan_GetList_NhanVien]    Script Date: 11/1/2023 2:52:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[DM_TaiKhoan_GetList_NhanVien]
@ID_TaiKhoan INT = 0,
@TenDayDu NVARCHAR(MAX) = N'',
@TenDangNhap NVARCHAR(MAX) = N'',
@IsLock INT = 0
AS
BEGIN
	SELECT *,
		t.SoNha + N', ' + t.TenPhuongXa + N', ' + t.TenQuanHuyen + N','  + t.TenTinhThanh AS DiaChi
	FROM (
		SELECT 
		ISNULL(tk.ID_TaiKhoan, 0) ID_TaiKhoan,
		ISNULL(tk.TenDayDu, N'') TenDayDu,
		ISNULL(tk.TenDangNhap, '') TenDangNhap,
		ISNULL(tk.SoDienThoai, '') SoDienThoai,
		ISNULL(tk.Email, N'') Email,
		CASE WHEN ISNULL(tk.IsLock, 0) = 0 THEN N'Đã khóa'
			ELSE N'Hoạt động'
		END TrangThai,
		tk.GioiTinh,
		CASE WHEN ISNULL(tk.GioiTinh, '') = 'NAM' THEN N'Nam' 
			 WHEN ISNULL(tk.GioiTinh, '') = 'NU' THEN N'Nữ'
			 ELSE N'Khác'
		END TenGioiTinh,
		ISNULL(tk.ID_ChucDanh, 0) ID_ChucDanh,
		ISNULL(cd.TenChucDanh, N'') TenChucDanh,
		ISNULL(tk.SoNha, N'') SoNha,
		ISNULL(tk.ID_TinhThanh, 0) ID_TinhThanh,
		ISNULL(tt.TenTinhThanh, N'') TenTinhThanh,
		ISNULL(tk.ID_QuanHuyen,0) ID_QuanHuyen,
		ISNULL(qh.TenQuanHuyen, N'') TenQuanHuyen,
		ISNULL(tk.ID_PhuongXa, 0) ID_PhuongXa,
		ISNULL(px.TenPhuongXa, N'') TenPhuongXa
		FROM dbo.DM_TaiKhoan tk
		LEFT JOIN dbo.DM_ChucDanh cd ON cd.ID_ChucDanh = tk.ID_ChucDanh AND cd.Delete_Mark = 0
		LEFT JOIN dbo.DC_TinhThanh tt ON tt.ID_TinhThanh = tk.ID_TinhThanh AND tt.Delete_Mark = 0
		LEFT JOIN dbo.DC_QuanHuyen qh ON qh.ID_QuanHuyen = tk.ID_QuanHuyen AND qh.Delete_Mark = 0
		LEFT JOIN dbo.DC_PhuongXa px ON px.ID_PhuongXa = tk.ID_PhuongXa AND px.Delete_Mark = 0
		WHERE tk.Delete_Mark = 0 AND
		tk.IsKhachHang = 0
	) AS t
	WHERE (@ID_TaiKhoan = 0 OR t.ID_TaiKhoan = @ID_TaiKhoan)
	AND (@TenDayDu = N'' OR t.TenDayDu LIKE N'%' + @TenDayDu + N'%')
	AND (@TenDangNhap = '' OR t.TenDangNhap LIKE '%' + @TenDangNhap + '%')
END
GO
/****** Object:  StoredProcedure [dbo].[DM_TaiKhoan_Insert_Or_Update]    Script Date: 11/1/2023 2:52:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[DM_TaiKhoan_Insert_Or_Update]
@ID_TaiKhoan INT = 0,
@TenDangNhap VARCHAR(100) = '',
@MatKhau NVARCHAR(100) = N'',
@TenDayDu nvarchar(500) = N'',
@GioiTinh VARCHAR(50) = '',
@IsKhachHang BIT = 0,
@Email nvarchar(250) = N'',
@SoDienThoai varchar(20) = '',
@SoNha NVARCHAR(250) = N'',
@ID_ChucDanh int = 0,
@ID_TinhThanh int = 0,
@ID_QuanHuyen int = 0,
@ID_PhuongXa int = 0,
@NguoiCapNhat nvarchar(50) = N''
AS
BEGIN
	IF @ID_TinhThanh = 0
		SET @ID_TinhThanh = NULL
	IF @ID_QuanHuyen = 0
		SET @ID_QuanHuyen = NULL
	IF @ID_PhuongXa = 0
		SET @ID_PhuongXa = NULL

	DECLARE @flag BIT = 1,
			@msg NVARCHAR(MAX) = N'Tác vụ thực hiện thành công',
			@value BIGINT = 0;
	
	SET @IsKhachHang = (CASE WHEN @ID_ChucDanh <> 8 THEN CAST(0 AS BIT) ELSE 1 END);
	IF(@ID_TaiKhoan > 0)
	BEGIN
	   UPDATE dbo.DM_TaiKhoan SET	
	   TenDayDu = @TenDayDu,
	   GioiTinh = @GioiTinh,
	   Email = @Email,
	   SoDienThoai = @SoDienThoai,
	   SoNha = @SoNha,
	   ID_ChucDanh = @ID_ChucDanh,
	   ID_TinhThanh = @ID_TinhThanh,
	   ID_QuanHuyen = @ID_QuanHuyen,
	   ID_PhuongXa = @ID_PhuongXa,
	   Modified_By = @NguoiCapNhat,
	   Modified_Date = GETDATE()
	   WHERE ID_TaiKhoan = @ID_TaiKhoan

	   SET @value = @ID_TaiKhoan;
	END
	ELSE
	BEGIN
		IF(EXISTS(SELECT * FROM dbo.DM_TaiKhoan WHERE Delete_Mark = 0 AND UPPER(TenDangNhap) = UPPER(@TenDangNhap)))
		BEGIN
			SET @flag = CAST(0 AS BIT);
			SET @msg = N'Tên tài khoản đã tồn tại!';
			SET @value = 0;
		END
		ELSE 
		BEGIN
			DECLARE @table TABLE(ID INT)
		    INSERT INTO dbo.DM_TaiKhoan
			(
		    TenDangNhap,
		    MatKhau,
		    TenDayDu,
		    IsKhachHang,
		    GioiTinh,
		    IsLock,
		    Email,
		    SoDienThoai,
			SoNha,
		    ID_ChucDanh,
		    ID_TinhThanh,
		    ID_QuanHuyen,
		    ID_PhuongXa,
		    Created_Date,
		    Created_By,
		    Modified_Date,
		    Modified_By,
		    Delete_Mark
			)
		OUTPUT Inserted.ID_TaiKhoan INTO @table
			VALUES (
		    @TenDangNhap,       -- TenDangNhap - varchar(100)
		    @MatKhau,       -- MatKhau - nvarchar(100)
		    @TenDayDu,       -- TenDayDu - nvarchar(500)
		    @IsKhachHang,      -- IsKhachHang - bit
		    @GioiTinh,        -- GioiTinh - varchar(50)
		    0,       -- IsLock - nchar(10)
		    @Email,       -- Email - nvarchar(250)
		    @SoDienThoai,        -- SoDienThoai - varchar(20)
			@SoNha,  -- SoNha - nvarchar(250)
		    @ID_ChucDanh,         -- ID_ChucDanh - int
		    @ID_TinhThanh,         -- ID_TinhThanh - int
		    @ID_QuanHuyen,         -- ID_QuanHuyen - int
		    @ID_PhuongXa,         -- ID_PhuongXa - int
		    GETDATE(), -- Created_Date - datetime
		    CASE WHEN ISNULL(@IsKhachHang, 0) = 0 THEN @TenDangNhap ELSE @NguoiCapNhat END,       -- Created_By - nvarchar(50)
		    GETDATE(), -- Modified_Date - datetime
		    CASE WHEN ISNULL(@IsKhachHang, 0) = 0 THEN @TenDangNhap ELSE @NguoiCapNhat END,       -- Modified_By - nvarchar(50)
		    0       -- Delete_Mark - bit
		    )

			SELECT @value = ISNULL(ID, 0) FROM @table

			IF @value > 0 
				SET @flag = CAST(1 AS BIT)
		END
	END

	SELECT @flag flag, @msg msg, @value value
END
GO
/****** Object:  StoredProcedure [dbo].[DonHang_Delete]    Script Date: 11/1/2023 2:52:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[DonHang_Delete]
    @ListID NVARCHAR(MAX) = '',
	@NguoiCapNhat VARCHAR(50) = ''
AS
BEGIN
	DECLARE @Table TABLE (ID INT);
	INSERT INTO @Table SELECT * FROM dbo.splitstring(@ListID, ',')

	UPDATE dbo.DonHang SET 
	Modified_By = @NguoiCapNhat,
	Modified_Date = GETDATE(),
	Delete_Mark = 1
	WHERE ID_DonHang IN (SELECT ID FROM @Table)
	
	SELECT 1 re
END
GO
/****** Object:  StoredProcedure [dbo].[DonHang_Get_Count]    Script Date: 11/1/2023 2:52:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[DonHang_Get_Count]
@ID_TaiKhoan INT = 0
AS
BEGIN
    SELECT COUNT(*)
	FROM dbo.DonHang dh
	LEFT JOIN dbo.DM_MonAn ma ON ma.ID_MonAn = dh.ID_MonAn AND ma.Delete_Mark = 0
	WHERE dh.Delete_Mark = 0 
	AND dh.ID_TaiKhoan = @ID_TaiKhoan
	AND dh.ID_TrangThai_DonHang = 1 -- SELECT * FROM dbo.DonHang_TrangThai
END
GO
/****** Object:  StoredProcedure [dbo].[DonHang_GetList_By_ID_TaiKhoan]    Script Date: 11/1/2023 2:52:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[DonHang_GetList_By_ID_TaiKhoan]
@ID_TaiKhoan INT = 0
AS
BEGIN
    SELECT  dh.ID_DonHang,
			dh.ID_TaiKhoan,
			dh.ID_MonAn,
			ma.TenMonAn,
			CASE WHEN ISNULL(ma.HinhAnhTheHien , N'') <> N'' THEN  N'https://localhost:44346/' + ma.HinhAnhTheHien ELSE N'' END HinhAnhTheHien,
			dh.SoLuong,
			dh.DonGia,
			dh.ThanhTien,
			dh.ID_TrangThai_DonHang,
			tt.TenTrangThai
	FROM dbo.DonHang dh
	LEFT JOIN dbo.DM_MonAn ma ON ma.ID_MonAn = dh.ID_MonAn AND ma.Delete_Mark = 0
	LEFT JOIN dbo.DonHang_TrangThai tt ON tt.ID_TrangThai = dh.ID_TrangThai_DonHang AND tt.Delete_Mark = 0
	WHERE dh.Delete_Mark = 0 
	AND dh.ID_TaiKhoan = @ID_TaiKhoan
	AND dh.ID_TrangThai_DonHang = 1 --SELECT * FROM dbo.DonHang_TrangThai
END
GO
/****** Object:  StoredProcedure [dbo].[DonHang_Insert_Or_Update]    Script Date: 11/1/2023 2:52:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[DonHang_Insert_Or_Update]
@ID_DonHang BIGINT = 0,
@ID_TaiKhoan  INT = 0,
@ID_MonAn  BIGINT = 0,
@SoLuong  FLOAT  = 0,
@NguoiCapNhat VARCHAR(50) = '',
@Type VARCHAR(50) = 'THEMMOI' --THEMMOI, CAPNHAT
AS
BEGIN
	DECLARE @flag BIT = CAST(1 AS BIT),
			@msg NVARCHAR(MAX) = N'Đã thêm vào giỏ hàng!',
			@value BIGINT = 0

	--GEN MÃ ĐƠN HÀNG
	DECLARE @prifix VARCHAR(10)= 'DH',
	@year_text VARCHAR(10) = FORMAT(GETDATE(),'yyyyMMdd'),
	@stt_donhang VARCHAR(5) = RIGHT('00000' + CAST((SELECT  TOP 1 ISNULL(ID_DonHang , 1) 
			FROM dbo.DonHang ORDER BY Created_Date DESC) AS NVARCHAR(5)), 5);

	DECLARE @MaDonHang VARCHAR(50)= CONCAT(@prifix,'-', @year_text, '-', @stt_donhang);

	--SELECT * FROM dbo.DonHang_TrangThai
	------KQ----
	DECLARE @LuuNhap INT = 1;
	DECLARE @DonGia FLOAT = ISNULL((SELECT DonGia FROM dbo.DM_MonAn WHERE ID_MonAn = @ID_MonAn AND Delete_Mark = 0), 0);

	IF(@Type = 'THEMMOI' AND @ID_DonHang = 0)
	BEGIN
		SET @SoLuong = @SoLuong + ISNULL((SELECT SoLuong FROM dbo.DonHang WHERE Delete_Mark = 0
									AND ID_MonAn = @ID_MonAn AND ID_TaiKhoan = @ID_TaiKhoan AND ID_TrangThai_DonHang = @LuuNhap),0);
	    SET @ID_DonHang = ISNULL((SELECT ID_DonHang FROM dbo.DonHang WHERE Delete_Mark = 0 AND ID_MonAn = @ID_MonAn
								AND ID_TaiKhoan = @ID_TaiKhoan AND ID_TrangThai_DonHang = @LuuNhap), 0)
	END
	
	IF(@ID_DonHang > 0)
	BEGIN
		UPDATE dbo.DonHang SET
		DonGia = @DonGia,
		SoLuong = @SoLuong,
		ThanhTien = @DonGia * @SoLuong,
		Modified_Date = GETDATE(),
		Modified_By = @NguoiCapNhat
		WHERE ID_DonHang = @ID_DonHang
		
		IF @SoLuong <= 0
		BEGIN
		    UPDATE dbo.DonHang SET
			Delete_Mark = 1
			WHERE ID_DonHang = @ID_DonHang
		END

		SET @value = @ID_DonHang
	END
	ELSE
	BEGIN
		DECLARE @table TABLE(ID BIGINT)
	    INSERT INTO dbo.DonHang
		(
			ID_TaiKhoan,
			ID_MonAn,
			MaDonHang,
			SoLuong,
			DonGia,
			ThanhTien,
			ID_TrangThai_DonHang,
			Created_Date,
			Created_By,
			Modified_Date,
			Modified_By,
			Delete_Mark
		)
		OUTPUT Inserted.ID_DonHang INTO @table
		VALUES
		(   @ID_TaiKhoan,         -- ID_TaiKhoan - int
			@ID_MonAn,         -- ID_MonAn - bigint
			@MaDonHang,		-- MaDonHang - varchar(50)
			@SoLuong,       -- SoLuong - float
			@DonGia,       -- DonGia - float
			@DonGia * @SoLuong,       -- ThanhTien - float
			@LuuNhap,         -- ID_TrangThai_DonHang - int
			GETDATE(), -- Created_Date - datetime
			@NguoiCapNhat,        -- Created_By - varchar(50)
			GETDATE(), -- Modified_Date - datetime
			@NguoiCapNhat,        -- Modified_By - varchar(50)
			0       -- Delete_Mark - bit
		)

		SET @value = ISNULL((SELECT TOP 1 ID FROM @table), 0) 
	END

	SELECT @flag AS flag,
		   @msg AS msg,
		   @value AS [value]
END	
GO
/****** Object:  StoredProcedure [dbo].[DonHang_MuaNhieuNhat]    Script Date: 11/1/2023 2:52:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[DonHang_MuaNhieuNhat]
AS
BEGIN

	IF OBJECT_ID('tempdb..#temp_donhang') IS NOT NULL
	DROP TABLE #temp_donhang;
    
	SELECT a.ID_DonHang
	INTO #temp_donhang
	FROM dbo.ThanhToan_DonHang_ChiTiet a
	WHERE a.Delete_Mark = 0 
	AND a.ID_ThanhToan IN (
		SELECT ID_ThanhToan 
		FROM dbo.ThanhToan_DonHang b
		WHERE b.Delete_Mark = 0
	)

	IF OBJECT_ID('tempdb..#temp_monan') IS NOT NULL
	DROP TABLE #temp_monan;

	SELECT TOP 5 dh.ID_MonAn, COUNT(dh.ID_MonAn) AS SoLuong
	INTO #temp_monan
	FROM dbo.DonHang dh
	WHERE dh.Delete_Mark = 0
	AND dh.ID_DonHang IN (SELECT ID_DonHang FROM #temp_donhang)
	AND dh.ID_TrangThai_DonHang NOT IN (1, 6) --Không lấy các đơn hàng đã hủy hoặc đang ở trong giỏ
	GROUP BY dh.ID_MonAn
	ORDER BY COUNT(dh.ID_MonAn) DESC


	SELECT a.ID_MonAn, 
	a.ID_MonAnPhanLoai, 
	b.TenTrangThai, 
	a.ID_MonAnTrangThai, 
	c.ID_MonAnPhanLoai, 
	c.TenMonAnPhanLoai, 
	a.TenMonAn, 
	a.DonGia, 
	CASE WHEN ISNULL(a.HinhAnhTheHien , N'') <> N'' THEN  N'https://localhost:44346/' + a.HinhAnhTheHien ELSE N'' END HinhAnhTheHien,
	a.DanhGia, 
	a.MoTa, 
	(STUFF((select ', ' + TenNguyenLieu 
	FROM DM_NguyenLieu WHERE  Delete_Mark = 0 AND ID_NguyenLieu IN (SELECT ID_NguyenLieu FROM DM_MonAn_NguyenLieu WHERE Delete_Mark = 0 AND ID_MonAn = a.ID_MonAn AND a.Delete_Mark = 0) 
	for xml path ('')), 1, 1, '')) TenNguyenLieu ,
	CASE WHEN a.ID_MonAnTrangThai = 1 THEN 1 ELSE 0 END isOrder
	FROM DM_MonAn a 
	LEFT JOIN DM_MonAn_TrangThai b ON b.ID_MonAnTrangThai = a.ID_MonAnTrangThai AND b.Delete_Mark = 0
	LEFT JOIN DM_MonAn_PhanLoai c ON c.ID_MonAnPhanLoai = a.ID_MonAnPhanLoai AND c.Delete_Mark = 0
	WHERE a.Delete_Mark = 0 
	AND a.ID_MonAn IN (SELECT ID_MonAn FROM #temp_monan)
END

GO
/****** Object:  StoredProcedure [dbo].[DonHang_ThanhToan_Insert_Or_Update]    Script Date: 11/1/2023 2:52:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[DonHang_ThanhToan_Insert_Or_Update]
@ID_TaiKhoan  INT = 0,
@ID_KhuyenMai INT = 0,
@NguoiNhan_HoTen  NVARCHAR(250) = N'',
@NguoiNhan_SoDienThoai  NVARCHAR(15) = N'',
@TongTienDonHang  FLOAT = 0,
@IsThanhToan  BIT = 0,
@SoNha  NVARCHAR(250) = N'',
@DiaChiNhanHang  NVARCHAR(500) = N'',
@ID_TinhThanh  INT = 0,
@ID_QuanHuyen  INT = 0,
@ID_PhuongXa  INT = 0,
@GhiChu NVARCHAR(500) = N'',
@NguoiCapNhat VARCHAR(50) = ''
AS
BEGIN
	DECLARE @prifix VARCHAR(10)= 'VC',
	@year_text VARCHAR(10) = FORMAT(GETDATE(),'yyyyMMdd'),
	@stt_donhang VARCHAR(5) = RIGHT('00000' + CAST((SELECT  TOP 1 ISNULL(ID_ThanhToan , 1) 
			FROM dbo.ThanhToan_DonHang ORDER BY Created_Date DESC) AS NVARCHAR(5)), 5);

	DECLARE @MaVanChuyen VARCHAR(50)= CONCAT(@prifix,'-', @year_text, '-', @stt_donhang);
	

	DECLARE @table TABLE(ID BIGINT);
    
	INSERT INTO dbo.ThanhToan_DonHang
	(
	    ID_TaiKhoan,
		ID_TrangThaiThanhToan,
		ID_KhuyenMai,
	    MaVanChuyen,
	    NguoiNhan_HoTen,
	    NguoiNhan_SoDienThoai,
	    TongTienDonHang,
	    IsThanhToan,
	    SoNha,
	    DiaChiNhanHang,
	    ID_TinhThanh,
	    ID_QuanHuyen,
	    ID_PhuongXa,
	    GhiChu,
	    Created_Date,
	    Created_By,
	    Modified_Date,
	    Modified_By,
	    Delete_Mark
	)
	OUTPUT Inserted.ID_ThanhToan INTO @table
	VALUES
	(   @ID_TaiKhoan,         -- ID_TaiKhoan - int
		1,--Chờ kiểm duyệt đơn hàng -- ID_TrangThaiThanhToan - int
		@ID_KhuyenMai,
	    @MaVanChuyen,        -- MaVanChuyen - varchar(50)
	    @NguoiNhan_HoTen,       -- NguoiNhan_HoTen - nvarchar(250)
	    @NguoiNhan_SoDienThoai,       -- NguoiNhan_SoDienThoai - nvarchar(15)
	    @TongTienDonHang,       -- TongTienDonHang - float
	    @IsThanhToan,      -- IsThanhToan - bit
	    @SoNha,       -- SoNha - nvarchar(250)
	    @DiaChiNhanHang,       -- DiaChiNhanHang - nvarchar(500)
	    @ID_TinhThanh,         -- ID_TinhThanh - int
	    @ID_QuanHuyen,         -- ID_QuanHuyen - int
	    @ID_PhuongXa,         -- ID_PhuongXa - int
	    @GhiChu,       -- GhiChu - nvarchar(500)
	    GETDATE(), -- Created_Date - datetime
	    @NguoiCapNhat,       -- Created_By - nvarchar(50)
	    GETDATE(), -- Modified_Date - datetime
	    @NguoiCapNhat,       -- Modified_By - nvarchar(50)
	    0       -- Delete_Mark - bit
	)
	
	SELECT TOP 1 * FROM @table
END
GO
/****** Object:  StoredProcedure [dbo].[Login_WEB]    Script Date: 11/1/2023 2:52:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Login_WEB]
    @TenDangNhap VARCHAR(50) = '',
    @MatKhau VARCHAR(250) = ''
AS
BEGIN
	DECLARE @re INT = 0;
	DECLARE @table_num TABLE(ID INT);

	DECLARE @ID_TaiKhoan INT = CASE WHEN EXISTS (SELECT 1 FROM dbo.DM_TaiKhoan t WHERE t.TenDangNhap = @TenDangNhap AND t.MatKhau = @MatKhau AND t.Delete_Mark = 0) 
									THEN (SELECT TOP 1 t.ID_TaiKhoan FROM dbo.DM_TaiKhoan t WHERE t.TenDangNhap = @TenDangNhap AND t.MatKhau = @MatKhau AND t.Delete_Mark = 0)
								ELSE -1 END;
	
	IF(@ID_TaiKhoan <= 0)
		    SET @re = -1; -- TÀI KHOẢN MẬT KHẨU KHÔNG ĐÚNG
	ELSE
		BEGIN
		     IF EXISTS (SELECT 1 FROM dbo.DM_TaiKhoan t WHERE t.ID_TaiKhoan = @ID_TaiKhoan AND t.IsHoatDong = 1)
				 BEGIN
					SET @re = 1;      -- TÀI KHOẢN MẬT KHẨU CHÍNH XÁC VÀ ĐANG HOẠT ĐỘNG		
				 END									
			 ELSE
				SET @re = 0;      -- TÀI KHOẢN MẬT KHẨU CHÍNH XÁC NHƯNG BỊ VÔ HIỆU HÓA
		END

	SELECT @re AS re;
END;
GO
/****** Object:  StoredProcedure [dbo].[ThanhToan_DonHang_ChiTiet_Insert_Or_Update]    Script Date: 11/1/2023 2:52:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ThanhToan_DonHang_ChiTiet_Insert_Or_Update]
@ID_ThanhToan BIGINT = 0,
@listID_DonHang BIGINT = 0,
@NguoiCapNhat VARCHAR(50) = ''
AS
BEGIN

	DECLARE @Table TABLE (ID INT);
	INSERT INTO @Table
		SELECT * FROM dbo.splitstring(@listID_DonHang, ',')

	--Thêm chi tiết đơn hàng
    INSERT INTO dbo.ThanhToan_DonHang_ChiTiet
    (
        ID_ThanhToan,
        ID_DonHang,
        Created_Date,
        Created_By,
        Modified_Date,
        Modified_By,
        Delete_Mark
    )
	SELECT @ID_ThanhToan, ID, GETDATE(), @NguoiCapNhat, GETDATE(), @NguoiCapNhat, 0 FROM @Table
    --VALUES
    --(   @ID_ThanhToan,         -- ID_ThanhToan - bigint
    --    @ID_DonHang,         -- ID_DonHang - bigint
    --    GETDATE(), -- Created_Date - datetime
    --    @NguoiCapNhat,        -- Created_By - varchar(50)
    --    GETDATE(), -- Modified_Date - datetime
    --    @NguoiCapNhat,        -- Modified_By - varchar(50)
    --    0       -- Delete_Mark - bit
    --)

	--Cập nhật trạng thái đơn hàng là chờ kiểm duyệt
	UPDATE dbo.DonHang SET
	ID_TrangThai_DonHang = 2
	WHERE ID_DonHang IN (SELECT ID FROM @Table)

	SELECT 1 AS re	
END
GO
/****** Object:  StoredProcedure [dbo].[TrangChu_GetList_MonAn]    Script Date: 11/1/2023 2:52:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TrangChu_GetList_MonAn]
@ID_MonAnPhanLoai INT = 0,
@TenMonAn NVARCHAR(MAX) = N'',
@SapXep INT = 0
AS 
BEGIN
        SELECT a.ID_MonAn, 
	a.ID_MonAnPhanLoai, 
	b.TenTrangThai, 
	a.ID_MonAnTrangThai, 
	c.ID_MonAnPhanLoai, 
	c.TenMonAnPhanLoai, 
	a.TenMonAn, 
	a.DonGia, 
	CASE WHEN ISNULL(a.HinhAnhTheHien , N'') <> N'' THEN  N'https://localhost:44346/' + a.HinhAnhTheHien ELSE N'' END HinhAnhTheHien,
	a.DanhGia, 
	--a.MaGiamGia, 
	a.MoTa, 
	(STUFF((select ', ' + TenNguyenLieu 
	FROM DM_NguyenLieu WHERE  Delete_Mark = 0 AND ID_NguyenLieu IN (SELECT ID_NguyenLieu FROM DM_MonAn_NguyenLieu WHERE Delete_Mark = 0 AND ID_MonAn = a.ID_MonAn AND a.Delete_Mark = 0) 
	for xml path ('')), 1, 1, '')) TenNguyenLieu ,
	CASE WHEN a.ID_MonAnTrangThai = 1 THEN 1 ELSE 0 END isOrder
	FROM DM_MonAn a 
	LEFT JOIN DM_MonAn_TrangThai b ON b.ID_MonAnTrangThai = a.ID_MonAnTrangThai AND b.Delete_Mark = 0
	LEFT JOIN DM_MonAn_PhanLoai c ON c.ID_MonAnPhanLoai = a.ID_MonAnPhanLoai AND c.Delete_Mark = 0
	WHERE a.Delete_Mark = 0 
	AND (@ID_MonAnPhanLoai = 0 OR @ID_MonAnPhanLoai = a.ID_MonAnPhanLoai)
	AND (@TenMonAn = '' OR a.TenMonAn LIKE N'%' + @TenMonAn + N'%')
	ORDER BY CASE WHEN @SapXep <> 1 THEN a.DonGia END ASC,
		CASE WHEN @SapXep = 1 THEN a.DonGia END DESC
END
 
GO
/****** Object:  StoredProcedure [dbo].[TrangThai_DonHang_Get_By_ID_TaiKhoan]    Script Date: 11/1/2023 2:52:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TrangThai_DonHang_Get_By_ID_TaiKhoan]
@ID_TrangThai INT = 0,
@ID_TaiKhoan INT = 0
AS
BEGIN
    SELECT 
	dh.MaDonHang
	FROM dbo.DonHang dh
	LEFT JOIN dbo.DM_MonAn ma ON ma.Delete_Mark = 0 AND ma.ID_MonAn = dh.ID_MonAn
	WHERE dh.Delete_Mark = 0
	AND dh.ID_TaiKhoan = @ID_TaiKhoan
END
SELECT * FROM dbo.DM_MonAn
SELECT * FROM dbo.DM_MonAn_PhanLoai
GO
/****** Object:  StoredProcedure [dbo].[User_GetUserByUserName]    Script Date: 11/1/2023 2:52:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[User_GetUserByUserName] 
@TenDangNhap VARCHAR(50) = ''
AS
BEGIN
    SELECT 
		t.*
	FROM dbo.DM_TaiKhoan t 	
	WHERE t.TenDangNhap = @TenDangNhap
	AND t.Delete_Mark = 0 
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'NAM, NU, KHAC' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DM_TaiKhoan', @level2type=N'COLUMN',@level2name=N'GioiTinh'
GO
USE [master]
GO
ALTER DATABASE [BanDoAnNhanh] SET  READ_WRITE 
GO
