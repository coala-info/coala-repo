cwlVersion: v1.2
class: CommandLineTool
baseCommand: trimFilter
label: fastqpuri_trimFilter
doc: "Reads in a fq file (gz, bz2, z formats also accepted) and removes: low quality
  reads, reads containing N base callings, reads representing contaminations, belonging
  to sequences in INPUT.fa\n\nTool homepage: https://github.com/jengelmann/FastqPuri"
inputs:
  - id: adapter_config
    type:
      - 'null'
      - string
    doc: 'adapter input. Three fields separated by colons: <ADAPTERS.fa>: fasta file
      containing adapters, <mismatches>: maximum mismatch count allowed, <score>:
      score threshold for the aligner.'
    inputBinding:
      position: 101
      prefix: --adapter
  - id: contamination_method
    type:
      - 'null'
      - string
    doc: 'method used to look for contaminations: TREE: uses a 4-ary tree. Index file
      optional, BLOOM: uses a bloom filter. Index file mandatory.'
    inputBinding:
      position: 101
      prefix: --method
  - id: fasta_contamination_file
    type:
      - 'null'
      - string
    doc: 'fasta input file of potential contaminations. To be included only with method
      TREE (it excludes the option --idx). Otherwise, an index file has to be precomputed
      and given as parameter (see option --idx). 3 fields separated by colons: <INPUT.fa>:
      fasta input file [*fa|*fa.gz|*fa.bz2], <score>: score threshold to accept a
      match [0,1], <lmer_len>: depth of the tree: [1,READ_LENGTH]. Corresponds to
      the length of the lmers to be looked for in the reads.'
    inputBinding:
      position: 101
      prefix: --ifa
  - id: global_trim_bases
    type:
      - 'null'
      - string
    doc: required option if --trimQ GLOBAL is passed. Two int, n1:n2, have to be
      passed specifying the number of bases to be globally cut from the left and
      right, respectively.
    inputBinding:
      position: 101
      prefix: --global
  - id: gzip_output
    type:
      - 'null'
      - boolean
    doc: 'gzip output files: yes or no (default yes)'
    default: true
    inputBinding:
      position: 101
      prefix: --gzip
  - id: index_file_config
    type:
      - 'null'
      - string
    doc: 'index input file. To be included with methods to remove contaminations (TREE,
      BLOOM). 3 fields separated by colons: <INDEX_FILE>: output of makeTree, makeBloom,
      <score>: score threshold to accept a match [0,1], [lmer_len]: the length of
      the lmers to be looked for in the reads [1,READ_LENGTH].'
    inputBinding:
      position: 101
      prefix: --idx
  - id: input_fastq
    type: File
    doc: fastq input file [*fq|*fq.gz|*fq.bz2], mandatory option.
    inputBinding:
      position: 101
      prefix: --ifq
  - id: low_quality_fraction_threshold
    type:
      - 'null'
      - float
    doc: percentage of low quality bases tolerated before discarding a read 
      (default 5)
    default: 0.05
    inputBinding:
      position: 101
      prefix: --percent
  - id: min_quality
    type:
      - 'null'
      - int
    doc: minimum quality allowed (int), optional (default 27).
    default: 27
    inputBinding:
      position: 101
      prefix: --minQ
  - id: min_read_length
    type:
      - 'null'
      - int
    doc: minimum length allowed for a read before it is discarded (default 25).
    default: 25
    inputBinding:
      position: 101
      prefix: --minL
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: output prefix (with path), optional (default ./out).
    default: ./out
    inputBinding:
      position: 101
      prefix: --output
  - id: read_length
    type: int
    doc: 'read length: length of the reads, mandatory option.'
    inputBinding:
      position: 101
      prefix: --length
  - id: trim_n_mode
    type:
      - 'null'
      - string
    doc: "NO: does nothing to reads containing N's, ALL: removes all reads containing
      N's, ENDS: trims ends of reads with N's, STRIPS: looks for the largest substring
      with no N's. All reads are discarded if they are shorter than the sequence length
      specified by -m/--minL."
    default: NO
    inputBinding:
      position: 101
      prefix: --trimN
  - id: trim_quality_mode
    type:
      - 'null'
      - string
    doc: 'NO: does nothing to low quality reads (default), ALL: removes all reads
      containing at least one low quality nucleotide., ENDS: trims the ends of the
      read if their quality is below the threshold -q, FRAC: discards a read if the
      fraction of bases with low quality scores (below -q) is over 5 percent or a
      user defined percentage (-p)., ENDSFRAC: trims the ends and then discards the
      read if there are more low quality nucleotides than allowed by the option -p.,
      GLOBAL: removes n1 bases on the left and n2 on the right, specified in -g. All
      reads are discarded if they are shorter than MINL (specified with -m or --minL).'
    default: NO
    inputBinding:
      position: 101
      prefix: --trimQ
  - id: zero_quality_ascii
    type:
      - 'null'
      - int
    doc: value of ASCII character representing zero quality (int), optional 
      (default 33).
    default: 33
    inputBinding:
      position: 101
      prefix: --zeroQ
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastqpuri:1.0.7--r44hb1d24b7_9
stdout: fastqpuri_trimFilter.out
