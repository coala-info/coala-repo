cwlVersion: v1.2
class: CommandLineTool
baseCommand: coptr_index
label: coptr_index
doc: "Index a reference FASTA file for use with coptr.\n\nTool homepage: https://github.com/tyjo/coptr"
inputs:
  - id: ref_fasta
    type: File
    doc: File or folder containing fasta to index. If a folder, the extension 
      for each fasta must be one of [.fasta, .fna, .fa]
    inputBinding:
      position: 1
  - id: index_out
    type: File
    doc: Filepath to store index.
    inputBinding:
      position: 2
  - id: bt2_bmax
    type:
      - 'null'
      - string
    doc: Set the --bmax arguement for bowtie2-build. Used to control memory 
      useage.
    inputBinding:
      position: 103
      prefix: --bt2-bmax
  - id: bt2_dcv
    type:
      - 'null'
      - string
    doc: Set the --dcv argument for bowtie2-build. Used to control memory usage.
    inputBinding:
      position: 103
      prefix: --bt2-dcv
  - id: bt2_packed
    type:
      - 'null'
      - boolean
    doc: Set the --packed flag for bowtie2-build. Used to control memory usage.
    inputBinding:
      position: 103
      prefix: --bt2-packed
  - id: bt2_threads
    type:
      - 'null'
      - int
    doc: Number of threads to pass to bowtie2-build.
    inputBinding:
      position: 103
      prefix: --bt2-threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coptr:1.1.4--pyhdfd78af_3
stdout: coptr_index.out
