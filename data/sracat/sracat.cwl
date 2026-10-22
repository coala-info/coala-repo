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
      items:
        - File
        - Directory
        - string
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
    inputBinding:
      position: 102
      prefix: -o
  - id: zlib_compression
    type:
      - 'null'
      - boolean
    doc: zlib-based compression of file-based output; default is no compression
    inputBinding:
      position: 102
      prefix: -z
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_files
    type:
      type: array
      items: File
    doc: Files written when an output prefix is given
    outputBinding:
      glob: "$(inputs.output_prefix ? inputs.output_prefix + '*' : [])"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sracat:0.2--h077b44d_3
stdout: sracat.out
