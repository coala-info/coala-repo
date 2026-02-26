cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnaseq-manifest-generator
label: atol-genome-launcher_rnaseq-manifest-generator
doc: "Generate a manifest of RNAseq data for an organism.\n\nTool homepage: https://github.com/TomHarrop/atol-genome-launcher"
inputs:
  - id: organism_grouping_key
    type: string
    doc: Data Mapper organism_grouping_key
    inputBinding:
      position: 1
  - id: packages
    type: string
    doc: Mapped Packages CSV. FIXME. Should be JSON.
    inputBinding:
      position: 102
      prefix: --packages
  - id: resources
    type: string
    doc: Mapped Resources CSV. FIXME. Should be JSON.
    inputBinding:
      position: 102
      prefix: --resources
outputs:
  - id: manifest
    type: File
    doc: Path to output the manifest
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/atol-genome-launcher:0.4.1--pyhdfd78af_0
