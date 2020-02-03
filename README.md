# zoomcli

This is a somewhat useless CLI app written in Ruby. It allows a user to keep track of their video game library using yaml database files. 


## Running the app

To run the app, simply use `./exe/zoomcli run`. This will start up the app and bring you to the main menu.

### Listing games
• Can be viewed by loaded platforms, or a dump of all games.

### Add games
• Add by title and platform. Name must be present, and date must parse properly. 
• Date should be entered as `YYYY-MM-DD` and be after Dec 31, 1969.

### Remove game
•Enter a title to be removed. This will remove all games with this title. This removes from yaml db not just runtime so only use to remove if you're sure.

### Search game
• Returns all games matching title.

### Find Game
Coming soon! 

## Loading sample data

Loading sample data can be done by running the command  `./exe/zoomcli samples`. Samples cannot be loaded if DB has data currently loaded. Clear DB before loading samples.

## Contributing

PRs welcome.

## Disclamer

This is a course work app. It's not meant to be used seriously. It is most likely full of holes and errors.

