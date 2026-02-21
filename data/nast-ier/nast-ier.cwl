cwlVersion: v1.2
class: CommandLineTool
baseCommand: nast-ier
label: nast-ier
doc: 'NAST-i-er is a tool for aligning 16S rRNA sequences against a reference database
  using the NAST (Nearest Alignment Space Termination) algorithm. (Note: The provided
  text was an execution error log and did not contain help documentation; therefore,
  no arguments could be extracted.)'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/nast-ier:v20101212dfsg1-2-deb_cv1
stdout: nast-ier.out
