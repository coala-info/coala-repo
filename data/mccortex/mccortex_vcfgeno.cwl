cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mccortex
  - vcfgeno
label: mccortex_vcfgeno
doc: "The provided text does not contain help information for the tool; it is a system
  error message indicating a failure to build a container due to lack of disk space.\n
  \nTool homepage: https://github.com/mcveanlab/mccortex"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mccortex:1.0--h24782f9_7
stdout: mccortex_vcfgeno.out
