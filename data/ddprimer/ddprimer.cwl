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
      - File
    doc: Configuration file (JSON).
    inputBinding:
      position: 101
      prefix: --config
  - id: db
    type:
      - 'null'
      - File
    doc: FASTA file to create a BLAST database from (created in the output 
      directory)
    inputBinding:
      position: 99
      prefix: --db
  - id: db_name
    type:
      - 'null'
      - string
    doc: Name of the BLAST database created from --db
    inputBinding:
      position: 100
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
      - File
    doc: Enable target-sequence based primer design workflow using CSV/Excel 
      input.
    inputBinding:
      position: 101
      prefix: --direct
  - id: fasta
    type:
      - 'null'
      - File
    secondaryFiles:
      - pattern: .fai
        required: false
    doc: Reference genome FASTA file
    inputBinding:
      position: 101
      prefix: --fasta
  - id: gff
    type:
      - 'null'
      - File
    secondaryFiles:
      - pattern: .tbi
        required: false
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
      - File
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
    secondaryFiles:
      - pattern: .tbi
        required: false
    doc: Variant Call Format (VCF) file with variants
    inputBinding:
      position: 101
      prefix: --vcf
  - id: output_dir_path
    type: string?
    doc: Output directory
    default: ddprimer_output
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_dir_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ddprimer:0.1.1--pyhdfd78af_0
