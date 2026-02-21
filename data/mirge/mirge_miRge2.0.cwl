cwlVersion: v1.2
class: CommandLineTool
baseCommand: mirge
label: mirge_miRge2.0
doc: "miRge2.0 is a tool for comprehensive analysis of miRNA-seq data. (Note: The
  provided text is an error log and does not contain help documentation; therefore,
  no arguments could be extracted.)\n\nTool homepage: https://github.com/mhalushka/miRge"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirge:2.0.6--py27_4
stdout: mirge_miRge2.0.out
