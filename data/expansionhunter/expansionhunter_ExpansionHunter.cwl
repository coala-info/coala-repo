cwlVersion: v1.2
class: CommandLineTool
baseCommand: ExpansionHunter
label: expansionhunter_ExpansionHunter
doc: "A tool for estimating sizes of tandem repeat expansions from sequencing data.\n\
  \nTool homepage: https://github.com/Illumina/ExpansionHunter"
inputs:
  - id: log_level
    type:
      - 'null'
      - string
    doc: Log level (trace, debug, info, warn, error)
    default: info
    inputBinding:
      position: 101
      prefix: --log-level
  - id: reads
    type: File
    doc: BAM or CRAM file containing reads
    inputBinding:
      position: 101
      prefix: --reads
  - id: reference
    type: File
    doc: FASTA file containing the reference genome
    inputBinding:
      position: 101
      prefix: --reference
  - id: sex
    type:
      - 'null'
      - string
    doc: Sex of the sample; must be either male or female
    inputBinding:
      position: 101
      prefix: --sex
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: variant_catalog
    type: File
    doc: JSON file containing descriptions of variants to genotype
    inputBinding:
      position: 101
      prefix: --variant-catalog
outputs:
  - id: output_prefix
    type: File
    doc: Prefix for the output files
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/expansionhunter:5.0.0--hc26b3af_5
