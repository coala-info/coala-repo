cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastaq
  - deinterleave
label: pyfastaq_fastaq_deinterleave
doc: "Deinterleaves sequence file, so that reads are written alternately between two output files\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: fasta_out
    type:
      - 'null'
      - boolean
    doc: "Use this to write output as fasta (default is same as input)"
    inputBinding:
      position: 1
      prefix: --fasta_out
  - id: infile
    type: File
    doc: "Name of fasta/q file to be deinterleaved"
    inputBinding:
      position: 20
  - id: out_fwd
    type: string
    doc: "Name of output fasta/q file of forwards reads"
    inputBinding:
      position: 21
  - id: out_rev
    type: string
    doc: "Name of output fasta/q file of reverse reads"
    inputBinding:
      position: 22
outputs:
  - id: forward_reads
    type: File
    doc: "Name of output fasta/q file of forwards reads"
    outputBinding:
      glob: $(inputs.out_fwd)
  - id: reverse_reads
    type: File
    doc: "Name of output fasta/q file of reverse reads"
    outputBinding:
      glob: $(inputs.out_rev)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
