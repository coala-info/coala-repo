cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pandora
  - index
label: pandora_index
doc: "Index population reference graph (PRG) sequences.\n\nTool homepage: https://github.com/rmcolq/pandora"
inputs:
  - id: prg
    type: File
    doc: PRG to index (in fasta format)
    inputBinding:
      position: 1
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: K-mer size for (w,k)-minimizers
    default: 15
    inputBinding:
      position: 102
      prefix: -k
  - id: threads
    type:
      - 'null'
      - int
    doc: Maximum number of threads to use
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbosity
    type:
      - 'null'
      - type: array
        items: boolean
    doc: Verbosity of logging. Repeat for increased verbosity
    inputBinding:
      position: 102
      prefix: -v
  - id: window_size
    type:
      - 'null'
      - int
    doc: Window size for (w,k)-minimizers (must be <=k)
    default: 14
    inputBinding:
      position: 102
      prefix: -w
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Filename for the index
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pandora:0.9.2--h4ac6f70_0
