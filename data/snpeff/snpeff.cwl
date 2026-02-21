cwlVersion: v1.2
class: CommandLineTool
baseCommand: snpeff
label: snpeff
doc: "SnpEff is a genetic variant annotation and functional effect prediction toolbox.
  (Note: The provided text appears to be a container execution log rather than help
  text, so no arguments could be extracted.)\n\nTool homepage: http://snpeff.sourceforge.net/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snpeff:5.4.0a--hdfd78af_0
stdout: snpeff.out
