cwlVersion: v1.2
class: CommandLineTool
baseCommand: blasr_libcpp
label: blasr_libcpp
doc: "The provided text does not contain help information for the tool. It is a log
  of a container execution failure indicating that the executable 'blasr_libcpp' was
  not found in the system PATH.\n\nTool homepage: https://github.com/PacificBiosciences/blasr_libcpp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blasr_libcpp:5.3.4--h6479705_1
stdout: blasr_libcpp.out
