cwlVersion: v1.2
class: CommandLineTool
baseCommand: whatsgnu_WhatsGNU_db_download.py
label: whatsgnu_WhatsGNU_db_download.py
doc: "Download the database for WhatsGNU. (Note: The provided text contains container
  runtime logs and error messages rather than command-line help documentation.)\n\n
  Tool homepage: https://github.com/ahmedmagds/WhatsGNU"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/whatsgnu:1.5--hdfd78af_0
stdout: whatsgnu_WhatsGNU_db_download.py.out
