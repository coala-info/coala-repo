cwlVersion: v1.2
class: CommandLineTool
baseCommand: mmCQL
label: cif-tools_mmCQL
doc: "A tool for querying mmCIF files. (Note: The provided input text consisted of
  system error logs regarding container extraction and did not contain actual help
  documentation or argument definitions.)\n\nTool homepage: https://github.com/PDB-REDO/cif-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cif-tools:1.0.12--h077b44d_0
stdout: cif-tools_mmCQL.out
