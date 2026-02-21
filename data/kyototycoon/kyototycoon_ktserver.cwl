cwlVersion: v1.2
class: CommandLineTool
baseCommand: ktserver
label: kyototycoon_ktserver
doc: "Kyoto Tycoon database server (Note: The provided text is an error log and does
  not contain help information or argument definitions).\n\nTool homepage: https://github.com/alticelabs/kyoto"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kyototycoon:20170410--hbed32c3_5
stdout: kyototycoon_ktserver.out
