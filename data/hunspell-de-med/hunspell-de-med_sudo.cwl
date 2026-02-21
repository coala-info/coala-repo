cwlVersion: v1.2
class: CommandLineTool
baseCommand: hunspell-de-med
label: hunspell-de-med_sudo
doc: "German medical dictionary for Hunspell. (Note: The provided text is a container
  execution error log and does not contain usage instructions or argument definitions.)\n
  \nTool homepage: https://github.com/glutanimate/hunspell-de-med-workaround"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/hunspell-de-med:v20160103-3-deb_cv1
stdout: hunspell-de-med_sudo.out
