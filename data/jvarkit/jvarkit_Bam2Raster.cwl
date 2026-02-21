cwlVersion: v1.2
class: CommandLineTool
baseCommand: jvarkit_Bam2Raster
label: jvarkit_Bam2Raster
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failure
  due to lack of disk space.\n\nTool homepage: https://github.com/lindenb/jvarkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jvarkit:2024.08.25--hdfd78af_2
stdout: jvarkit_Bam2Raster.out
