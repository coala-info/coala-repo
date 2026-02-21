cwlVersion: v1.2
class: CommandLineTool
baseCommand: sanitizeme_SanitizeMe_CLI.py
label: sanitizeme_SanitizeMe_CLI.py
doc: "A tool for sanitizing sequencing data (removing human reads). Note: The provided
  text appears to be a container build log rather than help text, so no arguments
  could be extracted.\n\nTool homepage: https://github.com/jiangweiyao/SanitizeMe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sanitizeme:1.1--hdfd78af_2
stdout: sanitizeme_SanitizeMe_CLI.py.out
