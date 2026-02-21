cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fgbio
  - ClipBam
label: fgbio_ClipBam
doc: "Note: The provided text is a system error log (FATAL: no space left on device)
  and does not contain the actual help documentation for the tool. As a result, no
  arguments could be extracted.\n\nTool homepage: https://github.com/fulcrumgenomics/fgbio"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
stdout: fgbio_ClipBam.out
