-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 20, 2024 at 03:37 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `userdatabase`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `category_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `category_name`) VALUES
(8, 'Main Dish'),
(9, 'Side Dish'),
(10, 'Dessert'),
(11, 'Salad'),
(12, 'Breakfast'),
(13, 'Soups'),
(14, 'Lunch'),
(15, 'Dinner'),
(16, 'Snacks'),
(17, 'kiven');

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` int(11) NOT NULL,
  `meal_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `comment` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`id`, `meal_id`, `user_id`, `comment`, `created_at`) VALUES
(6, 5, 2, 'how can i cook it?', '2024-06-19 05:27:55'),
(8, 10, 2, 'Hii', '2024-06-19 07:22:55'),
(10, 5, 2, 'fafa', '2024-06-19 11:36:21');

-- --------------------------------------------------------

--
-- Table structure for table `favorites`
--

CREATE TABLE `favorites` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `recipe_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `favorites`
--

INSERT INTO `favorites` (`id`, `user_id`, `recipe_id`) VALUES
(10, 10, 5),
(12, 10, 5),
(13, 10, 6),
(14, 2, 6);

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE `login` (
  `id` int(15) NOT NULL,
  `username` varchar(255) NOT NULL,
  `age` varchar(255) NOT NULL,
  `phone_number` varchar(11) NOT NULL,
  `nationality` varchar(255) NOT NULL,
  `gender` varchar(15) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `login`
--

INSERT INTO `login` (`id`, `username`, `age`, `phone_number`, `nationality`, `gender`, `password`) VALUES
(1, 'admin', '20', '09976757742', 'Philippines', 'male', '123'),
(2, 'chef2', '19', '09976757742', 'Philippines', 'Male', '123'),
(4, 'edden', '19', '09486362480', 'Philippines', 'female', '123'),
(5, 'jay', '19', '09283992062', 'Philippines', 'male', '123'),
(9, 'fwaf', '18', '09702239307', 'Filipino', 'male', '123'),
(10, 'chef', '18', '09802394922', 'Chinese', 'Male', 'jay');

-- --------------------------------------------------------

--
-- Table structure for table `recipes`
--

CREATE TABLE `recipes` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` varchar(1000) NOT NULL,
  `ingredients` text NOT NULL,
  `category` int(255) NOT NULL,
  `rating` float NOT NULL,
  `instructions` text NOT NULL,
  `author` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `recipes`
--

INSERT INTO `recipes` (`id`, `name`, `image`, `ingredients`, `category`, `rating`, `instructions`, `author`) VALUES
(5, 'Chocolate Chip Cookies', 'https://www.janespatisserie.com/wp-content/uploads/2016/02/IMG_7317.jpg', '1 cup unsalted butter, softened\r\n1 cup white sugar\r\n1 cup packed brown sugar\r\n2 eggs\r\n2 teaspoons vanilla extract\r\n3 cups all-purpose flour\r\n1 teaspoon baking soda\r\n2 teaspoons hot water\r\n1/2 teaspoon salt\r\n2 cups semisweet chocolate chips', 10, 10, 'Preheat the oven to 350Â°F (175Â°C).\r\nCream together the butter, white sugar, and brown sugar until smooth.\r\nBeat in the eggs one at a time, then stir in the vanilla.\r\nDissolve baking soda in hot water. Add to batter along with salt.\r\nStir in flour and chocolate chips.\r\nDrop by large spoonfuls onto ungreased pans.\r\nBake for about 10 minutes in the preheated oven, or until edges are nicely browned.', 2),
(6, 'Spaghetti Bolognese', 'https://www.ericlyons.co.uk/wp-content/uploads/2021/06/8K0A7866-2000x1333.jpg', '2 tablespoons olive oil\r\n1 onion, chopped\r\n2 garlic cloves, minced\r\n1 carrot, finely chopped\r\n1 celery stick, finely chopped\r\n1 pound ground beef\r\n1 can (28 ounces) crushed tomatoes\r\n2 tablespoons tomato paste\r\n1 cup beef broth\r\n1 teaspoon dried oregano\r\n1 teaspoon dried basil\r\nSalt and pepper to taste\r\n12 ounces spaghetti\r\nGrated Parmesan cheese (optional)', 8, 9.9, 'Heat the olive oil in a large skillet over medium heat. Add the onion, garlic, carrot, and celery. Cook until softened.\r\nAdd the ground beef and cook until browned.\r\nStir in the crushed tomatoes, tomato paste, beef broth, oregano, basil, salt, and pepper.\r\nReduce the heat and simmer for 30 minutes, stirring occasionally.\r\nCook the spaghetti according to package instructions. Drain.\r\nServe the Bolognese sauce over the spaghetti and sprinkle with Parmesan cheese if desired.\r\nLunch Recipe: Chicken Caesar Salad', 4),
(7, 'Chicken Caesar Salad', 'http://www.simplesweetsavory.com/wp-content/uploads/2016/04/Chicken-Caesar-Salad-wide.jpg', '2 chicken breasts\r\n2 tablespoons olive oil\r\nSalt and pepper to taste\r\n1 head of romaine lettuce, chopped\r\n1/2 cup Caesar dressing\r\n1/4 cup grated Parmesan cheese\r\n1 cup croutons\r\n1 lemon, cut into wedges', 11, 8.9, 'Preheat a grill or grill pan over medium heat.\r\nBrush the chicken breasts with olive oil and season with salt and pepper.\r\nGrill the chicken for about 5-7 minutes per side, or until fully cooked. Let cool, then slice.\r\nIn a large bowl, combine the lettuce, Caesar dressing, Parmesan cheese, and croutons.\r\nTop with the sliced chicken and serve with lemon wedges.\r\nBreakfast Recipe: Classic Pancakes', 4),
(8, 'Classic Pancakes', 'https://i0.wp.com/elizabethshome.com/wp-content/uploads/2013/03/Pancakes-9493.jpg?fit=1200%2C800&ssl=1', '1 cup all-purpose flour\r\n2 tablespoons sugar\r\n1 teaspoon baking powder\r\n1/2 teaspoon baking soda\r\n1/4 teaspoon salt\r\n1 cup buttermilk\r\n1 large egg\r\n2 tablespoons unsalted butter, melted\r\nButter or oil for the griddle\r\nMaple syrup and butter for serving', 12, 9.5, 'In a large bowl, whisk together the flour, sugar, baking powder, baking soda, and salt.\r\nIn another bowl, whisk together the buttermilk, egg, and melted butter.\r\nPour the wet ingredients into the dry ingredients and stir until just combined.\r\nHeat a griddle or non-stick skillet over medium heat and lightly grease with butter or oil.\r\nPour 1/4 cup of batter for each pancake onto the griddle.\r\nCook until bubbles form on the surface, then flip and cook until golden brown.\r\nServe warm with maple syrup and butter.', 5),
(9, 'Egg', 'https://th.bing.com/th/id/R.c13a39e0cd0fd3af053c6f1168581b9a?rik=6nc%2bUOyaNhmMxA&riu=http%3a%2f%2fwww.foodrepublic.com%2fwp-content%2fuploads%2f2013%2f02%2ffryanegg_anchor.jpg&ehk=eSWQ7hubf9FoIby7RqwsYrJ8%2bs5zg3LpEvJR316%2fHDY%3d&risl=&pid=ImgRaw&r=0', '1 table spoon of salt\r\nEgg', 12, 8.5, 'Inita ang oil', 5),
(10, 'Grilled Corn on the Cob', 'https://bing.com/th?id=OSK.c69eedb45e0563535699a1eeff0fa4f0', '6 Ears Corn\r\n\r\n6 Tablespoon butter, softened\r\nsalt and ground black pepper to taste\r\n', 16, 8.4, 'Step 1 Preheat an outdoor grill for high heat and lightly oil grate.\r\n\r\nStep 2. Peel back corn husk and remove silk.\r\n\r\nStep 3. Place 1 tablespoon butter, salt and pepper on each piece of corn. Close husks.\r\n\r\nStep 4. Wrap Each ear if corn tightly in aluminum foil.\r\n\r\n', 2),
(15, 'wwfaf', 'https://media1.popsugar-assets.com/files/thumbor/TAl3ppJPztqD8zoPnh-QFw3ePSw=/fit-in/525x800/filters:format_auto():upscale()/2013/01/05/1/192/1922664/70e2c08b0cb9ff8a_charlottes_web.JPG', 'wfaw', 16, 8.9, 'wafaw', 4),
(16, 'fawf', 'https://media1.popsugar-assets.com/files/thumbor/TAl3ppJPztqD8zoPnh-QFw3ePSw=/fit-in/525x800/filters:format_auto():upscale()/2013/01/05/1/192/1922664/70e2c08b0cb9ff8a_charlottes_web.JPG', 'wafaw', 16, 8.9, 'wafawf', 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_meal` (`meal_id`),
  ADD KEY `fk_user_id_7` (`user_id`);

--
-- Indexes for table `favorites`
--
ALTER TABLE `favorites`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_user_id_8` (`user_id`),
  ADD KEY `fk_recipe_id` (`recipe_id`);

--
-- Indexes for table `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `recipes`
--
ALTER TABLE `recipes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_cat` (`category`),
  ADD KEY `fk_author` (`author`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `favorites`
--
ALTER TABLE `favorites`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `login`
--
ALTER TABLE `login`
  MODIFY `id` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `recipes`
--
ALTER TABLE `recipes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `fk_meal` FOREIGN KEY (`meal_id`) REFERENCES `recipes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_user_id_7` FOREIGN KEY (`user_id`) REFERENCES `login` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `favorites`
--
ALTER TABLE `favorites`
  ADD CONSTRAINT `fk_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `recipes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_user_id_8` FOREIGN KEY (`user_id`) REFERENCES `login` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `recipes`
--
ALTER TABLE `recipes`
  ADD CONSTRAINT `fk_author` FOREIGN KEY (`author`) REFERENCES `login` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_cat` FOREIGN KEY (`category`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
