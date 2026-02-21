cwlVersion: v1.2
class: CommandLineTool
baseCommand: pmultiqc
label: pmultiqc_multiqc
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log from a container runtime (Apptainer/Singularity) failing
  to pull the image 'docker://quay.io/biocontainers/pmultiqc:0.0.40--pyhdfd78af_0'.\n
  \nTool homepage: https://github.com/bigbio/pmultiqc/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pmultiqc:0.0.40--pyhdfd78af_0
stdout: pmultiqc_multiqc.out
