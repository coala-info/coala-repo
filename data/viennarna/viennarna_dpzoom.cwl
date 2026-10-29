cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - perl
  - /usr/local/share/ViennaRNA/bin/dpzoom.pl
label: viennarna_dpzoom
doc: |-
  Zoom into a PostScript dot plot produced by RNAfold, RNAalifold or alidot.

  Tool homepage: https://www.tbi.univie.ac.at/RNA/
inputs:
  - id: first
    type:
      - 'null'
      - int
    doc: First sequence position of the zoomed region.
    inputBinding:
      position: 1
      prefix: -f
  - id: last
    type:
      - 'null'
      - int
    doc: Last sequence position of the zoomed region.
    inputBinding:
      position: 1
      prefix: -l
  - id: dot_plot
    type: File
    doc: Dot plot PostScript file.
    inputBinding:
      position: 10
outputs:
  - id: stdout
    type: stdout
    doc: Standard output of the program
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
stdout: dpzoom_dp.ps
s:url: https://www.tbi.univie.ac.at/RNA/
$namespaces:
  s: https://schema.org/
