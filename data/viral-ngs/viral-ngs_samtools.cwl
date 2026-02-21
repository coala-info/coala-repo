cwlVersion: v1.2
class: CommandLineTool
baseCommand: viral-ngs_samtools
label: viral-ngs_samtools
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a container runtime error log (Singularity/Apptainer) indicating a
  failure to fetch or build the OCI image for viral-ngs.\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
stdout: viral-ngs_samtools.out
