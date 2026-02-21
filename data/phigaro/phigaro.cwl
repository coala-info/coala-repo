cwlVersion: v1.2
class: CommandLineTool
baseCommand: phigaro
label: phigaro
doc: "Phigaro is a tool for phage detection in genomic and metagenomic assemblies.
  (Note: The provided text appears to be a container runtime error log rather than
  help text, so no arguments could be extracted.)\n\nTool homepage: https://phigaro.readthedocs.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phigaro:2.4.0--pyhdfd78af_0
stdout: phigaro.out
