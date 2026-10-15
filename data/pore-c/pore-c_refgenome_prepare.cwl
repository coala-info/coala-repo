cwlVersion: v1.2
class: CommandLineTool
baseCommand: [pore_c, refgenome, prepare]
label: pore-c_refgenome_prepare
doc: "Pre-process a reference genome for use by pore-C tools: writes a decompressed fasta, a chromsizes file, a metadata csv and an intake catalog.\n\nTool homepage: https://github.com/nanoporetech/pore-c"
inputs:
  - id: genome_id
    type:
      - 'null'
      - string
    doc: "An ID for this genome assembly"
    inputBinding:
      position: 1
      prefix: --genome-id
  - id: reference_fasta
    type: File
    doc: "Reference FASTA (may be gzip-compressed)"
    inputBinding:
      position: 10
  - id: output_prefix
    type: string
    doc: "Output prefix for the files that are written"
    inputBinding:
      position: 11
outputs:
  - id: fasta
    type: File
    doc: "Decompressed fasta file"
    outputBinding:
      glob: "$(inputs.output_prefix).fa"
  - id: fai
    type: File
    doc: "FASTA index"
    outputBinding:
      glob: "$(inputs.output_prefix).fa.fai"
  - id: chromsizes
    type: File
    doc: "Tab-separated chromosome lengths"
    outputBinding:
      glob: "$(inputs.output_prefix).chromsizes"
  - id: metadata
    type: File
    doc: "Metadata of each chromosome"
    outputBinding:
      glob: "$(inputs.output_prefix).metadata.csv"
  - id: catalog
    type: File
    doc: "Intake catalog of these files"
    outputBinding:
      glob: "$(inputs.output_prefix).catalog.yaml"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pore-c:0.4.0--pyhdfd78af_0
