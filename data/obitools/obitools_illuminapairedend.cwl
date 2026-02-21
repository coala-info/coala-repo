cwlVersion: v1.2
class: CommandLineTool
baseCommand: illuminapairedend
label: obitools_illuminapairedend
doc: "The provided text does not contain help information for the tool. It is a system
  error log indicating a failure to build a container image due to insufficient disk
  space ('no space left on device').\n\nTool homepage: http://metabarcoding.org/obitools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/obitools:1.2.13--py27h516909a_0
stdout: obitools_illuminapairedend.out
