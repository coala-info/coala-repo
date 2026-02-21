cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepnano
label: deepnano
doc: "DeepNano is a tool for basecalling Oxford Nanopore data. (Note: The provided
  help text contains only container runtime error messages and does not list specific
  command-line arguments.)\n\nTool homepage: https://github.com/fmfi-compbio/deepnano-blitz"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/deepnano:v0.0git20170813.e8a621e-3-deb_cv1
stdout: deepnano.out
