cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - perl
  - /usr/local/share/ViennaRNA/bin/relplot.pl
label: viennarna_relplot
doc: |-
  Colorize a secondary structure plot (RNAfold _ss.ps) with reliability annotation from positional entropy of a dot plot (_dp.ps) or SHAPE data.

  Tool homepage: https://www.tbi.univie.ac.at/RNA/
inputs:
  - id: pairs_only
    type:
      - 'null'
      - boolean
    doc: Use pair probabilities only (fixed maximal entropy scale of 1).
    inputBinding:
      position: 1
      prefix: -p
  - id: annotate_all
    type:
      - 'null'
      - boolean
    doc: Annotate all positions with the fixed scale of 1.
    inputBinding:
      position: 1
      prefix: -a
  - id: shape
    type:
      - 'null'
      - boolean
    doc: Second input is a SHAPE reactivity file instead of a dot plot.
    inputBinding:
      position: 1
      prefix: -s
  - id: structure_plot
    type: File
    doc: Secondary structure plot (FOO_ss.ps) written by RNAfold.
    inputBinding:
      position: 10
  - id: dot_plot
    type: File
    doc: Dot plot (FOO_dp.ps) written by RNAfold -p, or a SHAPE file with -s.
    inputBinding:
      position: 11
outputs:
  - id: stdout
    type: stdout
    doc: Standard output of the program
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
stdout: relplot_rss.ps
s:url: https://www.tbi.univie.ac.at/RNA/
$namespaces:
  s: https://schema.org/
