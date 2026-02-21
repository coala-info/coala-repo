cwlVersion: v1.2
class: CommandLineTool
baseCommand: qgrs-cpp
label: qgrs-cpp
doc: "QGRS-cpp is a tool for identifying and analyzing Quadruplex forming G-Rich Sequences
  (QGRS). (Note: The provided input text contains container build error logs and does
  not include the tool's help documentation; therefore, no arguments could be extracted.)\n
  \nTool homepage: https://github.com/freezer333/qgrs-cpp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qgrs-cpp:1.0--h503566f_5
stdout: qgrs-cpp.out
