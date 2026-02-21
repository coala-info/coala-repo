cwlVersion: v1.2
class: CommandLineTool
baseCommand: merquryfk
label: merquryfk
doc: "The provided text does not contain help information or a description of the
  tool. It is an error log indicating a failure to build a container image due to
  lack of disk space.\n\nTool homepage: https://github.com/thegenemyers/MERQURY.FK"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/merquryfk:1.2--h71df26d_1
stdout: merquryfk.out
