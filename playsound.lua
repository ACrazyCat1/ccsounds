local dfpwm = require("cc.audio.dfpwm")
local speaker = peripheral.find("speaker")

url,volume = "https://github.com/ACrazyCat1/ccsounds/raw/main/"..string.gsub(arg[1]," ", "%%20")..".dfpwm",arg[2]

function playFromUrl(url, volume)
    local file = http.get(url, nil, true)
    local decoder = dfpwm.make_decoder()
    if file ~=nil then
        while true do
            chunk = file.read(16*1024)
            if chunk == nil then
                break
            end
            local buffer = decoder(chunk)

            while not speaker.playAudio(buffer, tonumber(volume)) do
                os.pullEvent("speaker_audio_empty")
            end
        end
    else
        print("File does not exist, Try checking the Url for spelling.")
    end
end

playFromUrl(url,volume)