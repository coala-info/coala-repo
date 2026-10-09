cwlVersion: v1.2
class: CommandLineTool
baseCommand: hisat2_read_statistics.py
label: hisat2_read_statistics.py
doc: "Compute statistics of reads. Show number of reads and minimum, maximum,
  average length of reads\n\nTool homepage: https://daehwankimlab.github.io/hisat2"
inputs:
  - id: read_file
    type: File
    doc: reads file
    inputBinding:
      position: 2
  - id: read_count
    type:
      - 'null'
      - int
    doc: 'reads count (default: 10000)'
    inputBinding:
      position: 1
      prefix: -n
outputs:
  - id: statistics
    type: stdout
    doc: Number of reads and minimum, maximum and average read length
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hisat2:2.2.3--h8471819_0
stdout: hisat2_read_statistics.py.out
