cwlVersion: v1.2
class: CommandLineTool
baseCommand: gff2bed
label: gff2bed
doc: "Converts GFF (General Feature Format) files to BED format. Note: The provided
  help text contains a system error message regarding container execution and does
  not list specific arguments. Standard usage typically involves passing a GFF file
  via standard input or as a positional argument.\n\nTool homepage: https://gitlab.com/salk-tm/gff2bed"
inputs:
  - id: input_gff
    type: File
    doc: The GFF file to be converted to BED format.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gff2bed:1.0.3--pyhdfd78af_0
stdout: gff2bed.out
