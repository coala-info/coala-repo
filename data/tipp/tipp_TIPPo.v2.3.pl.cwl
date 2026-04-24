cwlVersion: v1.2
class: CommandLineTool
baseCommand: TIPPo.v2.3.pl
label: tipp_TIPPo.v2.3.pl
doc: "TIPPo.v2.3.pl is a tool for analyzing HiFi reads, potentially for chloroplast
  or organelle genomes.\n\nTool homepage: https://github.com/Wenfei-Xian/TIPP"
inputs:
  - id: assume_inverted_repeats
    type:
      - 'null'
      - int
    doc: 'Assume the presence of the inverted repeats (default: 1).'
    inputBinding:
      position: 101
      prefix: -i
  - id: chloroplast_or_organelle
    type:
      - 'null'
      - string
    doc: 'chloroplast or organelle (default: organelle).'
    inputBinding:
      position: 101
      prefix: -g
  - id: flye_parameter
    type:
      - 'null'
      - string
    doc: 'parameter for flye (default: --pacbio-hifi).'
    inputBinding:
      position: 101
      prefix: -y
  - id: hifi_reads
    type: boolean
    doc: HiFi reads (required).
    inputBinding:
      position: 101
      prefix: -f
  - id: high_kmer_count
    type:
      - 'null'
      - int
    doc: 'high kmer count - hkc (default: 5).'
    inputBinding:
      position: 101
      prefix: -c
  - id: lower_kmer_count
    type:
      - 'null'
      - float
    doc: 'lower kmer count - lkc (default: 0.3).'
    inputBinding:
      position: 101
      prefix: -l
  - id: min_overlap_repeat_graph
    type:
      - 'null'
      - int
    doc: minimum overlap in repeat graph construction (default:800)
    inputBinding:
      position: 101
      prefix: -m
  - id: minimap2_parameter
    type:
      - 'null'
      - string
    doc: 'parameter for minimap2 (default: map-hifi).'
    inputBinding:
      position: 101
      prefix: -a
  - id: num_random_downsamplings
    type:
      - 'null'
      - int
    doc: 'Number of random downsamplings (default: 5).'
    inputBinding:
      position: 101
      prefix: -r
  - id: num_reads_downsample_chloroplast
    type:
      - 'null'
      - int
    doc: Number of reads in each downsample for chloroplast.
    inputBinding:
      position: 101
      prefix: -n
  - id: reference_sequence
    type:
      - 'null'
      - string
    doc: 'reference sequence (default: No).'
    inputBinding:
      position: 101
      prefix: -b
  - id: threads
    type:
      - 'null'
      - int
    doc: Threads for tiara, flye, KMC3 and readskmercount.
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tipp:1.3.0--py38pl5321h077b44d_0
stdout: tipp_TIPPo.v2.3.pl.out
