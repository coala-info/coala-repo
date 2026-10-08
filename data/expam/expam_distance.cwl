cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - expam
  - distance
label: expam_distance
doc: "Compute pairwise distances between sketched sequences.\n\nTool homepage: https://github.com/seansolari/expam"
inputs:
  - id: database
    type: Directory
    doc: "Expam database directory (-db). It is staged writable in the work directory and returned as an output."
    inputBinding:
      position: 1
      prefix: -db
      valueFrom: $(self.basename)
  - id: group
    type:
      - 'null'
      - string
    doc: "Name of the sequence group the command applies to (--group)."
    inputBinding:
      position: 101
      prefix: --group
  - id: sourmash
    type:
      - 'null'
      - boolean
    doc: "Use sourmash for distance estimation."
    inputBinding:
      position: 101
      prefix: --sourmash
outputs:
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
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/expam:1.4.0.7--py39hbcbf7aa_0
    dockerOutputDirectory: /w
