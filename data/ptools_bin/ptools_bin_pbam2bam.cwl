cwlVersion: v1.2
class: CommandLineTool
baseCommand: ptools_bin_pbam2bam
label: ptools_bin_pbam2bam
doc: "The provided text does not contain help information for the tool, but appears
  to be a system error log from a container runtime (Singularity/Apptainer) failing
  to fetch an image. Based on the tool name, it is likely a utility for converting
  pBAM files to BAM format.\n\nTool homepage: https://github.com/ENCODE-DCC/ptools_bin"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ptools_bin:0.0.7--pyh5e36f6f_0
stdout: ptools_bin_pbam2bam.out
