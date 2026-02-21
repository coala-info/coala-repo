cwlVersion: v1.2
class: CommandLineTool
baseCommand: cgat-report
label: cgat-report
doc: "The provided text is an error log from a container runtime (Singularity/Apptainer)
  and does not contain the help documentation or usage instructions for the cgat-report
  tool. The log indicates a failure to build the container image due to 'no space
  left on device'.\n\nTool homepage: https://github.com/AndreasHeger/CGATReport"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cgat-report:0.9.1--py_0
stdout: cgat-report.out
