cwlVersion: v1.2
class: CommandLineTool
baseCommand: mseqtools_subset
label: mseqtools_subset
doc: "Subset a fasta/fastq file based on a list of identifiers.\n\nTool homepage:
  https://github.com/arumugamlab/mseqtools"
inputs:
  - id: exclude
    type:
      - 'null'
      - boolean
    doc: exclude sequences in this list
    inputBinding:
      position: 101
      prefix: --exclude
  - id: input_file
    type: File
    doc: input fasta/fastq file
    inputBinding:
      position: 101
      prefix: --input
  - id: list_file
    type: File
    doc: file containing list of fasta/fastq identifiers
    inputBinding:
      position: 101
      prefix: --list
  - id: paired
    type:
      - 'null'
      - boolean
    doc: get both reads from a pair corresponding to the entry; needs pairs to 
      be marked with /1 and /2
    inputBinding:
      position: 101
      prefix: --paired
  - id: uncompressed
    type:
      - 'null'
      - boolean
    doc: write uncompressed output
    inputBinding:
      position: 101
      prefix: --uncompressed
  - id: window
    type:
      - 'null'
      - int
    doc: number of chars per line in fasta file
    inputBinding:
      position: 101
      prefix: --window
outputs:
  - id: output_file
    type: File
    doc: output file (gzipped)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mseqtools:0.9.1--h7132678_1
