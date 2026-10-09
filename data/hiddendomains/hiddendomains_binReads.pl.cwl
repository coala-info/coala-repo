cwlVersion: v1.2
class: CommandLineTool
baseCommand: binReads.pl
label: hiddendomains_binReads.pl
doc: "Bin aligned reads (BAM or BED) into fixed-width bins and write the counts per
  bin to standard output.\n\nTool homepage: http://hiddendomains.sourceforge.net/"
inputs:
  - id: reads_file
    type: File
    doc: Aligned reads in BAM format (default) or BED format (with -B)
    inputBinding:
      position: 2
  - id: bin_width
    type:
      - 'null'
      - int
    doc: The width of the bin. Default is 1000bp.
    inputBinding:
      position: 1
      prefix: -b
  - id: input_is_bed
    type:
      - 'null'
      - boolean
    doc: The input file is in BED format (the default is BAM)
    inputBinding:
      position: 1
      prefix: -B
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: The minimum MAPQ score. Default is 30.
    inputBinding:
      position: 1
      prefix: -q
  - id: mouse_chromosomes
    type:
      - 'null'
      - boolean
    doc: Assume all bins should be on mouse chromosomes. This is the default.
    inputBinding:
      position: 1
      prefix: -M
  - id: human_chromosomes
    type:
      - 'null'
      - boolean
    doc: Assume all bins should be on human chromosomes.
    inputBinding:
      position: 1
      prefix: -H
  - id: chromosomes
    type:
      - 'null'
      - string
    doc: Bin reads only from the specified chromosomes, a space separated list
      such as "chr1 chr2".
    inputBinding:
      position: 1
      prefix: -c
outputs:
  - id: binned_reads
    type: stdout
    doc: Table of read counts per bin (id, chr, pos, count)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hiddendomains:3.1--pl526r36_0
stdout: $(inputs.reads_file.nameroot)_binned_reads.txt
