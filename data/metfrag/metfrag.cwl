cwlVersion: v1.2
class: CommandLineTool
baseCommand: metfrag
label: metfrag
doc: "MetFrag: In silico fragmentation for computer-assisted identification of metabolite
  structures. (Note: The provided text is a system error log and does not contain
  usage instructions or argument definitions.)\n\nTool homepage: http://c-ruttkies.github.io/MetFrag/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metfrag:2.4.5--3
stdout: metfrag.out
