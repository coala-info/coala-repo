cwlVersion: v1.2
class: CommandLineTool
baseCommand: halRemoveDupes
label: hal2vg_halRemoveDupes
doc: "The provided text does not contain help information or a description of the
  tool. It contains system log messages indicating a failure to build or run a container
  due to insufficient disk space.\n\nTool homepage: https://github.com/ComparativeGenomicsToolkit/hal2vg"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hal2vg:1.1.8--hee927d3_0
stdout: hal2vg_halRemoveDupes.out
