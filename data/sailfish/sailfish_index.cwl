cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sailfish
  - index
label: sailfish_index
doc: "Builds a Sailfish index\n\nTool homepage: https://github.com/kingsfordgroup/sailfish"
inputs:
  - id: transcripts
    type: File
    doc: 'Transcript fasta file(s).'
    inputBinding:
      position: 1
      prefix: --transcripts
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: 'Kmer size. (default 31)'
    inputBinding:
      position: 2
      prefix: --kmerSize
  - id: out
    type: string
    doc: 'Output stem [all files needed by Sailfish will be of the form stem.*].'
    inputBinding:
      position: 3
      prefix: --out
  - id: threads
    type:
      - 'null'
      - int
    doc: 'The number of threads to use concurrently. (default 20)'
    inputBinding:
      position: 4
      prefix: --threads
  - id: force
    type:
      - 'null'
      - boolean
    doc: 'Force the index to be rebuilt'
    inputBinding:
      position: 5
      prefix: --force
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: index_dir
    type: Directory
    doc: Sailfish index
    outputBinding:
      glob: $(inputs.out)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sailfish:0.10.1--1
stdout: sailfish_index.out
