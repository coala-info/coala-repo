cwlVersion: v1.2
class: CommandLineTool
baseCommand: hhsuite_cif2fasta.py
label: hhsuite_cif2fasta.py
doc: "A tool from the HH-suite for converting CIF files to FASTA format. (Note: The
  provided text contains container runtime error messages and does not include the
  tool's help documentation or argument list.)\n\nTool homepage: https://github.com/soedinglab/hh-suite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hhsuite:3.3.0--h503566f_15
stdout: hhsuite_cif2fasta.py.out
