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
  - id: fofn_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files named in the file of filenames (staged in the working directory so
      the names resolve)
  - id: kmer
    type:
      - 'null'
      - int
    doc: k-mer length
    inputBinding:
      position: 101
      prefix: --kmer
  - id: minfreq
    type:
      - 'null'
      - int
    doc: Min k-mer frequency (FASTQ only)
    inputBinding:
      position: 101
      prefix: --minfreq
  - id: ram
    type:
      - 'null'
      - int
    doc: RAM in gigabytes to use
    inputBinding:
      position: 101
      prefix: --ram
  - id: tempdir
    type:
      - 'null'
      - string
    doc: Fast working directory
    inputBinding:
      position: 101
      prefix: --tempdir
  - id: threads
    type:
      - 'null'
      - int
    doc: Threads to use
    inputBinding:
      position: 101
      prefix: --threads
  - id: out_path
    type: string
    doc: Output matrix file
    inputBinding:
      position: 102
      prefix: --out
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Genome contigs (FASTA) or reads (FASTQ, gzip allowed) to count, as
      positional arguments
    inputBinding:
      position: 200
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Output matrix file
    outputBinding:
      glob: $(inputs.out_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.fofn_files || [])
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kounta:0.2.3--0
