cwlVersion: v1.2
class: CommandLineTool
baseCommand: mob_cluster
label: mob_suite_mob_cluster
doc: "The provided text does not contain help information for the tool; it is a system
  error log indicating a failure to build or run a container due to insufficient disk
  space.\n\nTool homepage: https://github.com/phac-nml/mob-suite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mobyle-tutorials:v1.5.0-4-deb_cv1
stdout: mob_suite_mob_cluster.out
