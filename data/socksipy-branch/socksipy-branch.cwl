cwlVersion: v1.2
class: CommandLineTool
baseCommand: socksipy-branch
label: socksipy-branch
doc: "The provided text does not contain help information for the tool; it is a log
  of a failed container build process.\n\nTool homepage: https://github.com/gsutil-mirrors/socksipy-branch"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/socksipy-branch:1.01--py_1
stdout: socksipy-branch.out
