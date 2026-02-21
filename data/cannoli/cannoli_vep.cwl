cwlVersion: v1.2
class: CommandLineTool
baseCommand: cannoli_vep
label: cannoli_vep
doc: "The provided text is a system error log indicating a container build failure
  (no space left on device) and does not contain CLI help information, usage instructions,
  or argument definitions.\n\nTool homepage: https://github.com/bigdatagenomics/cannoli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cannoli:1.0.1--hdfd78af_0
stdout: cannoli_vep.out
