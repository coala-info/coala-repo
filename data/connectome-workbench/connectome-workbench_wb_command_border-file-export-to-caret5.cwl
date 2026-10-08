cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -border-file-export-to-caret5
label: connectome-workbench_wb_command_border-file-export-to-caret5
doc: "A Workbench border file may contain borders for multiple structures and borders that are both projected and unprojected. It also contains a color table for the borders. Caret5 has both border (unprojected) and border projection (projected) files. In addition, each Caret5 border or border projection file typically contains data for a single structure. Caret5 also uses a border color file that associates colors with the names of the borders. This command will try to output both Caret5 border and border projection files. Each output border/border projection file will contains data for one structure so there may be many files created. The structure name is included in the name of each border or border projection file that is created. One Caret5 border color file will also be produced by this command. Providing surface(s) as input parameters is optional, but recommended. Surfaces may be needed to create both projected and/or unprojected coordinates of borders. If there is a failure to produce an output border or border projection due to a missing surface with the matching structure, an error message will be displayed and some output files will not be created. When writing new files, this command will overwrite a file with the same name.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: border_file
    type: File
    doc: workbench border file
    inputBinding:
      position: 1
  - id: output_file_prefix
    type: string
    doc: prefix for name of output caret5 border/borderproj/bordercolor files
    inputBinding:
      position: 2
  - id: surface
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: -surface
    doc: 'specify an input surface: a surface file for unprojection of borders (repeatable)'
    inputBinding:
      position: 3
outputs:
  - id: caret5_files
    type:
      type: array
      items: File
    doc: Caret5 border, border projection and border color files
    outputBinding:
      glob: $(inputs.output_file_prefix)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
