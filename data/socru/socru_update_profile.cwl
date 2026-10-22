cwlVersion: v1.2
class: CommandLineTool
baseCommand: socru_update_profile
label: socru_update_profile
doc: "Admin utility to take the novel GS results and update the profile for the database\n\nTool homepage: https://github.com/quadram-institute-bioscience/socru"
inputs:
  - id: socru_output_filename
    type: File
    doc: Socru output file
    inputBinding:
      position: 1
  - id: profile_filename
    type: File
    doc: profile.txt from database
    inputBinding:
      position: 2
  - id: output_file
    type:
      - 'null'
      - string
    doc: Output filename (default updated_profile.txt)
    default: updated_profile.txt
    inputBinding:
      position: 103
      prefix: --output_file
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Turn on debugging
    inputBinding:
      position: 103
      prefix: --debug
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Turn on verbose output
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: updated_profile
    type: File
    doc: Updated profile
    outputBinding:
      glob: $(inputs.output_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/socru:2.2.5--pyhdfd78af_0
stdout: socru_update_profile.out
