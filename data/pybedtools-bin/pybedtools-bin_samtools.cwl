cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - samtools
label: pybedtools-bin_samtools
doc: "The provided text does not contain help information for the tool. It appears
  to be a log of a failed container build or execution attempt using Apptainer/Singularity.\n
  \nTool homepage: https://github.com/daler/pybedtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/pybedtools-bin:v0.8.0-1-deb_cv1
stdout: pybedtools-bin_samtools.out
