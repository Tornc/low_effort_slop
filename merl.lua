--[[ CONSTANTS ]]

local INIT_URL = "https://xsva.support.xboxlive.com/initialize_conversation"
local CHAT_URL = "https://xsva.support.xboxlive.com/chat"
local INIT_PAYLOAD = {
    clientId = "MINECRAFT_HELP",
    conversationId = nil,
    forceReset = false,
    greeting =
    "Hi there! I'm Merl, your helpful Minecraft Support Virtual Agent (in Beta), powered by AI!", -- Omitted the yap
    locale = "en-US",
    country = "US"
}

--[[ STATE ]]

local conversation_id, etag, persona_id, merl_resp_str, raw_response

local function send_init()
    local init_request = http.post(
        INIT_URL,
        textutils.serializeJSON(INIT_PAYLOAD),
        { ["Content-Type"] = "application/json" }
    )
    local init_response = textutils.unserializeJSON(init_request.readAll())
    init_request.close()
    return
        init_response["conversationId"],
        init_response["eTag"],
        init_response["customizationSelections"]["personaId"],
        init_response["history"][1]["response"][1]["text"]
end

local function send_chat(cid, et, text)
    local chat_payload = {
        conversationId = cid,
        eTag = et,
        text = text,
        customizationSelections = { personaId = persona_id },
    }
    local chat_request = http.post(
        CHAT_URL,
        textutils.serializeJSON(chat_payload),
        { ["Content-Type"] = "application/json" }
    )
    local chat_response = textutils.unserializeJSON(chat_request.readAll())
    chat_request.close()
    return chat_response
end

local function format_response_text(raw_resp)
    local parts = {}
    for _, v in ipairs(raw_resp["response"]) do
        if v["text"] then
            table.insert(parts, v["text"])
        elseif v["list"] then
            for _, vv in ipairs(v["list"]) do
                table.insert(parts, vv["text"])
            end
        end
    end
    return table.concat(parts, "\n")
end

conversation_id, etag, persona_id, merl_resp_str = send_init()

while true do
    print(merl_resp_str)

    term.write("> ")
    local text = read()

    raw_response = send_chat(conversation_id, etag, text)
    etag = raw_response["eTag"]
    merl_resp_str = format_response_text(raw_response)
end
