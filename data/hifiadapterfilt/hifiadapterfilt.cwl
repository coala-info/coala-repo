cwlVersion: v1.2
class: CommandLineTool
baseCommand: hifiadapterfilt
label: hifiadapterfilt
doc: "A tool for filtering adapter sequences from PacBio HiFi reads. (Note: Help text
  provided was an error log; arguments could not be parsed.)\n\nTool homepage: https://bio.tools/hifiadapterfilt"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hifiadapterfilt:3.0.0--hdfd78af_0
stdout: hifiadapterfilt.out
