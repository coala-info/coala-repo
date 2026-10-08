cwlVersion: v1.2
class: CommandLineTool
baseCommand: gdi
label: genomics-data-index_gdi_export_tree
doc: "Export the stored tree of a reference genome (Newick, or ASCII figure).\n\nThe tool needs a project folder made by \"gdi init\". It is passed as project_dir.\n\nTool homepage: https://github.com/apetkau/genomics-data-index"
arguments:
  - position: 3
    valueFrom: export
  - position: 4
    valueFrom: tree
inputs:
  - id: project_dir
    type: Directory
    doc: "project folder made by gdi init (global option --project-dir)"
    inputBinding:
      position: 1
      prefix: --project-dir
      valueFrom: $(self.basename)
  - id: ncores
    type:
      - 'null'
      - int
    doc: "Number of cores for any parallel processing"
    inputBinding:
      position: 1
      prefix: --ncores
  - id: log_level
    type:
      - 'null'
      - string
    doc: "Sets the log level (TRACE, DEBUG, INFO, WARNING, ERROR, CRITICAL)"
    inputBinding:
      position: 1
      prefix: --log-level
  - id: ascii
    type:
      - 'null'
      - boolean
    doc: "Export as ASCII figure"
    inputBinding:
      position: 10
      prefix: --ascii
  - id: no_ascii
    type:
      - 'null'
      - boolean
    doc: "Export as Newick (default)"
    inputBinding:
      position: 11
      prefix: --no-ascii
  - id: name
    type:
      - 'null'
      - type: array
        items: string
    doc: "Reference genome name(s) of the tree"
    inputBinding:
      position: 100
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      - envName: USER
        envValue: gdi
      - envName: QT_QPA_PLATFORM
        envValue: offscreen
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [{"entry": inputs.project_dir, "writable": true}];
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomics-data-index:0.9.2--pyhdfd78af_0
stdout: genomics-data-index_gdi_export_tree.out
