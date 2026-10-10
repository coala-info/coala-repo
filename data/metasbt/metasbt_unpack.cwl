cwlVersion: v1.2
class: CommandLineTool
baseCommand: [metasbt, unpack]
label: metasbt_unpack
doc: "Unpack a local MetaSBT tarball database.\n\nTool homepage: https://github.com/cumbof/MetaSBT"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.workdir)
        entry: "$({class: 'Directory', basename: inputs.workdir, listing: []})"
        writable: true
inputs:
  - id: workdir
    type: string
    doc: "Path to the working directory (created before the run)."
    inputBinding:
      position: 101
      prefix: "--workdir"
  - id: database
    type:
      - 'null'
      - string
    doc: "The database name. (default: MetaSBT)"
    default: "MetaSBT"
    inputBinding:
      position: 101
      prefix: "--database"
  - id: tarball
    type:
      - 'null'
      - File
    doc: "Path to the MetaSBT tarball database."
    inputBinding:
      position: 101
      prefix: "--tarball"
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output"
  - id: workdir_out
    type: Directory
    doc: "Working directory with the database and the results"
    outputBinding:
      glob: "$(inputs.workdir)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metasbt:0.1.5--pyhdfd78af_0
    dockerOutputDirectory: /metasbt_work
stdout: metasbt_unpack.out
