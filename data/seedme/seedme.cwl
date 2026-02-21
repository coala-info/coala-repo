cwlVersion: v1.2
class: CommandLineTool
baseCommand: seedme
label: seedme
doc: "The provided text does not contain help information or usage instructions for
  the 'seedme' tool; it contains error logs from a container runtime (Apptainer/Singularity)
  indicating a failure to pull or build the image due to insufficient disk space.\n
  \nTool homepage: https://github.com/HackUCF/seedme"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seedme:1.2.4--py27_1
stdout: seedme.out
