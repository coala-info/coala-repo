cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bamutils
label: ngsutils_bamutils
doc: "A suite of tools for processing and analyzing BAM files. (Note: The provided
  text was a system error message and did not contain specific command-line argument
  documentation.)\n\nTool homepage: https://github.com/ngsutils/ngsutils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngsutils:0.5.9--py27_0
stdout: ngsutils_bamutils.out
