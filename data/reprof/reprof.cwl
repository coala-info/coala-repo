cwlVersion: v1.2
class: CommandLineTool
baseCommand: reprof
label: reprof
doc: "Predicts protein sequence profiles.\n\nTool homepage: https://github.com/ephmo/reprofed"
inputs:
  - id: input_file
    type: File
    doc: Input BLAST PSSM matrix file (from Blast -Q option) or input (single) 
      FASTA file.
    inputBinding:
      position: 101
      prefix: --input
  - id: modeldir
    type:
      - 'null'
      - Directory
    doc: Directory where the model and feature files are stored.
    inputBinding:
      position: 101
      prefix: --modeldir
  - id: mutations
    type:
      - 'null'
      - string
    doc: "Either the keyword \"all\" to predict all possible mutations or a file containing
      mutations one per line such as \"C12M\" for C is mutated to M on position 12:\n\
      \n C30Y\n R31W\n G48D\n\nThis mutation code is also attached to the output filename
      using\n\"_\". An additional file ending \"_ORI\" contains the prediction using\n\
      no evolutionary information even if a BLAST PSSM matrix was\nprovided."
    inputBinding:
      position: 101
      prefix: --mutations
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Either an output file or a directory. If not provided or a directory, 
      the suffix of the input filename (i.e. .fasta or .blastPsiMat) is replaced
      to create an output filename.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/reprof:v1.0.1-6-deb_cv1
