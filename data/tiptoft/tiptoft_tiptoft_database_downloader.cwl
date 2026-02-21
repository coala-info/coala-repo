cwlVersion: v1.2
class: CommandLineTool
baseCommand: tiptoft_database_downloader
label: tiptoft_tiptoft_database_downloader
doc: "Download the database for tiptoft. (Note: The provided text contains build logs
  rather than help text; no arguments could be extracted from the input.)\n\nTool
  homepage: https://github.com/andrewjpage/tiptoft"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tiptoft:1.0.2--py310h4b81fae_4
stdout: tiptoft_tiptoft_database_downloader.out
