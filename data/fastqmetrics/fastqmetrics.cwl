cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastqmetrics
label: fastqmetrics
doc: "Extract metrics from a fastq file, streaming\n\nTool homepage: https://github.com/wdecoster/fastqmetrics"
inputs:
  - id: fastq
    type: File
    doc: Fastq file to extract features from.
    inputBinding:
      position: 1
  - id: threads
    type:
      - 'null'
      - int
    doc: Set the allowed number of threads to be used by the script. This only 
      applies to bam and fastq format as data source
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastqmetrics:0.1.0--py36_1
stdout: fastqmetrics.out
