cwlVersion: v1.2
class: CommandLineTool
baseCommand: sanitizeme_SanitizeMePaired_CLI.py
label: sanitizeme_SanitizeMePaired_CLI.py
doc: "A tool for sanitizing paired-end sequencing data. (Note: The provided text contains
  container runtime logs and error messages rather than the tool's help documentation;
  therefore, no arguments could be extracted from the input.)\n\nTool homepage: https://github.com/jiangweiyao/SanitizeMe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sanitizeme:1.1--hdfd78af_2
stdout: sanitizeme_SanitizeMePaired_CLI.py.out
