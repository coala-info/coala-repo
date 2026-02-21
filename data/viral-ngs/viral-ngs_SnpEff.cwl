cwlVersion: v1.2
class: CommandLineTool
baseCommand: snpEff
label: viral-ngs_SnpEff
doc: "The provided text does not contain help documentation or usage instructions.
  It appears to be a log of a failed container build/fetch process (Singularity/Apptainer).\n
  \nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
stdout: viral-ngs_SnpEff.out
