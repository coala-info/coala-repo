cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepsig
label: deepsig
doc: "Predictor of signal peptides in proteins\n\nTool homepage: https://github.com/BolognaBiocomp/deepsig"
inputs:
  - id: fasta
    type: File
    doc: The input multi-FASTA file name
    inputBinding:
      position: 101
      prefix: --fasta
  - id: organism
    type: string
    doc: The organism the sequences belongs to
    inputBinding:
      position: 101
      prefix: --organism
  - id: outfmt
    type:
      - 'null'
      - string
    doc: 'The output format: json or gff3 (default)'
    inputBinding:
      position: 101
      prefix: --outfmt
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use (default = number of available CPUs)
    inputBinding:
      position: 101
      prefix: --threads
  - id: outf_path
    type: string
    doc: Output or path parameter `outf_path`
    inputBinding:
      position: 102
      prefix: --outf
outputs:
  - id: outf
    type: File
    doc: The output file
    outputBinding:
      glob: $(inputs.outf_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepsig:1.2.5--pyhca03a8a_1
