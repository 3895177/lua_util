module(..., package.seeall)
function print_data(data,unvalue)
    local tyep_string = type(data)
    print("TYPE:"..tyep_string)
    if not unvalue then

        if tyep_string ~= "table" then
            print("VALUE:"..data)
        else
            print("VALUE:")
            serialize(data,2)
        end

    end
end

function serialize(o, n)
    -- if o ~= nil then
    --       return
    -- end
    if type(o) == "number" then
            io.write(o)
    elseif type(o) == "boolean" then
            io.write((o and "true") or "false")
    elseif type(o) == "string" then
            io.write(string.format("%q", o))
    elseif type(o) == "table" then
            io.write("{\n")
            for k,v in pairs(o) do
                    io.write(string.rep("   ", n) .. "[")
                    serialize(k, n + 1)
                    io.write("] = ")
                    serialize(v, n + 1)
                    io.write(",\n")
            end
    io.write("}")
    else
            error("cannot serialize a " .. type(o))
    end
end
