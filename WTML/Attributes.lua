---@enum AttributeTypes
AttributeTypes = {
    String = 0,
    Selector= 1,
    Real = 2,
    FullNumber = 3,
    Boolean = 4,
}

---@enum Attributes
Attributes = {
    width = {
        name = "width",
        type = AttributeTypes.FullNumber,
    },
    height = {
        name = "height",
        type = AttributeTypes.FullNumber,
    },
}
Attributes["scroll-x"] = {
    name = "scroll-x",
    type = AttributeTypes.Boolean,
}

Attributes["scroll-y"] = {
    name= "scroll-y",
    type = AttributeTypes.Boolean,
}