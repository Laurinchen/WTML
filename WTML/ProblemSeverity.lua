---@enum ProblemSeverityEnum
ProblemSeverityEnum = {
    other = 0,              -- not an actual problem
    style_convention = 1,   -- not affecting the behaviour of the problem
    warning = 2,            -- warnings that may be caused during development
    error = 3,              -- errors which fundamentally change how things are processed
    critical = 4,           -- errors which could make the Mod Crash. Not ignorable
};