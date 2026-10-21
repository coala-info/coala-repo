cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sailfish
  - quant
label: sailfish_quant
doc: "Perform quasi-mapping-based estimation of transcript abundance from RNA-seq reads\n\nTool homepage: https://github.com/kingsfordgroup/sailfish"
inputs:
  - id: index
    type: Directory
    doc: 'Sailfish index'
    inputBinding:
      position: 1
      prefix: --index
  - id: lib_type
    type: string
    doc: 'Format string describing the library type'
    inputBinding:
      position: 1
      prefix: --libType
  - id: unmated_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: 'List of files containing unmated reads of (e.g. single-end reads) (uncompressed FASTA/FASTQ)'
    inputBinding:
      position: 1
      prefix: --unmatedReads
  - id: mates1
    type:
      - 'null'
      - type: array
        items: File
    doc: 'File containing the #1 mates (uncompressed FASTA/FASTQ)'
    inputBinding:
      position: 1
      prefix: --mates1
  - id: mates2
    type:
      - 'null'
      - type: array
        items: File
    doc: 'File containing the #2 mates (uncompressed FASTA/FASTQ)'
    inputBinding:
      position: 1
      prefix: --mates2
  - id: threads
    type:
      - 'null'
      - int
    doc: 'The number of threads to use concurrently. (default 20)'
    inputBinding:
      position: 1
      prefix: --threads
  - id: output
    type: string
    doc: 'Output quantification file.'
    inputBinding:
      position: 1
      prefix: --output
  - id: gene_map
    type:
      - 'null'
      - File
    doc: 'File containing a mapping of transcripts to genes (GTF/GFF or tab-delimited). If provided Sailfish also outputs quant.genes.sf'
    inputBinding:
      position: 1
      prefix: --geneMap
  - id: bias_correct
    type:
      - 'null'
      - boolean
    doc: 'Perform sequence-specific bias correction'
    inputBinding:
      position: 1
      prefix: --biasCorrect
  - id: gc_bias_correct
    type:
      - 'null'
      - boolean
    doc: '[experimental] Perform fragment GC bias correction'
    inputBinding:
      position: 1
      prefix: --gcBiasCorrect
  - id: aux_dir
    type:
      - 'null'
      - string
    doc: 'The sub-directory of the quantification directory where auxiliary information e.g. bootstraps, bias parameters, etc. will be written. (default aux)'
    inputBinding:
      position: 1
      prefix: --auxDir
  - id: dump_eq
    type:
      - 'null'
      - boolean
    doc: 'Dump the equivalence class counts that were computed during quasi-mapping'
    inputBinding:
      position: 1
      prefix: --dumpEq
  - id: gc_size_samp
    type:
      - 'null'
      - int
    doc: 'The value by which to down-sample transcripts when representing the GC content. (default 1)'
    inputBinding:
      position: 1
      prefix: --gcSizeSamp
  - id: gc_speed_samp
    type:
      - 'null'
      - int
    doc: 'The value at which the fragment length PMF is down-sampled when evaluating GC fragment bias. (default 1)'
    inputBinding:
      position: 1
      prefix: --gcSpeedSamp
  - id: strict_intersect
    type:
      - 'null'
      - boolean
    doc: 'Modifies how orphans are assigned.'
    inputBinding:
      position: 1
      prefix: --strictIntersect
  - id: unsmoothed_fld
    type:
      - 'null'
      - boolean
    doc: 'Use the un-smoothed (i.e. traditional) approach to effective length correction'
    inputBinding:
      position: 1
      prefix: --unsmoothedFLD
  - id: max_frag_len
    type:
      - 'null'
      - int
    doc: 'The maximum length of a fragment to consider when building the empirical fragment length distribution (default 1000)'
    inputBinding:
      position: 1
      prefix: --maxFragLen
  - id: txp_aggregation_key
    type:
      - 'null'
      - string
    doc: 'When generating the gene-level estimates, use the provided key for aggregating transcripts. (default gene_id)'
    inputBinding:
      position: 1
      prefix: --txpAggregationKey
  - id: ignore_lib_compat
    type:
      - 'null'
      - boolean
    doc: 'Disables strand-aware processing completely.'
    inputBinding:
      position: 1
      prefix: --ignoreLibCompat
  - id: enforce_lib_compat
    type:
      - 'null'
      - boolean
    doc: 'Enforces strict library compatibility.'
    inputBinding:
      position: 1
      prefix: --enforceLibCompat
  - id: allow_dovetail
    type:
      - 'null'
      - boolean
    doc: 'Allow paired-end reads from the same fragment to dovetail'
    inputBinding:
      position: 1
      prefix: --allowDovetail
  - id: discard_orphans
    type:
      - 'null'
      - boolean
    doc: 'Discard orphaned fragments (paired-end input).'
    inputBinding:
      position: 1
      prefix: --discardOrphans
  - id: num_bias_samples
    type:
      - 'null'
      - int
    doc: 'Number of fragment mappings to use when learning the sequence-specific bias model. (default 1000000)'
    inputBinding:
      position: 1
      prefix: --numBiasSamples
  - id: num_frag_samples
    type:
      - 'null'
      - int
    doc: 'Number of fragments from unique alignments to sample when building the fragment length distribution (default 10000)'
    inputBinding:
      position: 1
      prefix: --numFragSamples
  - id: fld_mean
    type:
      - 'null'
      - int
    doc: 'Mean of the fragment length distribution for single-end or when an empirical distribution cannot be learned. (default 200)'
    inputBinding:
      position: 1
      prefix: --fldMean
  - id: fld_sd
    type:
      - 'null'
      - int
    doc: 'Standard deviation of the fragment length distribution for single-end or when an empirical distribution cannot be learned. (default 80)'
    inputBinding:
      position: 1
      prefix: --fldSD
  - id: max_read_occ
    type:
      - 'null'
      - int
    doc: 'Reads mapping to more than this many places won''t be considered. (default 200)'
    inputBinding:
      position: 1
      prefix: --maxReadOcc
  - id: no_effective_length_correction
    type:
      - 'null'
      - boolean
    doc: 'Disables effective length correction'
    inputBinding:
      position: 1
      prefix: --noEffectiveLengthCorrection
  - id: use_vb_opt
    type:
      - 'null'
      - boolean
    doc: 'Use the Variational Bayesian EM rather than the traditional EM algorithm'
    inputBinding:
      position: 1
      prefix: --useVBOpt
  - id: num_gibbs_samples
    type:
      - 'null'
      - int
    doc: '[super-experimental] Number of Gibbs sampling rounds to perform. (default 0)'
    inputBinding:
      position: 1
      prefix: --numGibbsSamples
  - id: num_bootstraps
    type:
      - 'null'
      - int
    doc: '[super-experimental] Number of bootstrap samples to generate. Mutually exclusive with Gibbs sampling. (default 0)'
    inputBinding:
      position: 1
      prefix: --numBootstraps
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: quant_dir
    type: Directory
    doc: Quantification output directory
    outputBinding:
      glob: $(inputs.output)
  - id: quant_sf
    type: File
    doc: Transcript abundance estimates
    outputBinding:
      glob: $(inputs.output)/quant.sf
  - id: quant_genes_sf
    type:
      - 'null'
      - File
    doc: Gene-level abundance estimates (when a gene map is given)
    outputBinding:
      glob: $(inputs.output)/quant.genes.sf
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sailfish:0.10.1--1
stdout: sailfish_quant.out
