cwlVersion: v1.2
class: CommandLineTool
baseCommand: populations
label: populations
doc: "The provided text does not contain help documentation or usage instructions
  for the 'populations' tool. It contains system error messages related to a failed
  container image retrieval (Singularity/Docker) due to insufficient disk space.\n\
  \nTool homepage: https://github.com/tj/git-extras"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/populations:v1.2.33svn0120106dfsg-2-deb_cv1
stdout: populations.out
