cwlVersion: v1.2
class: CommandLineTool
baseCommand: SnpSift
label: snpeff_SnpSift
doc: "SnpSift is a toolbox that allows you to filter and manipulate VCF files. (Note:
  The provided text contains error logs rather than help documentation; no arguments
  could be extracted from the input).\n\nTool homepage: http://snpeff.sourceforge.net/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snpeff:5.4.0a--hdfd78af_0
stdout: snpeff_SnpSift.out
