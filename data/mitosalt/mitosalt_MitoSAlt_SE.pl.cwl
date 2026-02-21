cwlVersion: v1.2
class: CommandLineTool
baseCommand: mitosalt_MitoSAlt_SE.pl
label: mitosalt_MitoSAlt_SE.pl
doc: "MitoSAlt (Mitochondrial Structural Allele tracker) for Single-End (SE) data.
  Note: The provided text contains a container runtime error and does not include
  help documentation for argument extraction.\n\nTool homepage: https://sourceforge.net/projects/mitosalt/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mitosalt:1.1.1--hdfd78af_2
stdout: mitosalt_MitoSAlt_SE.pl.out
