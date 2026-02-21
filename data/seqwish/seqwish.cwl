cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqwish
label: seqwish
doc: "variation graph inducer\n\nTool homepage: https://github.com/ekg/seqwish"
inputs:
  - id: base
    type:
      - 'null'
      - string
    doc: base name for temporary files
    inputBinding:
      position: 101
      prefix: --base
  - id: keep_temp
    type:
      - 'null'
      - boolean
    doc: keep temporary files
    inputBinding:
      position: 101
      prefix: --keep-temp
  - id: min_match_len
    type:
      - 'null'
      - int
    doc: filter matches shorter than this length
    inputBinding:
      position: 101
      prefix: --min-match-len
  - id: paf_alns
    type: File
    doc: PAF alignments for which to induce the variation graph
    inputBinding:
      position: 101
      prefix: --paf-alns
  - id: prefix
    type:
      - 'null'
      - string
    doc: prefix for node IDs in the GFA
    inputBinding:
      position: 101
      prefix: --prefix
  - id: seqs
    type: File
    doc: the sequences used to generate the alignments
    inputBinding:
      position: 101
      prefix: --seqs
  - id: sparse_paf
    type:
      - 'null'
      - boolean
    doc: use a sparse representation of the PAF alignments
    inputBinding:
      position: 101
      prefix: --sparse-paf
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: gfa
    type:
      - 'null'
      - File
    doc: write the variation graph in GFA format to FILE
    outputBinding:
      glob: $(inputs.gfa)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqwish:0.7.11--h5ca1c30_1
