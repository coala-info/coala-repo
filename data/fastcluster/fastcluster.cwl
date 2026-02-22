cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastcluster
label: fastcluster
doc: "The provided text is a system error log from a Singularity/Apptainer container
  build process and does not contain CLI help information or usage instructions for
  the tool 'fastcluster'.\n\nTool homepage: https://github.com/fastcluster/fastcluster"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastcluster:v1.1.22-1-deb-py2_cv1
stdout: fastcluster.out
