cwlVersion: v1.2
class: CommandLineTool
baseCommand: gff32gtf
label: how_are_we_stranded_here_gff32gtf
doc: "Convert a GFF3 file to basic GTF format\n\nTool homepage: https://github.com/betsig/how_are_we_stranded_here"
inputs:
  - id: gff3_file
    type: File
    doc: gff3 file to convert
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: file name to write gtf
    inputBinding:
      position: 101
      prefix: --output
outputs:
  - id: gtf
    type: File
    doc: converted GTF file
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/how_are_we_stranded_here:1.0.1--pyhfa5458b_0
