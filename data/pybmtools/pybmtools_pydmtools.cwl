cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pybmtools
  - pydmtools
label: pybmtools_pydmtools
doc: "The provided text does not contain help information or usage instructions; it
  is a log of a failed container build process. No arguments could be extracted.\n
  \nTool homepage: https://github.com/ZhouQiangwei/pybmtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pybmtools:0.1.3--py38h5df1436_1
stdout: pybmtools_pydmtools.out
