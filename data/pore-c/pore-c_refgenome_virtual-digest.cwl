cwlVersion: v1.2
class: CommandLineTool
baseCommand: [pore_c, refgenome, virtual-digest]
label: pore-c_refgenome_virtual-digest
doc: "Carry out a virtual digestion of the genome/assembly FASTA (enzyme, regex or fixed-width bins) and write the fragment table.\n\nTool homepage: https://github.com/nanoporetech/pore-c"
inputs:
  - id: digest_type
    type:
      - 'null'
      - string
    doc: "The type of digest: enzyme, regex or bin"
    inputBinding:
      position: 1
      prefix: --digest-type
  - id: n_workers
    type:
      - 'null'
      - int
    doc: "The number of dask workers to use. Default: 1"
    inputBinding:
      position: 1
      prefix: --n_workers
  - id: fasta
    type: File
    secondaryFiles:
      - ".fai"
    doc: "Genome or assembly FASTA (as written by refgenome prepare)"
    inputBinding:
      position: 10
  - id: cut_on
    type: string
    doc: "What to cut on: an enzyme name (NlaIII), a regex or a bin width"
    inputBinding:
      position: 11
  - id: output_prefix
    type: string
    doc: "Output prefix for the files that are written"
    inputBinding:
      position: 12
outputs:
  - id: fragments
    type: File
    doc: "Fragment coordinates and metadata"
    outputBinding:
      glob: "$(inputs.output_prefix).fragments.parquet"
  - id: digest_stats
    type: File
    doc: "Per chromosome summary statistics"
    outputBinding:
      glob: "$(inputs.output_prefix).digest_stats.csv"
  - id: catalog
    type: File
    doc: "Intake catalog of the digest files"
    outputBinding:
      glob: "$(inputs.output_prefix).catalog.yaml"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pore-c:0.4.0--pyhdfd78af_0
