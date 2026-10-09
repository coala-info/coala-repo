cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - memote
  - report
  - history
label: memote_report_history
doc: "Generate a report over a model's git commit history.\n\nTool homepage: https://memote.readthedocs.io/"
inputs:
  - id: results_location
    type:
      - 'null'
      - string
    doc: Location of test results. Can either by a directory or an rfc1738 
      compatible database URL.
    inputBinding:
      position: 102
      prefix: --location
  - id: model
    type:
      - 'null'
      - string
    doc: The path of the model file. Used to check if it was modified.
    inputBinding:
      position: 102
      prefix: --model
  - id: deployment
    type:
      - 'null'
      - string
    doc: Results will be read from and committed to the given branch.
    inputBinding:
      position: 102
      prefix: --deployment
  - id: custom_config
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --custom-config
          separate: true
    doc: A path to a report configuration file that will be merged into the 
      default configuration. This option can be specified multiple times.
    inputBinding:
      position: 102
  - id: filename_path
    type: string
    doc: Path for the HTML report output.
    inputBinding:
      position: 103
      prefix: --filename
outputs:
  - id: filename
    type:
      - 'null'
      - File
    doc: The HTML report.
    outputBinding:
      glob: $(inputs.filename_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/memote:0.17.0--pyhdfd78af_0
