cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - expam
  - draw_tree
label: expam_draw_tree
doc: "Draw the reference tree.\n\nTool homepage: https://github.com/seansolari/expam"
inputs:
  - id: database
    type: Directory
    doc: "Expam database directory (-db). It is staged writable in the work directory and returned as an output."
    inputBinding:
      position: 1
      prefix: -db
      valueFrom: $(self.basename)
  - id: out_name
    type:
      - 'null'
      - string
    doc: "Directory to write phylotree.pdf into (-o). It must exist, so it is created in the work directory."
    inputBinding:
      position: 101
      prefix: -o
  - id: rank
    type:
      - 'null'
      - string
    doc: "Taxonomic rank at which leaves are coloured (--rank)."
    inputBinding:
      position: 101
      prefix: --rank
  - id: ignore_names
    type:
      - 'null'
      - boolean
    doc: "Do not label leaves with names."
    inputBinding:
      position: 101
      prefix: --ignore-names
outputs:
  - id: tree_pdf
    type:
      - 'null'
      - File
    doc: "The drawn reference tree"
    outputBinding:
      glob: $(inputs.out_name || '.')/phylotree.pdf
  - id: database_out
    type:
      - 'null'
      - Directory
    doc: "The database directory after the command ran"
    outputBinding:
      glob: $(inputs.database.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.database)
        writable: true
  - class: EnvVarRequirement
    envDef:
      - envName: USER
        envValue: expam
      - envName: QT_QPA_PLATFORM
        envValue: offscreen
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/expam:1.4.0.7--py39hbcbf7aa_0
    dockerOutputDirectory: /w
