cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - viral-ngs
  - SPAdes
label: viral-ngs_SPAdes
doc: "The provided text is a system error log from a container runtime (Singularity/Apptainer)
  and does not contain help information or argument definitions for the tool viral-ngs_SPAdes.\n
  \nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
stdout: viral-ngs_SPAdes.out
