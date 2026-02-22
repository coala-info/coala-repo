cwlVersion: v1.2
class: CommandLineTool
baseCommand: corepywrap
label: corepywrap
doc: The provided text appears to be a log of a failed container 
  build/extraction process rather than a CLI help menu. No arguments or usage 
  instructions were found in the text.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/corepywrap:v1.005-6-deb-py2_cv1
stdout: corepywrap.out
