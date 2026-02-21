cwlVersion: v1.2
class: CommandLineTool
baseCommand: tepid_merge_deletions.py
label: tepid_merge_deletions.py
doc: "Merge deletion calls from TEPID\n\nTool homepage: https://github.com/ListerLab/TEPID"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tepid:0.10--py_0
stdout: tepid_merge_deletions.py.out
