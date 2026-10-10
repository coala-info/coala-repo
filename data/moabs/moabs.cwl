cwlVersion: v1.2
class: CommandLineTool
baseCommand: moabs
label: moabs
doc: "moabs\n\nTool homepage: https://github.com/sunnyisgalaxy/moabs"
inputs:
  - id: configuration_file
    type:
      - 'null'
      - File
    doc: configuration file.
    inputBinding:
      position: 101
      prefix: --cf
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: -i
    doc: input files. Inputs are FASTQ files.
    inputBinding:
      position: 101
  - id: overwrite_definitions
    type:
      - 'null'
      - string
    doc: overwrite definitions in configuration file. --def key=value
    inputBinding:
      position: 101
      prefix: --def
  - id: staged_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files named in the configuration file (FASTQ, reference FASTA, chromosome
      sizes, BAM, BED). They are staged in the working directory.
  - id: verbose_output
    type:
      - 'null'
      - int
    doc: 'verbose output [0 or 1, default 0]'
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: bam_files
    type:
      type: array
      items: File
    outputBinding:
      glob: ['*.bam', '*.bam.bai']
    doc: Mapped reads (BSMAP) and indexes.
  - id: methylation_calls
    type:
      type: array
      items: File
    outputBinding:
      glob: ['*.G.bed', '*.HG.bed', '*_stat.txt']
    doc: Methylation calls (MCALL) and statistics.
  - id: comparison_files
    type:
      type: array
      items: File
    outputBinding:
      glob: ['comp.*', 'dmc_*', 'dmr_*']
    doc: Methylation comparison, DMC and DMR files (MCOMP).
  - id: log_files
    type:
      type: array
      items: File
    outputBinding:
      glob: moabs.*.log
    doc: Logs of the MOABS modules.
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/moabs:1.3.9.6--pl526r40h3d033a0_0
stdout: moabs.out
