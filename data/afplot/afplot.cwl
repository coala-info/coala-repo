cwlVersion: v1.2
class: CommandLineTool
baseCommand: afplot
label: afplot
doc: "A tool for plotting allele frequencies from VCF files (Note: The provided text
  is a container execution error log and does not contain help documentation).\n\n
  Tool homepage: https://github.com/sndrtj/afplot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/afplot:0.2.1--py36h24bf2e0_1
stdout: afplot.out
