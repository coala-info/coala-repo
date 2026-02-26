cwlVersion: v1.2
class: CommandLineTool
baseCommand: nf-core pipelines
label: nf-core_pipelines
doc: "Commands to manage nf-core pipelines.\n\nTool homepage: http://nf-co.re/"
inputs:
  - id: command
    type: string
    doc: Command to execute (e.g., download, create-params-file, launch, list, 
      bump-version, create, create-logo, lint, rocrate, schema, sync)
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nf-core:3.5.2--pyhdfd78af_0
stdout: nf-core_pipelines.out
