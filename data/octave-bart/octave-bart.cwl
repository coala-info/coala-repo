cwlVersion: v1.2
class: CommandLineTool
baseCommand: octave-bart
label: octave-bart
doc: 'Octave interface for the Berkeley Advanced Reconstruction Toolbox (BART). Note:
  The provided text contains system error messages regarding container image conversion
  and does not list specific command-line arguments.'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/octave-bart:v0.4.04-2-deb_cv1
stdout: octave-bart.out
