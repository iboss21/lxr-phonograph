CREATE TABLE IF NOT EXISTS `phonographs` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `owner_identifier` varchar(255) DEFAULT NULL,
  `owner_charid` int(11) DEFAULT NULL,
  `x` double DEFAULT NULL,
  `y` double DEFAULT NULL,
  `z` double DEFAULT NULL,
  `rot_x` double DEFAULT NULL,
  `rot_y` double DEFAULT NULL,
  `rot_z` double DEFAULT NULL,
  PRIMARY KEY (`id`)
);


INSERT IGNORE INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `metadata`, `desc`, `weight`) VALUES
("lxr_phonograph", "Antique Phonograph", 200, 1, "item_standard", 1, "{}", "An antique phonograph used to play music. Place it on the ground to enjoy period sounds.", 15);
