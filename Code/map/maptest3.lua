return {
  version = "1.1",
  luaversion = "5.1",
  orientation = "orthogonal",
  width = 25,
  height = 15,
  tilewidth = 48,
  tileheight = 48,
  properties = {},
  tilesets = {
    {
      name = "fond",
      firstgid = 1,
      tilewidth = 32,
      tileheight = 32,
      spacing = 2,
      margin = 0,
      image = "../image/fond.png",
      imagewidth = 1200,
      imageheight = 720,
      transparentcolor = "#ffffff",
      properties = {},
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "Calque de Tile 1",
      x = 0,
      y = 0,
      width = 25,
      height = 15,
      visible = true,
      opacity = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      name = "wall",
      visible = true,
      opacity = 1,
      properties = {},
      objects = {
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 1200,
          height = 48,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 48,
          width = 48,
          height = 672,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 48,
          y = 672,
          width = 1152,
          height = 48,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1152,
          y = 48,
          width = 48,
          height = 624,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      name = "spawn",
      visible = true,
      opacity = 1,
      properties = {},
      objects = {
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 816,
          y = 192,
          width = 48,
          height = 48,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      name = "key",
      visible = true,
      opacity = 1,
      properties = {},
      objects = {
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 1104,
          y = 624,
          width = 48,
          height = 48,
          visible = true,
          properties = {
            ["id"] = "7",
            ["open"] = "107"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 144,
          y = 624,
          width = 48,
          height = 48,
          visible = true,
          properties = {
            ["id"] = "6",
            ["open"] = "106"
          }
        }
      }
    },
    {
      type = "objectgroup",
      name = "door",
      visible = true,
      opacity = 1,
      properties = {},
      objects = {
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 144,
          y = 96,
          width = 96,
          height = 48,
          visible = true,
          properties = {
            ["id"] = "107",
            ["teleport"] = "maptest2#1"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 960,
          y = 96,
          width = 96,
          height = 48,
          visible = true,
          properties = {
            ["id"] = "106",
            ["teleport"] = "maptest1#2"
          }
        }
      }
    },
    {
      type = "objectgroup",
      name = "switch",
      visible = true,
      opacity = 1,
      properties = {},
      objects = {}
    },
    {
      type = "objectgroup",
      name = "magic",
      visible = true,
      opacity = 1,
      properties = {},
      objects = {}
    }
  }
}
