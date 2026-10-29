cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - perl
  - /usr/local/share/ViennaRNA/bin/mountain.pl
label: viennarna_mountain
doc: |-
  Produce Pauline Hogeweg's mountain representation from an RNAfold dot plot (_dp.ps): three data sets (pair probability mountain, mfe structure mountain, positional entropy) separated by &.

  Tool homepage: https://www.tbi.univie.ac.at/RNA/
inputs:
  - id: dot_plot
    type: File
    doc: Dot plot PostScript file (FOO_dp.ps).
    inputBinding:
      position: 10
outputs:
  - id: stdout
    type: stdout
    doc: Standard output of the program
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
stdout: mountain.xy
s:url: https://www.tbi.univie.ac.at/RNA/
$namespaces:
  s: https://schema.org/
