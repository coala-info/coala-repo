cwlVersion: v1.2
class: CommandLineTool
baseCommand: cifte
label: beem-bio_cifte
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log from a container runtime (Singularity/Apptainer) indicating
  a failure to extract the OCI image due to insufficient disk space.\n\nTool homepage:
  https://github.com/kad-ecoli/BeEM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/beem-bio:1.0.1--h9948957_0
stdout: beem-bio_cifte.out
