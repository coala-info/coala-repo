cwlVersion: v1.2
class: CommandLineTool
baseCommand: basenji_bam_cov.py
label: basenji_bam_cov.py
doc: "The provided text does not contain help information for the tool; it is an error
  log describing a failure to build a Singularity/Apptainer container due to insufficient
  disk space.\n\nTool homepage: https://github.com/calico/basenji"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/basenji:0.6--pyhdfd78af_0
stdout: basenji_bam_cov.py.out
