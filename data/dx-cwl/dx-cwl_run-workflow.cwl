cwlVersion: v1.2
class: CommandLineTool
baseCommand: dx-cwl run-workflow
label: dx-cwl_run-workflow
doc: "Runs a CWL workflow on the DNAnexus platform.\n\nTool homepage: https://github.com/dnanexus/dx-cwl"
inputs:
  - id: workflow
    type: string
    doc: Pointer to workflow/applet file or ID on the platform
    inputBinding:
      position: 1
  - id: inputs
    type: string
    doc: Pointer to CWL input file on (JSON or YAML) the platform. All files 
      referenced within this file should exist within the project on the 
      platform. Relative paths are supported.
    inputBinding:
      position: 2
  - id: project
    type: string
    doc: DNAnexus project ID
    inputBinding:
      position: 103
      prefix: --project
  - id: rootdir
    type:
      - 'null'
      - string
    doc: Root directory to place CWL workflow, tools, and resources
    inputBinding:
      position: 103
      prefix: --rootdir
  - id: token
    type: string
    doc: DNAnexus authentication token
    inputBinding:
      position: 103
      prefix: --token
  - id: wait
    type:
      - 'null'
      - boolean
    doc: Pointer to CWL input file on (JSON or YAML) the platform. All files 
      referenced within this file should exist within the project on the 
      platform. Relative paths are supported.
    inputBinding:
      position: 103
      prefix: --wait
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dx-cwl:0.1.0a20180820--py27_0
stdout: dx-cwl_run-workflow.out
