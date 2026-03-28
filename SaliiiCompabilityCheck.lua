local envs = {
    _G,
    getgenv and getgenv() or nil,
    getrenv and getrenv() or nil,
    getfenv and getfenv() or nil
}

local function find(path)
    for _, env in pairs(envs) do
        if env then
            local current = env
            local ok = true

            for part in string.gmatch(path, "[^%.]+") do
                local success, value = pcall(function()
                    return current[part]
                end)

                if success and value ~= nil then
                    current = value
                else
                    ok = false
                    break
                end
            end

            if ok then
                return current
            end
        end
    end
    return nil
end

local function safe_call(func, ...)
    if type(func) ~= "function" then return false, nil end
    return pcall(func, ...)
end

local tests = {

{
name = "loadstring",
test = function()
    local f = find("loadstring")
    if type(f) ~= "function" then return false end
    local success, fn = safe_call(f, "return 5")
    if not success or type(fn) ~= "function" then return false end
    local success2, result = safe_call(fn)
    return success2 and result == 5
end
},

{
name = "getgenv",
test = function()
    local f = find("getgenv")
    if type(f) ~= "function" then return false end
    local success, env = safe_call(f)
    return success and type(env) == "table"
end
},

{
name = "getrenv",
test = function()
    local f = find("getrenv")
    if type(f) ~= "function" then return false end
    local success, env = safe_call(f)
    return success and type(env) == "table"
end
},

{
name = "getfenv",
test = function()
    local f = find("getfenv")
    if type(f) ~= "function" then return false end
    local success, env = safe_call(f)
    return success and type(env) == "table"
end
},

{
name = "hookfunction",
test = function()
    local hook = find("hookfunction") or find("hook_func") or (find("detours") and find("detours").hook)
    if type(hook) ~= "function" then return false end
    local original = function() return 1 end
    local success, hooked = safe_call(hook, original, function() return 2 end)
    if not success or type(hooked) ~= "function" then return false end
    local success2, result = safe_call(original)
    return success2 and result == 2
end
},

{
name = "newcclosure",
test = function()
    local f = find("newcclosure") or find("cclosure") or find("create_closure")
    if type(f) ~= "function" then return false end
    local success, closure = safe_call(f, function() return true end)
    return success and type(closure) == "function"
end
},

{
name = "getrawmetatable",
test = function()
    local f = find("getrawmetatable")
    if type(f) ~= "function" then return false end
    local success, mt = safe_call(f, {})
    return success and type(mt) == "table"
end
},

{
name = "setrawmetatable",
test = function()
    local f = find("setrawmetatable")
    if type(f) ~= "function" then return false end
    local obj = {}
    local success, result = safe_call(f, obj, {})
    return success and (result == obj or result == nil)
end
},

{
name = "checkcaller",
test = function()
    local f = find("checkcaller") or find("is_caller")
    if type(f) ~= "function" then return false end
    local success, result = safe_call(f)
    return success and type(result) == "boolean"
end
},

{
name = "islclosure",
test = function()
    local f = find("islclosure") or find("is_l_closure")
    if type(f) ~= "function" then return false end
    local success, result = safe_call(f, function() end)
    return success and type(result) == "boolean"
end
},

{
name = "iscclosure",
test = function()
    local f = find("iscclosure") or find("is_c_closure") or find("iscfunction")
    if type(f) ~= "function" then return false end
    local success, result = safe_call(f, print)
    return success and type(result) == "boolean"
end
},

{
name = "request",
test = function()
    local req = find("request") or find("http_request") or find("http_get") or find("http_post")
    if type(req) == "function" then return true end
    local syn = find("syn")
    if syn and type(syn.request) == "function" then return true end
    local fluxus = find("fluxus")
    if fluxus and type(fluxus.request) == "function" then return true end
    return false
end
},

{
name = "setclipboard",
test = function()
    local f = find("setclipboard") or find("set_clipboard") or find("toclipboard")
    if type(f) == "function" then 
        local success = safe_call(f, "test")
        return success
    end
    return false
end
},

{
name = "Drawing",
test = function()
    local D = find("Drawing") or find("drawing")
    if type(D) ~= "table" and type(D) ~= "function" then return false end
    if type(D) == "table" and type(D.new) == "function" then
        local success, obj = safe_call(D.new, "Line")
        return success and obj ~= nil
    elseif type(D) == "function" then
        local success, obj = safe_call(D, "Line")
        return success and obj ~= nil
    end
    return false
end
},

{
name = "syn namespace",
test = function()
    local syn = find("syn") or find("Synapse") or find("synapse")
    return type(syn) == "table"
end
},

{
name = "syn.protect_gui",
test = function()
    local syn = find("syn") or find("Synapse")
    return syn and type(syn.protect_gui) == "function"
end
},

{
name = "syn.queue_on_teleport",
test = function()
    local syn = find("syn") or find("Synapse")
    if syn and type(syn.queue_on_teleport) == "function" then return true end
    local qot = find("queue_on_teleport") or find("queueonteleport")
    return type(qot) == "function"
end
},

{
name = "identifyexecutor",
test = function()
    local f = find("identifyexecutor") or find("getexecutorname")
    if type(f) ~= "function" then return false end
    local success, name = safe_call(f)
    return success and type(name) == "string" and #name > 0
end
},

{
name = "firetouchinterest",
test = function()
    local f = find("firetouchinterest")
    if type(f) ~= "function" then return false end
    return true
end
},

{
name = "getnamecallmethod",
test = function()
    local f = find("getnamecallmethod")
    if type(f) ~= "function" then return false end
    local success, method = safe_call(f)
    return success
end
},

{
name = "setnamecallmethod",
test = function()
    local f = find("setnamecallmethod")
    return type(f) == "function"
end
},

{
name = "getgc",
test = function()
    local f = find("getgc")
    if type(f) ~= "function" then return false end
    local success, gc = safe_call(f)
    return success and type(gc) == "table"
end
},

{
name = "getinstances",
test = function()
    local f = find("getinstances") or find("get_instances")
    if type(f) ~= "function" then return false end
    local success, instances = safe_call(f)
    return success and type(instances) == "table"
end
},

{
name = "getnilinstances",
test = function()
    local f = find("getnilinstances") or find("get_nil_instances")
    if type(f) ~= "function" then return false end
    local success, instances = safe_call(f)
    return success and type(instances) == "table"
end
},

{
name = "getscripts",
test = function()
    local f = find("getscripts") or find("get_scripts")
    return type(f) == "function"
end
},

{
name = "getrunningscripts",
test = function()
    local f = find("getrunningscripts") or find("get_running_scripts")
    return type(f) == "function"
end
},

{
name = "getthreadcontext",
test = function()
    local f = find("getthreadcontext")
    if type(f) ~= "function" then return false end
    local success, ctx = safe_call(f)
    return success and type(ctx) == "number"
end
},

{
name = "setthreadcontext",
test = function()
    local f = find("setthreadcontext")
    return type(f) == "function"
end
},

{
name = "getcallingscript",
test = function()
    local f = find("getcallingscript") or find("get_calling_script")
    return type(f) == "function"
end
},

{
name = "getoriginalexecutor",
test = function()
    local f = find("getoriginalexecutor") or find("get_executor")
    return type(f) == "function"
end
},

{
name = "gethui",
test = function()
    local f = find("gethui") or find("get_hui")
    if type(f) ~= "function" then return false end
    local success, hui = safe_call(f)
    return success and type(hui) == "table"
end
},

{
name = "getcustomasset",
test = function()
    local f = find("getcustomasset") or find("get_custom_asset")
    return type(f) == "function"
end
},

{
name = "queueonteleport",
test = function()
    local f = find("queueonteleport") or find("queue_on_teleport")
    return type(f) == "function"
end
},

{
name = "rconsoleprint",
test = function()
    local f = find("rconsoleprint") or find("console_print")
    return type(f) == "function"
end
},

{
name = "rconsoleclear",
test = function()
    local f = find("rconsoleclear") or find("console_clear")
    return type(f) == "function"
end
},

{
name = "writefile",
test = function()
    local f = find("writefile") or find("write_file")
    return type(f) == "function"
end
},

{
name = "readfile",
test = function()
    local f = find("readfile") or find("read_file")
    return type(f) == "function"
end
},

{
name = "appendfile",
test = function()
    local f = find("appendfile") or find("append_file")
    return type(f) == "function"
end
},

{
name = "listfiles",
test = function()
    local f = find("listfiles") or find("list_files")
    return type(f) == "function"
end
},

{
name = "isfile",
test = function()
    local f = find("isfile") or find("is_file")
    return type(f) == "function"
end
},

{
name = "isfolder",
test = function()
    local f = find("isfolder") or find("is_folder")
    return type(f) == "function"
end
},

{
name = "makefolder",
test = function()
    local f = find("makefolder") or find("make_folder")
    return type(f) == "function"
end
},

{
name = "delfolder",
test = function()
    local f = find("delfolder") or find("del_folder")
    return type(f) == "function"
end
},

{
name = "delfile",
test = function()
    local f = find("delfile") or find("del_file")
    return type(f) == "function"
end
},

{
name = "getsenv",
test = function()
    local f = find("getsenv")
    if type(f) ~= "function" then return false end
    local success, env = safe_call(f, 1)
    return success and type(env) == "table"
end
},

{
name = "getrenv",
test = function()
    local f = find("getrenv")
    if type(f) ~= "function" then return false end
    local success, env = safe_call(f)
    return success and type(env) == "table"
end
},

{
name = "getgenv",
test = function()
    local f = find("getgenv")
    if type(f) ~= "function" then return false end
    local success, env = safe_call(f)
    return success and type(env) == "table"
end
},

{
name = "getreg",
test = function()
    local f = find("getreg")
    if type(f) ~= "function" then return false end
    local success, reg = safe_call(f)
    return success and type(reg) == "table"
end
},

{
name = "cloneref",
test = function()
    local f = find("cloneref") or find("clone_ref")
    return type(f) == "function"
end
}

}

local supported = 0
local failed = 0
local total = #tests

print("Running FULL sUNC benchmark...\n")

for _, t in ipairs(tests) do
    local ok, result = pcall(t.test)

    if ok and result then
        supported = supported + 1
        print("(passed :D): " .. t.name)
    else
        failed = failed + 1
        print("(not supported :c): " .. t.name)
    end
end

print("\nYour executor got:")
print("-===============-")
print("Supported: " .. supported .. " out of " .. total)
print("Failed: " .. failed)
local percent = math.floor((supported / total) * 100)
print("Compatibility: " .. percent .. "%")

if percent >= 95 then
    print("Grade: S+ (Exceptional executor)")
elseif percent >= 90 then
    print("Grade: S (Top-tier executor)")
elseif percent >= 80 then
    print("Grade: A+ (Very good executor)")
elseif percent >= 75 then
    print("Grade: A (Good executor)")
elseif percent >= 65 then
    print("Grade: B+ (Decent executor)")
elseif percent >= 55 then
    print("Grade: B (Average executor)")
elseif percent >= 45 then
    print("Grade: C (Below average)")
elseif percent >= 30 then
    print("Grade: D (Limited support)")
else
    print("Grade: F (Very limited support)")
end
