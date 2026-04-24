cwlVersion: v1.2
class: CommandLineTool
baseCommand: metapi sync
label: metapi_sync
doc: "Sync project to a directory\n\nTool homepage: https://github.com/ohmeta/metapi"
inputs:
  - id: workflow
    type:
      - 'null'
      - string
    doc: workflow. Allowed values are simulate_wf, mag_wf, gene_wf
    inputBinding:
      position: 1
  - id: task
    type:
      - 'null'
      - string
    doc: pipeline end point
    inputBinding:
      position: 2
  - id: check_samples
    type:
      - 'null'
      - boolean
    doc: check samples
    inputBinding:
      position: 103
      prefix: --check-samples
  - id: config
    type:
      - 'null'
      - File
    doc: config.yaml
    inputBinding:
      position: 103
      prefix: --config
  - id: name
    type: string
    doc: project basename
    inputBinding:
      position: 103
      prefix: --name
  - id: outdir
    type: Directory
    doc: sync to a directory
    inputBinding:
      position: 103
      prefix: --outdir
  - id: split_num
    type:
      - 'null'
      - int
    doc: split project to sync directory
    inputBinding:
      position: 103
      prefix: --split-num
  - id: workdir
    type:
      - 'null'
      - Directory
    doc: project workdir
    inputBinding:
      position: 103
      prefix: --workdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metapi:3.0.0--pyhdfd78af_0
stdout: metapi_sync.out
