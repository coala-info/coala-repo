cwlVersion: v1.2
class: CommandLineTool
baseCommand: [segmentation-fold-utils, find-boxes]
label: segmentation-fold_utils_find_boxes
doc: "Finds all occurances of two given boxes (sequence motifs) within a FASTA file (sequence headers may not contain spaces)\n\nTool homepage: https://github.com/yhoogstrate/segmentation-fold"
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
  - id: box1
    type: ['null', string]
    doc: "Sequence of box1 (default = C-box: 'NRUGAUG')"
    inputBinding:
      position: 1
      prefix: --box1
  - id: box2
    type: ['null', string]
    doc: "Sequence of box2 (default = D-box: 'CUGA')"
    inputBinding:
      position: 1
      prefix: --box2
  - id: forward
    type: ['null', boolean]
    doc: "Search in the forward direction of the reference sequence"
    inputBinding:
      position: 1
      prefix: --forward
  - id: no_forward
    type: ['null', boolean]
    doc: "Do not search in the forward direction"
    inputBinding:
      position: 1
      prefix: --no-forward
  - id: reverse
    type: ['null', boolean]
    doc: "Search in the reverse complement of the reference sequence"
    inputBinding:
      position: 1
      prefix: --reverse
  - id: no_reverse
    type: ['null', boolean]
    doc: "Do not search in the reverse complement"
    inputBinding:
      position: 1
      prefix: --no-reverse
  - id: fasta_input_file
    type: File
    doc: "FASTA input file"
    inputBinding:
      position: 2
      valueFrom: $(self.basename)
  - id: bed_output_file
    type: string
    doc: "BED output file name"
    inputBinding:
      position: 3
outputs:
  - id: bed_output
    type: File
    doc: "BED file with box positions"
    outputBinding:
      glob: $(inputs.bed_output_file)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/segmentation-fold:1.7.0--py27_0
stdout: segmentation-fold_utils_find_boxes.out
