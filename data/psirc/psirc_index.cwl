cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - psirc-quant
  - index
label: psirc_index
doc: "Builds index\n\nTool homepage: https://github.com/nictru/psirc"
inputs:
  - id: fasta_files
    type:
      type: array
      items: File
    doc: "FASTA file(s) with the transcripts"
    inputBinding:
      position: 10
  - id: index
    type: string
    doc: "Filename for the index to be constructed"
    inputBinding:
      position: 1
      prefix: -i
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: "k-mer (odd) length (default: 31, max value: 31)"
    inputBinding:
      position: 2
      prefix: -k
  - id: make_unique
    type:
      - 'null'
      - boolean
    doc: "Replace repeated target names with unique names"
    inputBinding:
      position: 3
      prefix: --make-unique
outputs:
  - id: index_file
    type: File
    doc: "The index that was built"
    outputBinding:
      glob: $(inputs.index)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psirc:1.0.0--h6f0a7f7_1
