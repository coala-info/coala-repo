cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - popscle
  - freemuxlet
label: popscle_freemuxlet
doc: "The provided text does not contain help information for the tool. It consists
  of error logs from a container runtime (Singularity/Apptainer) indicating a failure
  to fetch or build the OCI image.\n\nTool homepage: https://github.com/statgen/popscle"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/popscle:0.1--ha0d7e29_1
stdout: popscle_freemuxlet.out
