cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cpstools
  - LSRs
label: cpstools_LSRs
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_file)
        writable: true
      - entry: $(inputs.repeat_file)
        entryname: $(inputs.input_file.basename.split('.')[0]).txt
doc: "Process GenBank files for LSRs\n\nTool homepage: https://github.com/Xwb7533/CPStools"
inputs:
  - id: input_file
    type: File
    doc: GenBank format file
    inputBinding:
      position: 101
      prefix: --input_file
  - id: repeat_file
    type: File
    doc: REPuter repeat result for the same genome. The tool reads it as <genbank name>.txt beside the GenBank file; it is staged under that name.
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: lsr_results
    type: File
    doc: LSRs with their location and region type, written beside the input file
    outputBinding:
      glob: '*_LSRs_loc_results.txt'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cpstools:3.0--pyhdfd78af_0
stdout: cpstools_LSRs.out
