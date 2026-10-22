cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqhax
  - preapp
label: seqhax_preapp
doc: "Prepend or append string to sequences\n\nTool homepage: https://github.com/kdmurray91/seqhax"
inputs:
  - id: input_file
    type: File
    doc: Sequence file in FASTA or FASTQ format (use /dev/stdin for standard input)
    inputBinding:
      position: 1
  - id: prefix
    type:
      - 'null'
      - string
    doc: Add SEQ as prefix, adding quality charachters if fastq.
    inputBinding:
      position: 102
      prefix: -P
  - id: suffix
    type:
      - 'null'
      - string
    doc: Add SEQ as suffix, adding quality charachters if fastq.
    inputBinding:
      position: 102
      prefix: -S
  - id: paired
    type:
      - 'null'
      - boolean
    doc: 'Paired mode: reads are kept/discared in pairs'
    inputBinding:
      position: 102
      prefix: -p
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqhax:0.8.6--h43eeafb_1
stdout: seqhax_preapp.out
