cwlVersion: v1.2
class: CommandLineTool
baseCommand: theseus_make
label: theseus_make
doc: "The provided text appears to be a system error log from a container build process
  (Apptainer/Singularity) rather than the help text for the 'theseus_make' tool. As
  a result, no command-line arguments, flags, or descriptions could be extracted from
  the input.\n\nTool homepage: https://github.com/theseus-os/Theseus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/theseus:v3.3.0-8-deb_cv1
stdout: theseus_make.out
