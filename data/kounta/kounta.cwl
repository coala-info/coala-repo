cwlVersion: v1.2
class: CommandLineTool
baseCommand: kounta
label: kounta
doc: "Build a multi-genome k-mer count matrix\n\nTool homepage: https://github.com/tseemann/kounta"
inputs:
  - id: fofn
    type:
      - 'null'
      - File
    doc: File of filenames to process
    inputBinding:
      position: 101
      prefix: --fofn
  - id: kmer
    type:
      - 'null'
      - int
    doc: k-mer length
    default: 25
    inputBinding:
      position: 101
      prefix: --kmer
  - id: minfreq
    type:
      - 'null'
      - int
    doc: Min k-mer frequency (FASTQ only)
    default: 3
    inputBinding:
      position: 101
      prefix: --minfreq
  - id: ram
    type:
      - 'null'
      - int
    doc: RAM in gigabytes to use
    default: 4
    inputBinding:
      position: 101
      prefix: --ram
  - id: tempdir
    type:
      - 'null'
      - string
    doc: Fast working directory
    default: auto
    inputBinding:
      position: 101
      prefix: --tempdir
  - id: threads
    type:
      - 'null'
      - int
    doc: Threads to use
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Output matrix file
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kounta:0.2.3--0
