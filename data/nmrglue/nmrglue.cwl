cwlVersion: v1.2
class: CommandLineTool
baseCommand: nmrglue
label: nmrglue
doc: "A tool for working with NMR data. (Note: The provided help text contains only
  container runtime error messages and does not list specific CLI arguments.)\n\n
  Tool homepage: http://www.nmrglue.com"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nmrglue:0.9--py310h1fe012e_2
stdout: nmrglue.out
