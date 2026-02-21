cwlVersion: v1.2
class: CommandLineTool
baseCommand: proot_pd
label: proot_pd
doc: "The provided text appears to be a log of a failed container build process rather
  than help documentation. No command-line arguments, flags, or usage instructions
  were found in the input.\n\nTool homepage: https://github.com/termux/proot-distro"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/proot:5.1.0--0
stdout: proot_pd.out
