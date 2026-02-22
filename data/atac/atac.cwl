cwlVersion: v1.2
class: CommandLineTool
baseCommand: atac
label: atac
doc: "The provided text is a Singularity/Apptainer error log indicating a failure
  to build the container for 'atac' due to insufficient disk space. No help text or
  argument information was present in the input. Based on the container name (biocontainers/atac),
  this tool is likely the Assembly-to-Assembly Comparison tool.\n\nTool homepage:
  https://github.com/Julien-cpsn/ATAC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/atac:2008--py39pl5321h4846b57_8
stdout: atac.out
