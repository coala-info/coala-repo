cwlVersion: v1.2
class: CommandLineTool
baseCommand: last-dotplot
label: last-align_last-dotplot
doc: "Draw a dotplot of pair-wise sequence alignments in MAF or tabular format.\n\n\
  Tool homepage: https://gitlab.com/mcfrith/last"
inputs:
  - id: alignments
    type: File
    doc: MAF or tabular alignments
    inputBinding:
      position: 1
  - id: bed1
    type:
      - 'null'
      - File
    doc: read genome1 annotations from BED file
    inputBinding:
      position: 102
      prefix: --bed1
  - id: bed2
    type:
      - 'null'
      - File
    doc: read genome2 annotations from BED file
    inputBinding:
      position: 102
      prefix: --bed2
  - id: border_color
    type:
      - 'null'
      - string
    doc: color for pixels between sequences
    inputBinding:
      position: 102
      prefix: --border-color
  - id: border_pixels
    type:
      - 'null'
      - int
    doc: number of pixels between sequences
    inputBinding:
      position: 102
      prefix: --border-pixels
  - id: bridged_color
    type:
      - 'null'
      - string
    doc: color for bridged gaps
    inputBinding:
      position: 102
      prefix: --bridged-color
  - id: cds_color
    type:
      - 'null'
      - string
    doc: color for protein-coding regions
    inputBinding:
      position: 102
      prefix: --cds-color
  - id: exon_color
    type:
      - 'null'
      - string
    doc: color for exons
    inputBinding:
      position: 102
      prefix: --exon-color
  - id: fontfile
    type:
      - 'null'
      - File
    doc: TrueType or OpenType font file
    inputBinding:
      position: 102
      prefix: --fontfile
  - id: fontsize
    type:
      - 'null'
      - int
    doc: TrueType or OpenType font size
    inputBinding:
      position: 102
      prefix: --fontsize
  - id: forwardcolor
    type:
      - 'null'
      - string
    doc: color for forward alignments
    inputBinding:
      position: 102
      prefix: --forwardcolor
  - id: gap1
    type:
      - 'null'
      - File
    doc: read genome1 unsequenced gaps from agp or gap file
    inputBinding:
      position: 102
      prefix: --gap1
  - id: gap2
    type:
      - 'null'
      - File
    doc: read genome2 unsequenced gaps from agp or gap file
    inputBinding:
      position: 102
      prefix: --gap2
  - id: genePred1
    type:
      - 'null'
      - File
    doc: read genome1 genes from genePred file
    inputBinding:
      position: 102
      prefix: --genePred1
  - id: genePred2
    type:
      - 'null'
      - File
    doc: read genome2 genes from genePred file
    inputBinding:
      position: 102
      prefix: --genePred2
  - id: height
    type:
      - 'null'
      - int
    doc: maximum height in pixels
    inputBinding:
      position: 102
      prefix: --height
  - id: labels1
    type:
      - 'null'
      - int
    doc: 'genome1 labels: 0=name, 1=name:length, 2=name:start:length, 3=name:start-end'
    inputBinding:
      position: 102
      prefix: --labels1
  - id: labels2
    type:
      - 'null'
      - int
    doc: 'genome2 labels: 0=name, 1=name:length, 2=name:start:length, 3=name:start-end'
    inputBinding:
      position: 102
      prefix: --labels2
  - id: margin_color
    type:
      - 'null'
      - string
    doc: margin color
    inputBinding:
      position: 102
      prefix: --margin-color
  - id: max_gap1
    type:
      - 'null'
      - float
    doc: 'maximum unaligned (end,mid) gap in genome1: fraction of aligned length'
    inputBinding:
      position: 102
      prefix: --max-gap1
  - id: max_gap2
    type:
      - 'null'
      - float
    doc: 'maximum unaligned (end,mid) gap in genome2: fraction of aligned length'
    inputBinding:
      position: 102
      prefix: --max-gap2
  - id: maxseqs
    type:
      - 'null'
      - int
    doc: maximum number of horizontal or vertical sequences
    inputBinding:
      position: 102
      prefix: --maxseqs
  - id: pad
    type:
      - 'null'
      - float
    doc: 'pad length when cutting unaligned gaps: fraction of aligned length'
    inputBinding:
      position: 102
      prefix: --pad
  - id: reversecolor
    type:
      - 'null'
      - string
    doc: color for reverse alignments
    inputBinding:
      position: 102
      prefix: --reversecolor
  - id: rmsk1
    type:
      - 'null'
      - File
    doc: read genome1 repeats from RepeatMasker .out or rmsk.txt file
    inputBinding:
      position: 102
      prefix: --rmsk1
  - id: rmsk2
    type:
      - 'null'
      - File
    doc: read genome2 repeats from RepeatMasker .out or rmsk.txt file
    inputBinding:
      position: 102
      prefix: --rmsk2
  - id: rot1
    type:
      - 'null'
      - string
    doc: text rotation for the 1st genome
    inputBinding:
      position: 102
      prefix: --rot1
  - id: rot2
    type:
      - 'null'
      - string
    doc: text rotation for the 2nd genome
    inputBinding:
      position: 102
      prefix: --rot2
  - id: secondary_alignments
    type:
      - 'null'
      - File
    doc: secondary alignments
    inputBinding:
      position: 102
      prefix: --alignments
  - id: seq1
    type:
      - 'null'
      - string
    doc: which sequences to show from the 1st genome
    inputBinding:
      position: 102
      prefix: --seq1
  - id: seq2
    type:
      - 'null'
      - string
    doc: which sequences to show from the 2nd genome
    inputBinding:
      position: 102
      prefix: --seq2
  - id: sort1
    type:
      - 'null'
      - int
    doc: 'genome1 sequence order: 0=input order, 1=name order, 2=length order, 3=alignment
      order'
    inputBinding:
      position: 102
      prefix: --sort1
  - id: sort2
    type:
      - 'null'
      - int
    doc: 'genome2 sequence order: 0=input order, 1=name order, 2=length order, 3=alignment
      order'
    inputBinding:
      position: 102
      prefix: --sort2
  - id: strands1
    type:
      - 'null'
      - int
    doc: 'genome1 sequence orientation: 0=forward orientation, 1=alignment orientation'
    inputBinding:
      position: 102
      prefix: --strands1
  - id: strands2
    type:
      - 'null'
      - int
    doc: 'genome2 sequence orientation: 0=forward orientation, 1=alignment orientation'
    inputBinding:
      position: 102
      prefix: --strands2
  - id: unbridged_color
    type:
      - 'null'
      - string
    doc: color for unbridged gaps
    inputBinding:
      position: 102
      prefix: --unbridged-color
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: show progress messages & data about the plot
    inputBinding:
      position: 102
      prefix: --verbose
  - id: width
    type:
      - 'null'
      - int
    doc: maximum width in pixels
    inputBinding:
      position: 102
      prefix: --width
outputs:
  - id: dotplot_output
    type: File
    doc: Output dotplot file (png or gif)
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/last-align:v963-2-deb_cv1
