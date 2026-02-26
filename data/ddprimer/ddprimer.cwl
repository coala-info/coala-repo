cwlVersion: v1.2
class: CommandLineTool
baseCommand: ddprimer
label: ddprimer
doc: "A pipeline for primer design and filtering\n\nTool homepage: https://github.com/globuzzz2000/ddPrimer"
inputs:
  - id: cli
    type:
      - 'null'
      - boolean
    doc: Force CLI mode.
    inputBinding:
      position: 101
      prefix: --cli
  - id: config
    type:
      - 'null'
      - string
    doc: Configuration file path. With no arguments, shows config help mode.
    inputBinding:
      position: 101
      prefix: --config
  - id: db
    type:
      - 'null'
      - type: array
        items: string
    doc: Create or select a BLAST database. With no arguments, shows database 
      selection menu.Optionally use FASTA file path argument to create 
      database,optional second argument to determine database name.
    inputBinding:
      position: 101
      prefix: --db
  - id: debug
    type:
      - 'null'
      - type: array
        items: string
    doc: Enable debug mode. Use without arguments for universal debug,or specify
      module names (e.g. "--debug blast_processor").
    inputBinding:
      position: 101
      prefix: --debug
  - id: direct
    type:
      - 'null'
      - string
    doc: Enable target-sequence based primer design workflow using CSV/Excel 
      input.
    inputBinding:
      position: 101
      prefix: --direct
  - id: fasta
    type:
      - 'null'
      - File
    doc: Reference genome FASTA file
    inputBinding:
      position: 101
      prefix: --fasta
  - id: gff
    type:
      - 'null'
      - File
    doc: GFF annotation file
    inputBinding:
      position: 101
      prefix: --gff
  - id: noannotation
    type:
      - 'null'
      - boolean
    doc: Disable gene annotation filtering.
    inputBinding:
      position: 101
      prefix: --noannotation
  - id: nooligo
    type:
      - 'null'
      - boolean
    doc: Disable internal oligo (probe) design.
    inputBinding:
      position: 101
      prefix: --nooligo
  - id: remap
    type:
      - 'null'
      - string
    doc: Enable primer remapping and re-evaluation workflow using CSV/Excel 
      input.
    inputBinding:
      position: 101
      prefix: --remap
  - id: snp
    type:
      - 'null'
      - boolean
    doc: Enable SNP masking in direct mode. Requires VCF and FASTA files.
    inputBinding:
      position: 101
      prefix: --snp
  - id: vcf
    type:
      - 'null'
      - File
    doc: Variant Call Format (VCF) file with variants
    inputBinding:
      position: 101
      prefix: --vcf
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ddprimer:0.1.1--pyhdfd78af_0
