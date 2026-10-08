cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hlso
  - ref_consensus
label: haplotype-lso_ref_consensus
doc: "Build consensus sequences for the seeds and the haplotyping table.\n\nTool homepage: https://github.com/holtgrewe/haplotype-lso"
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Enable verbose mode"
    inputBinding:
      position: 1
      prefix: --verbose
  - id: max_errors
    type:
      - 'null'
      - int
    doc: "Maximal number of mismatches to accept in seed consensus computation"
    inputBinding:
      position: 1
      prefix: --max-errors
  - id: output_table
    type:
      - 'null'
      - string
    doc: "Path to output haplotype table."
    inputBinding:
      position: 1
      prefix: --output-table
  - id: in_tsv
    type: File
    doc: "Path to input TSV file (seeds_paths.tsv)."
    inputBinding:
      position: 2
  - id: seed_files
    type:
      type: array
      items: File
    doc: "Seed FASTA files and their BLAST XML results (<seed>.blast.xml); staged next to the TSV file"
outputs:
  - id: haplotype_table
    type:
      - 'null'
      - File
    doc: "Haplotype table"
    outputBinding:
      glob: $(inputs.output_table)
  - id: consensus_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Consensus and alignment files"
    outputBinding:
      glob: '*.consensus.fasta'
  - id: region_fastas
    type:
      - 'null'
      - type: array
        items: File
    doc: "Padded consensus seeds per region"
    outputBinding:
      glob: '[0-9]*S*.fasta'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $([inputs.in_tsv].concat(inputs.seed_files))
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haplotype-lso:0.4.4--pyhdfd78af_4
