cwlVersion: v1.2
class: CommandLineTool
baseCommand: edta_EDTA.pl
label: edta_EDTA.pl
doc: "Extensive de-novo TE Annotator (EDTA). Note: The provided text is a system error
  log indicating a failure to initialize the container environment (no space left
  on device) and does not contain the actual help documentation for the tool.\n\n
  Tool homepage: https://github.com/oushujun/EDTA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/edta:2.2.2--hdfd78af_1
stdout: edta_EDTA.pl.out
