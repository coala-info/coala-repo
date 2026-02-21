cwlVersion: v1.2
class: CommandLineTool
baseCommand: halfdeep_bam_depth.asm5.sh
label: halfdeep_bam_depth.asm5.sh
doc: "The provided text does not contain help documentation for the tool, but rather
  error logs from a container runtime (Apptainer/Singularity) indicating a failure
  to build the image due to lack of disk space.\n\nTool homepage: https://github.com/richard-burhans/HalfDeep"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/halfdeep:0.1.0--hdfd78af_1
stdout: halfdeep_bam_depth.asm5.sh.out
