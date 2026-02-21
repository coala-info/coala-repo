cwlVersion: v1.2
class: CommandLineTool
baseCommand: abpoa
label: pyabpoa_abpoa
doc: "The provided text does not contain help information or usage instructions. It
  consists of system logs and a fatal error message regarding a failed container build/fetch
  process for the pyabpoa image.\n\nTool homepage: https://github.com/yangao07/abPOA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyabpoa:1.5.5--py311h384fd50_0
stdout: pyabpoa_abpoa.out
