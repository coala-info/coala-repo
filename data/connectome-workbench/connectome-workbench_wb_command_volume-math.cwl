cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -volume-math
label: connectome-workbench_wb_command_volume-math
doc: "This command evaluates <expression> at each voxel independently. There must be at least one -var option (to get the volume space from), even if the <name> specified in it isn't used in <expression>. All volumes must have the same volume space. Filenames are not valid in <expression>, use a variable name and a -var option with matching <name> to specify an input file. If the -subvolume option is given to any -var option, only one subvolume is used from that file. If -repeat is specified, the file must either have only one subvolume, or have the -subvolume option specified. All files that don't use -repeat must have the same number of subvolumes requested to be used.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: expression
    type: string
    doc: "the expression to evaluate, in quotes"
    inputBinding:
      position: 1
  - id: volume_out
    type: string
    doc: "output - the output volume"
    inputBinding:
      position: 2
  - id: fixnan
    type:
      - 'null'
      - float
    doc: "replace NaN results with a value: value to replace NaN with"
    inputBinding:
      position: 3
      prefix: -fixnan
  - id: var
    type:
      type: array
      items:
        type: record
        fields:
          - name: name
            type: string
            doc: "the name of the variable, as used in the expression"
            inputBinding:
              position: 1
              prefix: -var
          - name: volume
            type: File
            doc: "the volume file to use as this variable"
            inputBinding:
              position: 2
          - name: subvolume
            type:
              - 'null'
              - string
            doc: "select a single subvolume: the subvolume number or name"
            inputBinding:
              position: 3
              prefix: -subvolume
          - name: repeat
            type:
              - 'null'
              - boolean
            doc: "reuse a single subvolume for each subvolume of calculation"
            inputBinding:
              position: 4
              prefix: -repeat
    doc: "repeatable -var (at least one): a volume file to use as a variable; one record per -var"
    inputBinding:
      position: 4
outputs:
  - id: output_volume
    type: File
    doc: "the output volume"
    outputBinding:
      glob: $(inputs.volume_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
