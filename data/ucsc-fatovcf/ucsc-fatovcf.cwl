cwlVersion: v1.2
class: CommandLineTool
baseCommand: faToVcf
label: ucsc-fatovcf
doc: "Convert a FASTA file to a VCF file. Note: The provided input text contained
  a container runtime error rather than the tool's help output; the following arguments
  represent the standard interface for the UCSC faToVcf tool.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
  - id: mask
    type:
      - 'null'
      - boolean
    doc: Include masked bases
    inputBinding:
      position: 102
      prefix: -mask
  - id: ref
    type:
      - 'null'
      - string
    doc: Use specific name for reference sequence
    inputBinding:
      position: 102
      prefix: -ref
  - id: verbose
    type:
      - 'null'
      - int
    doc: Set verbosity level
    default: 1
    inputBinding:
      position: 102
      prefix: -verbose
outputs:
  - id: output_vcf
    type: File
    doc: Output VCF file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-fatovcf:482--hdc0a859_1
