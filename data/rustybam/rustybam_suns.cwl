cwlVersion: v1.2
class: CommandLineTool
baseCommand: rustybam suns
label: rustybam_suns
doc: "Extract the intervals in a genome (fasta) that are made up of SUNs\n\nTool homepage:
  https://github.com/mrvollger/rustybam"
inputs:
  - id: fasta
    type:
      - 'null'
      - File
    doc: Input fasta file with the genome
    default: '-'
    inputBinding:
      position: 101
      prefix: --fasta
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: The size of the required unique kmer
    default: 21
    inputBinding:
      position: 101
      prefix: --kmer-size
  - id: max_size
    type:
      - 'null'
      - int
    doc: The maximum size SUN interval to report
    default: 18446744073709551615
    inputBinding:
      position: 101
      prefix: --max-size
  - id: validate
    type:
      - 'null'
      - boolean
    doc: Confirm all the SUNs (very slow) only for debugging
    inputBinding:
      position: 101
      prefix: --validate
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rustybam:0.1.34--hf24ce72_0
stdout: rustybam_suns.out
