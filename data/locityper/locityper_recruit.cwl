cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - locityper
  - recruit
label: locityper_recruit
doc: "Recruit reads to one/multiple loci.\n\nTool homepage: https://github.com/tprodanov/locityper"
inputs:
  - id: alt_contig
    type:
      - 'null'
      - int
    doc: Recruit reads mapped to contigs shorter than this [10M]. Only used 
      together with -R for mapped and indexed BAM/CRAM files.
    default: 10M
    inputBinding:
      position: 101
      prefix: --alt-contig
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: Recruit reads in chunks of this size [10k]. Impacts runtime in 
      multi-threaded read recruitment.
    default: 10k
    inputBinding:
      position: 101
      prefix: --chunk-size
  - id: distinct
    type:
      - 'null'
      - boolean
    doc: Every sequence represents a distinct target (only with -S).
    inputBinding:
      position: 101
      prefix: --distinct
  - id: input_bam
    type:
      - 'null'
      - type: array
        items: File
    doc: Reads in BAM/CRAM format, mutually exclusive with -i/--input. Unless 
      --no-index, mapped, sorted & indexed BAM/CRAM file is expected. If 
      provided, second file should contain path to the alignment index.
    inputBinding:
      position: 101
      prefix: --alignment
  - id: input_fq
    type:
      - 'null'
      - type: array
        items: File
    doc: Reads 1 and 2 in FASTA or FASTQ format, optionally gzip compressed. 
      Reads 1 are required, reads 2 are optional.
    inputBinding:
      position: 101
      prefix: --input
  - id: input_list
    type:
      - 'null'
      - File
    doc: File with input filenames (see documentation).
    inputBinding:
      position: 101
      prefix: --in-list
  - id: interleaved
    type:
      - 'null'
      - boolean
    doc: Interleaved paired-end reads in single input file.
    inputBinding:
      position: 101
      prefix: --interleaved
  - id: jellyfish_executable
    type:
      - 'null'
      - string
    doc: Jellyfish executable [jellyfish].
    default: jellyfish
    inputBinding:
      position: 101
      prefix: --jellyfish
  - id: jf_counts
    type:
      - 'null'
      - File
    doc: Canonical k-mer counts across the reference genome, calculated using 
      Jellyfish. Not required, but highly recommended. k does not have to match 
      minimizer size. See docs for recommended options.
    inputBinding:
      position: 101
      prefix: --jf-counts
  - id: kmer_thresh
    type:
      - 'null'
      - int
    doc: Only use k-mers that appear less than INT times in the reference genome
      [10]. Requires -j argument.
    default: 10
    inputBinding:
      position: 101
      prefix: --kmer-thresh
  - id: match_frac
    type:
      - 'null'
      - float
    doc: Minimal fraction of minimizers that need to match reference [0.5].
    default: 0.5
    inputBinding:
      position: 101
      prefix: --match-frac
  - id: match_len
    type:
      - 'null'
      - int
    doc: Recruit long reads with a matching subregion of this length [2000].
    default: 2000
    inputBinding:
      position: 101
      prefix: --match-len
  - id: minimizer
    type:
      - 'null'
      - type: array
        items: int
    doc: Use k-mers of size INT_1 (<= 31) with smallest hash across INT_2 
      consecutive k-mers [15 10].
    default: 15 10
    inputBinding:
      position: 101
      prefix: --minimizer
  - id: no_index
    type:
      - 'null'
      - boolean
    doc: 'Use input BAM/CRAM file (-a) without index: goes over all reads. Single-end
      and paired-end interleaved (-^) data is allowed.'
    inputBinding:
      position: 101
      prefix: --no-index
  - id: preset
    type:
      - 'null'
      - string
    doc: Parameter preset (illumina|illumina-SE|hifi|pacbio|ont). Modifies -m, 
      -M, see locityper genotype for default values. Additionally, changes -c to
      300 for long reads.
    inputBinding:
      position: 101
      prefix: --preset
  - id: reference
    type:
      - 'null'
      - File
    doc: Reference FASTA file. Required with input CRAM file (-a alns.cram).
    inputBinding:
      position: 101
      prefix: --reference
  - id: regions
    type:
      - 'null'
      - File
    doc: Recruit unmapped reads and reads with primary alignments to these 
      regions (BED). Only relevant for mapped and indexed BAM/CRAM files.
    inputBinding:
      position: 101
      prefix: --regions
  - id: seed
    type:
      - 'null'
      - int
    doc: Subsampling seed (optional). Ensures reproducibility for the same input
      and program version.
    inputBinding:
      position: 101
      prefix: --seed
  - id: seqs
    type:
      - 'null'
      - type: array
        items: File
    doc: FASTA file with target sequences for one locus. To recruit reads to 
      multiple loci, replace locus name with `{}`. Then, all matching files will
      be selected. Multiple entries allowed, but locus names must not repeat.
    inputBinding:
      position: 101
      prefix: --seqs
  - id: seqs_all
    type:
      - 'null'
      - File
    doc: Single FASTA file with target sequences for all loci. Unless 
      --distinct, record names should have format `LOCUS*SEQ_NAME`. Mutually 
      exclusive with -s.
    inputBinding:
      position: 101
      prefix: --seqs-all
  - id: seqs_list
    type:
      - 'null'
      - File
    doc: Two column file with input FASTA and output FASTQ filenames. Mutually 
      exclusive with -s, -S and -o.
    inputBinding:
      position: 101
      prefix: --seqs-list
  - id: subsample
    type:
      - 'null'
      - float
    doc: Before recruitment, subsample reads at this rate [1].
    default: 1
    inputBinding:
      position: 101
      prefix: --subsample
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads [8].
    default: 8
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: 'Path to the (interleaved) output FASTQ files. If the path contains `{}`,
      it will replaced by the locus name. Note: Will create parent directories, if
      needed. Note: For performance reasons, only single output can be gzipped.'
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/locityper:1.3.4--ha6fb395_0
