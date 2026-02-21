cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ngsutils
  - gtfutils
label: ngsutils_gtfutils
doc: "A collection of utilities for manipulating GTF files. (Note: The provided text
  contains system error messages regarding container execution and does not list specific
  command-line arguments.)\n\nTool homepage: https://github.com/ngsutils/ngsutils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngsutils:0.5.9--py27_0
stdout: ngsutils_gtfutils.out
