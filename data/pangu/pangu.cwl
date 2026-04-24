cwlVersion: v1.2
class: CommandLineTool
baseCommand: pangu
label: pangu
doc: "Call CYP2D6 star alleles from HiFi WGS data\n\nTool homepage: https://github.com/PacificBiosciences/pangu"
inputs:
  - id: in_bam
    type:
      - 'null'
      - type: array
        items: File
    doc: Aligned BAM file(s) of HiFi WGS reads
    inputBinding:
      position: 1
  - id: bam_fofn
    type:
      - 'null'
      - File
    doc: Text file of bam file names. Default None
    inputBinding:
      position: 102
      prefix: --bamFofn
  - id: config
    type:
      - 'null'
      - File
    doc: Override installed configuration yaml file
    inputBinding:
      position: 102
      prefix: --config
  - id: export_labeled_reads
    type:
      - 'null'
      - boolean
    doc: Write labeled reads to output prefix
    inputBinding:
      position: 102
      prefix: --exportLabeledReads
  - id: grayscale
    type:
      - 'null'
      - boolean
    doc: Use grayscale to annotate haplotypes in export bam. Default use color
    inputBinding:
      position: 102
      prefix: --grayscale
  - id: log_level
    type:
      - 'null'
      - string
    doc: Logging level (CRITICAL, ERROR, WARNING, INFO, DEBUG, NOTSET). Default INFO
    inputBinding:
      position: 102
      prefix: --logLevel
  - id: mode
    type:
      - 'null'
      - string
    doc: Calling mode by HiFi input type (wgs, amplicon, capture, consensus). Default
      wgs
    inputBinding:
      position: 102
      prefix: --mode
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for output files. Default cwd
    inputBinding:
      position: 102
      prefix: --prefix
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed for random generator. Default 42
    inputBinding:
      position: 102
      prefix: --seed
  - id: vcf
    type:
      - 'null'
      - File
    doc: Vcf file name for single bam input. Default None
    inputBinding:
      position: 102
      prefix: --vcf
  - id: vcf_fofn
    type:
      - 'null'
      - File
    doc: Text file of vcf file names in same order as bamFofn. Default None
    inputBinding:
      position: 102
      prefix: --vcfFofn
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print logging info to stdout
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log file. Default {prefix}[_/]caller.log
    outputBinding:
      glob: $(inputs.log_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pangu:0.2.8--pyhdfd78af_0
