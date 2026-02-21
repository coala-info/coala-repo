cwlVersion: v1.2
class: CommandLineTool
baseCommand: repeatmasker-recon
label: repeatmasker-recon
doc: "A tool for de novo identification of repeat families in genomic sequences. Note:
  The provided help text contains only system logs and a fatal error, so no arguments
  could be extracted.\n\nTool homepage: https://www.repeatmasker.org/RepeatMasker"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/repeatmasker-recon:v1.08-4-deb_cv1
stdout: repeatmasker-recon.out
