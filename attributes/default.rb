include_attribute "paco"
include_attribute "mecab"

default["groonga"]["version"] = "3.0.0"
default["groonga"]["package"] = "groonga-#{default["groonga"]["version"]}"
default["groonga"]["root"]    = "/usr/local/#{default["groonga"]["package"]}"
