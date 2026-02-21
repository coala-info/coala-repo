cwlVersion: v1.2
class: CommandLineTool
baseCommand: vgp-processcuration_chromosome_assignment
label: vgp-processcuration_chromosome_assignment
doc: "A tool for chromosome assignment within the VGP (Vertebrate Genomes Project)
  curation pipeline. Note: The provided input text contained container execution logs
  and error messages rather than the tool's help documentation, so no arguments could
  be extracted.\n\nTool homepage: https://github.com/vgl-hub/vgl-curation"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vgp-processcuration:1.1--pyhdfd78af_0
stdout: vgp-processcuration_chromosome_assignment.out
