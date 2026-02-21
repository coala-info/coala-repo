cwlVersion: v1.2
class: CommandLineTool
baseCommand: seq_crumbs_convert_format
label: seq_crumbs_convert_format
doc: "The provided text does not contain help information for seq_crumbs_convert_format;
  it is an error log from a container build process (Apptainer/Singularity) indicating
  a 'no space left on device' failure.\n\nTool homepage: https://github.com/JoseBlanca/seq_crumbs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sequana_pipetools:1.3.1--pyhdfd78af_0
stdout: seq_crumbs_convert_format.out
