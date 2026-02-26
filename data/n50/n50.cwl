cwlVersion: v1.2
class: CommandLineTool
baseCommand: n50
label: n50
doc: "Calculate sequence statistics (N50, GC%, length stats) for FASTA/FASTQ files.\n\
  \nTool homepage: http://metacpan.org/pod/Proch::N50"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: One or more FASTA/FASTQ files, gzipped or not. '-' for STDIN.
    inputBinding:
      position: 1
  - id: abs
    type:
      - 'null'
      - boolean
    doc: Print file paths as absolute paths
    inputBinding:
      position: 102
      prefix: --abs
  - id: basename
    type:
      - 'null'
      - boolean
    doc: Print file paths as basename only (e.g., file.fq.gz)
    inputBinding:
      position: 102
      prefix: --basename
  - id: csv
    type:
      - 'null'
      - boolean
    doc: Output results in CSV format (default is TSV)
    inputBinding:
      position: 102
      prefix: --csv
  - id: json
    type:
      - 'null'
      - boolean
    doc: Output results in JSON format
    inputBinding:
      position: 102
      prefix: --json
  - id: nice
    type:
      - 'null'
      - boolean
    doc: Output results in a visually aligned ASCII table
    inputBinding:
      position: 102
      prefix: --nice
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/n50:1.9.3--h577a1d6_0
stdout: n50.out
