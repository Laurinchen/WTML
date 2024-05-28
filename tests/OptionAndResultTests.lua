require("WTML/Util");
require("tests/DEBUG");

function TestOption()
    -- Empty
    ---@type Option
    local testobj = CreateOption();

    -- Option.unwrap_or
    assert(testobj:unwrap_or(10) == 10, "testobj:unwrap_or(10) is not 10");
    -- Option.unwrap_unchecked
    assert(testobj:unwrap_unchecked() == nil, "value in testobj not nil");
    -- Option.is_some
    assert(not testobj:is_some(), "testobj is some");
    -- Option.is_none
    assert(testobj:is_none(), "testobj is not none");

    ---@type string
    local error_string = "Successfully error'd";

    -- Option.expect
    ---@type boolean, string
    local success, resulting_error = pcall(testobj.expect, testobj, error_string);
    assert(not success, "success is true");
    assert(IsErrorMessageEqual(resulting_error, error_string),
        "Resulting Error doesn't end with \"" .. error_string .. '" (Full string: "' .. resulting_error .. '"');

    -- Option.unwrap
    ---@type boolean, _
    success, _ = pcall(testobj.unwrap, testobj);
    assert(not success, "success is true");

    -- With value
    ---@type number
    local optionvalue = 123
    testobj = CreateOption(optionvalue)

    -- Option.expect
    assert(testobj:expect("Error!") == optionvalue, "testobj:expect(...) isn't optionvalue");
    -- Option.unwrap
    assert(testobj:unwrap() == optionvalue, "testobj:unwrap() isn't optionvalue");
    -- Option.unwrap_or
    assert(testobj:unwrap_or(false) == optionvalue, "testobj:unwrap_or(...) isn't optionvalue")
    -- Option.unwrap_unchecked
    assert(testobj:unwrap_unchecked() == optionvalue, "value in testobj isn't optionvalue");
    -- Option.is_some
    assert(testobj:is_some(), "testobj is not some");
    -- Option.is_none
    assert(not testobj:is_none(), "testobj is none");
    -- #Option
    assert(#testobj == optionvalue, "#testobj isn't optionvalue");
end

function TestResult()
    -- Has value
    ---@type number
    local result_ok_value = 123;
    ---@type Result
    local testobj = CreateResult(result_ok_value);
    
    -- Result.expect
    assert(testobj:expect("Error!") == result_ok_value, "testobj:expect(...) isn't result_ok_value");
    -- Result.unwrap
    assert(testobj:unwrap() == result_ok_value, "testobj:unwrap() isn't result_ok_value");
    -- #Result
    assert(#testobj == result_ok_value, "#testobj isn't result_ok_value");
    -- Result.unwrap_or
    assert(testobj:unwrap_or(false) == result_ok_value, "testobj:unwrap_or(...) isn't result_ok_value")
    -- Result.unwrap_unchecked
    assert(testobj:unwrap_unchecked() == result_ok_value, "testobj:unwrap_unchecked() isn't result_ok_value");
    -- Result.ok
    assert(#testobj:ok() == result_ok_value, "testobj:ok() isn't Option<result_ok_value>");
    -- Result.err
    assert(testobj:err():is_none(), "testobj:err() isn't Option<None>");
    -- Result.is_ok
    assert(testobj:is_ok(), "testobj is not ok");
    -- Result.is_err
    assert(not testobj:is_err(), "testobj is err");
    -- Option.ok_or    
    assert(testobj:ok():ok_or(false):unwrap() == result_ok_value, "Result<Ok> -> Option<result_ok_value> -> Result<ok> circle doesn't yield result_ok_value");

    -- Has error
    local result_err_value = -123;
    testobj = CreateResult(result_err_value, true)


    -- Result.unwrap_or
    assert(testobj:unwrap_or(10) == 10, "testobj:unwrap_or(10) is not 10");
    -- Result.unwrap_unchecked
    assert(testobj:unwrap_unchecked() == result_err_value, "testobj:unwrap_unchecked() is not result_err_type");
    -- Result.ok
    assert(testobj:ok():is_none(), "testobj:ok() isn't Option<None>");
    -- Result.err
    assert(#testobj:err() == result_err_value, "testobj:err() isn't Option<result_err_value>");
    -- Result.is_ok
    assert(not testobj:is_ok(), "testobj is ok");
    -- Result.is_err
    assert(testobj:is_err(), "testobj is not err");
    -- Option.ok_or
    assert(testobj:ok():ok_or(10):err():unwrap() == 10, "Result<Err> -> Ok<10> -> Result<Err> doesn't yield 10")

    ---@type string
    local error_string = "Successfully error'd";

    -- Option.expect
    ---@type boolean, string
    local success, resulting_error = pcall(testobj.expect, testobj, error_string);
    assert(not success, "success is true");
    assert(IsErrorMessageEqual(resulting_error, error_string),
        "Resulting Error doesn't end with \"" .. error_string .. '" (Full string: "' .. resulting_error .. '"');

    -- Option.unwrap
    ---@type boolean, _
    success, _ = pcall(testobj.unwrap, testobj);
    assert(not success, "success is true");
end
