cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phenix.py
  - vcf2fasta
label: phenix_vcf2fasta
doc: "Combine multiple VCFs into a single FASTA file.\n\nTool homepage: https://github.com/phe-bioinformatics/PHEnix"
inputs:
  - id: directory
    type:
      - 'null'
      - Directory
    doc: "Path to the directory with .vcf files."
    inputBinding:
      position: 1
      prefix: --directory
  - id: input
    type:
      - 'null'
      - type: array
        items: File
    doc: "List of VCF files to process."
    inputBinding:
      position: 2
      prefix: --input
  - id: regexp
    type:
      - 'null'
      - string
    doc: "Regular expression for finding VCFs in a directory."
    inputBinding:
      position: 3
      prefix: --regexp
  - id: out
    type: string
    doc: "Path to the output FASTA file."
    inputBinding:
      position: 4
      prefix: --out
  - id: with_mixtures
    type:
      - 'null'
      - float
    doc: "Specify this option with a threshold to output mixtures above this threshold."
    inputBinding:
      position: 5
      prefix: --with-mixtures
  - id: column_ns
    type:
      - 'null'
      - float
    doc: "Keeps columns with fraction of Ns below specified threshold."
    inputBinding:
      position: 6
      prefix: --column-Ns
  - id: column_gaps
    type:
      - 'null'
      - float
    doc: "Keeps columns with fraction of gaps below specified threshold."
    inputBinding:
      position: 7
      prefix: --column-gaps
  - id: sample_ns
    type:
      - 'null'
      - string
    doc: "Keeps samples with fraction of Ns below specified threshold or put auto. Requires reflength or reference."
    inputBinding:
      position: 8
      prefix: --sample-Ns
  - id: sample_gaps
    type:
      - 'null'
      - string
    doc: "Keeps samples with fraction of gaps below specified threshold or put auto. Requires reflength or reference."
    inputBinding:
      position: 9
      prefix: --sample-gaps
  - id: sample_ns_gaps_auto_factor
    type:
      - 'null'
      - float
    doc: "When using auto for sample-gaps or sample-Ns, remove samples that have gaps or Ns this many times above the stddev of all samples. [Default 2.0]"
    inputBinding:
      position: 10
      prefix: --sample-Ns-gaps-auto-factor
  - id: reference
    type:
      - 'null'
      - File
    doc: "If path to reference specified (FASTA), then whole genome will be written to alignment."
    inputBinding:
      position: 11
      prefix: --reference
  - id: remove_invariant_npos
    type:
      - 'null'
      - boolean
    doc: "Remove all positions that are invariant apart from N positions."
    inputBinding:
      position: 12
      prefix: --remove-invariant-npos
  - id: reflength
    type:
      - 'null'
      - int
    doc: "Length of reference. Either as int or can be worked out from fasta file. Ignored if reference is used."
    inputBinding:
      position: 13
      prefix: --reflength
  - id: include
    type:
      - 'null'
      - File
    doc: "Only include positions in BED file in the FASTA"
    inputBinding:
      position: 14
      prefix: --include
  - id: exclude
    type:
      - 'null'
      - File
    doc: "Exclude any positions specified in the BED file."
    inputBinding:
      position: 15
      prefix: --exclude
  - id: with_stats
    type:
      - 'null'
      - string
    doc: "If a path is specified, then position of the outputed SNPs is stored in this file."
    inputBinding:
      position: 16
      prefix: --with-stats
outputs:
  - id: fasta
    type:
      - File
    doc: "Combined FASTA file"
    outputBinding:
      glob: $(inputs.out)
  - id: stats
    type:
      - 'null'
      - File
    doc: "Position statistics file"
    outputBinding:
      glob: $(inputs.with_stats)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phenix:1.4.1a--py27h24bf2e0_0
