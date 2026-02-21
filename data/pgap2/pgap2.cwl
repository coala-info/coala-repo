cwlVersion: v1.2
class: CommandLineTool
baseCommand: pgap2
label: pgap2
doc: "The provided text is an error log from a container build process (Singularity/Apptainer)
  and does not contain help text or usage information for the tool 'pgap2'.\n\nTool
  homepage: https://github.com/bucongfan/PGAP2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pgap2:1.0.8--pyhdfd78af_0
stdout: pgap2.out
