cwlVersion: v1.2
class: CommandLineTool
baseCommand: segemehl_haarz.x
label: segemehl_haarz.x
doc: "The provided input text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help text or usage information for segemehl_haarz.x. As
  a result, no arguments could be extracted.\n\nTool homepage: http://www.bioinf.uni-leipzig.de/Software/segemehl/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/segemehl:v0.3.4-1-deb_cv1
stdout: segemehl_haarz.x.out
