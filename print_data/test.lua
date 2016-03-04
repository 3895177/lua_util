local pd = require "print_data"

local function gen_raw_octets()
    local chars = {}
    for i = 0, 255 do chars[i + 1] = string.char(i) end
    return table.concat(chars)
end

local function gen_utf16_escaped()
    -- Create raw table escapes
    local utf16_escaped = {}
    local count = 0

    local function append_escape(code)
        local esc = ('\\u%04X'):format(code)
        table.insert(utf16_escaped, esc)
    end

    table.insert(utf16_escaped, '"')
    for i = 0, 0xD7FF do
        append_escape(i)
    end
    -- Skip 0xD800 - 0xDFFF since they are used to encode supplementary
    -- codepoints
    for i = 0xE000, 0xFFFF do
        append_escape(i)
    end
    -- Append surrogate pair for each supplementary codepoint
    for high = 0xD800, 0xDBFF do
        for low = 0xDC00, 0xDFFF do
            append_escape(high)
            append_escape(low)
        end
    end
    table.insert(utf16_escaped, '"')

    return table.concat(utf16_escaped)
end


pd.print_data(gen_utf16_escaped(),true)
