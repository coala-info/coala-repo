cwlVersion: v1.2
class: CommandLineTool
baseCommand: sracat
label: sracat
doc: "Reads SRA accession or file and outputs it to stdout or a file.\n\nTool homepage:
  https://github.com/lanl/sracat"
inputs:
  - id: sra_input
    type:
      type: array
      items: string
    doc: SRA accession/file
    inputBinding:
      position: 1
  - id: fastq_output
    type:
      - 'null'
      - boolean
    doc: fastq output
    inputBinding:
      position: 102
      prefix: --qual
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: output file *prefix*
    default: stdout
    inputBinding:
      position: 102
      prefix: -o
  - id: zlib_compression
    type:
      - 'null'
      - boolean
    doc: zlib-based compression of file-based output; default is no compression
    default: false
    inputBinding:
      position: 102
      prefix: -z
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sracat:0.2--h077b44d_3
stdout: sracat.out
