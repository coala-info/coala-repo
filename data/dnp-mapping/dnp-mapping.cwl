cwlVersion: v1.2
class: CommandLineTool
baseCommand: dnp-mapping
label: dnp-mapping
doc: "The provided text does not contain help information for dnp-mapping; it contains
  container runtime error messages regarding a failure to build a SIF image due to
  insufficient disk space.\n\nTool homepage: https://github.com/erinijapranckeviciene/mapping_CC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dnp-mapping:1.0--h9948957_4
stdout: dnp-mapping.out
