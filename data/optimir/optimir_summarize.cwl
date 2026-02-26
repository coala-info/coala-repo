cwlVersion: v1.2
class: CommandLineTool
baseCommand: optimir summarize
label: optimir_summarize
doc: "Summarize optimir results\n\nTool homepage: https://github.com/FlorianThibord/OptimiR"
inputs:
  - id: dir
    type: Directory
    doc: Full path of the directory containing results
    inputBinding:
      position: 101
      prefix: --dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/optimir:1.2--pyh5e36f6f_0
stdout: optimir_summarize.out
