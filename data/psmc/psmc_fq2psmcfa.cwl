cwlVersion: v1.2
class: CommandLineTool
baseCommand: psmc_fq2psmcfa
label: psmc_fq2psmcfa
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help text or usage information for the tool 'psmc_fq2psmcfa'.\n
  \nTool homepage: https://github.com/lh3/psmc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psmc:0.6.5--h5ca1c30_4
stdout: psmc_fq2psmcfa.out
