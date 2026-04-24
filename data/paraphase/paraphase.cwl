cwlVersion: v1.2
class: CommandLineTool
baseCommand: paraphase
label: paraphase
doc: "Paraphase: HiFi-based caller for highly similar paralogous genes\n\nTool homepage:
  https://github.com/PacificBiosciences/paraphase"
inputs:
  - id: bam
    type:
      - 'null'
      - File
    doc: Input BAM file, mutually exclusive with -l
    inputBinding:
      position: 101
      prefix: --bam
  - id: config
    type:
      - 'null'
      - File
    doc: Optional path to a user-defined config file listing the full set of regions
      to analyze.
    inputBinding:
      position: 101
      prefix: --config
  - id: gene
    type:
      - 'null'
      - string
    doc: Optionally specify which gene(s) to run (separated by comma). Will run all
      genes if not specified.
    inputBinding:
      position: 101
      prefix: --gene
  - id: gene1only
    type:
      - 'null'
      - boolean
    doc: Optional. If specified, variant calls will be made against the main gene
      only.
    inputBinding:
      position: 101
      prefix: --gene1only
  - id: genome
    type:
      - 'null'
      - string
    doc: Optionally specify which genome reference build the input BAM files are aligned
      against. Accepted values are 19, 37, chm13, and 38.
    inputBinding:
      position: 101
      prefix: --genome
  - id: list
    type:
      - 'null'
      - File
    doc: File listing absolute paths to multiple input BAM files, one per line
    inputBinding:
      position: 101
      prefix: --list
  - id: min_haplotype_frequency
    type:
      - 'null'
      - float
    doc: Optional. Minimum frequency of unique supporting reads for a haplotype. Works
      with the targeted mode.
    inputBinding:
      position: 101
      prefix: --min-haplotype-frequency
  - id: min_variant_frequency
    type:
      - 'null'
      - float
    doc: Optional. Minimum frequency for a variant to be used for phasing. Works with
      the targeted mode.
    inputBinding:
      position: 101
      prefix: --min-variant-frequency
  - id: minimap2
    type:
      - 'null'
      - File
    doc: Optional path to minimap2
    inputBinding:
      position: 101
      prefix: --minimap2
  - id: novcf
    type:
      - 'null'
      - boolean
    doc: Optional. If specified, paraphase will not write vcfs
    inputBinding:
      position: 101
      prefix: --novcf
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix of output files for a single sample. Used with -b. If not provided,
      prefix will be extracted from the header of the input BAM.
    inputBinding:
      position: 101
      prefix: --prefix
  - id: reference
    type: File
    doc: Path to reference genome fasta file
    inputBinding:
      position: 101
      prefix: --reference
  - id: samtools
    type:
      - 'null'
      - File
    doc: Optional path to samtools
    inputBinding:
      position: 101
      prefix: --samtools
  - id: targeted
    type:
      - 'null'
      - boolean
    doc: Optional. If specified, paraphase will not assume depth is uniform across
      the genome.
    inputBinding:
      position: 101
      prefix: --targeted
  - id: threads
    type:
      - 'null'
      - int
    doc: Optional number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: write_nocalls_in_vcf
    type:
      - 'null'
      - boolean
    doc: Optional. If specified, Paraphase will write no-call sites in the VCFs, marked
      with LowQual filter.
    inputBinding:
      position: 101
      prefix: --write-nocalls-in-vcf
outputs:
  - id: out
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/paraphase:3.4.0--pyhdfd78af_0
