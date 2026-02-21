cwlVersion: v1.2
class: CommandLineTool
baseCommand: enhjoerning
label: enhjoerning
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs related to a container runtime (Apptainer/Singularity)
  failure due to insufficient disk space.\n\nTool homepage: https://github.com/GeoGenetics/unicorn"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/enhjoerning:2.4.0--h577a1d6_0
stdout: enhjoerning.out
