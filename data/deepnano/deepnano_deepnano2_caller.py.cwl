cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepnano_deepnano2_caller.py
label: deepnano_deepnano2_caller.py
doc: "DeepNano2 caller for Nanopore sequencing data. (Note: The provided help text
  contains only system error messages and no usage information.)\n\nTool homepage:
  https://github.com/fmfi-compbio/deepnano-blitz"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/deepnano:v0.0git20170813.e8a621e-3-deb_cv1
stdout: deepnano_deepnano2_caller.py.out
