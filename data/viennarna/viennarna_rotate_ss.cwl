cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - perl
  - /usr/local/share/ViennaRNA/bin/rotate_ss.pl
label: viennarna_rotate_ss
doc: |-
  Rotate or mirror the layout of an RNA secondary structure plot (PostScript _ss.ps).

  Tool homepage: https://www.tbi.univie.ac.at/RNA/
inputs:
  - id: angle
    type:
      - 'null'
      - float
    doc: Rotate the structure plot by this angle (degrees).
    inputBinding:
      position: 1
      prefix: -a
  - id: mirror
    type:
      - 'null'
      - boolean
    doc: Mirror (flip) the structure plot.
    inputBinding:
      position: 1
      prefix: -m
  - id: structure_plot
    type: File
    doc: Secondary structure plot (FOO_ss.ps).
    inputBinding:
      position: 10
outputs:
  - id: stdout
    type: stdout
    doc: Standard output of the program
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
stdout: rotated_ss.ps
s:url: https://www.tbi.univie.ac.at/RNA/
$namespaces:
  s: https://schema.org/
