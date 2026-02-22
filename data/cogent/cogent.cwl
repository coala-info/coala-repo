cwlVersion: v1.2
class: CommandLineTool
baseCommand: cogent
label: cogent
doc: "COding GENome Reconstruction Tool (Cogent) for reconstructing coding sequences
  from transcriptomic data.\n\nTool homepage: http://www.pycogent.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/cogent:v1.9-14-deb-py2_cv1
stdout: cogent.out
