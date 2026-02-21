cwlVersion: v1.2
class: CommandLineTool
baseCommand: fusioncatcher_download-human-db.sh
label: fusioncatcher_download-human-db.sh
doc: "Download the human database for FusionCatcher. (Note: The provided help text
  contains only system error messages regarding container building and does not list
  specific command-line arguments.)\n\nTool homepage: https://github.com/ndaniel/fusioncatcher"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fusioncatcher:1.33--hdfd78af_6
stdout: fusioncatcher_download-human-db.sh.out
