cwlVersion: v1.2
class: CommandLineTool
baseCommand: isospecpy
label: isospecpy
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the tool's help information or usage instructions.\n\nTool
  homepage: http://matteolacki.github.io/IsoSpec/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isospecpy:2.2.2--py311h8ddd9a4_2
stdout: isospecpy.out
