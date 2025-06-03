---@class DutyZone
---@field name string The name of the duty zone
---@field group string The group this duty zone belongs to
---@field dutyType string The type of duty this zone is for ('enter', 'exit', 'both')
---@field points vector2[] The points that define the duty zone
---@field debug boolean Whether to enable debug mode for the zone
---@field onEnter? function Callback function when entering the zone
---@field onExit? function Callback function when exiting the zone
---@field inside? function Callback function to check if the player is inside the zone

