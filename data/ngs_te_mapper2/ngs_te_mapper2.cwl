cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngs_te_mapper2
label: ngs_te_mapper2
doc: "The provided text is an error message related to a container environment (Apptainer/Singularity)
  and does not contain the help text or argument definitions for ngs_te_mapper2.\n
  \nTool homepage: https://github.com/bergmanlab/ngs_te_mapper2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ngs:v2.9.3-1-deb-py2_cv1
stdout: ngs_te_mapper2.out
