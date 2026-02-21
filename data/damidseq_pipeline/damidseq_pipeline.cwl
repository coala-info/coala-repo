cwlVersion: v1.2
class: CommandLineTool
baseCommand: damidseq_pipeline
label: damidseq_pipeline
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs related to a container runtime (Apptainer/Singularity)
  failing to extract the tool's image due to lack of disk space.\n\nTool homepage:
  https://github.com/owenjm/damidseq_pipeline"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/damidseq_pipeline:1.6.2--pl5321hdfd78af_0
stdout: damidseq_pipeline.out
