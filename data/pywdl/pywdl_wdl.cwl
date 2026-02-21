cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pywdl
  - wdl
label: pywdl_wdl
doc: "The provided text does not contain help information or usage instructions; it
  appears to be a log of a failed container build process.\n\nTool homepage: https://github.com/broadinstitute/pywdl"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pywdl:1.0.22--py_1
stdout: pywdl_wdl.out
