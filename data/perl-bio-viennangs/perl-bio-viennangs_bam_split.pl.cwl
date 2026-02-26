cwlVersion: v1.2
class: CommandLineTool
baseCommand: bam_split.pl
label: perl-bio-viennangs_bam_split.pl
doc: "Split BAM files by strand and optionally create BED, BedGraph, and bigWig coverage
  files.\n\nTool homepage: http://metacpan.org/pod/Bio::ViennaNGS"
inputs:
  - id: bam
    type:
      - 'null'
      - File
    doc: Input file in BAM format
    inputBinding:
      position: 101
      prefix: --bam
  - id: bed
    type:
      - 'null'
      - boolean
    doc: Create a BED6 file for each split BAM file
    inputBinding:
      position: 101
      prefix: --bed
  - id: bw
    type:
      - 'null'
      - boolean
    doc: Create BedGraph and bigWig coverage files for e.g. genome browser 
      visualization.
    inputBinding:
      position: 101
      prefix: --bw
  - id: bwdir
    type:
      - 'null'
      - Directory
    doc: Directory name for resulting bigWig files. This directory is created as
      subdirectory of the output directory.
    default: vis
    inputBinding:
      position: 101
      prefix: --bwdir
  - id: cs
    type:
      - 'null'
      - File
    doc: Chromosome sizes file (required if --bw is given).
    inputBinding:
      position: 101
      prefix: --cs
  - id: log
    type:
      - 'null'
      - string
    doc: Log file extension. The log file is created in the directory given via 
      -o.
    default: .bam_split.log
    inputBinding:
      position: 101
      prefix: --log
  - id: man
    type:
      - 'null'
      - boolean
    doc: Prints the manual page and exits
    inputBinding:
      position: 101
      prefix: --man
  - id: norm
    type:
      - 'null'
      - boolean
    doc: Normalize resulting bigWig files
    inputBinding:
      position: 101
      prefix: --norm
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: Reverse the +/- strand mapping. This is required to achieve proper 
      strand assignments for certain RNA-seq library preparation protocol.
    inputBinding:
      position: 101
      prefix: --reverse
  - id: scale
    type:
      - 'null'
      - int
    doc: If --bw is given, scale bigWig files to this number.
    default: 1000000
    inputBinding:
      position: 101
      prefix: --scale
  - id: uniq
    type:
      - 'null'
      - boolean
    doc: 'Filter uniquely mapped reads by inspecting the NH:i: SAM attribute.'
    inputBinding:
      position: 101
      prefix: --uniq
outputs:
  - id: out
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-viennangs:v0.19.2--pl526_5
