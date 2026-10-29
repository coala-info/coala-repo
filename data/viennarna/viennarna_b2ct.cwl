cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - b2ct
label: viennarna_b2ct
doc: |-
  Convert RNA secondary structures in dot-bracket notation (extended FASTA, as written by RNAfold) to Zuker connectivity table (.ct) format.

  Tool homepage: https://www.tbi.univie.ac.at/RNA/
inputs:
  - id: structures
    type: File
    doc: Sequence with header and dot-bracket structure, for example the output of RNAfold.
outputs:
  - id: stdout
    type: stdout
    doc: Standard output of the program
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
stdin: $(inputs.structures.path)
stdout: b2ct.ct
s:url: https://www.tbi.univie.ac.at/RNA/
$namespaces:
  s: https://schema.org/
