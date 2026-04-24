cwlVersion: v1.2
class: CommandLineTool
baseCommand: virsorter run
label: virsorter_run
doc: "Runs the virsorter main function to classify viral sequences\n\nTool homepage:
  https://github.com/simroux/VirSorter"
inputs:
  - id: mode
    type:
      - 'null'
      - string
    doc: all or classify
    inputBinding:
      position: 1
  - id: snakemake_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional snakemake arguments
    inputBinding:
      position: 2
  - id: db_dir
    type:
      - 'null'
      - Directory
    doc: database directory, default to the --db-dir set during installation
    inputBinding:
      position: 103
      prefix: --db-dir
  - id: dryrun
    type:
      - 'null'
      - boolean
    doc: Check rules to run and files to produce
    inputBinding:
      position: 103
      prefix: --dryrun
  - id: exclude_lt2gene
    type:
      - 'null'
      - boolean
    doc: short seqs (less than 2 genes) does not have any scores, but those with
      hallmark genes are included as viral by default; use this option to 
      exclude them
    inputBinding:
      position: 103
      prefix: --exclude-lt2gene
  - id: hallmark_required
    type:
      - 'null'
      - boolean
    doc: require hallmark gene on all viral seqs
    inputBinding:
      position: 103
      prefix: --hallmark-required
  - id: hallmark_required_on_short
    type:
      - 'null'
      - boolean
    doc: require hallmark gene on short viral seqs (length cutoff as "short" 
      were set by "MIN_SIZE_ALLOWED_WO_HALLMARK_GENE" in template-config.yaml 
      file, default 3kbp); this can reduce false positives at reasonable cost of
      sensitivity
    inputBinding:
      position: 103
      prefix: --hallmark-required-on-short
  - id: high_confidence_only
    type:
      - 'null'
      - boolean
    doc: 'only output high confidence viral sequences; this is equivalent to screening
      final-viral-score.tsv with the following criteria: (max_score >= 0.9) OR (max_score
      >=0.7 AND hallmark >= 1)'
    inputBinding:
      position: 103
      prefix: --high-confidence-only
  - id: include_groups
    type:
      - 'null'
      - string
    doc: 'classifiers of viral groups to included (comma separated and no space in
      between); available options are: dsDNAphage,NCLDV,RNA,ssDNA,lavidaviridae'
    inputBinding:
      position: 103
      prefix: --include-groups
  - id: jobs
    type:
      - 'null'
      - int
    doc: 'max # of jobs allowed in parallel.'
    inputBinding:
      position: 103
      prefix: --jobs
  - id: keep_original_seq
    type:
      - 'null'
      - boolean
    doc: keep the original sequences instead of trimmed; By default, the 
      untranslated regions at both ends of identified viral seqs are trimmed; 
      circular sequences are modified to remove overlap between both ends and 
      adjusted for the gene splitted into two ends;
    inputBinding:
      position: 103
      prefix: --keep-original-seq
  - id: label
    type:
      - 'null'
      - string
    doc: add label as prefix to output files; this is useful when re-running 
      classify with different filtering options
    inputBinding:
      position: 103
      prefix: --label
  - id: max_orf_per_seq
    type:
      - 'null'
      - int
    doc: 'max # of orf used for computing taxonomic feature; this option can only
      be used in --provirus-off mode; if # of orf in a seq exceeds the max limit,
      it is sub-sampled to this # to reduce computation'
    inputBinding:
      position: 103
      prefix: --max-orf-per-seq
  - id: min_length
    type:
      - 'null'
      - int
    doc: minimal seq length required; all seqs shorter than this will be removed
    inputBinding:
      position: 103
      prefix: --min-length
  - id: min_score
    type:
      - 'null'
      - float
    doc: minimal score to be identified as viral
    inputBinding:
      position: 103
      prefix: --min-score
  - id: prep_for_dramv
    type:
      - 'null'
      - boolean
    doc: turn on generating viral seqfile and viral-affi-contigs.tab for DRAMv
    inputBinding:
      position: 103
      prefix: --prep-for-dramv
  - id: profile
    type:
      - 'null'
      - string
    doc: snakemake profile e.g. for cluster execution.
    inputBinding:
      position: 103
      prefix: --profile
  - id: provirus_off
    type:
      - 'null'
      - boolean
    doc: turn off extracting provirus after classifying full contigs; Togetehr 
      with lower --max-orf-per-seq, can speed up a run significantly
    inputBinding:
      position: 103
      prefix: --provirus-off
  - id: rm_tmpdir
    type:
      - 'null'
      - boolean
    doc: 'remove intermediate file directory (--tmpdir); More than 100 intermediate
      files are created for each run, so this is recommended when 100s of samples
      are processed to avoid exceeding file # quota for user'
    inputBinding:
      position: 103
      prefix: --rm-tmpdir
  - id: seqfile
    type: File
    doc: sequence file in fa or fq format (could be compressed by gzip or bz2)
    inputBinding:
      position: 103
      prefix: --seqfile
  - id: seqname_suffix_off
    type:
      - 'null'
      - boolean
    doc: turn off adding suffix (||full, ||{i}_partial, ||lt2gene) to sequence 
      names; note that this might cause partial seqs from the same contig to 
      have the same name; this option is could be used when you are sure there 
      is one partial sequence at max from each contig
    inputBinding:
      position: 103
      prefix: --seqname-suffix-off
  - id: tmpdir
    type:
      - 'null'
      - string
    doc: directory name for intermediate files
    inputBinding:
      position: 103
      prefix: --tmpdir
  - id: use_conda_off
    type:
      - 'null'
      - boolean
    doc: Stop using the conda envs (vs2.yaml) that come with this package and 
      use what are installed in current system; Only useful when you want to 
      install dependencies on your own with your own prefer version; this option
      works with the development version
    inputBinding:
      position: 103
      prefix: --use-conda-off
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: shows detailed rules output
    inputBinding:
      position: 103
      prefix: --verbose
  - id: viral_gene_enrich_off
    type:
      - 'null'
      - boolean
    doc: turn off the requirement of more viral than cellular genes for calling 
      full sequence viral; this is useful when only using VirSorter2 to produce 
      DRAMv input with viral sequence identified from other tools, or those 
      trimmed by checkV
    inputBinding:
      position: 103
      prefix: --viral-gene-enrich-off
  - id: viral_gene_required
    type:
      - 'null'
      - boolean
    doc: require viral genes annotated, removing putative viral seqs with no 
      genes annotated; this can reduce false positives at reasonable cost of 
      sensitivity
    inputBinding:
      position: 103
      prefix: --viral-gene-required
  - id: working_dir
    type: Directory
    doc: output directory
    inputBinding:
      position: 103
      prefix: --working-dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/virsorter:2.2.4--pyhdfd78af_2
stdout: virsorter_run.out
