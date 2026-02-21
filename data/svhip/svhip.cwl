cwlVersion: v1.2
class: CommandLineTool
baseCommand: svhip
label: svhip
doc: "Structural Variant Haplotype Informed Phenotyping\n\nTool homepage: https://github.com/chrisBioInf/Svhip"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svhip:1.0.9--hdfd78af_0
stdout: svhip.out
