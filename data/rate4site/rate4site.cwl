cwlVersion: v1.2
class: CommandLineTool
baseCommand: rate4site
label: rate4site
doc: "Rate4Site is a tool for calculating the relative evolutionary rate at each site
  for a given multiple sequence alignment (MSA). Note: The provided help text contains
  only container runtime error messages and does not list specific tool arguments.\n
  \nTool homepage: https://github.com/pupkoLab/Rate4Site"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rate4site:v3.0.0-6-deb_cv1
stdout: rate4site.out
