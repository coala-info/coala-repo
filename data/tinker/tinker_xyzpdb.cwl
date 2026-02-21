cwlVersion: v1.2
class: CommandLineTool
baseCommand: tinker_xyzpdb
label: tinker_xyzpdb
doc: "A utility from the TINKER molecular modeling package to convert XYZ Cartesian
  coordinate files to Protein Data Bank (PDB) files. (Note: The provided help text
  contained container runtime error logs rather than tool usage instructions.)\n\n
  Tool homepage: https://dasher.wustl.edu/tinker/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
stdout: tinker_xyzpdb.out
