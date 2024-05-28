--- <NAME> = required (NAME should be replaced by an actual name)
--- [...] = (optional) content
---         + = once or more
---         * = zero or more
---         ? = zero or once
--- abc...=,;"{} = literals (required)
--- --... = comment, shall be ignored
--- 
---
--- ---@enum <CATEGORY>Tags
--- <CATEGORY> = {
---     [
---     <TAGNAME> = {
---         name = "<TAGNAME>",
---         tag_special_attributes = {
---             [TagSpecialAttributes.<TAG_ATTRIBUTE>,]*
---         },
---         [
---         required_attributes = {
---             ["<ATTRIBUTE>",]+
---         },
---         ]?
---         [
---         disallowed_attributes = {
---             ["<ATTRIBUTE>",]+
---         },
---         ]?
---         [
---         allowed_attributes = {
---             ["<ATTRIBUTE>",]+
---             -- data-* attributes are always allowed
---         },
---         ]?
---     },
---     ]+
--- };

require("WTML/Attributes");

---@enum TagSpecialAttributes
TagSpecialAttributes = {
    SelfClosing = 0,                    -- a slash is required by styling convention, like this: <... />
    InsertsClosingTagAutomatically = 1, -- <li> for example - omitting a closing tag is still against styling convention
    NeedsAtLeastOneAttribute = 2,
};



---@enum GoverningTags
GoverningTags = {
    body = {
        name = "body",
        tag_special_attributes ={

        },
    },
    head = {
        name = "head",
        tag_special_attributes = {

        },
    },
    wtml = {
        name = "wtml",
        tag_special_attributes = {

        },
        required_attributes = {
            "version"
        },
    },
};

---@enum MetaTags
MetaTags = {
    fss = {
        name="fss",
        tag_special_attributes = {

        },
        allowed_attributes = {

        },
    },
    dimension = {
        name="dimension",
        tag_special_attributes = {
            TagSpecialAttributes.NeedsAtLeastOneAttribute,
        },
        allowed_attributes = {
            
        },
    },
    scrollable = {
        name="scrollable",
    },
};

---@enum StructureTags
StructuralTags = {

};