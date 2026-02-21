cwlVersion: v1.2
class: CommandLineTool
baseCommand: clinvar-tsv
label: clinvar-tsv
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to extract the tool's image due to lack of disk space. It does
  not contain help text or usage information for the clinvar-tsv tool.\n\nTool homepage:
  https://github.com/bihealth/clinvar-tsv"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clinvar-tsv:0.6.3--pyhdfd78af_0
stdout: clinvar-tsv.out
