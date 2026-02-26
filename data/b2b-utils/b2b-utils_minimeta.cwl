cwlVersion: v1.2
class: CommandLineTool
baseCommand: minimeta
label: b2b-utils_minimeta
doc: "Produces a polished consensus assembly from long-read sequencing data using
  miniasm, racon, and medaka. Software settings are tuned for metagenomic/metatranscriptomic
  assemblies of variable, sometimes low, coverage.\n\nTool homepage: https://github.com/jvolkening/b2b-utils"
inputs:
  - id: assembly
    type:
      - 'null'
      - File
    doc: Path to existing assembly. If provided, assembly is skipped and only 
      polishing is performed
    default: none
    inputBinding:
      position: 101
      prefix: --assembly
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: If this option is given, input reads will be split into chunks of 
      --chunk_size reads and each chunk will be assembled independently. The 
      resulting assemblies will be combined, shredded into pseudoreads, and 
      reassembled.
    inputBinding:
      position: 101
      prefix: --chunk_size
  - id: deterministic
    type:
      - 'null'
      - boolean
    doc: Use a fixed seed for random processes such as shuffling
    inputBinding:
      position: 101
      prefix: --deterministic
  - id: homopolish_ref
    type:
      - 'null'
      - File
    doc: Path to reference FASTA file used by homopolish. Providing this 
      filename also triggers polishing using homopolish
    default: none
    inputBinding:
      position: 101
      prefix: --homopolish
  - id: hp_model
    type:
      - 'null'
      - string
    doc: Name of model to be used by homopolish. Has no effect if --homopolish 
      not used.
    default: R9.4.pkl
    inputBinding:
      position: 101
      prefix: --hp_model
  - id: input_reads
    type: File
    doc: Path to input reads in FASTx format
    inputBinding:
      position: 101
      prefix: --in
  - id: mask_below
    type:
      - 'null'
      - int
    doc: If given, final assembly positions with coverage depth below this value
      will be hard masked with 'N'
    inputBinding:
      position: 101
      prefix: --mask_below
  - id: medaka_batch_size
    type:
      - 'null'
      - int
    doc: Batch size (medaka_consensus parameter -b) for medaka to use; using a 
      smaller value should reduce memory consumption
    default: 100
    inputBinding:
      position: 101
      prefix: --medaka_batch_size
  - id: medaka_model
    type:
      - 'null'
      - string
    doc: Name of model to be used by medaka_consensus (based on basecalling 
      model used for data)
    inputBinding:
      position: 101
      prefix: --medaka_model
  - id: min_cov
    type:
      - 'null'
      - int
    doc: Minimum read coverage required by assembler to keep position
    default: 2
    inputBinding:
      position: 101
      prefix: --min_cov
  - id: min_ident
    type:
      - 'null'
      - float
    doc: Minimum identity (0 to 1) between contigs required to remove shorter 
      contig during redundancy reduction.
    default: 0.8
    inputBinding:
      position: 101
      prefix: --min_ident
  - id: min_len
    type:
      - 'null'
      - int
    doc: Minimum contig length to keep
    default: 1
    inputBinding:
      position: 101
      prefix: --min_len
  - id: minimizer_cutoff
    type:
      - 'null'
      - int
    doc: During all-vs-all mapping, discard minimizers occurring above this 
      frequency. This is the -f parameter to minimap2, and can be useful with 
      high-coverage input datasets that may otherwise consume very large amounts
      of memory and time. A value between 1000 and 10,000 may be useful in these
      cases.
    inputBinding:
      position: 101
      prefix: --minimizer_cutoff
  - id: n_medaka
    type:
      - 'null'
      - int
    doc: Number of Medaka polishing rounds to perform
    default: 1
    inputBinding:
      position: 101
      prefix: --n_medaka
  - id: n_racon
    type:
      - 'null'
      - int
    doc: Number of Racon polishing rounds to perform
    default: 3
    inputBinding:
      position: 101
      prefix: --n_racon
  - id: noshuffle
    type:
      - 'null'
      - boolean
    doc: Don't randomly shuffle input reads prior to assembly
    inputBinding:
      position: 101
      prefix: --noshuffle
  - id: only_split_at_hp
    type:
      - 'null'
      - boolean
    doc: If given in conjuction with "--split", only splits low coverage regions
      if one or both junctions is at a homopolymer stretch
    inputBinding:
      position: 101
      prefix: --only_split_at_hp
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Don't write status messages to STDERR
    inputBinding:
      position: 101
      prefix: --quiet
  - id: reassemblies
    type:
      - 'null'
      - int
    doc: Perform one or more rounds of pseudo-assembly in order to minimize 
      redundancy. For each round, the existing assembly is shredded into 
      pseudoreads and reassembled.
    inputBinding:
      position: 101
      prefix: --reassemblies
  - id: reduce
    type:
      - 'null'
      - boolean
    doc: Apply a reduction algorithm to the pre-final assembly to remove 
      redundant contigs (i.e. contigs mostly or completely overlapping with 
      identity above a cutoff specified by --min_ident. Currently this is done 
      using Redundans, which is required to be installed.
    inputBinding:
      position: 101
      prefix: --reduce
  - id: shred_len
    type:
      - 'null'
      - int
    doc: For re-assemblies, the maximum length of pseudo-reads to generate as an
      absolute value; the actual value will be the minimum of this and the value
      of --shred_max_frac times the actual contig length
    default: 2000
    inputBinding:
      position: 101
      prefix: --shred_len
  - id: shred_max_frac
    type:
      - 'null'
      - float
    doc: For re-assemblies, the maximum length of pseudo-reads to generate as a 
      fraction of the contig length; the actual value will be the minimum of 
      this and the value of --shred_len
    default: 0.66
    inputBinding:
      position: 101
      prefix: --shred_max_frac
  - id: shred_tgt_depth
    type:
      - 'null'
      - int
    doc: For re-assemblies, the target depth of the pseudoreads on each contig; 
      this is used to calculate how many reads to generate
    default: 10
    inputBinding:
      position: 101
      prefix: --shred_tgt_depth
  - id: split
    type:
      - 'null'
      - float
    doc: If given in conjunction with "--mask_below", splits contigs at masked 
      regions into smaller pieces.
    inputBinding:
      position: 101
      prefix: --split
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of processsing threads to use for mapping and polishing
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: trim_polyn
    type:
      - 'null'
      - boolean
    doc: Trim long poly-N stretches from reads prior to assembly
    inputBinding:
      position: 101
      prefix: --trim_polyN
outputs:
  - id: output_consensus
    type:
      - 'null'
      - File
    doc: Path to write consensus sequence to (as FASTA)
    outputBinding:
      glob: $(inputs.output_consensus)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/b2b-utils:0.020--pl5321h9ee0642_0
