module(..., package.seeall)
function _16to10(str)
    return string.format("%d",str)
end

function _10to16(str)
    return string.format("%#x",str)
end