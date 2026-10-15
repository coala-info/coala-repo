cwlVersion: v1.2
class: CommandLineTool
baseCommand: [pore_c, contacts, export]
label: pore-c_contacts_export
doc: "Export contacts to cooler, salsa_bed, paired_end_fastq, pairs or merged_no_dups formats.\n\nTool homepage: https://github.com/nanoporetech/pore-c"
inputs:
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: "Both alignments have mapping qualities greater than this. Default: 0"
    inputBinding:
      position: 1
      prefix: --min-mapping-quality
  - id: min_align_base_qscore
    type:
      - 'null'
      - int
    doc: "Both alignments have mean base qualities greater than this. Default: 0"
    inputBinding:
      position: 1
      prefix: --min-align-base-qscore
  - id: cooler_resolution
    type:
      - 'null'
      - int
    doc: "The bin width of the resulting matrix. Default: 1000"
    inputBinding:
      position: 1
      prefix: --cooler-resolution
  - id: fragment_table
    type:
      - 'null'
      - File
    doc: "The fragment table of the corresponding virtual digest (required for cooler)"
    inputBinding:
      position: 1
      prefix: --fragment-table
  - id: by_haplotype
    type:
      - 'null'
      - boolean
    doc: "Create a cooler for each pair of haplotypes (only valid with cooler)"
    inputBinding:
      position: 1
      prefix: --by-haplotype
  - id: chromsizes
    type:
      - 'null'
      - File
    doc: "The chromsizes file of the corresponding genome (required for cooler and pairs)"
    inputBinding:
      position: 1
      prefix: --chromsizes
  - id: reference_fasta
    type:
      - 'null'
      - File
    secondaryFiles:
      - ".fai"
    doc: "The reference genome used to generate the contact table (required for paired_end_fastq and merged_no_dups)"
    inputBinding:
      position: 1
      prefix: --reference-fasta
  - id: contact_table
    type: File
    doc: "Contact table (parquet)"
    inputBinding:
      position: 10
  - id: export_format
    type: string
    doc: "Export format: cooler, salsa_bed, paired_end_fastq, pairs or merged_no_dups"
    inputBinding:
      position: 11
  - id: output_prefix
    type: string
    doc: "Output prefix"
    inputBinding:
      position: 12
outputs:
  - id: exported
    type:
      type: array
      items: File
    doc: "Exported files"
    outputBinding:
      glob: "$(inputs.output_prefix).*"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pore-c:0.4.0--pyhdfd78af_0
