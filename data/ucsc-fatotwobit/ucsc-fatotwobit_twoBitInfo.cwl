cwlVersion: v1.2
class: CommandLineTool
baseCommand: twoBitInfo
label: ucsc-fatotwobit_twoBitInfo
doc: "The provided text does not contain help information for the tool. It appears
  to be a fatal error log from a container runtime (Apptainer/Singularity) failing
  to fetch the OCI image.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-fatotwobit:482--hdc0a859_0
stdout: ucsc-fatotwobit_twoBitInfo.out
