cwlVersion: v1.2
class: CommandLineTool
baseCommand: proot-distro
label: proot_proot-distro
doc: "The provided text appears to be an error log from a container build process
  (Apptainer/Singularity) rather than help text for the proot-distro tool. Consequently,
  no command-line arguments, flags, or descriptions could be extracted.\n\nTool homepage:
  https://github.com/termux/proot-distro"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/proot:5.1.0--0
stdout: proot_proot-distro.out
