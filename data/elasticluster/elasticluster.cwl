cwlVersion: v1.2
class: CommandLineTool
baseCommand: elasticluster
label: elasticluster
doc: "The provided text is an error log from a container runtime (Singularity/Apptainer)
  and does not contain help information or argument definitions for the tool 'elasticluster'.\n
  \nTool homepage: https://github.com/elasticluster/elasticluster"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/elasticluster:0.1.3bcbio--py27_11
stdout: elasticluster.out
