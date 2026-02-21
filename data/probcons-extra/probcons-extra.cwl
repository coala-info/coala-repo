cwlVersion: v1.2
class: CommandLineTool
baseCommand: probcons-extra
label: probcons-extra
doc: "Probabilistic Consistency-based Multiple Alignment of Amino Acid Sequences (Note:
  The provided text is a container execution error log and does not contain help documentation
  or argument definitions).\n\nTool homepage: http://probcons.stanford.edu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/probcons-extra:v1.12-12-deb_cv1
stdout: probcons-extra.out
