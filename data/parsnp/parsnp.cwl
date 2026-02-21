cwlVersion: v1.2
class: CommandLineTool
baseCommand: parsnp
label: parsnp
doc: "Parsnp is a command-line tool for efficient microbial core genome alignment
  and SNP calling.\n\nTool homepage: https://github.com/marbl/parsnp"
inputs:
  - id: alignment_program
    type:
      - 'null'
      - string
    doc: Alignment program to use (mafft, muscle, fsa, prank)
    inputBinding:
      position: 101
      prefix: --alignment-program
  - id: curated
    type:
      - 'null'
      - boolean
    doc: (c)urated genome directory, use all genomes in dir and ignore MUMi.
    inputBinding:
      position: 101
      prefix: --curated
  - id: extend
    type:
      - 'null'
      - boolean
    doc: Extend alignment
    inputBinding:
      position: 101
      prefix: --extend
  - id: extend_ani_cutoff
    type:
      - 'null'
      - float
    doc: Cutoff ANI for lcb extension
    inputBinding:
      position: 101
      prefix: --extend-ani-cutoff
  - id: extend_indel_cutoff
    type:
      - 'null'
      - int
    doc: Cutoff for indels in LCB extension region. LCB extension will be at most
      min(seqs) + cutoff bases
    inputBinding:
      position: 101
      prefix: --extend-indel-cutoff
  - id: extend_lcbs
    type:
      - 'null'
      - boolean
    doc: Extend the boundaries of LCBs with an ungapped alignment
    inputBinding:
      position: 101
      prefix: --extend-lcbs
  - id: fastmum
    type:
      - 'null'
      - boolean
    doc: Fast MUMi calculation
    inputBinding:
      position: 101
      prefix: -F
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrites any results in the output directory if it already exists
    inputBinding:
      position: 101
      prefix: --force-overwrite
  - id: gap_penalty
    type:
      - 'null'
      - int
    doc: Value of gap penalty for extension (should be negative)
    inputBinding:
      position: 101
      prefix: --gap-penalty
  - id: genbank
    type:
      - 'null'
      - type: array
        items: File
    doc: A list of Genbank file(s) (gbk)
    inputBinding:
      position: 101
      prefix: --genbank
  - id: inifile
    type:
      - 'null'
      - File
    doc: Path to ini file
    inputBinding:
      position: 101
      prefix: --inifile
  - id: match_score
    type:
      - 'null'
      - int
    doc: Value of match score for extension
    inputBinding:
      position: 101
      prefix: --match-score
  - id: max_cluster_d
    type:
      - 'null'
      - int
    doc: Maximal cluster D value
    inputBinding:
      position: 101
      prefix: --max-cluster-d
  - id: max_concurrent_partitions
    type:
      - 'null'
      - int
    doc: Maximum number of partitions to run in parallel. Unlimited by default
    inputBinding:
      position: 101
      prefix: --max-concurrent-partitions
  - id: max_diagonal_difference
    type:
      - 'null'
      - string
    doc: Maximal diagonal difference. Either percentage (e.g. 0.2) or bp (e.g. 100bp)
    inputBinding:
      position: 101
      prefix: --max-diagonal-difference
  - id: max_mash_dist
    type:
      - 'null'
      - float
    doc: Max mash distance.
    inputBinding:
      position: 101
      prefix: --max-mash-dist
  - id: max_mumi_distance
    type:
      - 'null'
      - float
    doc: 'Max MUMi distance (default: autocutoff based on distribution of MUMi values)'
    inputBinding:
      position: 101
      prefix: --max-mumi-distance
  - id: max_mumi_distr_dist
    type:
      - 'null'
      - float
    doc: Max MUMi distance value for MUMi distribution
    inputBinding:
      position: 101
      prefix: --max-mumi-distr-dist
  - id: max_partition_size
    type:
      - 'null'
      - int
    doc: Max partition size (limits memory usage)
    inputBinding:
      position: 101
      prefix: --max-partition-size
  - id: min_anchor_length
    type:
      - 'null'
      - int
    doc: Min (a)NCHOR length (default = 1.1*(Log(S)))
    inputBinding:
      position: 101
      prefix: --min-anchor-length
  - id: min_ani
    type:
      - 'null'
      - float
    doc: Min ANI value required to include genome
    inputBinding:
      position: 101
      prefix: --min-ani
  - id: min_cluster_size
    type:
      - 'null'
      - int
    doc: Minimum cluster size
    inputBinding:
      position: 101
      prefix: --min-cluster-size
  - id: min_partition_size
    type:
      - 'null'
      - int
    doc: Minimum size of a partition. Input genomes will be split evenly across partitions
      at least this large.
    inputBinding:
      position: 101
      prefix: --min-partition-size
  - id: min_ref_cov
    type:
      - 'null'
      - float
    doc: Minimum percent of reference segments to be covered in FastANI
    inputBinding:
      position: 101
      prefix: --min-ref-cov
  - id: mismatch_penalty
    type:
      - 'null'
      - int
    doc: Value of mismatch score for extension (should be negative)
    inputBinding:
      position: 101
      prefix: --mismatch-penalty
  - id: mum_length
    type:
      - 'null'
      - int
    doc: Mum length
    inputBinding:
      position: 101
      prefix: --mum-length
  - id: mumi_only
    type:
      - 'null'
      - boolean
    doc: Calculate MUMi and exit? overrides all other choices!
    inputBinding:
      position: 101
      prefix: --mumi_only
  - id: no_maf
    type:
      - 'null'
      - boolean
    doc: Do not generage MAF file (XMFA only)
    inputBinding:
      position: 101
      prefix: --no-maf
  - id: no_partition
    type:
      - 'null'
      - boolean
    doc: Run all query genomes in single parsnp alignment, no partitioning.
    inputBinding:
      position: 101
      prefix: --no-partition
  - id: query
    type:
      - 'null'
      - File
    doc: Specify (assembled) query genome to use, in addition to genomes found in
      genome dir
    inputBinding:
      position: 101
      prefix: --query
  - id: recomb_filter
    type:
      - 'null'
      - boolean
    doc: Run recombination filter (phipack)
    inputBinding:
      position: 101
      prefix: --recomb-filter
  - id: reference
    type:
      - 'null'
      - File
    doc: (r)eference genome (set to ! to pick random one from sequence dir)
    inputBinding:
      position: 101
      prefix: --reference
  - id: sequences
    type:
      type: array
      items: File
    doc: A list of files containing genomes/contigs/scaffolds. If the file ends in
      .txt, each line in the file corresponds to the path to an input file.
    inputBinding:
      position: 101
      prefix: --sequences
  - id: skip_ani_filter
    type:
      - 'null'
      - boolean
    doc: Skip the filtering step which discards inputs based on the ANI/MUMi distance
      to the reference.
    inputBinding:
      position: 101
      prefix: --skip-ani-filter
  - id: skip_phylogeny
    type:
      - 'null'
      - boolean
    doc: Do not generate phylogeny from core SNPs
    inputBinding:
      position: 101
      prefix: --skip-phylogeny
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: --threads
  - id: unaligned
    type:
      - 'null'
      - boolean
    doc: Output unaligned regions
    inputBinding:
      position: 101
      prefix: --unaligned
  - id: use_ani
    type:
      - 'null'
      - boolean
    doc: Use ANI for genome filtering
    inputBinding:
      position: 101
      prefix: --use-ani
  - id: use_fasttree
    type:
      - 'null'
      - boolean
    doc: Use fasttree instead of RaxML
    inputBinding:
      position: 101
      prefix: --use-fasttree
  - id: use_mash
    type:
      - 'null'
      - boolean
    doc: Use mash for genome filtering
    inputBinding:
      position: 101
      prefix: --use-mash
  - id: validate_input
    type:
      - 'null'
      - boolean
    doc: Use Biopython to validate input files
    inputBinding:
      position: 101
      prefix: --validate-input
  - id: vcf
    type:
      - 'null'
      - boolean
    doc: Generate VCF file.
    inputBinding:
      position: 101
      prefix: --vcf
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parsnp:2.1.5--h077b44d_0
