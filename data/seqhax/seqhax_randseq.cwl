cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqhax
  - randseq
label: seqhax_randseq
doc: "Generate a random sequence file\n\nTool homepage: https://github.com/kdmurray91/seqhax"
inputs:
  - id: reads
    type:
      - 'null'
      - int
    doc: Number of reads. Use 0 for infinite. [default 1000]
    inputBinding:
      position: 102
      prefix: -n
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed for RNG.
    inputBinding:
      position: 102
      prefix: -s
  - id: length
    type:
      - 'null'
      - int
    doc: Length of each read. [default 100]
    inputBinding:
      position: 102
      prefix: -l
  - id: paired
    type:
      - 'null'
      - boolean
    doc: Paired reads [default false]
    inputBinding:
      position: 102
      prefix: -p
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: Output as fasta (no qualities)
    inputBinding:
      position: 102
      prefix: -f
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqhax:0.8.6--h43eeafb_1
stdout: seqhax_randseq.out
