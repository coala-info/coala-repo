cwlVersion: v1.2
class: CommandLineTool
baseCommand: fqc
label: n50_fqc
doc: "Count the sequences of a gzip compressed FASTQ file.\n\nTool homepage: https://github.com/quadram-institute-bioscience/n50"
inputs:
  - id: fastq_gz
    type: File
    doc: "Input gzip compressed FASTQ file"
    inputBinding:
      position: 1
  - id: num_threads
    type:
      - 'null'
      - int
    doc: "Number of threads"
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/n50:1.9.3--h577a1d6_0
stdout: n50_fqc.out
