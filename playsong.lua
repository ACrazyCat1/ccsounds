local dfpwm = require("cc.audio.dfpwm")
local speaker = peripheral.find("speaker")

file = http.get(arg[1],nil,true)

local decoder = dfpwm.make_decoder()
while true do
    chunk = file.read(16*1024)
    if chunk == nil then
        break
    end
    local buffer = decoder(chunk)

    while not speaker.playAudio(buffer) do
        os.pullEvent("speaker_audio_empty")
    end
    --io.read()
end

