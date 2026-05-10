cwlVersion: v1.2
class: CommandLineTool
baseCommand: fqc
label: fastqc-rs_fqc
doc: "A FASTQ quality control tool inspired by fastQC\n\nTool homepage: https://github.com/fxwiegand/fastqc-rs"
inputs:
  - id: fastq
    type: File
    doc: The input FASTQ file to use.
    inputBinding:
      position: 101
      prefix: --fastq
  - id: kmer
    type:
      - 'null'
      - int
    doc: The length k of k-mers for k-mer counting.
    inputBinding:
      position: 101
      prefix: --kmer
  - id: summary_path
    type: string
    doc: Output or path parameter `summary_path`
    inputBinding:
      position: 102
      prefix: --summary
outputs:
  - id: summary
    type:
      - 'null'
      - File
    doc: Creates an output file for usage with MultiQC under the given path.
    outputBinding:
      glob: $(inputs.summary_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastqc-rs:0.3.4--hd2a40b3_1
