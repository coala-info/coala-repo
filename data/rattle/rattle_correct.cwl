cwlVersion: v1.2
class: CommandLineTool
baseCommand: rattle_correct
label: rattle_correct
doc: "Corrects errors in fasta/fastq files based on cluster information.\n\nTool homepage:
  https://github.com/comprna/RATTLE"
inputs:
  - id: clusters_file
    type: File
    doc: clusters file (required)
    inputBinding:
      position: 101
      prefix: --clusters
  - id: gap_occ
    type:
      - 'null'
      - float
    doc: 'gap-occ (default: 0.3)'
    default: 0.3
    inputBinding:
      position: 101
      prefix: --gap-occ
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
  - id: min_occ
    type:
      - 'null'
      - float
    doc: 'min-occ (default: 0.3)'
    default: 0.3
    inputBinding:
      position: 101
      prefix: --min-occ
  - id: min_reads
    type:
      - 'null'
      - int
    doc: 'min reads to correct/output consensus for a cluster (default: 5)'
    default: 5
    inputBinding:
      position: 101
      prefix: --min-reads
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: 'output folder (default: .)'
    default: .
    inputBinding:
      position: 101
      prefix: --output
  - id: split_clusters_size
    type:
      - 'null'
      - int
    doc: 'split clusters into sub-clusters of size s for msa (default: 200)'
    default: 200
    inputBinding:
      position: 101
      prefix: --split
  - id: threads
    type:
      - 'null'
      - int
    doc: 'number of threads to use (default: 1)'
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: use this flag if need to print the progress
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rattle:1.0--h5ca1c30_0
stdout: rattle_correct.out
