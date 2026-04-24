cwlVersion: v1.2
class: CommandLineTool
baseCommand: dx-cwl compile-tool
label: dx-cwl_compile-tool
doc: "Compile a CWL tool definition file into a DNAnexus applet.\n\nTool homepage:
  https://github.com/dnanexus/dx-cwl"
inputs:
  - id: tool
    type: File
    doc: CWL tool definition file
    inputBinding:
      position: 1
  - id: assets
    type:
      - 'null'
      - type: array
        items: string
    doc: One or more DNAnexus asset IDs to include in tool.
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
  - id: extradisk
    type:
      - 'null'
      - int
    doc: Additional disk space required for instance in mebibytes (2**20)
    inputBinding:
      position: 102
      prefix: --extradisk
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
stdout: dx-cwl_compile-tool.out
