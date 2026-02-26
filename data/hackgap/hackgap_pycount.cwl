cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hackgap
  - pycount
label: hackgap_pycount
doc: "Index and count k-mers in FASTQ files.\n\nTool homepage: https://gitlab.com/rahmannlab/hackgap"
inputs:
  - id: fastq
    type:
      type: array
      items: File
    doc: FASTQ file(s) to index and count
    inputBinding:
      position: 101
      prefix: --fastq
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: k-mer size
    inputBinding:
      position: 101
      prefix: --kmersize
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: name of output file (dummy, unused)
    inputBinding:
      position: 101
      prefix: --out
  - id: rcmode
    type:
      - 'null'
      - string
    doc: mode specifying how to encode k-mers
    inputBinding:
      position: 101
      prefix: --rcmode
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hackgap:1.0.1--pyhdfd78af_0
stdout: hackgap_pycount.out
