cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastq-scan
label: fastq-scan
doc: "Calculates sequencing coverage and quality statistics from FASTQ files.\n\n\
  Tool homepage: https://github.com/rpetit3/fastq-scan"
inputs:
  - id: genome_size
    type:
      - 'null'
      - int
    doc: Genome size for calculating estimated sequencing coverage.
    inputBinding:
      position: 101
      prefix: -g
  - id: qc_stats_only
    type:
      - 'null'
      - boolean
    doc: Print only the QC stats, do not print read lengths or per-base quality 
      scores
    inputBinding:
      position: 101
      prefix: -q
  - id: quality_offset
    type:
      - 'null'
      - int
    doc: ASCII offset for input quality scores, can be 33 or 64.
    inputBinding:
      position: 101
      prefix: -p
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastq-scan:1.0.1--h9948957_4
stdout: fastq-scan.out
