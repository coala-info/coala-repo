cwlVersion: v1.2
class: CommandLineTool
baseCommand: hunspell-de-med_cp
label: hunspell-de-med_cp
doc: "A tool associated with the German medical dictionary for Hunspell. Note: The
  provided text contains system error messages regarding container image retrieval
  and does not list specific command-line arguments.\n\nTool homepage: https://github.com/glutanimate/hunspell-de-med-workaround"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/hunspell-de-med:v20160103-3-deb_cv1
stdout: hunspell-de-med_cp.out
