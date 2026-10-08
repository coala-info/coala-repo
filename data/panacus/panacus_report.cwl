cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - panacus
  - report
label: panacus_report
doc: "Create an html report from a YAML config file\n\nTool homepage: https://github.com/marschall-lab/panacus"
inputs:
  - id: yaml_file
    type:
      - 'null'
      - File
    doc: Specifies yaml config
    inputBinding:
      position: 1
  - id: data_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Graph (GFA) and subset/group files named in the YAML config; staged in the
      working directory so the names in the config resolve
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: If set, no actual computation is done, only the planned computation 
      will be shown
    inputBinding:
      position: 102
      prefix: --dry-run
  - id: json
    type:
      - 'null'
      - boolean
    doc: Instead of an HTML report, a json result will be delivered. These can 
      later be combined and rendered as a single HTML.
    inputBinding:
      position: 102
      prefix: --json
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Set the number of threads used (default: use all threads)'
    inputBinding:
      position: 102
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Set the number of threads used (default: use all threads)'
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.data_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panacus:0.4.1--hc1c3326_0
stdout: panacus_report.out
