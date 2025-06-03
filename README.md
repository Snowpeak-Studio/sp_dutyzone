# SP Duty Zone

A FiveM resource that creates zones to toggle duty on/off for a specific group when entering/exiting a zone.

## Features
- Multiple types of duty toggle you can choose to only toggle duty on upon entering a zone
- You can also choose to have duty toggle off on exiting the zone
- Or you can have both where it will toggle duty on and off when entering/exiting.

## Dependencies

This resource requires the following dependencies:

- [qbx_core](https://github.com/Qbox-Project/qbx_core) - The core framework that provides player data and other essential functions
- [ox_lib](https://github.com/CommunityOx/ox_lib) - Library providing callback functions and UI components


## Installation

1. Ensure all dependencies are installed and working properly
2. Copy the `sp_dutyzone` folder to your server's resources directory
3. Add `ensure sp_dutyzone` to your server.cfg file after ensuring all dependencies
4. Configure the settings in the config.lua file to match your server's needs
5. Restart your server

## Configuration

The resource uses a configuration file (`config.lua`) where you can set up:

- Zones for specific groups/jobs to then toggle duty for them.

## 
Copyright © 2025 Snowpeak Studio https://github.com/Snowpeak-Studio

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see https://www.gnu.org/licenses/.