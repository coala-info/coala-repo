cwlVersion: v1.2
class: CommandLineTool
baseCommand: gdi
label: genomics-data-index_gdi_load_mlst-tseemann
doc: "Load MLST results from the mlst tool of T. Seemann into the index.\n\nThe tool needs a project folder made by \"gdi init\". It is passed as project_dir.\n\nTool homepage: https://github.com/apetkau/genomics-data-index"
arguments:
  - position: 3
    valueFrom: load
  - position: 4
    valueFrom: mlst-tseemann
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
  - id: scheme_name
    type:
      - 'null'
      - string
    doc: "Scheme name (overrides the name found in the file)"
    inputBinding:
      position: 10
      prefix: --scheme-name
  - id: mlst_file
    type:
      type: array
      items: File
    doc: "MLST result file(s)"
    inputBinding:
      position: 100
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output"
  - id: project_dir_out
    type:
      - 'null'
      - Directory
    doc: "The project folder with the new data"
    outputBinding:
      glob: $(inputs.project_dir.basename)
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
stdout: genomics-data-index_gdi_load_mlst-tseemann.out
