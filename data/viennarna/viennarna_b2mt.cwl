cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - perl
  - /usr/local/share/ViennaRNA/bin/b2mt.pl
label: viennarna_b2mt
doc: |-
  Produce coordinates for a mountain plot from bracket notation (RNAfold output), as two columns: position and number of enclosing base pairs.

  Tool homepage: https://www.tbi.univie.ac.at/RNA/
inputs:
  - id: structures
    type: File
    doc: RNAfold output (FASTA header, sequence, dot-bracket structure).
outputs:
  - id: stdout
    type: stdout
    doc: Standard output of the program
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
stdin: $(inputs.structures.path)
stdout: b2mt.xy
s:url: https://www.tbi.univie.ac.at/RNA/
$namespaces:
  s: https://schema.org/
