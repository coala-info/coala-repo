cwlVersion: v1.2
class: CommandLineTool
baseCommand: freyja update
label: freyja_update
doc: "Update to the most recent barcodes and curated lineage data\n\nTool homepage:
  https://github.com/andersen-lab/Freyja"
inputs:
  - id: buildlocal
    type:
      - 'null'
      - boolean
    doc: Perform barcode building locally(only available for SARS-CoV-2)
    inputBinding:
      position: 101
      prefix: --buildlocal
  - id: noncl
    type:
      - 'null'
      - boolean
    doc: only include lineages that are confirmed by cov-lineages
    default: true
    inputBinding:
      position: 101
      prefix: --noncl
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory to save updated files.if this option is used, the 
      barcodes are onlydownloaded to the directory specified.
    default: '""'
    inputBinding:
      position: 101
      prefix: --outdir
  - id: pathogen
    type:
      - 'null'
      - string
    doc: Pathogen to provide update for
    default: SARS-CoV-2
    inputBinding:
      position: 101
      prefix: --pathogen
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/freyja:2.0.3--pyhdfd78af_0
stdout: freyja_update.out
