cwlVersion: v1.2
class: CommandLineTool
baseCommand: n50_binner
label: n50_binner
doc: "Count the reads of a FASTQ file in 16 predefined length bins and print a CSV table (Bin,Number of Reads).\n\nTool homepage: https://github.com/quadram-institute-bioscience/n50"
inputs:
  - id: fastq_file
    type: File
    doc: "Input FASTQ file (gzip compressed or not)"
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: CSV table of read counts per length bin
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/n50:1.9.3--h577a1d6_0
stdout: n50_binner.out
