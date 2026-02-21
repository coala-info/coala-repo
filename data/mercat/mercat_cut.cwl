cwlVersion: v1.2
class: CommandLineTool
baseCommand: mercat_cut
label: mercat_cut
doc: "The provided text does not contain help information for the tool; it contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to build an image due to lack of disk space.\n\nTool homepage: https://www.gnu.org/software/coreutils/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mercat:0.2--py_1
stdout: mercat_cut.out
