---@class (exact) Option
---@field _value? any
---@field expect fun(self, message: string): any
---@field unwrap fun(self): any
---@field unwrap_or fun(self, default: any): any
---@field unwrap_unchecked fun(self): any
---@field is_some fun(self): boolean
---@field is_none fun(self): boolean
---@field ok_or fun(self, default: any): Result

---@enum ResultEnumType
local ResultEnumType = {
    Ok = 0,
    Err = 1
}


---@class (exact) Result
---@field _value any
---@field _resultenumtype ResultEnumType
---@field expect fun(self, message: string): any
---@field unwrap fun(self): any
---@field unwrap_or fun(self, default: any): any
---@field unwrap_unchecked fun(self): any
---@field ok fun(self): Option
---@field err fun(self): Option
---@field is_ok fun(self): boolean
---@field is_err fun(self): boolean



---Rust Option Type, Use # to unwrap
---@param value? any
---@return Option
function CreateOption(value)
    ---@type Option
    local option = {
        _value = value,
        is_some = function(self)
            return self._value ~= nil;
        end,
        is_none = function(self)
            return self._value == nil;
        end,
        expect = function(self, message)
            if self:is_none() then
                error(message);
            end
            return self._value
        end,
        unwrap = function(self)
            return self:expect("Unwrapped Option without value");
        end,
        unwrap_or = function(self, default)
            if default == nil then
                error("a default must be given");
            end
            if self:is_none() then
                return default;
            else
                return self._value;
            end
        end,
        unwrap_unchecked = function(self)
            return self._value;
        end,
        ok_or = function(self, default)
            if default == nil then
                error("a default must be given");
            end
            if self:is_some() then
                return CreateResult(self._value);
            else
                return CreateResult(default, true);
            end
        end
    };

    ---@type metatable
    local optionMetatable = {
        ---@param t Option
        ---@return any
        __len = function(t)
            return t:unwrap();
        end,
        ---@param t Option
        ---@return string
        __tostring = function(t)
            if t:is_none() then
                return "Option<None>";
            else
                local val = t:unwrap_unchecked();
                if type(val) == "string" then
                    val = '"' .. val .. '"';
                end
                return "Option<" .. tostring(val) .. ">";
            end
        end
    }

    setmetatable(option, optionMetatable);

    return option;
end

---Rust Result type. Unwrap with #
---@param value any
---@param is_err? boolean
---@nodiscard
---@return Result
function CreateResult(value, is_err)
    if value == nil then
        error("CreateResult(value, is_err?) must be provided with an ok or error value");
    end
    if is_err == nil or type(is_err) ~= "boolean" then
        is_err = false;
    end

    ---@type ResultEnumType
    local resultenumtype;
    if is_err then
        resultenumtype = ResultEnumType.Err;
    else
        resultenumtype = ResultEnumType.Ok;
    end

    ---@type Result
    local result = {
        _value = value,
        _resultenumtype = resultenumtype,
        is_ok = function(self)
            return self._resultenumtype == ResultEnumType.Ok;
        end,
        is_err = function(self)
            return self._resultenumtype == ResultEnumType.Err;
        end,
        expect = function(self, message)
            if self:is_err() then
                error(message)
            end
            return self._value
        end,
        unwrap = function(self)
            return self:expect("Unwrapped Result with an error-value");
        end,
        unwrap_or = function(self, default)
            if default == nil then
                error("a default must be given");
            end
            if self:is_ok() then
                return self._value;
            else
                return default;
            end
        end,
        unwrap_unchecked = function(self)
            return self._value
        end,
        ok = function(self)
            if self:is_ok() then
                return CreateOption(self._value);
            else
                return CreateOption();
            end
        end,
        err = function(self)
            if self:is_err() then
                return CreateOption(self._value);
            else
                return CreateOption();
            end
        end
    }

    ---@type metatable
    local resultMetatable = {
        ---@param t Result
        ---@return any
        __len = function(t)
            return t:unwrap();
        end,
        ---@param t Result
        ---@return string
        __tostring = function(t)
            local val = t:unwrap_unchecked();
            if type(val) == "string" then
                val = '"' .. val .. '"';
            end
            if t:is_ok() then
                return "Ok<" .. tostring(val) .. ">";
            else
                return "Err<" .. tostring(val) .. ">";
            end
        end
    }


    setmetatable(result, resultMetatable);

    return result;
end

---@param t table
---@param v any
---@return Option
function GetKeyOfValue(t, v)
    local found_key = nil;
    for key, value in pairs(t) do
        if value == v then
            found_key = key;
            break;
        end
    end
    return CreateOption(found_key);
end

---@param t table
---@param v any
---@return Option
function GetKeysOfValue(t, v)
    ---@type any[]
    local found_keys = {};
    for key, value in pairs(t) do
        if value == v then
            table.insert(found_keys, key);
        end
    end
    if #found_keys == 0 then
        return CreateOption();
    else
        return CreateOption(found_keys);
    end
end

---@param t table
---@param key any
---@return boolean
function HasKey(t, key)
    return t[key] ~= nil
end