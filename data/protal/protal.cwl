cwlVersion: v1.2
class: CommandLineTool
baseCommand: protal
label: protal
doc: "Protal help text\n\nTool homepage: https://github.com/4less/protal"
inputs:
  - id: align_top
    type:
      - 'null'
      - int
    doc: After seeding, anchor are sorted by quality passed to alignment. 
      <take_top> specifies how many anchors should be aligned starting with the 
      most promising anchor.
    default: 3
    inputBinding:
      position: 101
      prefix: --align_top
  - id: benchmark_alignment
    type:
      - 'null'
      - boolean
    doc: 'Benchmark alignment part of protal based on true taxonomic id and gene id
      supplied in the read header. Header must fulfill the formatting >taxid_geneid...
      with the regex: >[0-9]+_[0-9]+([^0-9]+.*)*'
    inputBinding:
      position: 101
      prefix: --benchmark_alignment
  - id: benchmark_alignment_output
    type:
      - 'null'
      - File
    doc: Benchmark alignment output. Output is appended to the file.
    inputBinding:
      position: 101
      prefix: --benchmark_alignment_output
  - id: build
    type:
      - 'null'
      - boolean
    doc: Build index from reference file with header format ()
    inputBinding:
      position: 101
      prefix: --build
  - id: db
    type:
      - 'null'
      - Directory
    doc: Path to protal database folder.
    inputBinding:
      position: 101
      prefix: --db
  - id: first
    type:
      - 'null'
      - string
    doc: Comma separated list of reads. If paired-end, also specify second read 
      via -2/--second.
    default: ''
    inputBinding:
      position: 101
      prefix: --first
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force redo alignment even if sam files exists.
    inputBinding:
      position: 101
      prefix: --force
  - id: full_reference
    type:
      - 'null'
      - string
    doc: All marker genomes (not only representative ones) to check unique 
      k-mers during build process
    default: ''
    inputBinding:
      position: 101
      prefix: --full_reference
  - id: map
    type:
      - 'null'
      - string
    doc: For larger datasets you can define parameters -1, -2, -3 and -o in a 
      tsv-file.
    default: ''
    inputBinding:
      position: 101
      prefix: --map
  - id: map_help
    type:
      - 'null'
      - boolean
    doc: Get help how to format the map file.
    inputBinding:
      position: 101
      prefix: --map_help
  - id: map_range
    type:
      - 'null'
      - string
    doc: 'If you specified a map file with --map you can also pass a range to protal
      to run protal only on a subset. The first entry is 1, the end is inclusive.
      e.g.: 1-10. If the end open or larger than the number of entries in the map
      file, the last entry in the map file is selected as end.'
    default: 1-
    inputBinding:
      position: 101
      prefix: --map_range
  - id: mapq_debug_output
    type:
      - 'null'
      - boolean
    doc: Output mapq debug info to stderr
    inputBinding:
      position: 101
      prefix: --mapq_debug_output
  - id: max_key_ubiquity
    type:
      - 'null'
      - int
    doc: Max key ubiquity. Best matching Flexkey count for seed must be lower or
      equal
    default: 256
    inputBinding:
      position: 101
      prefix: --max_key_ubiquity
  - id: max_out
    type:
      - 'null'
      - int
    doc: Maximum alignments that should be outputted
    default: 1
    inputBinding:
      position: 101
      prefix: --max_out
  - id: max_score_ani
    type:
      - 'null'
      - float
    doc: 'A max score makes an alignment stop if the alignment diverges too much.
      This parameter estimates the score for a given ani and is a tradeoff between
      speed/accuracy. [ Default: 0.900000]'
    default: 0.9
    inputBinding:
      position: 101
      prefix: --max_score_ani
  - id: max_seed_size
    type:
      - 'null'
      - int
    doc: Max seed size after which seeding is stopped.
    default: 128
    inputBinding:
      position: 101
      prefix: --max_seed_size
  - id: min_successful_lookups
    type:
      - 'null'
      - int
    doc: If the number of seeds is >=max_seed_size and the number of successful 
      core-mer lookups is >= min_successful_lookups, stop looking for further 
      seeds.
    default: 4
    inputBinding:
      position: 101
      prefix: --min_successful_lookups
  - id: msa_min_vcov
    type:
      - 'null'
      - float
    doc: Protal outputs two MSAs. The processed MSA is condensed horizontally 
      such that each position in the MSA is covered by at least msa_min_cov 
      percent of the sequences with bases that are neither '-' nor 'N'
    default: 0.5
    inputBinding:
      position: 101
      prefix: --msa_min_vcov
  - id: no_profile
    type:
      - 'null'
      - boolean
    doc: Do NOT perform taxonomic profiling, only output alignments.
    inputBinding:
      position: 101
      prefix: --no_profile
  - id: no_strains
    type:
      - 'null'
      - boolean
    doc: Stay on species level. Do not output SNPs or MSAs
    inputBinding:
      position: 101
      prefix: --no_strains
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Comma separated list of output prefixes (optional). If not specified, 
      output file prefixes are generated from the input file names. If not 
      otherwise specified by using --map, sam files, profiles, msas, and other 
      miscellaneous files will be stored in the subfolders to this directory 
      'sam', 'profiles', 'strains', and 'misc'.
    inputBinding:
      position: 101
      prefix: --outdir
  - id: output_top
    type:
      - 'null'
      - int
    doc: After alignment, alignments are sorted by score. <output_top> specifies
      how many alignments should be reported starting with the highest scoring 
      alignment.
    default: 3
    inputBinding:
      position: 101
      prefix: --output_top
  - id: prefix
    type:
      - 'null'
      - string
    doc: Comma separated list of output prefixes (optional). If not specified, 
      output file prefixes are generated from the input file names by taking 
      their longest common prefix. Only works when both pairs of the read file 
      are in the same folder.
    default: ''
    inputBinding:
      position: 101
      prefix: --prefix
  - id: preload_genomes_off
    type:
      - 'null'
      - boolean
    doc: Do not preload complete reference library (reference.fna and 
      reference.map in protal index folder) and instead do dynamic loading. This
      usually decreases performance but saves memory.
    inputBinding:
      position: 101
      prefix: --preload_genomes_off
  - id: profile_only
    type:
      - 'null'
      - File
    doc: Provide profile filename (.sam) and only perform profiling based on sam
      file.
    default: ''
    inputBinding:
      position: 101
      prefix: --profile_only
  - id: profile_truth
    type:
      - 'null'
      - string
    doc: Provide truth file and annotate profile taxa with TP/FP. Format is list
      of integers (internal ids)
    default: ''
    inputBinding:
      position: 101
      prefix: --profile_truth
  - id: reference
    type:
      - 'null'
      - string
    doc: Set of reference sequences to build the internal alignment database 
      from
    default: ''
    inputBinding:
      position: 101
      prefix: --reference
  - id: second
    type:
      - 'null'
      - string
    doc: Comma separated list of reads. must have <-1/--first> specified. 
      Currently this must be specified -- single-end reads are not yet 
      supported.
    default: ''
    inputBinding:
      position: 101
      prefix: --second
  - id: threads
    type:
      - 'null'
      - int
    doc: Specify number of threads to use. Will be passed on to pigz for 
      compression of sam files.
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Have verbose program output
    inputBinding:
      position: 101
      prefix: --verbose
  - id: x_drop
    type:
      - 'null'
      - int
    doc: 'Value determines when to cut of branches in the aligment process that are
      unpromising. [ Default: 1000]'
    default: 1000
    inputBinding:
      position: 101
      prefix: --x_drop
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/protal:0.2.0a--h5ca1c30_0
stdout: protal.out
