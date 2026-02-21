cwlVersion: v1.2
class: CommandLineTool
baseCommand: qgrs
label: qgrs-cpp_qgrs
doc: "A tool for Quadruplex forming G-Rich Sequences (QGRS) analysis. Note: The provided
  help text contains only system execution logs and error messages, so no specific
  arguments could be extracted.\n\nTool homepage: https://github.com/freezer333/qgrs-cpp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qgrs-cpp:1.0--h503566f_5
stdout: qgrs-cpp_qgrs.out
