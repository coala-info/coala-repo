cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqhax
  - filter
label: seqhax_filter
doc: "Filter sequence files based on length and format options.\n\nTool homepage:
  https://github.com/kdmurray91/seqhax"
inputs:
  - id: input_file
    type: File
    doc: Sequence file in FASTA or FASTQ format
    inputBinding:
      position: 1
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum length of each read.
    default: 1
    inputBinding:
      position: 102
      prefix: -l
  - id: output_fasta
    type:
      - 'null'
      - boolean
    doc: Output as fasta (no qualities)
    inputBinding:
      position: 102
      prefix: -f
  - id: paired_mode
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
stdout: seqhax_filter.out
