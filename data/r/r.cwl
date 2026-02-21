cwlVersion: v1.2
class: CommandLineTool
baseCommand: r
label: r
doc: "The provided text appears to be an execution log or error message from a container
  runtime (Apptainer/Singularity) rather than CLI help text. It describes a failure
  to fetch or build a SIF image for a Bioconductor R package.\n\nTool homepage: https://github.com/alexdobin/STAR"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/bioconductor-bsgenome.cneoformansvargrubiikn99.ncbi.asm221672v1:1.0.0--r44hdfd78af_3
stdout: r.out
