class CreateTables < ActiveRecord::Migration[5.0]
  def change
    execute <<-SQL
    	CREATE TABLE `users` (
        `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
        `isAdmin` tinyint(1) DEFAULT NULL,
        `points` int(11) DEFAULT 50,
        `encrypted_password` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
        `reset_password_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
        `reset_password_sent_at` datetime DEFAULT NULL,
        `remember_created_at` datetime DEFAULT NULL,
        `sign_in_count` int(11) NOT NULL DEFAULT '0',
        `current_sign_in_at` datetime DEFAULT NULL,
        `last_sign_in_at` datetime DEFAULT NULL,
        `current_sign_in_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
        `last_sign_in_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
        PRIMARY KEY (`username`),
        UNIQUE KEY `index_users_on_username` (`username`),
        UNIQUE KEY `index_users_on_reset_password_token` (`reset_password_token`)
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
      SQL
			
		execute <<-SQL
			CREATE TABLE `stuffs` (
     		`stuff_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
     		`stuff_description` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
     		`stuff_type` varchar(25) COLLATE utf8_unicode_ci,
     		`owner_username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
     		`pick_up_point` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
        `return_point` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
        `cost` int(11) DEFAULT 0,
        `availability` tinyint(1) DEFAULT NULL,
        `pick_up_time` datetime DEFAULT NULL,
        `return_time` datetime DEFAULT NULL,
        `create_time` datetime DEFAULT NOW(),
        `end_time` datetime DEFAULT NOW(),
        PRIMARY KEY (`create_time`, `owner_username`),
        FOREIGN KEY (`owner_username`) REFERENCES `users`(`username`) ON DELETE CASCADE ON UPDATE CASCADE,
        CONSTRAINT `stuff_type` CHECK (`stuff_type` IN ('tool', 'appliance', 'furniture', 'book'))
     	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
     	SQL

    execute <<-SQL
    	CREATE TABLE `bids` (
    		`stuff_create_time` datetime DEFAULT NOW(),
    		`owner_username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    		`bidder_username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    		`bidding_points` int(11) DEFAULT 50,
    		`status` tinyint(1) DEFAULT NULL,
    		`create_time` datetime DEFAULT NOW(),
        `update_time` datetime DEFAULT NOW(),
        PRIMARY KEY (`stuff_create_time`, `owner_username`, `bidder_username`),
        FOREIGN KEY (`stuff_create_time`) REFERENCES `stuffs`(`create_time`) ON DELETE CASCADE ON UPDATE CASCADE,
        FOREIGN KEY (`owner_username`) REFERENCES `stuffs`(`owner_username`) ON DELETE CASCADE ON UPDATE CASCADE,
        FOREIGN KEY (`bidder_username`) REFERENCES `users`(`username`) ON DELETE CASCADE ON UPDATE CASCADE
    	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
     	SQL

  end
end
