cwlVersion: v1.2
class: CommandLineTool
baseCommand: rattle_extract_clusters
label: rattle_extract_clusters
doc: "Extracts clusters from a fasta/fastq file based on a clusters file.\n\nTool
  homepage: https://github.com/comprna/RATTLE"
inputs:
  - id: clusters_file
    type: File
    doc: clusters file (required)
    inputBinding:
      position: 101
      prefix: --clusters
  - id: fastq_format
    type:
      - 'null'
      - boolean
    doc: whether input and output should be in fastq format (instead of fasta)
    inputBinding:
      position: 101
      prefix: --fastq
  - id: input_file
    type: File
    doc: input fasta/fastq file (required)
    inputBinding:
      position: 101
      prefix: --input
  - id: labels
    type:
      - 'null'
      - type: array
        items: string
    doc: labels for the files in order of entry
    inputBinding:
      position: 101
      prefix: --label
  - id: min_reads
    type:
      - 'null'
      - int
    doc: min reads per cluster to save it into a file
    inputBinding:
      position: 101
      prefix: --min-reads
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: 'output folder for fastx files (default: .)'
    default: .
    inputBinding:
      position: 101
      prefix: --output-folder
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rattle:1.0--h5ca1c30_0
stdout: rattle_extract_clusters.out
