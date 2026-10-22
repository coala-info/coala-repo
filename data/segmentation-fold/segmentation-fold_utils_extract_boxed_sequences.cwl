cwlVersion: v1.2
class: CommandLineTool
baseCommand: [segmentation-fold-utils, extract-boxed-sequences]
label: segmentation-fold_utils_extract_boxed_sequences
doc: "Extracts boxed sequences from bed_input_file which has to be created with 'find-boxes', part of this utility\n\nTool homepage: https://github.com/yhoogstrate/segmentation-fold"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.fasta_input_file)
        writable: true
  - class: EnvVarRequirement
    envDef:
      - envName: LANG
        envValue: C.UTF-8
inputs:
  - id: max_inner_dist
    type: ['null', int]
    doc: "Maximal distance between the boxes (default=250bp)"
    inputBinding:
      position: 1
      prefix: --max-inner-dist
  - id: bp_extension
    type: ['null', int]
    doc: "Extend extracted sequences with this number of bases (default: 10bp)"
    inputBinding:
      position: 1
      prefix: --bp-extension
  - id: fasta_input_file
    type: File
    doc: "FASTA input file"
    inputBinding:
      position: 2
      valueFrom: $(self.basename)
  - id: bed_input_file
    type: File
    doc: "BED input file made by find-boxes"
    inputBinding:
      position: 3
  - id: fasta_output_file
    type: string
    doc: "FASTA output file name"
    inputBinding:
      position: 4
outputs:
  - id: fasta_output
    type: File
    doc: "Extracted boxed sequences"
    outputBinding:
      glob: $(inputs.fasta_output_file)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/segmentation-fold:1.7.0--py27_0
stdout: segmentation-fold_utils_extract_boxed_sequences.out
