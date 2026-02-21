cwlVersion: v1.2
class: CommandLineTool
baseCommand: hisat-3n-build
label: hisat-3n_hisat-3n-build
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help text or usage information for hisat-3n-build. As a
  result, no arguments could be extracted.\n\nTool homepage: https://github.com/fulcrumgenomics/hisat-3n"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hisat-3n:0.0.3--h503566f_0
stdout: hisat-3n_hisat-3n-build.out
