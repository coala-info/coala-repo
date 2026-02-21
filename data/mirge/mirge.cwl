cwlVersion: v1.2
class: CommandLineTool
baseCommand: mirge
label: mirge
doc: "miRge is a tool for the analysis of small RNA-seq data (Note: The provided text
  contains container runtime errors and does not include the actual help documentation
  for the tool).\n\nTool homepage: https://github.com/mhalushka/miRge"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirge:2.0.6--py27_4
stdout: mirge.out
