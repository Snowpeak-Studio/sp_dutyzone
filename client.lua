---[[ Variables ]]
client = {
    zones = {}
}
--- [[ Libraries / Modules]]
local Qbox = exports.qbx_core
local Config = require 'data.config'



---[[ Functions ]]

--- Function to handle entering a duty zone
--- @param self DutyZone
function OnEnter(self)
    if self.dutyType == 'exit' then
        return
    end
    if not Qbox:HasPrimaryGroup(self.group) then
        return
    end
    local result, message = lib.callback.await('sp_dutyzone:toggleDuty', 1000, self.group, 'on', self.name)
    if not result then
        return error(message or locale('error.duty_failed'))
    end
    local jobData = QBX.PlayerData.job
    lib.notify({
        title = locale('duty.title'),
        description = locale('duty.on', jobData?.label, jobData?.grade.name),
        type = 'success',
        position = 'top-right',
    })

end

--- Function to handle exiting a duty zone
--- @param self DutyZone
function OnExit(self)
    if self.dutyType == 'enter' then
        return
    end
    if not Qbox:HasPrimaryGroup(self.group) then
        return
    end
    local result, message = lib.callback.await('sp_dutyzone:toggleDuty', 1000, self.group, 'off', self.name)
    if not result then
        return error(message or 'Failed to toggle duty')
    end
    local jobData = QBX.PlayerData.job
    lib.notify({
        title = locale('duty.title'),
        description = locale('duty.off', jobData?.label, jobData?.grade.name),
        type = 'error',
        position = 'top-right',
    })
end

--- Function to check if the player is inside a duty zone Is a noop
--- @param self DutyZone
function inside(self) end

--- Initialization of the script to create the duty zones
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
            onEnter = OnEnter,
            onExit = OnExit,
            inside = inside,
        })
        client.zones[zone.name] = zone
    end
end

--- Function to handle cleanup when the resource stops
local function onStop()
    for _, zone in pairs(client.zones) do
        zone:remove()
    end
    client.zones = {}
end

---[[ Initialization ]]
AddEventHandler('onClientResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		   init()
	end
 
end)

--- [[ Cleanup ]]
AddEventHandler('onClientResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
        onStop()
	end
end)




