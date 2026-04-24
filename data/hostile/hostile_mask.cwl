cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hostile
  - mask
label: hostile_mask
doc: "Mask reference genome against target genome(s)\n\nTool homepage: https://github.com/bede/hostile"
inputs:
  - id: reference
    type: File
    doc: path to reference genome in fasta(.gz) format
    inputBinding:
      position: 1
  - id: target
    type: File
    doc: path to target genome(s) in fasta(.gz) format
    inputBinding:
      position: 2
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: length of target genome k-mers
    inputBinding:
      position: 103
      prefix: --kmer-length
  - id: kmer_step
    type:
      - 'null'
      - int
    doc: interval between target genome k-mer start positions
    inputBinding:
      position: 103
      prefix: --kmer-step
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use
    inputBinding:
      position: 103
      prefix: --threads
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: path to output directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hostile:2.0.2--pyhdfd78af_0
