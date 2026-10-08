cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -wbsparse-merge-dense
label: connectome-workbench_wb_command_wbsparse-merge-dense
doc: "The input wbsparse files must have matching mappings along the direction not specified, and the mapping along the specified direction must be brain models.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: direction
    type: string
    doc: "which dimension to merge along, ROW or COLUMN"
    inputBinding:
      position: 1
  - id: wbsparse_out
    type: string
    doc: "output - the output wbsparse file"
    inputBinding:
      position: 2
  - id: wbsparse
    type:
      type: array
      items:
        type: record
        fields:
          - name: wbsparse_in
            type: File
            doc: "a wbsparse file to merge"
            inputBinding:
              position: 1
              prefix: -wbsparse
    doc: "repeatable -wbsparse (at least one): specify an input wbsparse file; one record per -wbsparse"
    inputBinding:
      position: 3
outputs:
  - id: output_wbsparse
    type: File
    doc: "the output wbsparse file"
    outputBinding:
      glob: $(inputs.wbsparse_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
