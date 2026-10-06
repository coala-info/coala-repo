cwlVersion: v1.2
class: CommandLineTool
baseCommand: autometa-setup-gtdb
label: autometa_autometa-setup-gtdb
doc: "Combine GTDB representative genome protein files (*_protein.faa.gz) and format them as a diamond database\n\nTool homepage: https://github.com/KwanLab/Autometa"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: reps_faa
    type:
      - File
      - Directory
    doc: "Directory (or .tar.gz tarball) containing GTDB ref genome amino acid sequences (*_protein.faa.gz)"
    inputBinding:
      position: 1
      prefix: --reps-faa
  - id: dbdir
    type: string
    doc: "Path to output GTDB database directory"
    inputBinding:
      position: 1
      prefix: --dbdir
  - id: cpus
    type:
      - 'null'
      - int
    doc: "Number of cpus to use for diamond-formatting GTDB database"
    inputBinding:
      position: 1
      prefix: --cpus
outputs:
  - id: gtdb_dir
    type: Directory
    doc: "GTDB database directory (gtdb.faa, gtdb.dmnd)"
    outputBinding:
      glob: "$(inputs.dbdir)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/autometa:2.2.3--pyh7e72e81_0
