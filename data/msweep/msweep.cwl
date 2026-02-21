cwlVersion: v1.2
class: CommandLineTool
baseCommand: msweep
label: msweep
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the tool's help information or usage instructions. msweep is
  typically used for fast and accurate abundance estimation of bacterial lineages
  from sequencing data.\n\nTool homepage: https://github.com/PROBIC/mSWEEP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msweep:2.2.1--h503566f_1
stdout: msweep.out
