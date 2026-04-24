cwlVersion: v1.2
class: CommandLineTool
baseCommand: iva
label: iva
doc: "IVA is a de novo assembler for the de novo assembly of genomes from short reads.\n\
  \nTool homepage: https://github.com/sanger-pathogens/iva"
inputs:
  - id: output_directory
    type: Directory
    doc: Name of output directory (must not already exist)
    inputBinding:
      position: 1
  - id: adapters
    type:
      - 'null'
      - File
    doc: Fasta file of adapter sequences to be trimmed off reads. If used, must 
      also use --trimmomatic. Default is file of adapters supplied with IVA
    inputBinding:
      position: 102
      prefix: --adapters
  - id: contigs
    type:
      - 'null'
      - File
    doc: Fasta file of contigs to be extended. Incompatible with --reference
    inputBinding:
      position: 102
      prefix: --contigs
  - id: ctg_first_trim
    type:
      - 'null'
      - int
    doc: Number of bases to trim off the end of every contig before extending 
      for the first time
    inputBinding:
      position: 102
      prefix: --ctg_first_trim
  - id: ctg_iter_trim
    type:
      - 'null'
      - int
    doc: During iterative extension, number of bases to trim off the end of a 
      contig when extension fails (then try extending again)
    inputBinding:
      position: 102
      prefix: --ctg_iter_trim
  - id: ext_max_bases
    type:
      - 'null'
      - int
    doc: Maximum number of bases to try to extend on each iteration
    inputBinding:
      position: 102
      prefix: --ext_max_bases
  - id: ext_min_clip
    type:
      - 'null'
      - int
    doc: Set minimum number of bases soft clipped off a read for those bases to 
      be used for extension
    inputBinding:
      position: 102
      prefix: --ext_min_clip
  - id: ext_min_cov
    type:
      - 'null'
      - int
    doc: Minimum kmer depth needed to use that kmer to extend a contig
    inputBinding:
      position: 102
      prefix: --ext_min_cov
  - id: ext_min_ratio
    type:
      - 'null'
      - float
    doc: Sets N, where kmer for extension must be at least N times more abundant
      than next most common kmer
    inputBinding:
      position: 102
      prefix: --ext_min_ratio
  - id: fr_reads
    type:
      - 'null'
      - File
    doc: Name of interleaved fasta/q file
    inputBinding:
      position: 102
      prefix: --fr
  - id: keep_files
    type:
      - 'null'
      - boolean
    doc: Keep intermediate files (could be many!). Default is to delete all 
      unnecessary files
    inputBinding:
      position: 102
      prefix: --keep_files
  - id: kmc_onethread
    type:
      - 'null'
      - boolean
    doc: Force kmc to use one thread. By default the value of -t/--threads is 
      used when running kmc
    inputBinding:
      position: 102
      prefix: --kmc_onethread
  - id: make_new_seeds
    type:
      - 'null'
      - boolean
    doc: When no more contigs can be extended, generate a new seed. This is 
      forced to be true when --contigs is not used
    inputBinding:
      position: 102
      prefix: --make_new_seeds
  - id: max_contigs
    type:
      - 'null'
      - int
    doc: Maximum number of contigs allowed in the assembly. No more seeds 
      generated if the cutoff is reached
    inputBinding:
      position: 102
      prefix: --max_contigs
  - id: max_insert
    type:
      - 'null'
      - int
    doc: Maximum insert size (includes read length). Reads with inferred insert 
      size more than the maximum will not be used to extend contigs
    inputBinding:
      position: 102
      prefix: --max_insert
  - id: min_trimmed_length
    type:
      - 'null'
      - int
    doc: Minimum length of read after trimming
    inputBinding:
      position: 102
      prefix: --min_trimmed_length
  - id: pcr_primers
    type:
      - 'null'
      - File
    doc: FASTA file of primers. The first perfect match found to a sequence in 
      the primers file will be trimmed off the start of each read. This is run 
      after trimmomatic (if --trimmomatic used)
    inputBinding:
      position: 102
      prefix: --pcr_primers
  - id: reads_fwd
    type:
      - 'null'
      - File
    doc: Name of forward reads fasta/q file. Must be used in conjunction with 
      --reads_rev
    inputBinding:
      position: 102
      prefix: --reads_fwd
  - id: reads_rev
    type:
      - 'null'
      - File
    doc: Name of reverse reads fasta/q file. Must be used in conjunction with 
      --reads_fwd
    inputBinding:
      position: 102
      prefix: --reads_rev
  - id: reference
    type:
      - 'null'
      - File
    doc: EXPERIMENTAL! This option is EXPERIMENTAL, not recommended, and has not
      been tested! Fasta file of reference genome, or parts thereof. IVA will 
      try to assemble one contig per sequence in this file. Incompatible with 
      --contigs
    inputBinding:
      position: 102
      prefix: --reference
  - id: seed_ext_max_bases
    type:
      - 'null'
      - int
    doc: Maximum number of bases to try to extend on each iteration
    inputBinding:
      position: 102
      prefix: --seed_ext_max_bases
  - id: seed_ext_min_cov
    type:
      - 'null'
      - int
    doc: Minimum kmer depth needed to use that kmer to extend a contig
    inputBinding:
      position: 102
      prefix: --seed_ext_min_cov
  - id: seed_ext_min_ratio
    type:
      - 'null'
      - float
    doc: Sets N, where kmer for extension must be at least N times more abundant
      than next most common kmer
    inputBinding:
      position: 102
      prefix: --seed_ext_min_ratio
  - id: seed_max_kmer_cov
    type:
      - 'null'
      - int
    doc: Maximum kmer coverage of initial seed
    inputBinding:
      position: 102
      prefix: --seed_max_kmer_cov
  - id: seed_min_kmer_cov
    type:
      - 'null'
      - int
    doc: Minimum kmer coverage of initial seed
    inputBinding:
      position: 102
      prefix: --seed_min_kmer_cov
  - id: seed_overlap_length
    type:
      - 'null'
      - int
    doc: Number of overlapping bases needed between read and seed to use that 
      read to extend [seed_start_length]
    inputBinding:
      position: 102
      prefix: --seed_overlap_length
  - id: seed_start_length
    type:
      - 'null'
      - int
    doc: 'When making a seed sequence, use the most common kmer of this length. Default
      is to use the minimum of (median read length, 95). Warning: it is not recommended
      to set this higher than 95'
    inputBinding:
      position: 102
      prefix: --seed_start_length
  - id: seed_stop_length
    type:
      - 'null'
      - string
    doc: Stop extending seed using perfect matches from reads when this length 
      is reached. Future extensions are then made by treating the seed as a 
      contig [0.9*max_insert]
    inputBinding:
      position: 102
      prefix: --seed_stop_length
  - id: smalt_id
    type:
      - 'null'
      - float
    doc: Minimum identity threshold for mapping to be reported (the -y option in
      smalt map)
    inputBinding:
      position: 102
      prefix: --smalt_id
  - id: smalt_k
    type:
      - 'null'
      - int
    doc: kmer hash length in SMALT (the -k option in smalt index)
    inputBinding:
      position: 102
      prefix: --smalt_k
  - id: smalt_s
    type:
      - 'null'
      - int
    doc: kmer hash step size in SMALT (the -s option in smalt index)
    inputBinding:
      position: 102
      prefix: --smalt_s
  - id: strand_bias
    type:
      - 'null'
      - float
    doc: Set strand bias cutoff of mapped reads when trimming contig ends, in 
      the interval [0,0.5]. A value of x means that a base needs min(fwd_depth, 
      rev_depth) / total_depth <= x. The only time this should be used is with 
      libraries with overlapping reads (ie fragment length < 2*read length), and
      even then, it can make results worse. If used, try a low value like 0.1 
      first
    inputBinding:
      position: 102
      prefix: --strand_bias
  - id: test
    type:
      - 'null'
      - boolean
    doc: Run using built in test data. All other options will be ignored, except
      the mandatory output directory, and --trimmomatic and --threads can be 
      also be used
    inputBinding:
      position: 102
      prefix: --test
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 102
      prefix: --threads
  - id: trimmo_qual
    type:
      - 'null'
      - string
    doc: Trimmomatic options used to quality trim reads
    inputBinding:
      position: 102
      prefix: --trimmo_qual
  - id: trimmomatic
    type:
      - 'null'
      - File
    doc: Provide location of trimmomatic.jar file to enable read trimming. 
      Required if --adapters used
    inputBinding:
      position: 102
      prefix: --trimmomatic
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Be verbose by printing messages to stdout. Use up to three times for 
      increasing verbosity.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/iva:1.0.11--py_0
stdout: iva.out
