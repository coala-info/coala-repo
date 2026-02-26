cwlVersion: v1.2
class: CommandLineTool
baseCommand: nf-core subworkflows
label: nf-core_subworkflows
doc: "Commands to manage Nextflow DSL2 subworkflows (tool wrappers).\n\nTool homepage:
  http://nf-co.re/"
inputs:
  - id: command
    type: string
    doc: Command to execute (e.g., list, info, install, update, remove, patch, 
      create, lint, test)
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
  - id: branch
    type:
      - 'null'
      - string
    doc: Branch of git repository hosting modules.
    inputBinding:
      position: 103
      prefix: --branch
  - id: git_remote
    type:
      - 'null'
      - string
    doc: Remote git repo to fetch files from
    inputBinding:
      position: 103
      prefix: --git-remote
  - id: no_pull
    type:
      - 'null'
      - boolean
    doc: Do not pull in latest changes to local clone of modules repository.
    inputBinding:
      position: 103
      prefix: --no-pull
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nf-core:3.5.2--pyhdfd78af_0
stdout: nf-core_subworkflows.out
