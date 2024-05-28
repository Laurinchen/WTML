require("WTML/Util");
require("WTML/ProblemSeverity");
require("WTML/Tags");

---@class Position
---@field from integer
---@field to integer
---@field getLength fun(): integer

---@enum TokenType
TokenType = {
    Ampersand = "Ampersand",
    Attribute = "Attribute",
    AttributeValue = "AttributeValue",
    Entity = "Entity",
    Equal = "Equal",
    FSSContent = "FSSContent",
    GreaterThan = "GreaterThan",
    LessThan = "LessThan",
    Tag = "Tag",
    Text = "Text",
};

---@enum LexerProblemType
LexerProblemType = {
    meta_element_not_contained_in_head = {
        severity=ProblemSeverityEnum.style_convention,
        type="meta_element_not_contained_in_head",
        description="this meta element is not contained in a head element",
        how_to_fix="Move the meta element into a head element"
    },
    structure_element_not_contained_in_body = {
        severity=ProblemSeverityEnum.style_convention,
        type="structure_element_not_contained_in_body",
        description="this structure/UI element is not contained in a body element",
        how_to_fix="move the structure/UI element into a body element"
    },
    li_not_closed = {
        severity=ProblemSeverityEnum.warning,
        type="li_not_closed",
        description="<li> never has been closed. It may have been automatically closed at the wrong location",
        how_to_fix="Add a </li> tag"
    },
    no_outer_wtml = {
        severity=ProblemSeverityEnum.warning,
        type="no_outer_wtml",
        description="there's no wtml-pair containing everything",
        how_to_fix='add a surrounding <wtml version="...">...</wtml>',
    },
    unclosed_entity = {
        severity=ProblemSeverityEnum.warning,
        type="unclosed_entity",
        description="this entity is not closed",
        how_to_fix="this entity was not close. close it by adding a semicolon. If you meant to write a literal '&', escape it by writing '&amp;'"
    },
    unknown_attribute = {
        severity=ProblemSeverityEnum.warning,
        type="unknown_attribute",
        description="this attribute is not known",
        how_to_fix="add a 'data-' prefix, fix a spelling mistake or remove the unknown attribute"
    },
    governing_element_more_than_once = {
        severity=ProblemSeverityEnum.error,
        type="governing_element_more_than_once",
        description="this wtml, head or body element appeared more than once",
        how_to_fix="remove other governing elements of the same type"
    },
    governing_element_not_direct_child_of_wtml_element = {
        severity=ProblemSeverityEnum.error,
        type="governing_element_not_direct_child_of_wtml_element",
        description="this head or body element is not a direct child of a wtml element",
        how_to_fix="make the governing element child of a wtml child by moving it"
    },
    less_than_not_closed = {
        severity=ProblemSeverityEnum.error,
        type="less_than_not_closed",
        description="Another < or EOF was found before a closing >",
        how_to_fix="Add a > at the end of the tag"
    },
}




---@class Token
---@field position Position
---@field tokentype TokenType
---@field content? string

---@class LexerResult
---@field tokens Option
---@field problems Option

---@class Lexer
---@field peek fun(self, offset: integer): string
---@field tokenize fun(self)
---@field input string
---@field position integer
---@field buffer string