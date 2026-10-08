cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -volume-merge
label: connectome-workbench_wb_command_volume-merge
doc: "Takes one or more volume files and constructs a new volume file by concatenating subvolumes from them. The input volume files must have the same volume space.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: volume_out
    type: string
    doc: "output - the output volume file"
    inputBinding:
      position: 1
  - id: volume
    type:
      type: array
      items:
        type: record
        fields:
          - name: volume_in
            type: File
            doc: "a volume file to use subvolumes from"
            inputBinding:
              position: 1
              prefix: -volume
          - name: subvolume
            type:
              - 'null'
              - string
            doc: "select a single subvolume to use: the subvolume number or name"
            inputBinding:
              position: 2
              prefix: -subvolume
          - name: up_to
            type:
              - 'null'
              - string
            doc: "use an inclusive range of subvolumes: the number or name of the last subvolume to include (with -subvolume)"
            inputBinding:
              position: 3
              prefix: -up-to
          - name: reverse
            type:
              - 'null'
              - boolean
            doc: "use the range in reverse order (with -up-to)"
            inputBinding:
              position: 4
              prefix: -reverse
    doc: "repeatable -volume (at least one): specify an input volume file; one record per -volume"
    inputBinding:
      position: 2
outputs:
  - id: output_volume
    type: File
    doc: "the output volume file"
    outputBinding:
      glob: $(inputs.volume_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
