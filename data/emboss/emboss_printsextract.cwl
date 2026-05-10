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
  - id: outdir_path
    type: string
    doc: Output or path parameter `outdir_path`
    inputBinding:
      position: 102
      prefix: --outdir
outputs:
  - id: outdir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.outdir_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/emboss:6.6.0--h0f19ade_14
