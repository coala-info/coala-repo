cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sparse
  - report
label: meta-sparse_sparse_report
doc: "Generate a flat-table report for multiple SPARSE runs. Also tries to identify some potential human pathogens.\n\nTool homepage: https://github.com/zheminzhou/SPARSE"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "$(inputs.workspaces.map(function (d) { return {entry: d, writable: true}; }))"
inputs:
  - id: path
    type: 
      - 'null'
      - string
    doc: "All sparse workspaces under the assigned folder will be added in automatically"
    inputBinding:
      position: 1
      prefix: --path
  - id: tag
    type: 
      - 'null'
      - string
    doc: "Tag level to report, default: s"
    inputBinding:
      position: 2
      prefix: --tag
  - id: absolute
    type: 
      - 'null'
      - boolean
    doc: "Report absolute numbers. Default: False (report percentages)"
    inputBinding:
      position: 3
      prefix: --absolute
  - id: low
    type: 
      - 'null'
      - float
    doc: "Lower limit of percentage for a value to report. Default: 0.0"
    inputBinding:
      position: 4
      prefix: --low
  - id: species_filter
    type: 
      - 'null'
      - File
    doc: "Show only species listed in the file"
    inputBinding:
      position: 5
      prefix: --speciesFilter
  - id: sample_filter
    type: 
      - 'null'
      - boolean
    doc: "Show only samples that have hits in the listed species. Default: False"
    inputBinding:
      position: 6
      prefix: --sampleFilter
  - id: inverse
    type: 
      - 'null'
      - boolean
    doc: "Inverse the output matrix such that columns are species and rows are samples"
    inputBinding:
      position: 7
      prefix: --inverse
  - id: workspaces
    type:
      type: array
      items: Directory
    doc: "Workspace folders (from sparse predict / sparse extract); at least one is required; staged writable"
    inputBinding:
      position: 8
      valueFrom: $(self.map(function (d) { return d.basename; }))
outputs:
  - id: workspaces_out
    type: Directory[]
    doc: "Workspace folders with the report files (profile.txt)"
    outputBinding:
      glob: $(inputs.workspaces.map(function (d) { return d.basename; }))
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meta-sparse:0.1.12--py27h24bf2e0_0
stdout: meta-sparse_sparse_report.out
