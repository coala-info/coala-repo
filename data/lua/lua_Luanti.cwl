cwlVersion: v1.2
class: CommandLineTool
baseCommand: lua
label: lua_Luanti
doc: "Lua is a powerful, efficient, lightweight, embeddable scripting language. (Note:
  The provided help text contains only system error messages and no usage information.)\n
  \nTool homepage: https://github.com/luanti-org/luanti"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lua:5.3.4
stdout: lua_Luanti.out
