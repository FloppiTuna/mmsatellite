_G.WORKING_DIR = "/" .. fs.getDir(shell.getRunningProgram())

print(require(_G.WORKING_DIR .. "/data/splash"))

-- open rednet modem and begin broadcasting

rednet.open("top")

local isReady = false
local sourceComputerId = nil

while not isReady do
    rednet.broadcast("satellite_announce")
    local senderId, message, protocol = rednet.receive(5)
    
    if message == "satellite_ack" then
        sourceComputerId = senderId
        print("Connected to source computer ID " .. tostring(sourceComputerId))
        isReady = true
    end
end

