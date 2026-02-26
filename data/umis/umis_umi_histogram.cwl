cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - umis
  - umi_histogram
label: umis_umi_histogram
doc: "Counts the number of reads for each UMI\n\nTool homepage: https://github.com/vals/umis"
inputs:
  - id: fastq
    type: File
    doc: Formatted fastq file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/umis:1.0.9--py310h1fe012e_5
stdout: umis_umi_histogram.out
