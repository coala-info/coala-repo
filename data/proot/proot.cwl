cwlVersion: v1.2
class: CommandLineTool
baseCommand: proot
label: proot
doc: "The provided text does not contain help information or usage instructions for
  the tool 'proot'. It appears to be a log of a failed container build process.\n\n
  Tool homepage: https://github.com/termux/proot-distro"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/proot:5.1.0--0
stdout: proot.out
