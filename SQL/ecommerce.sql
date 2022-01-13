-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 13, 2022 at 03:24 AM
-- Server version: 10.4.11-MariaDB-log
-- PHP Version: 7.4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ecommerce`
--
CREATE DATABASE IF NOT EXISTS `ecommerce` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `ecommerce`;

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart` (
  `userId` int(10) NOT NULL,
  `productId` int(10) NOT NULL,
  `productQty` int(10) NOT NULL,
  `status` varchar(25) NOT NULL,
  `createdAt` date NOT NULL DEFAULT current_timestamp(),
  `updatedAt` date NOT NULL DEFAULT current_timestamp(),
  `transactionId` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Truncate table before insert `cart`
--

TRUNCATE TABLE `cart`;
-- --------------------------------------------------------

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `productId` int(10) NOT NULL,
  `productName` varchar(25) NOT NULL,
  `productSummary` text NOT NULL,
  `productDesc` text NOT NULL,
  `productCategory` varchar(255) NOT NULL,
  `productBrand` varchar(25) NOT NULL,
  `productPrice` varchar(25) NOT NULL,
  `productStock` int(10) NOT NULL,
  `discountId` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Truncate table before insert `product`
--

TRUNCATE TABLE `product`;
--
-- Dumping data for table `product`
--

INSERT IGNORE INTO `product` (`productId`, `productName`, `productSummary`, `productDesc`, `productCategory`, `productBrand`, `productPrice`, `productStock`, `discountId`) VALUES
(1, 'Testing Monitor', 'SummaryTESt', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus ut est bibendum, vulputate felis quis, porta libero. Curabitur ut mauris sed ligula blandit porttitor eu eget elit. Praesent vulputate vestibulum fermentum. Sed efficitur quam enim, sit amet porttitor justo sollicitudin in. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Fusce luctus eleifend semper. Suspendisse tempus turpis ac augue tincidunt pellentesque. Duis non tristique libero. In vitae nulla lectus. Ut arcu sem, convallis sed semper ac, bibendum id tortor. Aenean convallis pellentesque dolor eu gravida. Nunc commodo urna tempus mauris euismod congue.\r\n\r\nNulla leo odio, accumsan vitae mi at, porta consectetur neque. Sed non sem fermentum, ornare elit in, laoreet massa. Proin et sagittis risus. Suspendisse non porta purus. Vivamus sit amet ultrices urna, sed viverra sapien. Cras sed augue ut ante rutrum suscipit at ac augue. Morbi ultricies, tellus eu congue pellentesque, purus odio tristique lectus, a ultrices quam orci nec erat. Donec quis suscipit dui. Mauris semper, ex at consequat tempor, dolor felis lacinia felis, eu rutrum nisl libero sed lacus. Aliquam dapibus tellus eu augue egestas bibendum. In sed rutrum lacus. Fusce non pellentesque eros. Sed vel vestibulum augue.', 'Elektronik', 'Monitor', '1000000', 5, 4),
(3, 'Asus Zen-Book Pro-Duo', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus sit amet turpis ex. Curabitur fermentum interdum odio vitae sollicitudin. Proin nec viverra orci, vitae ullamcorper nisi. Proin vitae porttitor justo. Donec interdum sollicitudin velit, vel semper mi egestas ac. Suspendisse potenti. Proin commodo posuere enim dignissim aliquam. Vivamus ut aliquam lectus. Sed facilisis odio at elit feugiat venenatis. Integer fermentum suscipit tempus. Donec quis leo dui. Vivamus quis leo vitae risus pharetra pellentesque.', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse bibendum pretium mauris rhoncus ornare. Phasellus sit amet efficitur dui. Phasellus hendrerit leo in pharetra fringilla. Sed ac erat diam. Fusce nec mattis urna. Suspendisse potenti. Cras fringilla, lorem ac iaculis pharetra, libero lorem interdum neque, at tristique augue felis sit amet elit. Donec tempor consectetur lectus in laoreet.\r\n\r\nVestibulum id facilisis massa, quis pharetra diam. Donec id rhoncus est, ut viverra leo. Cras vel fringilla diam. Fusce fringilla, enim a euismod molestie, purus metus faucibus ipsum, quis sodales massa ex ac orci. Donec magna dolor, malesuada eget gravida quis, mattis eget metus. Sed nec porttitor orci, eget maximus nisi. Donec fringilla dapibus erat, eget fermentum nibh interdum ac.\r\n\r\nMorbi laoreet odio eu lacus egestas semper. Fusce vestibulum mattis mi. Ut tincidunt fringilla ullamcorper. Vestibulum rhoncus at elit eget sodales. Quisque rhoncus risus lectus, eget aliquet elit efficitur a. Maecenas sit amet libero posuere, dictum dui rutrum, tincidunt massa. Donec scelerisque convallis nulla nec congue. Aenean semper, lacus et aliquam blandit, enim orci interdum lacus, a malesuada diam felis vitae lorem. Nulla placerat luctus libero. Ut ultricies finibus erat at venenatis. Vestibulum sollicitudin a turpis sed pretium.', 'Laptop', 'ASUS', '50000000', 5, NULL),
(12, 'Testing', 'Lorem', 'Ipsum', 'Computer', 'Test', '2500000', 10, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `product_comment`
--

DROP TABLE IF EXISTS `product_comment`;
CREATE TABLE `product_comment` (
  `commentId` int(15) NOT NULL,
  `userId` int(10) NOT NULL,
  `productId` int(10) NOT NULL,
  `commentText` text NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Truncate table before insert `product_comment`
--

TRUNCATE TABLE `product_comment`;
--
-- Dumping data for table `product_comment`
--

INSERT IGNORE INTO `product_comment` (`commentId`, `userId`, `productId`, `commentText`, `createdAt`, `updatedAt`) VALUES
(2, 1, 1, 'First Content!', '2022-01-05 00:12:14', '2022-01-09 12:19:25'),
(5, 2, 1, 'Waiting for your next! my man', '2022-01-06 16:22:15', '2022-01-09 09:04:31'),
(6, 1, 1, 'Thanks Man!', '2022-01-06 16:23:31', '2022-01-06 16:23:31'),
(8, 2, 1, 'Your Welcome', '2022-01-07 21:06:51', '2022-01-07 21:06:51'),
(14, 3, 1, 'Test', '2022-01-09 13:51:20', '2022-01-09 13:51:20');

-- --------------------------------------------------------

--
-- Table structure for table `product_discount`
--

DROP TABLE IF EXISTS `product_discount`;
CREATE TABLE `product_discount` (
  `discountId` int(10) NOT NULL,
  `discountName` varchar(25) NOT NULL,
  `discountPercent` int(3) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Truncate table before insert `product_discount`
--

TRUNCATE TABLE `product_discount`;
--
-- Dumping data for table `product_discount`
--

INSERT IGNORE INTO `product_discount` (`discountId`, `discountName`, `discountPercent`, `createdAt`, `updatedAt`) VALUES
(2, 'Diskon Akhir Tahun', 50, '2022-01-09 07:09:23', '2022-01-09 07:09:23'),
(4, 'Diskon Awal Tahun', 60, '2022-01-09 18:36:28', '2022-01-09 18:36:28');

-- --------------------------------------------------------

--
-- Table structure for table `product_gallery`
--

DROP TABLE IF EXISTS `product_gallery`;
CREATE TABLE `product_gallery` (
  `imageId` int(10) NOT NULL,
  `imageType` varchar(25) NOT NULL,
  `imageName` varchar(50) NOT NULL,
  `imagePath` varchar(250) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `used` enum('True','False') NOT NULL,
  `productId` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Truncate table before insert `product_gallery`
--

TRUNCATE TABLE `product_gallery`;
--
-- Dumping data for table `product_gallery`
--

INSERT IGNORE INTO `product_gallery` (`imageId`, `imageType`, `imageName`, `imagePath`, `createdAt`, `used`, `productId`) VALUES
(1, 'image/jpeg', 'images.jpg', 'uploads/1641214251065-Testing Monitor-images.jpg', '2022-01-03 12:50:51', 'True', 1),
(5, 'image/jpeg', 'download (3).jpg', 'uploads/1641587482180-Testing Monitor-download (3).jpg', '2022-01-07 20:31:22', 'False', 1),
(6, 'image/jpeg', 'download (2).jpg', 'uploads/1641587488113-Testing Monitor-download (2).jpg', '2022-01-07 20:31:28', 'False', 1),
(7, 'image/jpeg', 'produo.jpg', 'uploads/1641722909127-Asus Zen-Book Pro-Duo-produo.jpg', '2022-01-09 10:08:30', 'True', 3),
(8, 'image/jpeg', 'download (1).jpg', 'uploads/1641725685502-Asus Zen-Book Pro-Duo-download (1).jpg', '2022-01-09 10:54:45', 'False', 3),
(17, 'image/png', 'download.png', 'uploads/1641992044302-Testing-download.png', '2022-01-12 12:54:04', 'True', 12);

-- --------------------------------------------------------

--
-- Table structure for table `product_rating`
--

DROP TABLE IF EXISTS `product_rating`;
CREATE TABLE `product_rating` (
  `productRatingId` int(10) NOT NULL,
  `userId` int(10) NOT NULL,
  `productId` int(10) NOT NULL,
  `productRating` int(1) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Truncate table before insert `product_rating`
--

TRUNCATE TABLE `product_rating`;
--
-- Dumping data for table `product_rating`
--

INSERT IGNORE INTO `product_rating` (`productRatingId`, `userId`, `productId`, `productRating`, `createdAt`, `updatedAt`) VALUES
(7, 2, 1, 4, '2022-01-08 17:25:25', '2022-01-09 09:01:56'),
(8, 3, 1, 5, '2022-01-08 18:03:40', '2022-01-09 13:52:19'),
(9, 6, 3, 4, '2022-01-12 14:32:08', '2022-01-12 15:16:17'),
(10, 6, 12, 5, '2022-01-12 15:03:32', '2022-01-12 15:16:13'),
(11, 6, 1, 4, '2022-01-12 15:16:03', '2022-01-12 15:16:03');

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
CREATE TABLE `transaction` (
  `transactionId` int(10) NOT NULL,
  `userId` int(10) NOT NULL,
  `createdAt` date NOT NULL DEFAULT current_timestamp(),
  `paymentMethod` varchar(25) NOT NULL,
  `transactionPoint` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Truncate table before insert `transaction`
--

TRUNCATE TABLE `transaction`;
-- --------------------------------------------------------

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `userId` int(10) NOT NULL,
  `name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `phoneNo` varchar(15) NOT NULL,
  `address` varchar(50) NOT NULL,
  `userName` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `createdAt` date NOT NULL DEFAULT current_timestamp(),
  `updatedAt` date NOT NULL DEFAULT current_timestamp(),
  `userAvatar` varchar(255) NOT NULL,
  `role` enum('Admin','User') NOT NULL,
  `refresh_token` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Truncate table before insert `user`
--

TRUNCATE TABLE `user`;
--
-- Dumping data for table `user`
--

INSERT IGNORE INTO `user` (`userId`, `name`, `email`, `phoneNo`, `address`, `userName`, `password`, `createdAt`, `updatedAt`, `userAvatar`, `role`, `refresh_token`) VALUES
(1, 'Arruhu Nahya', 'Arruhu@mail.com', '08528449919104', 'jl.stasiun, kp.lalang', 'Arruhu0821', '$2b$10$1MKSudulHlTp46CnuwbMgO/XhgCt8GPRaU60uxiGjx9H1VekLJy/G', '2022-01-03', '2022-01-09', 'avatars/Admin.jpg', 'Admin', NULL),
(2, 'Lorem Ipsum', 'lorem@mail.com', '0865659911', 'Hell\'s Road', 'loremCool', '$2b$10$3BTgj01PYkgaW.NPC55WyeKK/Rx/tPLVGllJCBNEh1YETHSoN/ycS', '2022-01-06', '2022-01-09', 'avatars/Avatar-loremCool.png', 'User', NULL),
(3, 'Eric Martin', 'eric@mail.com', '9734100101', 'Unknown', 'ericm', '$2b$10$nSOMj/KcK.vu76DBmqfyNunXRRfal.LdyRtZ3CM6xyUzc2NIWWhd2', '2022-01-08', '2022-01-09', 'avatars/ericm-Mr-Big_1440-e1497560284421-1.jpg', 'User', NULL),
(4, 'Alvin Christ', 'alvinardiansyah2002@gmail.com', '08991720400', 'Test', 'alvinchrist', '$2b$10$Kcd45bzp4sEpDWD5ElXpB.9z/0PFQwp0e9nHn/Oj2D3bDOt625MZ2', '2022-01-09', '2022-01-11', '', 'Admin', NULL),
(5, 'Admin', 'admin@gmail.com', '0000', '-', 'admin', '$2b$10$PWzsmU1g3QopvjIDMM2xOuxpbpiAQZE9AI5rh5tDvnPK32r.uHQ8e', '2022-01-11', '2022-01-12', '', 'Admin', NULL),
(6, 'User', 'user@gmail.com', '0000', '-', 'user', '$2b$10$EnJqSuzkqgRa30OoX4yxR.UjEll1lc7Z/tcoBmGKbs8F1C6PL1yv6', '2022-01-11', '2022-01-12', '', 'User', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjYsInVzZXJOYW1lIjoidXNlciIsImVtYWlsIjoidXNlckBnbWFpbC5jb20iLCJyb2xlIjoiVXNlciIsImlhdCI6MTY0MjAxMDc5MSwiZXhwIjoxNjQyMDk3MTkxfQ.GBBmfPtVsIndh4SjofdfZzPoh36ijt7XELjDC6p_LSQ');

-- --------------------------------------------------------

--
-- Table structure for table `wishlist`
--

DROP TABLE IF EXISTS `wishlist`;
CREATE TABLE `wishlist` (
  `userId` int(10) NOT NULL,
  `productId` int(10) NOT NULL,
  `productQty` int(11) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Truncate table before insert `wishlist`
--

TRUNCATE TABLE `wishlist`;
--
-- Dumping data for table `wishlist`
--

INSERT IGNORE INTO `wishlist` (`userId`, `productId`, `productQty`, `createdAt`, `updatedAt`) VALUES
(2, 1, 5, '2022-01-09 06:39:21', '2022-01-09 06:39:39');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD KEY `userId` (`userId`),
  ADD KEY `productId` (`productId`),
  ADD KEY `transactionId` (`transactionId`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`productId`),
  ADD KEY `discountId` (`discountId`);

--
-- Indexes for table `product_comment`
--
ALTER TABLE `product_comment`
  ADD PRIMARY KEY (`commentId`),
  ADD KEY `userId` (`userId`),
  ADD KEY `productId` (`productId`);

--
-- Indexes for table `product_discount`
--
ALTER TABLE `product_discount`
  ADD PRIMARY KEY (`discountId`);

--
-- Indexes for table `product_gallery`
--
ALTER TABLE `product_gallery`
  ADD PRIMARY KEY (`imageId`),
  ADD KEY `productId` (`productId`);

--
-- Indexes for table `product_rating`
--
ALTER TABLE `product_rating`
  ADD PRIMARY KEY (`productRatingId`),
  ADD KEY `userId` (`userId`),
  ADD KEY `productId` (`productId`);

--
-- Indexes for table `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`transactionId`),
  ADD KEY `userId` (`userId`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`userId`);

--
-- Indexes for table `wishlist`
--
ALTER TABLE `wishlist`
  ADD KEY `userId` (`userId`),
  ADD KEY `productId` (`productId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `productId` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `product_comment`
--
ALTER TABLE `product_comment`
  MODIFY `commentId` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `product_discount`
--
ALTER TABLE `product_discount`
  MODIFY `discountId` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `product_gallery`
--
ALTER TABLE `product_gallery`
  MODIFY `imageId` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `product_rating`
--
ALTER TABLE `product_rating`
  MODIFY `productRatingId` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `transaction`
--
ALTER TABLE `transaction`
  MODIFY `transactionId` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `userId` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `cart_ibfk_3` FOREIGN KEY (`transactionId`) REFERENCES `transaction` (`transactionId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`discountId`) REFERENCES `product_discount` (`discountId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `product_comment`
--
ALTER TABLE `product_comment`
  ADD CONSTRAINT `product_comment_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `product_comment_ibfk_2` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `product_gallery`
--
ALTER TABLE `product_gallery`
  ADD CONSTRAINT `product_gallery_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `product_rating`
--
ALTER TABLE `product_rating`
  ADD CONSTRAINT `product_rating_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `product_rating_ibfk_2` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `transaction`
--
ALTER TABLE `transaction`
  ADD CONSTRAINT `transaction_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `wishlist`
--
ALTER TABLE `wishlist`
  ADD CONSTRAINT `wishlist_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `wishlist_ibfk_2` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
