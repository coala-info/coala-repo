cwlVersion: v1.2
class: CommandLineTool
baseCommand: halfdeep_bam_depth.hifi.sh
label: halfdeep_bam_depth.hifi.sh
doc: "A script for calculating BAM depth for HiFi data using the HalfDeep tool. (Note:
  The provided help text contains container runtime errors and does not list specific
  arguments.)\n\nTool homepage: https://github.com/richard-burhans/HalfDeep"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/halfdeep:0.1.0--hdfd78af_1
stdout: halfdeep_bam_depth.hifi.sh.out
