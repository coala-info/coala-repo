cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - art_illumina
label: art_less
doc: Simulation of Illumina next-generation sequencing reads
inputs:
  - id: qprof1
    type:
      - 'null'
      - File
    doc: the first-read quality profile
    inputBinding:
      position: 101
      prefix: --qprof1
  - id: qprof2
    type:
      - 'null'
      - File
    doc: the second-read quality profile
    inputBinding:
      position: 101
      prefix: --qprof2
  - id: amplicon
    type:
      - 'null'
      - boolean
    doc: amplicon sequencing simulation
    inputBinding:
      position: 101
      prefix: --amplicon
  - id: rcount
    type:
      - 'null'
      - int
    doc: number of reads/read pairs to be generated per sequence/amplicon (not 
      be used together with -f/--fcov)
    inputBinding:
      position: 101
      prefix: --rcount
  - id: id
    type:
      - 'null'
      - string
    doc: the prefix identification tag for read ID
    inputBinding:
      position: 101
      prefix: --id
  - id: errfree
    type:
      - 'null'
      - boolean
    doc: indicate to generate the zero sequencing errors SAM file as well the 
      regular one
    inputBinding:
      position: 101
      prefix: --errfree
  - id: fcov
    type:
      - 'null'
      - float
    doc: the fold of read coverage to be simulated or number of reads/read pairs
      generated for each amplicon
    inputBinding:
      position: 101
      prefix: --fcov
  - id: in
    type: File
    doc: the filename of input DNA/RNA reference
    inputBinding:
      position: 101
      prefix: --in
  - id: ins_rate
    type:
      - 'null'
      - float
    doc: 'the first-read insertion rate (default: 0.00009)'
    inputBinding:
      position: 101
      prefix: --insRate
  - id: ins_rate2
    type:
      - 'null'
      - float
    doc: 'the second-read insertion rate (default: 0.00015)'
    inputBinding:
      position: 101
      prefix: --insRate2
  - id: del_rate
    type:
      - 'null'
      - float
    doc: 'the first-read deletion rate (default:  0.00011)'
    inputBinding:
      position: 101
      prefix: --delRate
  - id: del_rate2
    type:
      - 'null'
      - float
    doc: 'the second-read deletion rate (default: 0.00023)'
    inputBinding:
      position: 101
      prefix: --delRate2
  - id: max_indel
    type:
      - 'null'
      - int
    doc: 'the maximum total number of insertion and deletion per read (default: up
      to read length)'
    inputBinding:
      position: 101
      prefix: --maxIndel
  - id: len
    type: int
    doc: the length of reads to be simulated
    inputBinding:
      position: 101
      prefix: --len
  - id: mflen
    type:
      - 'null'
      - float
    doc: the mean size of DNA/RNA fragments for paired-end simulations
    inputBinding:
      position: 101
      prefix: --mflen
  - id: matepair
    type:
      - 'null'
      - boolean
    doc: indicate a mate-pair read simulation
    inputBinding:
      position: 101
      prefix: --matepair
  - id: cigar_m
    type:
      - 'null'
      - boolean
    doc: indicate to use CIGAR 'M' instead of '=/X' for alignment match/mismatch
    inputBinding:
      position: 101
      prefix: --cigarM
  - id: mask_n
    type:
      - 'null'
      - int
    doc: "the cutoff frequency of 'N' in a window size of the read length for masking
      genomic regions. default: '-nf 1' to mask all regions with 'N'. Use '-nf 0'
      to turn off masking"
    inputBinding:
      position: 101
      prefix: --maskN
  - id: no_aln
    type:
      - 'null'
      - boolean
    doc: do not output ALN alignment file
    inputBinding:
      position: 101
      prefix: --noALN
  - id: out
    type: string
    doc: the prefix of output filename
    inputBinding:
      position: 101
      prefix: --out
  - id: paired
    type:
      - 'null'
      - boolean
    doc: indicate a paired-end read simulation or to generate reads from both 
      ends of amplicons
    inputBinding:
      position: 101
      prefix: --paired
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: turn off end of run summary
    inputBinding:
      position: 101
      prefix: --quiet
  - id: min_q
    type:
      - 'null'
      - int
    doc: the minimum base quality score
    inputBinding:
      position: 101
      prefix: --minQ
  - id: max_q
    type:
      - 'null'
      - int
    doc: the maxiumum base quality score
    inputBinding:
      position: 101
      prefix: --maxQ
  - id: q_shift
    type:
      - 'null'
      - float
    doc: the amount to shift every first-read quality score by
    inputBinding:
      position: 101
      prefix: --qShift
  - id: q_shift2
    type:
      - 'null'
      - float
    doc: the amount to shift every second-read quality score by
    inputBinding:
      position: 101
      prefix: --qShift2
  - id: rnd_seed
    type:
      - 'null'
      - int
    doc: 'the seed for random number generator (default: system time in second)'
    inputBinding:
      position: 101
      prefix: --rndSeed
  - id: sdev
    type:
      - 'null'
      - float
    doc: the standard deviation of DNA/RNA fragment size for paired-end 
      simulations.
    inputBinding:
      position: 101
      prefix: --sdev
  - id: samout
    type:
      - 'null'
      - boolean
    doc: indicate to generate SAM alignment file
    inputBinding:
      position: 101
      prefix: --samout
  - id: sep_prof
    type:
      - 'null'
      - boolean
    doc: indicate to use separate quality profiles for different bases (ATGC)
    inputBinding:
      position: 101
      prefix: --sepProf
  - id: seq_sys
    type:
      - 'null'
      - string
    doc: The name of Illumina sequencing system of the built-in profile used for
      simulation
    inputBinding:
      position: 101
      prefix: --seqSys
outputs:
  - id: output_out
    type: File[]
    doc: the prefix of output filename
    outputBinding:
      glob: $(inputs.out)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/art:2016.06.05--h0704011_13
s:url: https://github.com/jlevy/the-art-of-command-line
$namespaces:
  s: https://schema.org/
