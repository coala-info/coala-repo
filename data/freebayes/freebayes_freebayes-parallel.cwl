cwlVersion: v1.2
class: CommandLineTool
baseCommand: freebayes-parallel
label: freebayes_freebayes-parallel
doc: "The provided text does not contain help information for the tool, but rather
  a fatal error message from a container runtime (Singularity/Apptainer) indicating
  a failure to build the image due to lack of disk space.\n\nTool homepage: https://github.com/freebayes/freebayes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/freebayes:1.3.10--hbefcdb2_0
stdout: freebayes_freebayes-parallel.out
