cwlVersion: v1.2
class: CommandLineTool
baseCommand: biolib
label: pybiolib_biolib
doc: "BioLib command line tool (Note: The provided text appears to be a system log
  rather than help text, so no arguments could be extracted).\n\nTool homepage: https://github.com/biolib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pybiolib:1.2.1882--pyhdfd78af_0
stdout: pybiolib_biolib.out
