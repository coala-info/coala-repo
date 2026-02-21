cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - svanalyzer
  - SVcomp
label: svanalyzer_SVcomp
doc: "Structural variant comparison tool (Note: The provided text contains container
  runtime errors and does not include usage information or argument definitions).\n
  \nTool homepage: http://svanalyzer.readthedocs.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svanalyzer:0.36--pl5321hdfd78af_2
stdout: svanalyzer_SVcomp.out
