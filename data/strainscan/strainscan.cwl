cwlVersion: v1.2
class: CommandLineTool
baseCommand: strainscan
label: strainscan
doc: "The provided text does not contain help information or usage instructions; it
  is a log of a container build failure.\n\nTool homepage: https://github.com/liaoherui/StrainScan"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strainscan:1.0.14--pyhdfd78af_1
stdout: strainscan.out
