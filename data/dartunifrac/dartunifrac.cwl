cwlVersion: v1.2
class: CommandLineTool
baseCommand: dartunifrac
label: dartunifrac
doc: "The provided text does not contain help information for the tool. It is an error
  log from a container build process (Apptainer/Singularity) indicating a 'no space
  left on device' failure.\n\nTool homepage: https://github.com/jianshu93/DartUniFrac"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dartunifrac:0.2.9--h3dc2dae_0
stdout: dartunifrac.out
