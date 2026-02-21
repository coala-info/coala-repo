cwlVersion: v1.2
class: CommandLineTool
baseCommand: hsdecipher_HSD_batch_run.py
label: hsdecipher_HSD_batch_run.py
doc: "HSDecipher batch run script (Note: The provided text contains container runtime
  error logs rather than tool help documentation, so no arguments could be extracted).\n
  \nTool homepage: https://github.com/zx0223winner/HSDecipher"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hsdecipher:1.1.2--hdfd78af_0
stdout: hsdecipher_HSD_batch_run.py.out
