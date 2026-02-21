cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mimi
  - hmdb
  - extract
label: mimi_mimi_hmdb_extract
doc: "Extract data from HMDB (Human Metabolome Database)\n\nTool homepage: https://github.com/NYUAD-Core-Bioinformatics/MIMI"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mimi:1.0.4--pyhdfd78af_0
stdout: mimi_mimi_hmdb_extract.out
