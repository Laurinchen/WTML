require("WTML/Util");
require("tests/DEBUG");

function TestGetKeyOfValue()
    ---@type string[]
    local test_array = { 'a', 'b', 'c', 'd', 'e' }
    assert(GetKeyOfValue(test_array, 'c'):unwrap() == 3, "GetKeyOfValue(test_array, 'c'):unwrap() isn't 3")
    assert(GetKeyOfValue(test_array, 'f'):is_none(), "GetKeyOfValue(test_array, 'f') is Option<Some>")
end

function TestGetKeysOfValue()
    ---@type table<string, integer>
    local test_map = {
        a = 1,
        b = 2,
        c = 3,
        d = 2,
        e = 1,
        f = 2,
        g = 3,
        h = 2,
        i = 1,
    }
    ---@type string
    local expected_result = { b = true, d = true, f = true, h = true }

    ---@type string[]
    local test_result = GetKeysOfValue(test_map, 2):unwrap();

    for _, c in ipairs(test_result) do
        assert(expected_result[c] == true, "test result not in expected_result");
    end

    assert(GetKeysOfValue(test_map, 4):is_none(), "GetKeysOfValue(test_map, 4) is Option<Some>")
end

function TestHasKey()
    local test_map = {hello = false};
    assert(HasKey(test_map, "hello"), "test_map hasn't key 'hello'");
    assert(not HasKey(test_map, "bye"), "test_map has key 'bye'")
end