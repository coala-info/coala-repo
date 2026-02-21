cwlVersion: v1.2
class: CommandLineTool
baseCommand: halfdeep_halfdeep.illumina.sh
label: halfdeep_halfdeep.illumina.sh
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build the image due to lack of disk space.\n\nTool homepage:
  https://github.com/richard-burhans/HalfDeep"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/halfdeep:0.1.0--hdfd78af_1
stdout: halfdeep_halfdeep.illumina.sh.out
