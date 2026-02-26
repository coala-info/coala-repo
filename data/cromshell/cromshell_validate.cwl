cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cromshell
  - validate
label: cromshell_validate
doc: "Validate a WDL workflow and its input JSON using the Cromwell server's womtool
  API and miniwdl.\n\nTool homepage: https://github.com/broadinstitute/cromshell"
inputs:
  - id: wdl
    type: File
    doc: WDL workflow file
    inputBinding:
      position: 1
  - id: wdl_json
    type:
      - 'null'
      - File
    doc: Input JSON file for the WDL workflow
    inputBinding:
      position: 2
  - id: dependencies_zip
    type:
      - 'null'
      - Directory
    doc: ZIP file or directory containing workflow source files that are used to
      resolve local imports. This zip bundle will be unpacked in a sandbox 
      accessible to this workflow.
    inputBinding:
      position: 103
      prefix: --dependencies-zip
  - id: no_miniwdl
    type:
      - 'null'
      - boolean
    doc: Disable miniwdl to validation.
    inputBinding:
      position: 103
      prefix: --no-miniwdl
  - id: no_womtool
    type:
      - 'null'
      - boolean
    doc: Disable womtool to validation.
    inputBinding:
      position: 103
      prefix: --no-womtool
  - id: strict
    type:
      - 'null'
      - boolean
    doc: Exit with nonzero status code if any lint warnings are shown (in 
      addition to syntax and type errors)
    inputBinding:
      position: 103
      prefix: --strict
  - id: suppress
    type:
      - 'null'
      - type: array
        items: string
    doc: Warnings to disable e.g. StringCoercion,NonemptyCoercion. (can supply 
      multiple times)
    inputBinding:
      position: 103
      prefix: --suppress
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cromshell:2.1.1--pyhdfd78af_0
stdout: cromshell_validate.out
