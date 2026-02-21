cwlVersion: v1.2
class: CommandLineTool
baseCommand: setsimilaritysearch_all_pairs.py
label: setsimilaritysearch_all_pairs.py
doc: "A tool for performing all-pairs set similarity search. (Note: The provided input
  text is a system error log regarding container build failure and does not contain
  help documentation or argument definitions.)\n\nTool homepage: https://github.com/ekzhu/SetSimilaritySearch"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/setsimilaritysearch:1.0.0
stdout: setsimilaritysearch_all_pairs.py.out
