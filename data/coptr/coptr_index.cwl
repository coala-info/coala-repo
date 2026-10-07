cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - coptr
  - index
label: coptr_index
doc: "Index a reference FASTA file for use with coptr.\n\nTool homepage: https://github.com/tyjo/coptr"
inputs:
  - id: ref_fasta
    type:
      - File
      - Directory
    doc: File or folder containing fasta to index. If a folder, the extension 
      for each fasta must be one of [.fasta, .fna, .fa]
    inputBinding:
      position: 1
  - id: index_out
    type: string
    doc: Filepath to store index (bowtie2 index prefix).
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
  - id: index
    type: File
    doc: Bowtie2 index (index_out.1.bt2) with the other index files and the 
      list of genome ids (index_out.genomes) as secondary files.
    outputBinding:
      glob: $(inputs.index_out).1.bt2
    secondaryFiles:
      - ^^.2.bt2
      - ^^.3.bt2
      - ^^.4.bt2
      - ^^.rev.1.bt2
      - ^^.rev.2.bt2
      - ^^.genomes
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coptr:1.1.4--pyhdfd78af_3
