cwlVersion: v1.2
class: CommandLineTool
baseCommand: president
label: president
doc: "Calculate pairwise nucleotide identity.\n\nTool homepage: https://gitlab.com/RKIBioinformaticsPipelines/president"
inputs:
  - id: id_threshold
    type:
      - 'null'
      - float
    doc: "ACGT nucleotide identity threshold after alignment\n                   \
      \     (percentage). A query sequence is reported as valid\n                \
      \        based on this threshold (def: 0.9)"
    inputBinding:
      position: 101
      prefix: --id_threshold
  - id: n_threshold
    type:
      - 'null'
      - float
    doc: "A query sequence is reported as valid, if the\n                        percentage
      of Ns is smaller or equal the threshold\n                        (def: 0.05)"
    inputBinding:
      position: 101
      prefix: --n_threshold
  - id: path
    type: Directory
    doc: Path to be used to store results and FASTA files.
    inputBinding:
      position: 101
      prefix: --path
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix to be used t store results in the path
    inputBinding:
      position: 101
      prefix: --prefix
  - id: query
    type:
      type: array
      items: File
    doc: Query genome(s).
    inputBinding:
      position: 101
      prefix: --query
  - id: quite
    type:
      - 'null'
      - boolean
    doc: Print log messages also to the screen (False)
    inputBinding:
      position: 101
      prefix: --quite
  - id: reference
    type: File
    doc: Reference genome.
    inputBinding:
      position: 101
      prefix: --reference
  - id: store_alignment
    type:
      - 'null'
      - boolean
    doc: add query alignment columns (PSL format)
    inputBinding:
      position: 101
      prefix: --store_alignment
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for pblat.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/president:0.6.8--pyhdfd78af_0
stdout: president.out
