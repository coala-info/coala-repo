cwlVersion: v1.2
class: CommandLineTool
baseCommand: vmatchselect
label: vmatch_vmatchselect
doc: "The provided text does not contain help information for the tool. It appears
  to be a fatal error log from a container runtime (Singularity/Apptainer) indicating
  a failure to fetch or build the OCI image.\n\nTool homepage: http://www.vmatch.de/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vmatch:2.3.1--h7b50bb2_0
stdout: vmatch_vmatchselect.out
