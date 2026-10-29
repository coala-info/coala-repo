cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - perl
  - /usr/local/share/ViennaRNA/bin/coloraln.pl
label: viennarna_coloraln
doc: |-
  Colorize an alignment (CLUSTAL format) with a consensus secondary structure taken from a PostScript structure plot (alirna.ps); compensatory mutations are marked by color.

  Tool homepage: https://www.tbi.univie.ac.at/RNA/
inputs:
  - id: ruler
    type:
      - 'null'
      - boolean
    doc: Add a ruler below the alignment showing sequence positions.
    inputBinding:
      position: 1
      prefix: -r
  - id: resnum
    type:
      - 'null'
      - boolean
    doc: Write the sequence position at the end of each sequence line.
    inputBinding:
      position: 1
      prefix: -n
  - id: no_t_to_u
    type:
      - 'null'
      - boolean
    doc: Suppress conversion of T to U (do not convert DNA to RNA).
    inputBinding:
      position: 1
      prefix: -t
  - id: columns
    type:
      - 'null'
      - int
    doc: Break alignments into blocks of at most this many columns (default 120).
    inputBinding:
      position: 1
      prefix: -c
  - id: structure_ps
    type:
      - 'null'
      - File
    doc: PostScript structure plot to extract the consensus structure from (default alirna.ps).
    inputBinding:
      position: 1
      prefix: -s
  - id: alignment
    type: File
    doc: Alignment in CLUSTAL format.
    inputBinding:
      position: 10
outputs:
  - id: stdout
    type: stdout
    doc: Standard output of the program
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
stdout: coloraln.ps
s:url: https://www.tbi.univie.ac.at/RNA/
$namespaces:
  s: https://schema.org/
