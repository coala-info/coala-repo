cwlVersion: v1.2
class: CommandLineTool
baseCommand: mztosqlite
label: mztosqlite
doc: "A tool for converting mass spectrometry data (mzML) to SQLite format.\n\nTool
  homepage: https://github.com/galaxyproteomics/mzToSQLite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mztosqlite:2.1.1--py312h7e72e81_2
stdout: mztosqlite.out
