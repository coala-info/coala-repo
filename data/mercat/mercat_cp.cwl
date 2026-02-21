cwlVersion: v1.2
class: CommandLineTool
baseCommand: mercat_cp
label: mercat_cp
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a system error log related to a container runtime (Apptainer/Singularity)
  failure.\n\nTool homepage: https://www.gnu.org/software/coreutils/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mercat:0.2--py_1
stdout: mercat_cp.out
