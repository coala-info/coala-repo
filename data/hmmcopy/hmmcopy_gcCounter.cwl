cwlVersion: v1.2
class: CommandLineTool
baseCommand: gcCounter
label: hmmcopy_gcCounter
doc: "Calculates GC content for a given FASTA file. (Note: The provided input text
  contained a system error message rather than help text; arguments are derived from
  standard tool documentation).\n\nTool homepage: http://compbio.bccrc.ca/software/hmmcopy/"
inputs:
  - id: input_fasta
    type: File
    doc: The input FASTA file to calculate GC content from.
    inputBinding:
      position: 1
  - id: chromosomes
    type:
      - 'null'
      - string
    doc: Comma-separated list of chromosomes to process.
    inputBinding:
      position: 102
      prefix: --chromosomes
  - id: window
    type:
      - 'null'
      - int
    doc: The window size for calculating GC content.
    default: 1000
    inputBinding:
      position: 102
      prefix: --window
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file for GC content results.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmmcopy:0.1.1--h5b0a936_12
