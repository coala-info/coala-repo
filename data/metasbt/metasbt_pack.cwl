cwlVersion: v1.2
class: CommandLineTool
baseCommand: pack
label: metasbt_pack
doc: "Pack a MetaSBT database into a compressed tarball.\n\nTool homepage: https://github.com/cumbof/MetaSBT"
inputs:
  - id: database
    type:
      - 'null'
      - string
    doc: The database name.
    default: MetaSBT
    inputBinding:
      position: 101
      prefix: --database
  - id: workdir
    type: Directory
    doc: Path to the working directory.
    inputBinding:
      position: 101
      prefix: --workdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metasbt:0.1.5--pyhdfd78af_0
stdout: metasbt_pack.out
