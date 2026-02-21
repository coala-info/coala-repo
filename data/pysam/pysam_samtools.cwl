cwlVersion: v1.2
class: CommandLineTool
baseCommand: pysam
label: pysam_samtools
doc: "The provided text does not contain help information or usage instructions; it
  is an error log from a container build process (Singularity/Apptainer) attempting
  to fetch a pysam image.\n\nTool homepage: https://github.com/pysam-developers/pysam"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pysam:0.23.3--py39hdd5828d_1
stdout: pysam_samtools.out
