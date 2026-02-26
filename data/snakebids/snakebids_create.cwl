cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakebids_create
label: snakebids_create
doc: "Create a new snakebids project.\n\nTool homepage: https://github.com/khanlab/snakebids"
inputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory to create the snakebids project in.
    inputBinding:
      position: 1
  - id: snakebids_version
    type:
      - 'null'
      - string
    doc: Specify snakebids version requirement. Supports either a valid version 
      specifier (e.g. `>=x.x.x`, `==a.b.c`) or a url prepended with `@` (e.g. `@
      https://...`). Paths can be specified with `@ file:///absolute/path/...`. 
      Markers and extras may not be specified.
    inputBinding:
      position: 102
      prefix: --snakebids-version
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakebids:0.15.0--pyhdfd78af_0
stdout: snakebids_create.out
