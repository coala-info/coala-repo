cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mykrobe
  - panels
  - update_species
label: mykrobe_panels_update_species
doc: "Update species panel(s)\n\nTool homepage: https://github.com/Mykrobe-tools/mykrobe"
inputs:
  - id: species
    type: string
    doc: Name of species to update, or 'all' to update all species
    inputBinding:
      position: 2
  - id: panels_dir
    type: Directory
    doc: Name of directory that contains panel data (a writable copy is staged and
      updated)
    inputBinding:
      position: 1
      prefix: --panels_dir
      valueFrom: $(self.basename)
  - id: remove
    type:
      - 'null'
      - boolean
    doc: Remove species instead of updating
    inputBinding:
      position: 1
      prefix: --remove
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Only output warnings/errors to stderr
    inputBinding:
      position: 1
      prefix: --quiet
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Output debugging information to stderr
    inputBinding:
      position: 1
      prefix: --debug
outputs:
  - id: updated_panels_dir
    type: Directory
    doc: Panel directory after the species update
    outputBinding:
      glob: $(inputs.panels_dir.basename)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.panels_dir)
        writable: true
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mykrobe:0.13.0--py38h59a8061_3
stdout: mykrobe_panels_update_species.out
