cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mykrobe
  - panels
  - update_metadata
label: mykrobe_panels_update_metadata
doc: "Update metadata about available species and their panels\n\nTool homepage: https://github.com/Mykrobe-tools/mykrobe"
inputs:
  - id: panels_dir
    type: Directory
    doc: Name of directory that contains panel data (a writable copy is staged and
      updated)
    inputBinding:
      position: 1
      prefix: --panels_dir
      valueFrom: $(self.basename)
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
    doc: Panel directory with updated metadata (manifest.json)
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
stdout: mykrobe_panels_update_metadata.out
