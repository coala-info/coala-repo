cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - zdb
  - export
label: zdb_export
doc: "Exports the results of a given run name into an archive to make sharing easier\n\
  \nTool homepage: https://github.com/metagenlab/zDB/"
inputs:
  - id: dir
    type:
      - 'null'
      - Directory
    doc: specify the directory where the analysis was run
    inputBinding:
      position: 101
      prefix: --dir=
      separate: false
  - id: name
    type:
      - 'null'
      - string
    doc: specify the run to be exported
    inputBinding:
      position: 101
      prefix: --name=
      separate: false
outputs:
  - id: archive
    type:
      - 'null'
      - File
    doc: exported run archive
    outputBinding:
      glob: '*.tar.gz'
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/zdb:1.3.11--hdfd78af_0
stdout: zdb_export.out
