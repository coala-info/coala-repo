cwlVersion: v1.2
class: CommandLineTool
baseCommand: svtk standardize
label: svtk_standardize
doc: "Standardize a VCF of SV calls.\n\nTool homepage: https://github.com/talkowski-lab/svtk"
inputs:
  - id: vcf
    type: File
    doc: Raw VCF.
    inputBinding:
      position: 1
  - id: source
    type: string
    doc: Source algorithm. [delly,lumpy,manta,wham,melt]
    inputBinding:
      position: 2
  - id: call_null_sites
    type:
      - 'null'
      - boolean
    doc: "Call sites with null genotypes (./.). Generally useful\n               \
      \         when an algorithm has been run on a single sample and\n          \
      \              has only reported variant sites."
    inputBinding:
      position: 103
      prefix: --call-null-sites
  - id: contigs
    type:
      - 'null'
      - File
    doc: "Reference fasta index (.fai). If provided, contigs in\n                \
      \        index will be used in VCF header. Otherwise all GRCh37\n          \
      \              contigs will be used in header. Variants on contigs\n       \
      \                 not in provided list will be removed."
    inputBinding:
      position: 103
      prefix: --contigs
  - id: include_reference_sites
    type:
      - 'null'
      - boolean
    doc: "Include records where all samples are called 0/0 or ./\n               \
      \         ."
    inputBinding:
      position: 103
      prefix: --include-reference-sites
  - id: min_size
    type:
      - 'null'
      - int
    doc: Minimum SV size to report [50].
    default: 50
    inputBinding:
      position: 103
      prefix: --min-size
  - id: prefix
    type:
      - 'null'
      - string
    doc: If provided, variant names will be overwritten with this prefix.
    inputBinding:
      position: 103
      prefix: --prefix
  - id: standardizer
    type:
      - 'null'
      - string
    doc: "Path to python file with custom standardizer\n                        definition.
      (Not yet supported.)"
    inputBinding:
      position: 103
      prefix: --standardizer
outputs:
  - id: fout
    type: File
    doc: Standardized VCF.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svtk:0.0.20190615--py39hbcbf7aa_7
