cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnftools
label: rnftools
doc: "RNFtools is a framework for simulating NGS reads and evaluating mappers. (Note:
  The provided text appears to be a container build error log rather than help text;
  no arguments could be extracted from the input).\n\nTool homepage: http://karel-brinda.github.io/rnftools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnftools:0.4.0.0--pyhdfd78af_0
stdout: rnftools.out
