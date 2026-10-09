cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - locidex
  - manifest
label: locidex_manifest
doc: "Create a multi-database folder manifest\n\nTool homepage: https://pypi.org/project/locidex/"
inputs:
  - id: input_directory
    type: Directory
    doc: Input directory containing multiple locidex databases. It is staged writable, because
      locidex writes manifest.json into it.
    inputBinding:
      position: 101
      prefix: --input
      valueFrom: $(self.basename)
outputs:
  - id: manifest
    type: File
    doc: Manifest file (manifest.json) listing the databases.
    outputBinding:
      glob: $(inputs.input_directory.basename + '/manifest.json')
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_directory)
        writable: true
  - class: EnvVarRequirement
    envDef:
      - envName: USER
        envValue: root
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/locidex:0.4.0--pyhdfd78af_0
stdout: locidex_manifest.out
