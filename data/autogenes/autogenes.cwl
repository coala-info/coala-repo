cwlVersion: v1.2
class: CommandLineTool
baseCommand: autogenes
label: autogenes
doc: "The provided text does not contain help information or usage instructions for
  the 'autogenes' tool; it contains error logs from a Singularity/Apptainer container
  build process that failed due to insufficient disk space.\n\nTool homepage: https://github.com/theislab/AutoGeneS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/autogenes:1.0.4--pyhdfd78af_0
stdout: autogenes.out
