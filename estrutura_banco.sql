-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           8.0.41 - MySQL Community Server - GPL
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              12.10.0.7000
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Copiando estrutura do banco de dados para el_cht
CREATE DATABASE IF NOT EXISTS `el_cht` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `el_cht`;

-- Copiando estrutura para tabela el_cht.el_m
CREATE TABLE IF NOT EXISTS `el_m` (
  `id` int NOT NULL AUTO_INCREMENT,
  `from` varchar(150) NOT NULL DEFAULT '',
  `to` varchar(150) NOT NULL DEFAULT '',
  `message` varchar(50) NOT NULL DEFAULT '',
  `date` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela el_cht.el_m: ~2 rows (aproximadamente)
INSERT INTO `el_m` (`id`, `from`, `to`, `message`, `date`) VALUES
	(4, 'a04649787f2f34f4b14952cb699e7506', 'a04649787f2f34f4b14952cb699e7506', 'eaeeee', '2025-03-20 18:40:13'),
	(5, 'a04649787f2f34f4b14952cb699e7506', 'a04649787f2f34f4b14952cb699e7506', 'ta por onde bb', '2025-03-20 18:40:40');

-- Copiando estrutura para tabela el_cht.ipblocked
CREATE TABLE IF NOT EXISTS `ipblocked` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ip` varchar(100) DEFAULT NULL,
  `reason` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela el_cht.ipblocked: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela el_cht.locations
CREATE TABLE IF NOT EXISTS `locations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `device` varchar(50) NOT NULL DEFAULT '0',
  `system` varchar(50) NOT NULL DEFAULT '0',
  `navigator` varchar(50) NOT NULL DEFAULT '0',
  `user` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela el_cht.locations: ~1 rows (aproximadamente)
INSERT INTO `locations` (`id`, `device`, `system`, `navigator`, `user`) VALUES
	(1, 'Desktop', 'Windows', 'Chrome', 'a04649787f2f34f4b14952cb699e7506');

-- Copiando estrutura para tabela el_cht.moneys
CREATE TABLE IF NOT EXISTS `moneys` (
  `id` int NOT NULL AUTO_INCREMENT,
  `token` varchar(150) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela el_cht.moneys: ~1 rows (aproximadamente)
INSERT INTO `moneys` (`id`, `token`) VALUES
	(2, 'a04649787f2f34f4b14952cb699e7506');


-- Copiando estrutura do banco de dados para marketplace
CREATE DATABASE IF NOT EXISTS `marketplace` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `marketplace`;

-- Copiando estrutura para tabela marketplace.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(150) NOT NULL,
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela marketplace.users: ~2 rows (aproximadamente)
INSERT INTO `users` (`id`, `name`, `email`, `password`) VALUES
	(3, 'name', 'name@gmail.com', '$2b$10$AWb5ImsmrQNywKMSU1.KF.TIUK.c7TKRc6WtVsfXRNry6IMBkSUcW'),
	(8, 'name', 'name2@gmail.com', '$2b$10$e05JBLkFTUtMPuPLhle/gOjcPt0jnCOD6/xerocoEZckafDCR5eQ.'),
	(9, 'José Carlos', 'josecarlos@gmail.com', '$2b$10$fLCAcma.B5eG7SqeU.x2X.9dwz4Z2J3ElYv8WYVBsABI7NShifzr2');

-- Copiando estrutura para tabela marketplace.user_cart
CREATE TABLE IF NOT EXISTS `user_cart` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user` int NOT NULL,
  `title` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `price` varchar(50) NOT NULL DEFAULT '',
  `image` varchar(150) NOT NULL DEFAULT '',
  `rating` varchar(50) NOT NULL DEFAULT '',
  `link` varchar(700) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `product` varchar(50) NOT NULL DEFAULT '',
  `discount` varchar(50) NOT NULL DEFAULT '',
  `originalPrice` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `user` (`user`),
  CONSTRAINT `FK1_user_cart` FOREIGN KEY (`user`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela marketplace.user_cart: ~28 rows (aproximadamente)
INSERT INTO `user_cart` (`id`, `user`, `title`, `price`, `image`, `rating`, `link`, `product`, `discount`, `originalPrice`) VALUES
	(1, 3, 'Apple MacBook Air (13 polegadas, 2020, Chip M1, 256 GB de SSD, 8 GB de RAM) - Cinza-espacial', 'R$ 3.989,05', 'https://http2.mlstatic.com/D_Q_NP_2X_992371-MLU75322243215_032024-E.webp', '4.9', 'https://www.mercadolivre.com.br/apple-macbook-air-13-polegadas-2020-chip-m1-256-gb-de-ssd-8-gb-de-ram-cinza-espacial/p/MLB17828518#polycard_client=search-nordic&searchVariation=MLB17828518&wid=MLB5234462148&position=2&search_layout=grid&type=product&tracking_id=14856ef8-a52b-4587-90a0-2801b520ad1c&sid=search', 'MLB17828518', '35', 'R$ 6.137,00'),
	(2, 3, 'MacBook Air M2 (2022) 13.6" space gray 8GB de Ram - 256GB SSD - Apple M', 'R$ 4.972,50', 'https://http2.mlstatic.com/D_Q_NP_2X_637313-MLA51356401031_082022-E.webp', '4.9', 'https://www.mercadolivre.com.br/macbook-air-m2-2022-136-space-gray-8gb-de-ram-256gb-ssd-apple-m/p/MLB19563444#polycard_client=search-nordic&searchVariation=MLB19563444&wid=MLB3873373000&position=3&search_layout=grid&type=product&tracking_id=14856ef8-a52b-4587-90a0-2801b520ad1c&sid=search', 'MLB19563444', '35', 'R$ 7.650,00'),
	(3, 3, 'Apple MacBook Air (13 polegadas, 2020, Chip M1, 256 GB de SSD, 8 GB de RAM) - Cinza-espacial', 'R$ 3.989,05', 'https://http2.mlstatic.com/D_Q_NP_2X_992371-MLU75322243215_032024-E.webp', '4.9', 'https://www.mercadolivre.com.br/apple-macbook-air-13-polegadas-2020-chip-m1-256-gb-de-ssd-8-gb-de-ram-cinza-espacial/p/MLB17828518#polycard_client=search-nordic&searchVariation=MLB17828518&wid=MLB5234462148&position=2&search_layout=grid&type=product&tracking_id=14856ef8-a52b-4587-90a0-2801b520ad1c&sid=search', 'MLB17828518', '35', 'R$ 6.137,00'),
	(4, 3, 'Apple MacBook Air (13 polegadas, 2020, Chip M1, 256 GB de SSD, 8 GB de RAM) - Cinza-espacial', 'R$ 3.989,05', 'https://http2.mlstatic.com/D_Q_NP_2X_992371-MLU75322243215_032024-E.webp', '4.9', 'https://www.mercadolivre.com.br/apple-macbook-air-13-polegadas-2020-chip-m1-256-gb-de-ssd-8-gb-de-ram-cinza-espacial/p/MLB17828518#polycard_client=search-nordic&searchVariation=MLB17828518&wid=MLB5234462148&position=2&search_layout=grid&type=product&tracking_id=14856ef8-a52b-4587-90a0-2801b520ad1c&sid=search', 'MLB17828518', '35', 'R$ 6.137,00'),
	(5, 3, 'Apple MacBook Air (13 polegadas, 2020, Chip M1, 256 GB de SSD, 8 GB de RAM) - Cinza-espacial', 'R$ 3.989,05', 'https://http2.mlstatic.com/D_Q_NP_2X_992371-MLU75322243215_032024-E.webp', '4.9', 'https://www.mercadolivre.com.br/apple-macbook-air-13-polegadas-2020-chip-m1-256-gb-de-ssd-8-gb-de-ram-cinza-espacial/p/MLB17828518#polycard_client=search-nordic&searchVariation=MLB17828518&wid=MLB5234462148&position=2&search_layout=grid&type=product&tracking_id=14856ef8-a52b-4587-90a0-2801b520ad1c&sid=search', 'MLB17828518', '35', 'R$ 6.137,00'),
	(6, 3, 'Apple MacBook Air (13 polegadas, 2020, Chip M1, 256 GB de SSD, 8 GB de RAM) - Cinza-espacial', 'R$ 3.989,05', 'https://http2.mlstatic.com/D_Q_NP_2X_992371-MLU75322243215_032024-E.webp', '4.9', 'https://www.mercadolivre.com.br/apple-macbook-air-13-polegadas-2020-chip-m1-256-gb-de-ssd-8-gb-de-ram-cinza-espacial/p/MLB17828518#polycard_client=search-nordic&searchVariation=MLB17828518&wid=MLB5234462148&position=2&search_layout=grid&type=product&tracking_id=14856ef8-a52b-4587-90a0-2801b520ad1c&sid=search', 'MLB17828518', '35', 'R$ 6.137,00'),
	(7, 3, 'Apple MacBook Air (13 polegadas, 2020, Chip M1, 256 GB de SSD, 8 GB de RAM) - Cinza-espacial', 'R$ 3.989,05', 'https://http2.mlstatic.com/D_Q_NP_2X_992371-MLU75322243215_032024-E.webp', '4.9', 'https://www.mercadolivre.com.br/apple-macbook-air-13-polegadas-2020-chip-m1-256-gb-de-ssd-8-gb-de-ram-cinza-espacial/p/MLB17828518#polycard_client=search-nordic&searchVariation=MLB17828518&wid=MLB5234462148&position=2&search_layout=grid&type=product&tracking_id=14856ef8-a52b-4587-90a0-2801b520ad1c&sid=search', 'MLB17828518', '35', 'R$ 6.137,00'),
	(8, 3, 'Apple MacBook Air (13 polegadas, 2020, Chip M1, 256 GB de SSD, 8 GB de RAM) - Cinza-espacial', 'R$ 3.989,05', 'https://http2.mlstatic.com/D_Q_NP_2X_992371-MLU75322243215_032024-E.webp', '4.9', 'https://www.mercadolivre.com.br/apple-macbook-air-13-polegadas-2020-chip-m1-256-gb-de-ssd-8-gb-de-ram-cinza-espacial/p/MLB17828518#polycard_client=search-nordic&searchVariation=MLB17828518&wid=MLB5234462148&position=2&search_layout=grid&type=product&tracking_id=14856ef8-a52b-4587-90a0-2801b520ad1c&sid=search', 'MLB17828518', '35', 'R$ 6.137,00'),
	(9, 3, 'Apple MacBook Air (13 polegadas, 2020, Chip M1, 256 GB de SSD, 8 GB de RAM) - Cinza-espacial', 'R$ 3.989,05', 'https://http2.mlstatic.com/D_Q_NP_2X_992371-MLU75322243215_032024-E.webp', '4.9', 'https://www.mercadolivre.com.br/apple-macbook-air-13-polegadas-2020-chip-m1-256-gb-de-ssd-8-gb-de-ram-cinza-espacial/p/MLB17828518#polycard_client=search-nordic&searchVariation=MLB17828518&wid=MLB5234462148&position=2&search_layout=grid&type=product&tracking_id=14856ef8-a52b-4587-90a0-2801b520ad1c&sid=search', 'MLB17828518', '35', 'R$ 6.137,00'),
	(10, 3, 'Apple MacBook Air (13 polegadas, 2020, Chip M1, 256 GB de SSD, 8 GB de RAM) - Cinza-espacial', 'R$ 3.989,05', 'https://http2.mlstatic.com/D_Q_NP_2X_992371-MLU75322243215_032024-E.webp', '4.9', 'https://www.mercadolivre.com.br/apple-macbook-air-13-polegadas-2020-chip-m1-256-gb-de-ssd-8-gb-de-ram-cinza-espacial/p/MLB17828518#polycard_client=search-nordic&searchVariation=MLB17828518&wid=MLB5234462148&position=2&search_layout=grid&type=product&tracking_id=14856ef8-a52b-4587-90a0-2801b520ad1c&sid=search', 'MLB17828518', '35', 'R$ 6.137,00'),
	(11, 3, 'Apple MacBook Air (13 polegadas, 2020, Chip M1, 256 GB de SSD, 8 GB de RAM) - Cinza-espacial', 'R$ 3.989,05', 'https://http2.mlstatic.com/D_Q_NP_2X_992371-MLU75322243215_032024-E.webp', '4.9', 'https://www.mercadolivre.com.br/apple-macbook-air-13-polegadas-2020-chip-m1-256-gb-de-ssd-8-gb-de-ram-cinza-espacial/p/MLB17828518#polycard_client=search-nordic&searchVariation=MLB17828518&wid=MLB5234462148&position=2&search_layout=grid&type=product&tracking_id=14856ef8-a52b-4587-90a0-2801b520ad1c&sid=search', 'MLB17828518', '35', 'R$ 6.137,00'),
	(12, 3, 'Apple MacBook Air (13 polegadas, 2020, Chip M1, 256 GB de SSD, 8 GB de RAM) - Cinza-espacial', 'R$ 3.989,05', 'https://http2.mlstatic.com/D_Q_NP_2X_992371-MLU75322243215_032024-E.webp', '4.9', 'https://www.mercadolivre.com.br/apple-macbook-air-13-polegadas-2020-chip-m1-256-gb-de-ssd-8-gb-de-ram-cinza-espacial/p/MLB17828518#polycard_client=search-nordic&searchVariation=MLB17828518&wid=MLB5234462148&position=2&search_layout=grid&type=product&tracking_id=14856ef8-a52b-4587-90a0-2801b520ad1c&sid=search', 'MLB17828518', '35', 'R$ 6.137,00'),
	(13, 3, 'Apple MacBook Air (13 polegadas, 2020, Chip M1, 256 GB de SSD, 8 GB de RAM) - Cinza-espacial', 'R$ 3.989,05', 'https://http2.mlstatic.com/D_Q_NP_2X_992371-MLU75322243215_032024-E.webp', '4.9', 'https://www.mercadolivre.com.br/apple-macbook-air-13-polegadas-2020-chip-m1-256-gb-de-ssd-8-gb-de-ram-cinza-espacial/p/MLB17828518#polycard_client=search-nordic&searchVariation=MLB17828518&wid=MLB5234462148&position=2&search_layout=grid&type=product&tracking_id=14856ef8-a52b-4587-90a0-2801b520ad1c&sid=search', 'MLB17828518', '35', 'R$ 6.137,00'),
	(14, 3, 'MacBook Air M2 (2022) 13.6" space gray 8GB de Ram - 256GB SSD - Apple M', 'R$ 4.972,50', 'https://http2.mlstatic.com/D_Q_NP_2X_637313-MLA51356401031_082022-E.webp', '4.9', 'https://www.mercadolivre.com.br/macbook-air-m2-2022-136-space-gray-8gb-de-ram-256gb-ssd-apple-m/p/MLB19563444#polycard_client=search-nordic&searchVariation=MLB19563444&wid=MLB3873373000&position=3&search_layout=grid&type=product&tracking_id=14856ef8-a52b-4587-90a0-2801b520ad1c&sid=search', 'MLB19563444', '35', 'R$ 7.650,00'),
	(15, 3, 'MacBook Air M2 (2022) 13.6" space gray 8GB de Ram - 256GB SSD - Apple M', 'R$ 4.972,50', 'https://http2.mlstatic.com/D_Q_NP_2X_637313-MLA51356401031_082022-E.webp', '4.9', 'https://www.mercadolivre.com.br/macbook-air-m2-2022-136-space-gray-8gb-de-ram-256gb-ssd-apple-m/p/MLB19563444#polycard_client=search-nordic&searchVariation=MLB19563444&wid=MLB3873373000&position=3&search_layout=grid&type=product&tracking_id=14856ef8-a52b-4587-90a0-2801b520ad1c&sid=search', 'MLB19563444', '35', 'R$ 7.650,00'),
	(16, 3, 'Apple MacBook Air (13 polegadas, 2020, Chip M1, 256 GB de SSD, 8 GB de RAM) - Cinza-espacial', 'R$ 3.989,05', 'https://http2.mlstatic.com/D_Q_NP_2X_992371-MLU75322243215_032024-E.webp', '4.9', 'https://www.mercadolivre.com.br/apple-macbook-air-13-polegadas-2020-chip-m1-256-gb-de-ssd-8-gb-de-ram-cinza-espacial/p/MLB17828518#polycard_client=search-nordic&searchVariation=MLB17828518&wid=MLB5234462148&position=2&search_layout=grid&type=product&tracking_id=14856ef8-a52b-4587-90a0-2801b520ad1c&sid=search', 'MLB17828518', '35', 'R$ 6.137,00'),
	(17, 3, 'MacBook Air M2 (2022) 13.6" midnight 8GB de Ram - 256GB SSD - Apple M', 'R$ 4.761,25', 'https://http2.mlstatic.com/D_Q_NP_2X_708839-MLA51356236557_082022-E.webp', '4.9', 'https://www.mercadolivre.com.br/macbook-air-m2-2022-136-midnight-8gb-de-ram-256gb-ssd-apple-m/p/MLB19563442#polycard_client=search-nordic&searchVariation=MLB19563442&wid=MLB5151156094&position=4&search_layout=grid&type=product&tracking_id=14856ef8-a52b-4587-90a0-2801b520ad1c&sid=search', 'MLB19563442', '35', 'R$ 7.325,00'),
	(18, 3, 'MacBook Air M2 (2022) 13.6" midnight 8GB de Ram - 256GB SSD - Apple M', 'R$ 4.761,25', 'https://http2.mlstatic.com/D_Q_NP_2X_708839-MLA51356236557_082022-E.webp', '4.9', 'https://www.mercadolivre.com.br/macbook-air-m2-2022-136-midnight-8gb-de-ram-256gb-ssd-apple-m/p/MLB19563442#polycard_client=search-nordic&searchVariation=MLB19563442&wid=MLB5151156094&position=4&search_layout=grid&type=product&tracking_id=14856ef8-a52b-4587-90a0-2801b520ad1c&sid=search', 'MLB19563442', '35', 'R$ 7.325,00'),
	(19, 3, 'Apple MacBook Air (13 polegadas, 2020, Chip M1, 256 GB de SSD, 8 GB de RAM) - Cinza-espacial', 'R$ 3.989,05', 'https://http2.mlstatic.com/D_Q_NP_2X_992371-MLU75322243215_032024-E.webp', '4.9', 'https://www.mercadolivre.com.br/apple-macbook-air-13-polegadas-2020-chip-m1-256-gb-de-ssd-8-gb-de-ram-cinza-espacial/p/MLB17828518#polycard_client=search-nordic&searchVariation=MLB17828518&wid=MLB5234462148&position=2&search_layout=grid&type=product&tracking_id=a6eee074-c736-4eaf-bd3b-e59122392072&sid=search', 'MLB17828518', '35', 'R$ 6.137,00'),
	(20, 3, 'Apple MacBook Air (13 polegadas, 2020, Chip M1, 256 GB de SSD, 8 GB de RAM) - Cinza-espacial', 'R$ 3.989,05', 'https://http2.mlstatic.com/D_Q_NP_2X_992371-MLU75322243215_032024-E.webp', '4.9', 'https://www.mercadolivre.com.br/apple-macbook-air-13-polegadas-2020-chip-m1-256-gb-de-ssd-8-gb-de-ram-cinza-espacial/p/MLB17828518#polycard_client=search-nordic&searchVariation=MLB17828518&wid=MLB5234462148&position=2&search_layout=grid&type=product&tracking_id=a6eee074-c736-4eaf-bd3b-e59122392072&sid=search', 'MLB17828518', '35', 'R$ 6.137,00'),
	(21, 3, 'Apple MacBook Air (13 polegadas, 2020, Chip M1, 256 GB de SSD, 8 GB de RAM) - Cinza-espacial', 'R$ 3.989,05', 'https://http2.mlstatic.com/D_Q_NP_2X_992371-MLU75322243215_032024-E.webp', '4.9', 'https://www.mercadolivre.com.br/apple-macbook-air-13-polegadas-2020-chip-m1-256-gb-de-ssd-8-gb-de-ram-cinza-espacial/p/MLB17828518#polycard_client=search-nordic&searchVariation=MLB17828518&wid=MLB5234462148&position=2&search_layout=grid&type=product&tracking_id=a6eee074-c736-4eaf-bd3b-e59122392072&sid=search', 'MLB17828518', '35', 'R$ 6.137,00'),
	(22, 3, 'Apple MacBook Air (13 polegadas, 2020, Chip M1, 256 GB de SSD, 8 GB de RAM) - Cinza-espacial', 'R$ 3.989,05', 'https://http2.mlstatic.com/D_Q_NP_2X_992371-MLU75322243215_032024-E.webp', '4.9', 'https://www.mercadolivre.com.br/apple-macbook-air-13-polegadas-2020-chip-m1-256-gb-de-ssd-8-gb-de-ram-cinza-espacial/p/MLB17828518#polycard_client=search-nordic&searchVariation=MLB17828518&wid=MLB5234462148&position=5&search_layout=grid&type=product&tracking_id=41c61d78-1f95-4ace-b350-2c3215bb9e03&sid=search', 'MLB17828518', '35', 'R$ 6.137,00'),
	(23, 3, 'MacBook Air M2 (2022) 13.6" midnight 8GB de Ram - 256GB SSD - Apple M', 'R$ 4.761,25', 'https://http2.mlstatic.com/D_Q_NP_2X_708839-MLA51356236557_082022-E.webp', '4.9', 'https://www.mercadolivre.com.br/macbook-air-m2-2022-136-midnight-8gb-de-ram-256gb-ssd-apple-m/p/MLB19563442#polycard_client=search-nordic&searchVariation=MLB19563442&wid=MLB5151156094&position=4&search_layout=grid&type=product&tracking_id=569fcf13-4a92-4b9f-8c2f-dccd75170593&sid=search', 'MLB19563442', '35', 'R$ 7.325,00'),
	(24, 3, 'MacBook Pro MacBook Pro 14" M3 Pro 14" silver 18GB de Ram - 1TB SSD - Apple M3', 'R$ 12.949,50', 'https://http2.mlstatic.com/D_Q_NP_2X_624461-MLA73997068086_012024-E.webp', '4.9', 'https://www.mercadolivre.com.br/macbook-pro-macbook-pro-14-m3-pro-14-silver-18gb-de-ram-1tb-ssd-apple-m3/p/MLB29805432#polycard_client=search-nordic&searchVariation=MLB29805432&wid=MLB3986355391&position=3&search_layout=grid&type=product&tracking_id=dcfaa480-9598-445a-8671-cb710304521f&sid=search', 'MLB29805432', '50', 'R$ 25.899,00'),
	(25, 3, 'MacBook Pro MacBook Pro 14" M3 Pro 14" silver 18GB de Ram - 1TB SSD - Apple M3', 'R$ 12.949,50', 'https://http2.mlstatic.com/D_Q_NP_2X_624461-MLA73997068086_012024-E.webp', '4.9', 'https://www.mercadolivre.com.br/macbook-pro-macbook-pro-14-m3-pro-14-silver-18gb-de-ram-1tb-ssd-apple-m3/p/MLB29805432#polycard_client=search-nordic&searchVariation=MLB29805432&wid=MLB3986355391&position=3&search_layout=grid&type=product&tracking_id=dcfaa480-9598-445a-8671-cb710304521f&sid=search', 'MLB29805432', '50', 'R$ 25.899,00'),
	(26, 3, 'MacBook Pro MacBook Pro 14" M3 Pro 14" silver 18GB de Ram - 1TB SSD - Apple M3', 'R$ 12.949,50', 'https://http2.mlstatic.com/D_Q_NP_2X_624461-MLA73997068086_012024-E.webp', '4.9', 'https://www.mercadolivre.com.br/macbook-pro-macbook-pro-14-m3-pro-14-silver-18gb-de-ram-1tb-ssd-apple-m3/p/MLB29805432#polycard_client=search-nordic&searchVariation=MLB29805432&wid=MLB3986355391&position=3&search_layout=grid&type=product&tracking_id=dcfaa480-9598-445a-8671-cb710304521f&sid=search', 'MLB29805432', '50', 'R$ 25.899,00'),
	(27, 3, 'MacBook Pro M3 A2918 14" silver 8GB de Ram 512GB SSD HDD Apple M3', 'R$ 7.212,50', 'https://http2.mlstatic.com/D_Q_NP_2X_859268-MLU77312568033_062024-E.webp', '5.0', 'https://www.mercadolivre.com.br/macbook-pro-m3-a2918-14-silver-8gb-de-ram-512gb-ssd-hdd-apple-m3/p/MLB37448075#polycard_client=search-nordic&searchVariation=MLB37448075&wid=MLB4991841932&position=6&search_layout=grid&type=product&tracking_id=dcfaa480-9598-445a-8671-cb710304521f&sid=search', 'MLB37448075', '50', 'R$ 14.425,00'),
	(28, 3, 'Apple iPhone 13 (128 GB) - Estelar - Distribuidor Autorizado', 'R$ 4.939,35', 'https://http2.mlstatic.com/D_Q_NP_2X_916682-MLA47782359266_102021-V.webp', '4.9', 'https://www.mercadolivre.com.br/apple-iphone-13-128-gb-estelar-distribuidor-autorizado/p/MLB1018500855#polycard_client=search-nordic&searchVariation=MLB1018500855&wid=MLB3582540395&position=6&search_layout=stack&type=product&tracking_id=277e36d7-43dd-4d2b-a55d-87c7af3e986f&sid=search', 'MLB1018500855', '35', 'R$ 7.599,00');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
