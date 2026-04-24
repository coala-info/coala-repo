cwlVersion: v1.2
class: CommandLineTool
baseCommand: sawfish discover
label: sawfish_discover
doc: "Discover SV candidate alleles in one sample\n\nTool homepage: https://github.com/PacificBiosciences/sawfish"
inputs:
  - id: bam
    type: File
    doc: Alignment file for query sample in BAM or CRAM format
    inputBinding:
      position: 101
      prefix: --bam
  - id: clobber
    type:
      - 'null'
      - boolean
    doc: Overwrite an existing output directory
    inputBinding:
      position: 101
      prefix: --clobber
  - id: cnv_excluded_regions
    type:
      - 'null'
      - File
    doc: "Regions of the genome to exclude from CNV analysis, in BED format.\n   \
      \       \n          Note this does not impact SV breakpoint analysis"
    inputBinding:
      position: 101
      prefix: --cnv-excluded-regions
  - id: cov_regex
    type:
      - 'null'
      - string
    doc: Regex used to select chromosomes for mean haploid coverage estimation. 
      All selected chromosomes are assumed diploid
    inputBinding:
      position: 101
      prefix: --cov-regex
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "Turn on extra debug logging\n          \n          This option enables extra
      logging intended for debugging only. It is highly recommended (but not required)
      to set --threads to 1 when this is enabled."
    inputBinding:
      position: 101
      prefix: --debug
  - id: disable_cnv
    type:
      - 'null'
      - boolean
    doc: "Disable CNV calling\n          \n          Disable CNV calling and read
      depth GC-bias estimation for this sample."
    inputBinding:
      position: 101
      prefix: --disable-cnv
  - id: disable_path_canonicalization
    type:
      - 'null'
      - boolean
    doc: "Don't canonicalize input file paths\n          \n          By default, all
      file paths input to the discover step are canonicalized and stored in the discover
      output directory for use in follow-on joint-call steps. This flag disables all
      canonicalization, which allows all paths to be stored as-is, including as relative
      paths. This may be useful for situations where the sample discover and joint-call
      steps are run in different directory structures."
    inputBinding:
      position: 101
      prefix: --disable-path-canonicalization
  - id: expected_cn
    type:
      - 'null'
      - File
    doc: "Expected copy number values by genomic interval, in BED format.\n      \
      \    \n          Copy number will be read from column 5 of the input BED file.
      Column 4 is ignored and can be used as a region label. The default copy number
      is 2 for unspecified regions. These copy number values will be stored in discover
      output for each sample and automatically selected for the given sample during
      joint-calling.\n          \n          Note this option is especially useful
      to clarify expected sex chromosome copy number in the sample.\n          \n\
      \          By default, the expected copy number only affects CNV calling behavior.
      If the option \"treat-single-copy-as-haploid\" is given during joint calling,
      then SV genotyping is updated for single copy regions as well."
    inputBinding:
      position: 101
      prefix: --expected-cn
  - id: fast_cnv_mode
    type:
      - 'null'
      - boolean
    doc: "This mode is designed to more quickly run a CNV-focused analysis by analyzing
      only the larger-scale SV breakpoint evidence that could be useful to improve
      CNV/large-variant accuracy, together with depth-based CNV analysis which is
      run regardless of this mode setting.\n          \n          Smaller assembly
      regions are skipped in his mode, which will remove all insertions, and most
      deletions below about 1kb."
    inputBinding:
      position: 101
      prefix: --fast-cnv-mode
  - id: maf
    type:
      - 'null'
      - File
    doc: "Variant file used to generate minor allele frequency track for this sample,
      in VCF or BCF format.\n          \n          The bigwig track file will be output
      for each sample in the joint-call step as 'maf.bw' in each sample directory.
      The frequencies may also be used to improve copy-number segmentation in a future
      update."
    inputBinding:
      position: 101
      prefix: --maf
  - id: maf_sample_name
    type:
      - 'null'
      - string
    doc: Specify the sample name to extract from the minor allele frequency 
      variant file. By default the file is searched for the sample name found in
      the input alignment file. This option allows an alternative name to be 
      specificied
    inputBinding:
      position: 101
      prefix: --maf-sample-name
  - id: min_indel_size
    type:
      - 'null'
      - int
    doc: Co-linear SVs must have either an insertion or deletion of this size or
      greater to be included in the output. All other SV evidence patterns such 
      as those consistent with duplications, inversions and translocations will 
      always be included in the output
    inputBinding:
      position: 101
      prefix: --min-indel-size
  - id: min_sv_mapq
    type:
      - 'null'
      - int
    doc: Minimum MAPQ value for reads to be used in SV breakend finding. This 
      does not change depth analysis
    inputBinding:
      position: 101
      prefix: --min-sv-mapq
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory for all discover command output (must not already exist)
    inputBinding:
      position: 101
      prefix: --output-dir
  - id: reduce_overlapping_sv_alleles
    type:
      - 'null'
      - boolean
    doc: "Reduce overlapping SV alleles to a single copy\n          \n          Certain
      benchmarks like GIAB SV v0.6 tend to compress both alleles at a VNTR to a single
      allele, often genotyped as homozygous. Using this flag will make the SV caller's
      output more directly comparable to such representations, but should not be used
      otherwise."
    inputBinding:
      position: 101
      prefix: --reduce-overlapping-sv-alleles
  - id: ref
    type: File
    doc: Genome reference in FASTA format
    inputBinding:
      position: 101
      prefix: --ref
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use. Defaults to all logical cpus detected
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sawfish:2.2.1--h9ee0642_0
stdout: sawfish_discover.out
