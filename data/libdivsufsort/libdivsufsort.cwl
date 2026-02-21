cwlVersion: v1.2
class: CommandLineTool
baseCommand: libdivsufsort
label: libdivsufsort
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build or pull the container image due to insufficient disk
  space. It does not contain the help text or usage information for the tool.\n\n
  Tool homepage: https://www.gnu.org/software/coreutils/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/libdivsufsort:2.0.2--1
stdout: libdivsufsort.out
