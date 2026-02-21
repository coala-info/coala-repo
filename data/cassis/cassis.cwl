cwlVersion: v1.2
class: CommandLineTool
baseCommand: cassis
label: cassis
doc: "The provided text does not contain help information or usage instructions for
  the tool 'cassis'. It contains system log messages and a fatal error regarding a
  container build failure (no space left on device).\n\nTool homepage: http://pbil.univ-lyon1.fr/software/Cassis/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cassis:0.0.20120106--hdfd78af_1
stdout: cassis.out
