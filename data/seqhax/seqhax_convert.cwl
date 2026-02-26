cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqhax
  - convert
label: seqhax_convert
doc: "Convert sequence files to FASTA or FASTQ format\n\nTool homepage: https://github.com/kdmurray91/seqhax"
inputs:
  - id: input_file
    type: File
    doc: Input sequence file
    inputBinding:
      position: 1
  - id: output_fasta
    type:
      - 'null'
      - boolean
    doc: Output FASTA.
    inputBinding:
      position: 102
      prefix: -a
  - id: output_fastq
    type:
      - 'null'
      - boolean
    doc: Output FASTQ (adding qualities).
    inputBinding:
      position: 102
      prefix: -q
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqhax:0.8.6--h43eeafb_1
stdout: seqhax_convert.out
