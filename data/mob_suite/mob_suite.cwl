cwlVersion: v1.2
class: CommandLineTool
baseCommand: mob_suite
label: mob_suite
doc: "The provided text does not contain help information or a description of the
  tool. It contains error logs related to a container runtime (Singularity/Apptainer)
  failure due to insufficient disk space.\n\nTool homepage: https://github.com/phac-nml/mob-suite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mobyle-tutorials:v1.5.0-4-deb_cv1
stdout: mob_suite.out
