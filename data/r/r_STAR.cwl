cwlVersion: v1.2
class: CommandLineTool
baseCommand: r_STAR
label: r_STAR
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a container runtime error log (Singularity/Apptainer)
  reporting a failure to fetch or build an OCI image.\n\nTool homepage: https://github.com/alexdobin/STAR"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/bioconductor-bsgenome.cneoformansvargrubiikn99.ncbi.asm221672v1:1.0.0--r44hdfd78af_3
stdout: r_STAR.out
