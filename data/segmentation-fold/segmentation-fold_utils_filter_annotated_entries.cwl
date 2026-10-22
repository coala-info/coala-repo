cwlVersion: v1.2
class: CommandLineTool
baseCommand: [segmentation-fold-utils, filter-annotated-entries]
label: segmentation-fold_utils_filter_annotated_entries
doc: "Split entries into two files based on whether they overlap annotations in a bed file\n\nTool homepage: https://github.com/yhoogstrate/segmentation-fold"
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: LANG
        envValue: C.UTF-8
inputs:
  - id: regex
    type: ['null', string]
    doc: "Regex to capture the targeted location in DBN file (default: '>.*?(chr[^:]):([0-9]+)-([0-9]+)' )"
    inputBinding:
      position: 1
      prefix: --regex
  - id: dbn_input_file
    type: File
    doc: "DBN input file"
    inputBinding:
      position: 2
  - id: bed_input_file
    type: File
    doc: "BED annotation file"
    inputBinding:
      position: 3
  - id: dbn_output_file_overlapping
    type: string
    doc: "DBN output file name for overlapping entries"
    inputBinding:
      position: 4
  - id: dbn_output_file_non_overlapping
    type: string
    doc: "DBN output file name for non-overlapping entries"
    inputBinding:
      position: 5
outputs:
  - id: dbn_overlapping
    type: File
    doc: "Entries that overlap annotations"
    outputBinding:
      glob: $(inputs.dbn_output_file_overlapping)
  - id: dbn_non_overlapping
    type: File
    doc: "Entries that do not overlap annotations"
    outputBinding:
      glob: $(inputs.dbn_output_file_non_overlapping)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/segmentation-fold:1.7.0--py27_0
stdout: segmentation-fold_utils_filter_annotated_entries.out
