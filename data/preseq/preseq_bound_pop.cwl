cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - preseq
  - bound_pop
label: preseq_bound_pop
doc: "The provided text does not contain help information for the tool. It appears
  to be a fatal error log from a container runtime (Apptainer/Singularity) failing
  to fetch or build the OCI image.\n\nTool homepage: https://github.com/smithlabcode/preseq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/preseq:3.2.0--hdcf5f25_6
stdout: preseq_bound_pop.out
