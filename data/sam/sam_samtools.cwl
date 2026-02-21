cwlVersion: v1.2
class: CommandLineTool
baseCommand: samtools
label: sam_samtools
doc: "The provided text does not contain help information or usage instructions. It
  appears to be an error log from a container build process (Singularity/Apptainer).\n
  \nTool homepage: https://www.htslib.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sam:3.5--0
stdout: sam_samtools.out
