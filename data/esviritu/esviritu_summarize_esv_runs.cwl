cwlVersion: v1.2
class: CommandLineTool
baseCommand: summarize_esv_runs
label: esviritu_summarize_esv_runs
doc: "Summarize EsViritu run outputs across a directory.\n\nTool homepage: https://github.com/cmmr/EsViritu"
inputs:
  - id: directory
    type: Directory
    doc: Directory containing EsViritu .tsv outputs
    inputBinding:
      position: 1
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Directory to save output files
    inputBinding:
      position: 102
      prefix: --outdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esviritu:1.1.6--pyhdfd78af_0
stdout: esviritu_summarize_esv_runs.out
