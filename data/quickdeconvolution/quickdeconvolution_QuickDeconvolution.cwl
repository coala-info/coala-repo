cwlVersion: v1.2
class: CommandLineTool
baseCommand: QuickDeconvolution
label: quickdeconvolution_QuickDeconvolution
doc: "QuickDeconvolution\n\nTool homepage: https://github.com/RolandFaure/QuickDeconvolution"
inputs:
  - id: density
    type:
      - 'null'
      - int
    doc: on average 1/2^d kmers are sparse kmers
    inputBinding:
      position: 101
      prefix: --density
  - id: dropout
    type:
      - 'null'
      - float
    doc: QD does not try to deconvolve clouds smaller than this value
    inputBinding:
      position: 101
      prefix: --dropout
  - id: input_file
    type: File
    doc: input file (mandatory)
    inputBinding:
      position: 101
      prefix: --input-file
  - id: kmers_length
    type:
      - 'null'
      - int
    doc: size of kmers
    inputBinding:
      position: 101
      prefix: --kmers-length
  - id: metagenome
    type:
      - 'null'
      - boolean
    doc: Use this option on metagenomic samples
    inputBinding:
      position: 101
      prefix: --metagenome
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: window_size
    type:
      - 'null'
      - int
    doc: size of window guaranteed to contain at least one minimizing kmer
    inputBinding:
      position: 101
      prefix: --window-size
outputs:
  - id: output_file
    type: File
    doc: file to write the output (mandatory)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quickdeconvolution:1.2--h9f5acd7_1
