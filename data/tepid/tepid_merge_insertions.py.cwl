cwlVersion: v1.2
class: CommandLineTool
baseCommand: tepid_merge_insertions.py
label: tepid_merge_insertions.py
doc: "Merge insertions identified by TEPID (Note: The provided text contains container
  build logs rather than tool help text, so arguments could not be extracted).\n\n
  Tool homepage: https://github.com/ListerLab/TEPID"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tepid:0.10--py_0
stdout: tepid_merge_insertions.py.out
