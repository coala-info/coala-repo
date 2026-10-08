cwlVersion: v1.2
class: CommandLineTool
baseCommand: xyalign
label: xyalign_chrom_stats
doc: "Limit XYalign to only analyzing provided bam files for depth and mapq across\
  \ entire chromosomes.\n\nTool homepage: https://github.com/WilsonSayresLab/XYalign"
inputs:
  - id: bam
    type:
      type: array
      items: File
    doc: Full path to input bam files (indexed). If more than one provided, only the
      first will be used for modules other than CHROM_STATS
    inputBinding:
      position: 101
      prefix: --bam
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
  - id: chromosomes
    type:
      type: array
      items: string
    doc: Chromosomes to analyze (names must match reference exactly). For humans,
      we recommend at least chr19, chrX, chrY. Generally, we suggest including the
      sex chromosomes and at least one autosome. To analyze all chromosomes use '--chromosomes
      ALL' or '--chromosomes all'.
    inputBinding:
      position: 101
      prefix: --chromosomes
  - id: cpus
    type:
      - 'null'
      - int
    doc: Number of cores/threads to use. Default is 1
    inputBinding:
      position: 101
      prefix: --cpus
  - id: logfile
    type:
      - 'null'
      - string
    doc: Name of logfile. Will overwrite if exists. Default is sample_xyalign.log
    inputBinding:
      position: 101
      prefix: --logfile
  - id: no_cleanup
    type:
      - 'null'
      - boolean
    doc: Include flag to preserve temporary files.
    inputBinding:
      position: 101
      prefix: --no_cleanup
  - id: ref
    type: File
    doc: Path to reference sequence (including file name). Must have a .fai index
      beside it.
    inputBinding:
      position: 101
      prefix: --ref
    secondaryFiles:
      - pattern: .fai
        required: false
  - id: reporting_level
    type:
      - 'null'
      - string
    doc: Set level of messages printed to console. Default is 'INFO'. Choose from
      (in decreasing amount of reporting) DEBUG, INFO, ERROR or CRITICAL
    inputBinding:
      position: 101
      prefix: --reporting_level
  - id: sambamba_path
    type:
      - 'null'
      - string
    doc: Path to sambamba. Default is 'sambamba'
    inputBinding:
      position: 101
      prefix: --sambamba_path
  - id: sample_id
    type:
      - 'null'
      - string
    doc: Name/ID of sample - for use in plot titles and file naming. Default is sample
    inputBinding:
      position: 101
      prefix: --sample_id
  - id: samtools_path
    type:
      - 'null'
      - string
    doc: Path to samtools. Default is 'samtools'
    inputBinding:
      position: 101
      prefix: --samtools_path
  - id: skip_compatibility_check
    type:
      - 'null'
      - boolean
    doc: Include flag to prevent check of compatibility between input bam and reference
      fasta
    inputBinding:
      position: 101
      prefix: --skip_compatibility_check
  - id: use_counts
    type:
      - 'null'
      - boolean
    doc: If True, get counts of reads per chromosome for CHROM_STATS, rather than
      calculating mean depth and mapq. Much faster, but provides less information.
      Default is False
    inputBinding:
      position: 101
      prefix: --use_counts
  - id: output_dir
    type: string
    default: xyalign_output
    doc: Output directory. XYalign will create a directory structure within this directory
    inputBinding:
      position: 101
      prefix: --output_dir
outputs:
  - id: output_dir_dir
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_dir)
  - id: stdout
    type: stdout
    doc: Standard output
arguments:
  - position: 1
    valueFrom: --CHROM_STATS
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xyalign:1.1.5--py_1
stdout: xyalign_chrom_stats.out
