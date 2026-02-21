cwlVersion: v1.2
class: CommandLineTool
baseCommand: geneBody_coverage.py
label: rseqc_geneBody_coverage.py
doc: "Calculate the RNA-seq signals coverage over gene body. This tool is used to
  check if read coverage is uniform and if there is any 5'/3' bias.\n\nTool homepage:
  https://rseqc.sourceforge.net"
inputs:
  - id: input_file
    type:
      type: array
      items: File
    doc: Input file(s) in BAM or SAM format. Multiple files can be separated by comma.
    inputBinding:
      position: 101
      prefix: --input-file
  - id: minimum_length
    type:
      - 'null'
      - int
    doc: Minimum mRNA length (bp). mRNA that are shorter than this value will be skipped.
    default: 100
    inputBinding:
      position: 101
      prefix: --minimum-length
  - id: refgene
    type: File
    doc: Reference gene model in BED format.
    inputBinding:
      position: 101
      prefix: --refgene
outputs:
  - id: out_prefix
    type: File
    doc: Prefix of output files.
    outputBinding:
      glob: $(inputs.out_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
