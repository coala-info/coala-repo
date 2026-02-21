cwlVersion: v1.2
class: CommandLineTool
baseCommand: svanalyzer_SVwiden
label: svanalyzer_SVwiden
doc: "A tool for structural variant analysis. (Note: The provided input text is a
  container runtime error log and does not contain help documentation or argument
  definitions.)\n\nTool homepage: http://svanalyzer.readthedocs.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svanalyzer:0.36--pl5321hdfd78af_2
stdout: svanalyzer_SVwiden.out
