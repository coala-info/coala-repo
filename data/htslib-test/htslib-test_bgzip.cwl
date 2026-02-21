cwlVersion: v1.2
class: CommandLineTool
baseCommand: htslib-test_bgzip
label: htslib-test_bgzip
doc: "The provided text does not contain help information for the tool, but rather
  error logs from a container runtime environment (Apptainer/Singularity) indicating
  a failure to build the container image due to lack of disk space.\n\nTool homepage:
  https://github.com/samtools/htslib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/htslib-test:v1.9-11-deb_cv1
stdout: htslib-test_bgzip.out
