cwlVersion: v1.2
class: CommandLineTool
baseCommand: hca-matrix-downloader
label: hca-matrix-downloader
doc: "Download data via HCA DCP FTP. Requires -p input. Files are downloaded into
  current working directory.\n\nTool homepage: https://github.com/ebi-gene-expression-group/hca-matrix-downloader"
inputs:
  - id: format
    type:
      - 'null'
      - string
    doc: 'Format to download matrix in: loom or mtx (Matrix Market). Defaults to loom.'
    inputBinding:
      position: 101
      prefix: --format
  - id: outprefix
    type:
      - 'null'
      - string
    doc: Output prefix to replace project uuid in filename of downloaded matrix.
      Leave as project uuid if not specified.
    inputBinding:
      position: 101
      prefix: --outprefix
  - id: project
    type: string
    doc: The project's Project Title, Project short name or link-derived ID, 
      obtained from the HCA DCP, wrapped in quotes.
    inputBinding:
      position: 101
      prefix: --project
  - id: species
    type:
      - 'null'
      - string
    doc: The species to use, when a project has more than one.
    inputBinding:
      position: 101
      prefix: --species
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hca-matrix-downloader:0.0.4--py_0
stdout: hca-matrix-downloader.out
