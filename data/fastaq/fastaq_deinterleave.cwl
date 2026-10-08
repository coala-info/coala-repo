cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastaq
  - deinterleave
label: fastaq_deinterleave
doc: "Deinterleaves sequence file, so that reads are written alternately between two\n\
  output files\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: infile
    type: File
    doc: Name of fasta/q file to be deinterleaved
    inputBinding:
      position: 1
  - id: fasta_out
    type:
      - 'null'
      - boolean
    doc: Use this to write output as fasta (default is same as input)
    inputBinding:
      position: 102
      prefix: --fasta_out
  - id: out_fwd
    type: string
    doc: Name of output fasta/q file of forwards reads
    inputBinding:
      position: 2
  - id: out_rev
    type: string
    doc: Name of output fasta/q file of reverse reads
    inputBinding:
      position: 3
outputs:
  - id: out_out_fwd
    type: File
    doc: Name of output fasta/q file of forwards reads
    outputBinding:
      glob: $(inputs.out_fwd)
  - id: out_out_rev
    type: File
    doc: Name of output fasta/q file of reverse reads
    outputBinding:
      glob: $(inputs.out_rev)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastaq:v3.17.0-2-deb_cv1
