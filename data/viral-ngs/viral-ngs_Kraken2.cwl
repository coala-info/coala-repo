cwlVersion: v1.2
class: CommandLineTool
baseCommand: kraken2
label: viral-ngs_Kraken2
doc: "The provided text does not contain help information for the tool. It contains
  container runtime error logs (Singularity/Apptainer) indicating a failure to fetch
  or build the OCI image.\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
stdout: viral-ngs_Kraken2.out
