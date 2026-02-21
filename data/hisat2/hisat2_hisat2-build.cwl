cwlVersion: v1.2
class: CommandLineTool
baseCommand: hisat2-build
label: hisat2_hisat2-build
doc: "The provided text does not contain help information for the tool. It appears
  to be a fatal error message from a container runtime (Singularity/Apptainer) indicating
  a failure to build the image due to insufficient disk space.\n\nTool homepage: http://daehwankimlab.github.io/hisat2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hisat2:2.2.2--h503566f_0
stdout: hisat2_hisat2-build.out
