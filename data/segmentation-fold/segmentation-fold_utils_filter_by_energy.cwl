cwlVersion: v1.2
class: CommandLineTool
baseCommand: [segmentation-fold-utils, filter-by-energy]
label: segmentation-fold_utils_filter_by_energy
doc: "Split entries over two files based on the estimated energy\n\nTool homepage: https://github.com/yhoogstrate/segmentation-fold"
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: LANG
        envValue: C.UTF-8
inputs:
  - id: energy
    type: ['null', float]
    doc: "Entries with transitions with energy smaller than energy (< e) or without transitions go into the first output file, those larger or equal (>= e) into the second"
    inputBinding:
      position: 1
      prefix: --energy
  - id: dbn_input_file
    type: File
    doc: "DBN input file"
    inputBinding:
      position: 2
  - id: dbn_output_file_larger_or_equal
    type: string
    doc: "DBN output file name (entries < e or without transitions)"
    inputBinding:
      position: 3
  - id: dbn_output_file_smaller
    type: string
    doc: "DBN output file name (entries >= e)"
    inputBinding:
      position: 4
outputs:
  - id: dbn_larger_or_equal
    type: File
    doc: "First output file"
    outputBinding:
      glob: $(inputs.dbn_output_file_larger_or_equal)
  - id: dbn_smaller
    type: File
    doc: "Second output file"
    outputBinding:
      glob: $(inputs.dbn_output_file_smaller)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/segmentation-fold:1.7.0--py27_0
stdout: segmentation-fold_utils_filter_by_energy.out
