cwlVersion: v1.2
class: CommandLineTool
baseCommand: dx-cwl compile-workflow
label: dx-cwl_compile-workflow
doc: "Compile a CWL workflow to a DNAnexus workflow.\n\nTool homepage: https://github.com/dnanexus/dx-cwl"
inputs:
  - id: workflow
    type: File
    doc: CWL workflow definition file
    inputBinding:
      position: 1
  - id: assets
    type:
      - 'null'
      - type: array
        items: string
    doc: One or more DNAnexus asset IDs to include in tools.
    inputBinding:
      position: 102
      prefix: --assets
  - id: bundled
    type:
      - 'null'
      - type: array
        items: string
    doc: One or more DNAnexus bundledDepends file IDs to include in tool.
    inputBinding:
      position: 102
      prefix: --bundled
  - id: instance_provider
    type:
      - 'null'
      - string
    doc: VM instance provider
    inputBinding:
      position: 102
      prefix: --instance-provider
  - id: project
    type: string
    doc: DNAnexus project ID
    inputBinding:
      position: 102
      prefix: --project
  - id: rootdir
    type:
      - 'null'
      - Directory
    doc: Root directory to place CWL workflow, tools, and resources
    inputBinding:
      position: 102
      prefix: --rootdir
  - id: token
    type: string
    doc: DNAnexus authentication token
    inputBinding:
      position: 102
      prefix: --token
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dx-cwl:0.1.0a20180820--py27_0
stdout: dx-cwl_compile-workflow.out
