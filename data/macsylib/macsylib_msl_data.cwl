cwlVersion: v1.2
class: CommandLineTool
baseCommand: macsylib_msl_data
label: macsylib_msl_data
doc: "A tool for managing MacSyLib MSL (Macromolecular System Library) data.\n\nTool
  homepage: https://github.com/gem-pasteur/macsylib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macsylib:1.0.4--pyhdfd78af_1
stdout: macsylib_msl_data.out
