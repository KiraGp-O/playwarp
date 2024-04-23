### PlayWarp

![](https://github.com/thomas10-10/foo-Wallpaper-Feh-Gif/blob/master/desktop-animation2.gif)

**PlayWarp** is a wallpaper player for X11, allowing you to display videos as your desktop wallpaper. It supports various video formats including mp3, mp4, mov, YouTube URLs, and local directory paths.

## Features

- Play videos as wallpaper on X11 desktop.
- Supports a wide range of video formats.
- Option to loop videos.
- Configure opacity, audio playback, and more.
- Random or non-random playback from local directories.
- Integration with YouTube URLs.
- Lightweight and easy to use.

## Installation

To install PlayWarp, follow these steps:

1. Clone the repository to your local machine:

2. Go into the PlayWarp directory:
   
3. Run the setup script to install dependencies:
```bash

chmod a+r ./*
```
```bash
./installer
```

## Usage

PlayWarp provides various options to customize your wallpaper playback. Here are some common usage scenarios:

- Display a local video as wallpaper
- Play a YouTube video as wallpaper
- Configure opacity, audio playback, and other options using the configuration file (`warp.config`).
- For more advanced usage and configuration options, see the full documentation in the `README.md` file or run:

## Configuration

PlayWarp uses a configuration file (`warp.config`) to customize various aspects of wallpaper playback. You can edit this file to adjust settings such as loop behavior, audio playback, opacity, and more.

### Example Configuration

```ini
:loop : # Enable loop playback
:autrue # Enable audio playback
:value=0.9 # Set opacity to 90%
:Sb=0 # Sleep before the program starts
:SA=0 # Sleep after the program starts
:random # Enable random directory playback
```
# Contributing
Contributions are welcome! If you have any ideas, bug fixes, or improvements, feel free to open an issue or submit a pull request.

# License
This project is licensed under the MIT License.

# Author
Written by KiraGP-O.

# Bugs
If you encounter any bugs or issues, please report them on the GitHub issues page.

# Support
For support, questions, or feedback, please contact KiraGP-O.

Feel free to customize it further to better fit your project's specific features and requirements!
