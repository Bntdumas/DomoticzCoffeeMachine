local stringParsing = {}

-- returns true if the string "str" starts with "starts" 
function stringParsing.stringStarts(str, starts)
   return string.sub(str, 1, string.len(starts)) == starts
end

-- remove "string" at the beginning of "command"
function stringParsing.removeSubString(string, command)
    return string.gsub(string, command, "")
end

return stringParsing
