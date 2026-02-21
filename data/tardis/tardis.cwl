cwlVersion: v1.2
class: CommandLineTool
baseCommand: tardis
label: tardis
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help documentation or argument definitions for the 'tardis'
  tool.\n\nTool homepage: https://github.com/AgResearch/tardis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tardis:1.0.19--py27ha92aebf_0
stdout: tardis.out
