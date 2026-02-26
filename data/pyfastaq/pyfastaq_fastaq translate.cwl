cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyfastaq_fastaq_translate
label: pyfastaq_fastaq translate
doc: "Translate DNA sequences to protein sequences.\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: input_file
    type: File
    doc: Input FASTA file containing DNA sequences.
    inputBinding:
      position: 1
  - id: frame
    type:
      - 'null'
      - int
    doc: Translation frame (1, 2, or 3). Default is 1.
    default: 1
    inputBinding:
      position: 102
      prefix: --frame
  - id: genetic_code
    type:
      - 'null'
      - string
    doc: Genetic code to use (e.g., 'standard', 'vertebrate_mt'). Default is 
      'standard'.
    default: standard
    inputBinding:
      position: 102
      prefix: --genetic-code
  - id: reverse_complement
    type:
      - 'null'
      - boolean
    doc: Translate the reverse complement of the sequences.
    inputBinding:
      position: 102
      prefix: --reverse-complement
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file to write translated protein sequences.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
