cwlVersion: v1.2
class: CommandLineTool
baseCommand: spine_spine.pl
label: spine_spine.pl
doc: "This is a wrapper script to run the Spine algorithm\n\nTool homepage: https://github.com/egonozer/Spine"
inputs:
  - id: breaklen
    type:
      - 'null'
      - int
    doc: Integer
    inputBinding:
      position: 101
      prefix: --breaklen
  - id: diagdiff
    type:
      - 'null'
      - int
    doc: Integer
    inputBinding:
      position: 101
      prefix: --diagdiff
  - id: diagfactor
    type:
      - 'null'
      - float
    doc: Float
    inputBinding:
      position: 101
      prefix: --diagfactor
  - id: file
    type: File
    doc: "file with list of input sequence files. Accepted file formats include fasta
      sequence files, genbank sequence + annotation files, or separate fasta sequence
      files with corresponding gff3-formatted annotation files.\n                \
      \    This file should be formatted like so:\n                    \n        \
      \            path/to/file1<tab>unique_identifier<tab>fasta or gbk or comb\n\
      \                    path/to/file2<tab>unique_identifier<tab>fasta or gbk or
      comb\n                    \n                    Example:\n                 \
      \   /home/seqs/PAO1.fasta   PAO1    fasta\n                    /home/seqs/LESB58.gbk\
      \   LESB58  gbk\n                    /home/seqs/PA14.fasta,/home/seqs/PA14.gff3\
      \  PA14    comb\n                    \n                    The third column
      (fasta, gbk, or comb) is optional, but should\n                    be given
      if your sequence files end with suffixes other\n                    than \"\
      .fasta\" or \".gbk\" or if you are providing sequences\n                   \
      \ with gff3 annotation files, i.e. comb(ined).\n                    \n     \
      \               If you have genomes spread across multiple files (i.e.\n   \
      \                 chromosomes and/or plasmids), these can be combined by\n \
      \                   either concatenating the files into one:\n             \
      \       i.e. 'cat chrom_I.gbk chrom_II.gbk > combined.gbk'\n               \
      \     or by including all the files in this input file, \n                 \
      \   separated by commmas:\n                    Example:\n                  \
      \  /seqs/chrom_I.fasta,/seqs/chrom_II.fasta    mygenome    fasta\n         \
      \           chrom_A.gbk,chrom_B.gbk,plasmid_X.gbk   myothergenome   gbk\n  \
      \                  seqA.fasta,seqB.fasta,seqA.gff3,seqB.gff3   genomeAB    comb\n\
      \                    \n                    IMPORTANT: When including multiple
      files for a strain or\n                    joining multiple files within a strain,
      please ensure that\n                    all chromosome/plasmid/contig IDs are
      unique across files\n                    within a single genome. If sequence
      IDs are duplicated, the\n                    results are likely to be wrong."
    inputBinding:
      position: 101
      prefix: --file
  - id: license
    type:
      - 'null'
      - boolean
    doc: print license information and quit
    inputBinding:
      position: 101
      prefix: --license
  - id: maxdist
    type:
      - 'null'
      - int
    doc: "maximum distance between core genome segments. Distances\n             \
      \       less than this between adjacent segments will result in\n          \
      \          combination of fragments with N's rather than separating\n      \
      \              into two or more fragments."
    inputBinding:
      position: 101
      prefix: --maxdist
  - id: mincluster
    type:
      - 'null'
      - int
    doc: Integer
    inputBinding:
      position: 101
      prefix: --mincluster
  - id: mini
    type:
      - 'null'
      - boolean
    doc: "produce only limited output, i.e. just the backbone sequence\n         \
      \           derived from the reference genome(s). This saves time on\n     \
      \               large data sets, especially if you only need the backbone\n\
      \                    sequence to get accessory sequences from AGEnt."
    inputBinding:
      position: 101
      prefix: --mini
  - id: minmatch
    type:
      - 'null'
      - int
    doc: Integer
    inputBinding:
      position: 101
      prefix: --minmatch
  - id: minout
    type:
      - 'null'
      - int
    doc: minimum size of sequences to be output, in bases
    inputBinding:
      position: 101
      prefix: --minout
  - id: nosimplify
    type:
      - 'null'
      - boolean
    doc: 'default: simplify'
    inputBinding:
      position: 101
      prefix: --nosimplify
  - id: nucpath
    type:
      - 'null'
      - Directory
    doc: "full path to folder containing MUMmer scripts and\n                    executables,
      i.e. /home/applications/MUMmer/bin"
    inputBinding:
      position: 101
      prefix: --nucpath
  - id: pangenome
    type:
      - 'null'
      - boolean
    doc: "produce a pangenome sequence and characteristics from\n                \
      \    sequences in the order given. This option will be ignored\n           \
      \         if '--mini' option is given."
    inputBinding:
      position: 101
      prefix: --pangenome
  - id: pctcore
    type:
      - 'null'
      - int
    doc: "percentage of input genomes in which a region must be\n                \
      \    found in order to be considered core"
    inputBinding:
      position: 101
      prefix: --pctcore
  - id: pctid
    type:
      - 'null'
      - float
    doc: "minimum percent identity for regions to be considered\n                \
      \    homologous"
    inputBinding:
      position: 101
      prefix: --pctid
  - id: prefix
    type:
      - 'null'
      - string
    doc: Output prefix
    inputBinding:
      position: 101
      prefix: --prefix
  - id: refs
    type:
      - 'null'
      - type: array
        items: string
    doc: "reference genome sequence(s) to use as primary output\n                \
      \    source(s). This should be one or more integers corresponding\n        \
      \            to the order of the genomes given in the file above, i.e.\n   \
      \                 \"1\" would use the first-listed sequence, \"3\" would use\n\
      \                    the third-listed, etc. To prioritize multiple genome\n\
      \                    sequences, separate the integers with commas, i.e. \"1,3\"\
      \n                    for giving sequence 1 the highest priority and sequence
      3\n                    the next-highest priority.\n                    Reference
      sequences will serve as the source of backbone\n                    sequences
      to be output, as well as the source of backbone\n                    locus IDs,
      if applicable.\n                    The number of reference genomes used will
      depend on the\n                    definition of core genome given by option
      -a. For instance,\n                    if core is determined from 10 input genomes
      and -a is given\n                    as 100, then core sequence will only be
      taken from one\n                    reference genome. If, for example, -a is
      given as 90 from\n                    10 input genomes, then potentially two
      reference sequences\n                    will be needed: The first for sequences
      present in all 10\n                    genomes and for sequences present in
      9 out of 10 genomes\n                    including the first genome. The second
      reference sequence\n                    would then be used as the source of
      all sequences present\n                    in 9 out of 10 genomes, but not present
      in the first\n                    reference genome."
    inputBinding:
      position: 101
      prefix: --refs
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of parallel processes to run. Careful: This script\n            \
      \        does not perform any verification of the number of\n              \
      \      processers available. If you set this number higher than\n          \
      \          the number of processors you have, performance is likely to\n   \
      \                 be significantly degraded."
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spine:0.3.2--pl526_0
stdout: spine_spine.pl.out
