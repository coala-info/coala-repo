cwlVersion: v1.2
class: CommandLineTool
baseCommand: nextdenovo
label: nextdenovo
doc: "NextDenovo is a string graph-based de novo assembler for long reads (CLR, HiFi,
  and ONT). Note: The provided text contains container runtime error messages and
  does not list specific command-line arguments.\n\nTool homepage: https://github.com/Nextomics/NextDenovo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextdenovo:2.5.2--py310h0ceaa1d_6
stdout: nextdenovo.out
