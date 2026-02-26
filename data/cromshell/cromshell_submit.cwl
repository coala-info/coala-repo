cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cromshell
  - submit
label: cromshell_submit
doc: "Submit a workflow and arguments to the Cromwell Server\n\nTool homepage: https://github.com/broadinstitute/cromshell"
inputs:
  - id: wdl
    type: File
    doc: WDL workflow file
    inputBinding:
      position: 1
  - id: wdl_json
    type: File
    doc: JSON file containing workflow arguments
    inputBinding:
      position: 2
  - id: dependencies_zip
    type:
      - 'null'
      - File
    doc: ZIP file or directory containing workflow source files that are used to
      resolve local imports. This zip bundle will be unpacked in a sandbox 
      accessible to this workflow.
    inputBinding:
      position: 103
      prefix: --dependencies-zip
  - id: do_not_flatten_wdls
    type:
      - 'null'
      - boolean
    doc: .
    inputBinding:
      position: 103
      prefix: --do-not-flatten-wdls
  - id: no_validation
    type:
      - 'null'
      - boolean
    doc: Do not check womtool for validation before submitting.
    inputBinding:
      position: 103
      prefix: --no-validation
  - id: options_json
    type:
      - 'null'
      - File
    doc: JSON file containing configuration options for the execution of the 
      workflow.
    inputBinding:
      position: 103
      prefix: --options-json
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cromshell:2.1.1--pyhdfd78af_0
stdout: cromshell_submit.out
