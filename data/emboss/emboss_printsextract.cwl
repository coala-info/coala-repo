cwlVersion: v1.2
class: CommandLineTool
baseCommand: printsextract
label: emboss_printsextract
doc: "Extract fingerprints from PRINTS database\n\nTool homepage: http://emboss.open-bio.org/"
inputs:
  - id: dbdir
    type: Directory
    doc: PRINTS database directory
    inputBinding:
      position: 101
      prefix: -dbdir
outputs:
  - id: outdir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/emboss:6.6.0--h0f19ade_14
