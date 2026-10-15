cwlVersion: v1.2
class: CommandLineTool
baseCommand: summary_report_pid.py
label: plasmidid_summary_report_pid.py
doc: "Creates a summary report in tsv and hml from plasmidID execution\n\nTool homepage:
  https://github.com/BU-ISCIII/plasmidID"
inputs:
  - id: group
    type:
      - 'null'
      - boolean
    doc: Creates a group report instead of individual
    inputBinding:
      position: 101
      prefix: --group
  - id: input_folder
    type: Directory
    doc: REQUIRED.Input pID folder
    inputBinding:
      position: 101
      prefix: --input
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: report_folder
    type: Directory
    doc: The input folder with the report files written into it
    outputBinding:
      glob: $(inputs.input_folder.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_folder)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plasmidid:1.6.5--hdfd78af_0
stdout: plasmidid_summary_report_pid.py.out
