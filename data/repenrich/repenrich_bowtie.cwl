cwlVersion: v1.2
class: CommandLineTool
baseCommand: bowtie
label: repenrich_bowtie
doc: "Alignments for short DNA sequences\n\nTool homepage: https://github.com/nskvir/RepEnrich"
inputs:
  - id: ebwt
    type: File
    doc: Bowtie index
    inputBinding:
      position: 1
  - id: singles
    type:
      - 'null'
      - type: array
        items: File
    doc: Comma-separated list of files containing unpaired reads
    inputBinding:
      position: 2
  - id: all_alignments
    type:
      - 'null'
      - boolean
    doc: report all alignments per read (much slower than low -k)
    inputBinding:
      position: 103
      prefix: --all
  - id: best_stratum_hits
    type:
      - 'null'
      - boolean
    doc: hits guaranteed best stratum; ties broken by quality
    inputBinding:
      position: 103
      prefix: --best
  - id: chunk_mbs
    type:
      - 'null'
      - int
    doc: max megabytes of RAM for best-first search frames
    default: 64
    inputBinding:
      position: 103
      prefix: --chunkmbs
  - id: col_cqual
    type:
      - 'null'
      - boolean
    doc: print original colorspace quals, not decoded quals
    inputBinding:
      position: 103
      prefix: --col-cqual
  - id: col_cseq
    type:
      - 'null'
      - boolean
    doc: print aligned colorspace seqs as colors, not decoded bases
    inputBinding:
      position: 103
      prefix: --col-cseq
  - id: col_keepends
    type:
      - 'null'
      - boolean
    doc: keep nucleotides at extreme ends of decoded alignment
    inputBinding:
      position: 103
      prefix: --col-keepends
  - id: colorspace
    type:
      - 'null'
      - boolean
    doc: reads and index are in colorspace
    inputBinding:
      position: 103
      prefix: -C
  - id: fasta_input
    type:
      - 'null'
      - boolean
    doc: query input files are (multi-)FASTA .fa/.mfa
    inputBinding:
      position: 103
      prefix: -f
  - id: fastq_input
    type:
      - 'null'
      - boolean
    doc: query input files are FASTQ .fq/.fastq
    default: true
    inputBinding:
      position: 103
      prefix: -q
  - id: ff_mates
    type:
      - 'null'
      - boolean
    doc: -1, -2 mates align fw/fw
    inputBinding:
      position: 103
      prefix: --ff
  - id: fr_mates
    type:
      - 'null'
      - boolean
    doc: -1, -2 mates align fw/rev
    default: true
    inputBinding:
      position: 103
      prefix: --fr
  - id: fullref
    type:
      - 'null'
      - boolean
    doc: 'write entire ref name (default: only up to 1st space)'
    inputBinding:
      position: 103
      prefix: --fullref
  - id: integer_quals
    type:
      - 'null'
      - boolean
    doc: qualities are given as space-separated integers (not ASCII)
    inputBinding:
      position: 103
      prefix: --integer-quals
  - id: large_index
    type:
      - 'null'
      - boolean
    doc: force usage of a 'large' index, even if a small one is present
    inputBinding:
      position: 103
      prefix: --large-index
  - id: maq_err_qual
    type:
      - 'null'
      - int
    doc: max sum of mismatch quals across alignment for -n
    default: 70
    inputBinding:
      position: 103
      prefix: --maqerr
  - id: mates1
    type:
      - 'null'
      - type: array
        items: File
    doc: Comma-separated list of files containing upstream mates
    inputBinding:
      position: 103
      prefix: --1
  - id: mates2
    type:
      - 'null'
      - type: array
        items: File
    doc: Comma-separated list of files containing downstream mates
    inputBinding:
      position: 103
      prefix: --2
  - id: max_alignments_per_read
    type:
      - 'null'
      - int
    doc: report up to <int> good alignments per read
    default: 1
    inputBinding:
      position: 103
      prefix: -k
  - id: max_backtracks
    type:
      - 'null'
      - int
    doc: 'max # backtracks for -n 2/3'
    default: 125
    inputBinding:
      position: 103
      prefix: --maxbts
  - id: max_insert_size
    type:
      - 'null'
      - int
    doc: maximum insert size for paired-end alignment
    default: 250
    inputBinding:
      position: 103
      prefix: --maxins
  - id: max_mismatches_end_to_end
    type:
      - 'null'
      - int
    doc: report end-to-end hits w/ <=v mismatches; ignore qualities
    inputBinding:
      position: 103
      prefix: -v
  - id: max_mismatches_seed
    type:
      - 'null'
      - int
    doc: max mismatches in seed (can be 0-3)
    default: 2
    inputBinding:
      position: 103
      prefix: --seedmms
  - id: memory_mapped_io
    type:
      - 'null'
      - boolean
    doc: use memory-mapped I/O for index; many 'bowtie's can share
    inputBinding:
      position: 103
      prefix: --mm
  - id: min_insert_size
    type:
      - 'null'
      - int
    doc: minimum insert size for paired-end alignment
    default: 0
    inputBinding:
      position: 103
      prefix: --minins
  - id: no_unaligned
    type:
      - 'null'
      - boolean
    doc: suppress SAM records for unaligned reads
    inputBinding:
      position: 103
      prefix: --no-unal
  - id: nofw
    type:
      - 'null'
      - boolean
    doc: do not align to forward reference strand
    inputBinding:
      position: 103
      prefix: --nofw
  - id: nomaqround
    type:
      - 'null'
      - boolean
    doc: disable Maq-like quality rounding for -n
    inputBinding:
      position: 103
      prefix: --nomaqround
  - id: norc
    type:
      - 'null'
      - boolean
    doc: do not align to reverse-complement reference strand
    inputBinding:
      position: 103
      prefix: --norc
  - id: offbase
    type:
      - 'null'
      - int
    doc: leftmost ref offset = <int> in bowtie output
    default: 0
    inputBinding:
      position: 103
      prefix: --offbase
  - id: offrate
    type:
      - 'null'
      - int
    doc: override offrate of index; must be >= index's offrate
    inputBinding:
      position: 103
      prefix: --offrate
  - id: pair_tries
    type:
      - 'null'
      - int
    doc: 'max # attempts to find mate for anchor hit'
    default: 100
    inputBinding:
      position: 103
      prefix: --pairtries
  - id: phred33_quals
    type:
      - 'null'
      - boolean
    doc: input quals are Phred+33
    default: true
    inputBinding:
      position: 103
      prefix: --phred33-quals
  - id: phred64_quals
    type:
      - 'null'
      - boolean
    doc: input quals are Phred+64
    inputBinding:
      position: 103
      prefix: --phred64-quals
  - id: quals1_file
    type:
      - 'null'
      - File
    doc: QV file for mate file 1
    inputBinding:
      position: 103
      prefix: --Q1
  - id: quals2_file
    type:
      - 'null'
      - File
    doc: QV file for mate file 2
    inputBinding:
      position: 103
      prefix: --Q2
  - id: quals_file
    type:
      - 'null'
      - type: array
        items: File
    doc: QV file(s) corresponding to CSFASTA inputs
    inputBinding:
      position: 103
      prefix: --quals
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: print nothing but the alignments
    inputBinding:
      position: 103
      prefix: --quiet
  - id: qupto_reads
    type:
      - 'null'
      - int
    doc: stop after first <int> reads/pairs (excl. skipped reads)
    inputBinding:
      position: 103
      prefix: --qupto
  - id: random_hit_if_over_limit
    type:
      - 'null'
      - int
    doc: like -m, but reports 1 random hit (MAPQ=0); requires --best
    inputBinding:
      position: 103
      prefix: -M
  - id: random_seed
    type:
      - 'null'
      - int
    doc: seed for random number generator
    inputBinding:
      position: 103
      prefix: --seed
  - id: raw_input
    type:
      - 'null'
      - boolean
    doc: query input files are raw one-sequence-per-line
    inputBinding:
      position: 103
      prefix: -r
  - id: reads_cross
    type:
      - 'null'
      - type: array
        items: File
    doc: Comma-separated list of files containing Crossbow-style reads
    inputBinding:
      position: 103
      prefix: --12
  - id: reads_interleaved
    type:
      - 'null'
      - type: array
        items: File
    doc: Files with interleaved paired-end FASTQ reads
    inputBinding:
      position: 103
      prefix: --interleaved
  - id: reads_per_batch
    type:
      - 'null'
      - int
    doc: '# of reads to read from input file at once'
    default: 16
    inputBinding:
      position: 103
      prefix: --reads-per-batch
  - id: refidx
    type:
      - 'null'
      - boolean
    doc: refer to ref. seqs by 0-based index rather than name
    inputBinding:
      position: 103
      prefix: --refidx
  - id: rf_mates
    type:
      - 'null'
      - boolean
    doc: -1, -2 mates align rev/fw
    inputBinding:
      position: 103
      prefix: --rf
  - id: sam_RG
    type:
      - 'null'
      - string
    doc: add <text> (usually "lab=value") to @RG line of SAM header
    inputBinding:
      position: 103
      prefix: --sam-RG
  - id: sam_mapq
    type:
      - 'null'
      - int
    doc: default mapping quality (MAPQ) to print for SAM alignments
    inputBinding:
      position: 103
      prefix: --mapq
  - id: sam_nohead
    type:
      - 'null'
      - boolean
    doc: suppress header lines (starting with @) for SAM output
    inputBinding:
      position: 103
      prefix: --sam-nohead
  - id: sam_nosq
    type:
      - 'null'
      - boolean
    doc: suppress @SQ header lines for SAM output
    inputBinding:
      position: 103
      prefix: --sam-nosq
  - id: sam_output
    type:
      - 'null'
      - boolean
    doc: write hits in SAM format
    inputBinding:
      position: 103
      prefix: --sam
  - id: seed_len
    type:
      - 'null'
      - int
    doc: seed length for -n
    default: 28
    inputBinding:
      position: 103
      prefix: --seedlen
  - id: seq_on_cmd
    type:
      - 'null'
      - boolean
    doc: query sequences given on cmd line
    inputBinding:
      position: 103
      prefix: -c
  - id: shared_memory
    type:
      - 'null'
      - boolean
    doc: use shared mem for index; many 'bowtie's can share
    inputBinding:
      position: 103
      prefix: --shmem
  - id: skip_reads
    type:
      - 'null'
      - int
    doc: skip the first <int> reads/pairs in the input
    inputBinding:
      position: 103
      prefix: --skip
  - id: snpfrac
    type:
      - 'null'
      - float
    doc: approx. fraction of SNP bases (e.g. 0.001); sets --snpphred
    inputBinding:
      position: 103
      prefix: --snpfrac
  - id: snpphred
    type:
      - 'null'
      - int
    doc: Phred penalty for SNP when decoding colorspace
    default: 30
    inputBinding:
      position: 103
      prefix: --snpphred
  - id: solexa1_3_quals
    type:
      - 'null'
      - boolean
    doc: input quals are from GA Pipeline ver. >= 1.3
    inputBinding:
      position: 103
      prefix: --solexa1.3-quals
  - id: solexa_quals
    type:
      - 'null'
      - boolean
    doc: input quals are from GA Pipeline ver. < 1.3
    inputBinding:
      position: 103
      prefix: --solexa-quals
  - id: strata_only
    type:
      - 'null'
      - boolean
    doc: hits in sub-optimal strata aren't reported (requires --best)
    inputBinding:
      position: 103
      prefix: --strata
  - id: suppress_columns
    type:
      - 'null'
      - string
    doc: suppresses given columns (comma-delim'ed) in default output
    inputBinding:
      position: 103
      prefix: --suppress
  - id: suppress_if_over_limit
    type:
      - 'null'
      - int
    doc: suppress all alignments if > <int> exist
    inputBinding:
      position: 103
      prefix: -m
  - id: threads
    type:
      - 'null'
      - int
    doc: number of alignment threads to launch
    default: 1
    inputBinding:
      position: 103
      prefix: --threads
  - id: time_phases
    type:
      - 'null'
      - boolean
    doc: print wall-clock time taken by search phases
    inputBinding:
      position: 103
      prefix: --time
  - id: trim3_bases
    type:
      - 'null'
      - int
    doc: trim <int> bases from 3' (right) end of reads
    inputBinding:
      position: 103
      prefix: --trim3
  - id: trim5_bases
    type:
      - 'null'
      - int
    doc: trim <int> bases from 5' (left) end of reads
    inputBinding:
      position: 103
      prefix: --trim5
  - id: tryhard
    type:
      - 'null'
      - boolean
    doc: try hard to find valid alignments, at the expense of speed
    inputBinding:
      position: 103
      prefix: --tryhard
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose output (for debugging)
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: hit_file
    type:
      - 'null'
      - File
    doc: File to write hits to
    outputBinding:
      glob: '*.out'
  - id: aligned_output_file
    type:
      - 'null'
      - File
    doc: write aligned reads/pairs to file(s)
    outputBinding:
      glob: $(inputs.aligned_output_file)
  - id: unaligned_output_file
    type:
      - 'null'
      - File
    doc: write unaligned reads/pairs to file(s)
    outputBinding:
      glob: $(inputs.unaligned_output_file)
  - id: max_output_file
    type:
      - 'null'
      - File
    doc: write reads/pairs over -m limit to file(s)
    outputBinding:
      glob: $(inputs.max_output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/repenrich:1.2--py27_1
