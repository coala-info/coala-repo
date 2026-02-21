cwlVersion: v1.2
class: CommandLineTool
baseCommand: phirbo_phirbo.py
label: phirbo_phirbo.py
doc: "PHage-host Interaction Research By Orthology (Note: The provided text is a container
  build log and does not contain help information or argument definitions).\n\nTool
  homepage: https://github.com/aziele/phirbo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phirbo:1.0--0
stdout: phirbo_phirbo.py.out
