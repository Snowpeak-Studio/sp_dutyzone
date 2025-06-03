---[[ Variables ]]
server = {
    zones = {}
}

--- [[ Libraries / Modules]]
local Config = require 'data.config'
local Qbox = exports.qbx_core

--- [[ Functions ]]

--- Function to get zone server side
--- @param name string
--- @return DutyZone|nil
local function getZone(name)
    if not name or not server.zones[name] then
        return nil
    end
    return server.zones[name]
end

--- Function that initalizes and creates zones server side for checks.
local function init()
    for i = 1, #Config.zones do
        local location = Config.zones[i]
        if not location.points or not location.group then
            print(locale('error.invalid_config', i))
        end
        ---@type DutyZone
        local zone = lib.zones.poly({
            name = 'sp_duty_zone_' .. location.group,
            group = location.group,
            dutyType = location.dutyType or 'both',
            points = location.points,
            thickness = location.thickness or 1.0,
            debug = Config.debug,
        })
        server.zones[zone.name] = zone
    end
end

--- [[ Callbacks ]]
lib.callback.register('sp_dutyzone:toggleDuty', function(source, group, dutyType, zoneName)
    local source = source
    -- Check if parameters are valid
    if not source or not group or not dutyType or not zoneName then
        return false, locale('error.invalid_parameters')
    end
    -- Check if job exists
    local jobExists = Qbox:GetJob(group)
    if not jobExists then
        return false, locale('error.invalid_job', group)
    end
    -- Check if player exists and get it.
    local character = Qbox:GetPlayer(source)
    if not character then
        return false, locale('error.invalid_player', source)
    end
    -- Check if parameters are valid
    if not source or not group or not dutyType or not zoneName then
        return false, locale('error.invalid_parameters')
    end
    -- Check if player has the primary group
    if not Qbox:HasPrimaryGroup(source, group) then
        return false, locale('error.invalid_group_permission', group)
    end
    -- Grab players groups and grade
    local groups = Qbox:GetGroups(source)
    local grade
    if groups[group] then
        grade = groups[group]
    else
        return false, locale('error.invalid_job', group)
    end
    -- Check if the zone exists and if the player is in it
    local zone = getZone(zoneName)
    if not zone then
        return false, locale('error.invalid_zone', zoneName)
    end
    if zone then
        -- Get the player's coordinates
        local coords = vec3(character.PlayerData.position.x, character.PlayerData.position.y,
            character.PlayerData.position.z)
        -- Check if the zone group is valid
        if not groups or not groups[zone.group] then
            return false, locale('error.invalid_group_zone', zone.group, zone.name)
        end
        -- Check if the player is in the zone
        if zone:contains(coords) then
            -- If the player is in the zone, toggle the duty
            Qbox:SetJob(source, group, grade)
            if dutyType == 'on' then
                -- If the duty type is 'on', set the job duty to true
                Qbox:SetJobDuty(source, true)
                return true, locale('duty.toggled_on', source, group, grade)
            elseif dutyType == 'off' then
                -- If the duty type is 'off', set the job duty to false
                Qbox:SetJobDuty(source, false)
                return true, locale('duty.toggled_off', source, group, grade)
            else
                -- If the duty type is invalid, return an error
                return false, locale('error.invalid_duty_type', dutyType)
            end
        else
            -- If the player is not in the zone, return an error
            return false, locale('error.not_in_zone')
        end
    end
end)

init()
