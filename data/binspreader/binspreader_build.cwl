cwlVersion: v1.2
class: CommandLineTool
baseCommand: binspreader_build
label: binspreader_build
doc: "The provided text appears to be a log of a container build process (Singularity/Apptainer)
  that failed due to insufficient disk space, rather than the help text for a command-line
  tool. As a result, no command-line arguments could be extracted.\n\nTool homepage:
  https://cab.spbu.ru/software/binspreader/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/binspreader:3.16.0.dev--h95f258a_0
stdout: binspreader_build.out
