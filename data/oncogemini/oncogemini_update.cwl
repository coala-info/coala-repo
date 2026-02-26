cwlVersion: v1.2
class: CommandLineTool
baseCommand: oncogemini update
label: oncogemini_update
doc: "Update oncogemini and its dependencies.\n\nTool homepage: https://github.com/fakedrtom/oncogemini"
inputs:
  - id: dataonly
    type:
      - 'null'
      - boolean
    doc: Only update data, not the underlying libraries.
    inputBinding:
      position: 101
      prefix: --dataonly
  - id: devel
    type:
      - 'null'
      - boolean
    doc: Get the latest development version instead of the release
    inputBinding:
      position: 101
      prefix: --devel
  - id: extra
    type:
      - 'null'
      - string
    doc: Add additional non-standard genome annotations to include
    inputBinding:
      position: 101
      prefix: --extra
  - id: nodata
    type:
      - 'null'
      - boolean
    doc: Do not install data dependencies
    inputBinding:
      position: 101
      prefix: --nodata
  - id: tooldir
    type:
      - 'null'
      - Directory
    doc: Directory for third party tools (ie /usr/local) update
    inputBinding:
      position: 101
      prefix: --tooldir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oncogemini:1.0.0--pyh3252c3a_0
stdout: oncogemini_update.out
