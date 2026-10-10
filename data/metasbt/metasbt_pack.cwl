cwlVersion: v1.2
class: CommandLineTool
baseCommand: [metasbt, pack]
label: metasbt_pack
doc: "Pack a MetaSBT database into a compressed tarball.\n\nTool homepage: https://github.com/cumbof/MetaSBT"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.workdir)
        writable: true
inputs:
  - id: workdir
    type: Directory
    doc: "Path to the working directory with the MetaSBT database. It is staged as a writable copy."
    inputBinding:
      position: 101
      prefix: "--workdir"
      valueFrom: "$(self.basename)"
  - id: database
    type:
      - 'null'
      - string
    doc: "The database name. (default: MetaSBT)"
    default: "MetaSBT"
    inputBinding:
      position: 101
      prefix: "--database"
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output"
  - id: workdir_out
    type: Directory
    doc: "Working directory with the database and the results"
    outputBinding:
      glob: "$(inputs.workdir.basename)"
  - id: tarball
    type:
      type: array
      items: File
    doc: "Compressed tarball of the database"
    outputBinding:
      glob: "$(inputs.workdir.basename)/*.tar.gz"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metasbt:0.1.5--pyhdfd78af_0
    dockerOutputDirectory: /metasbt_work
stdout: metasbt_pack.out
