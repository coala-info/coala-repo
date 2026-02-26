cwlVersion: v1.2
class: CommandLineTool
baseCommand: quantpi_sync
label: quantpi_sync
doc: "Sync project data to a directory.\n\nTool homepage: https://github.com/ohmeta/quantpi"
inputs:
  - id: workflow
    type:
      - 'null'
      - string
    doc: 'workflow. Allowed values are profiling_wf (default: profiling_wf)'
    default: profiling_wf
    inputBinding:
      position: 1
  - id: task
    type:
      - 'null'
      - string
    doc: 'pipeline end point (default: all)'
    default: all
    inputBinding:
      position: 2
  - id: check_samples
    type:
      - 'null'
      - boolean
    doc: 'check samples, default: False'
    default: false
    inputBinding:
      position: 103
      prefix: --check-samples
  - id: config
    type:
      - 'null'
      - File
    doc: 'config.yaml (default: ./config.yaml)'
    default: ./config.yaml
    inputBinding:
      position: 103
      prefix: --config
  - id: name
    type: string
    doc: project basename
    inputBinding:
      position: 103
      prefix: --name
  - id: split_num
    type:
      - 'null'
      - int
    doc: 'split project to sync directory (default: 1)'
    default: 1
    inputBinding:
      position: 103
      prefix: --split-num
  - id: workdir
    type:
      - 'null'
      - Directory
    doc: 'project workdir (default: ./) '
    default: ./
    inputBinding:
      position: 103
      prefix: --workdir
outputs:
  - id: outdir
    type: Directory
    doc: sync to a directory
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quantpi:1.0.0--pyh7e72e81_0
