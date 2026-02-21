cwlVersion: v1.2
class: CommandLineTool
baseCommand: squizz
label: squizz
doc: "The provided text does not contain help information or usage instructions for
  the tool 'squizz'. It contains error logs related to a container image build failure.\n
  \nTool homepage: http://ftp.pasteur.fr/pub/gensoft/projects/squizz/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/squizz:v0.99ddfsg-2-deb_cv1
stdout: squizz.out
