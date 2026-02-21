cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bart
  - update
label: bart_bart-update
doc: "The provided text does not contain help information for the tool. It appears
  to be an error log from a container build process (Singularity/Apptainer) indicating
  a 'no space left on device' failure.\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bart:0.1.2--pyhdfd78af_0
stdout: bart_bart-update.out
