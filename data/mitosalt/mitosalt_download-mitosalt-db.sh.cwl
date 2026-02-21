cwlVersion: v1.2
class: CommandLineTool
baseCommand: mitosalt_download-mitosalt-db.sh
label: mitosalt_download-mitosalt-db.sh
doc: "Download the MitoSALT database. (Note: The provided help text contains only
  system error messages and no usage information.)\n\nTool homepage: https://sourceforge.net/projects/mitosalt/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mitosalt:1.1.1--hdfd78af_2
stdout: mitosalt_download-mitosalt-db.sh.out
