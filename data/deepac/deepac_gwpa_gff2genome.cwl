cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deepac
  - gwpa
  - gff2genome
label: deepac_gwpa_gff2genome
doc: "Generate .genome files.\n\nTool homepage: https://gitlab.com/rki_bioinformatics/DeePaC"
inputs:
  - id: gff3_dir
    type: Directory
    doc: "Input directory."
    inputBinding:
      position: 1
  - id: out_dir
    type: string
    doc: "Output directory."
    default: "genome"
    inputBinding:
      position: 2
outputs:
  - id: out
    type: Directory
    doc: "Output directory"
    outputBinding:
      glob: $(inputs.out_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepac:0.14.1--pyhdfd78af_0
