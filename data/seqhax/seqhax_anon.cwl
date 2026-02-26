cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqhax
  - anon
label: seqhax_anon
doc: "Anonymize sequence headers in a file\n\nTool homepage: https://github.com/kdmurray91/seqhax"
inputs:
  - id: input_file
    type: File
    doc: Input sequence file
    inputBinding:
      position: 1
  - id: base_16_ids
    type:
      - 'null'
      - boolean
    doc: Use base-16 sequence IDs.
    inputBinding:
      position: 102
      prefix: -x
  - id: paired_reads
    type:
      - 'null'
      - boolean
    doc: Treat reads as pairs, add /1 or /2 to headers.
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
stdout: seqhax_anon.out
