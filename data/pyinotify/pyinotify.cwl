cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyinotify
label: pyinotify
doc: "The provided text does not contain help documentation for pyinotify; it is a
  log of a failed container build process. No command-line arguments or descriptions
  could be extracted from the input.\n\nTool homepage: https://github.com/seb-m/pyinotify"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyinotify:0.9.6--py36_0
stdout: pyinotify.out
