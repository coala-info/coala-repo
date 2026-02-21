cwlVersion: v1.2
class: CommandLineTool
baseCommand: lua
label: lua_Minetest
doc: "The provided text appears to be a system error log from a container runtime
  (Apptainer/Singularity) rather than help text for the tool. No command-line arguments,
  flags, or usage instructions were found in the input.\n\nTool homepage: https://github.com/luanti-org/luanti"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lua:5.3.4
stdout: lua_Minetest.out
