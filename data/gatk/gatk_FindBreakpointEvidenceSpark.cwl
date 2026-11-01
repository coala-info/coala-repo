cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - FindBreakpointEvidenceSpark
label: gatk_FindBreakpointEvidenceSpark
doc: |-
  This tool is used in development and should not be of interest to most researchers.  It packages the identification of genomic regions that might contain structural variation and the generation of local assemblies of these regions as a separate tool, independent of the calling of structural variations from these assemblies Most researchers will run StructuralVariationDiscoveryPipelineSpark, which both generates local assemblies of interesting genomic regions, and then calls structural variants from these assemblies. This tool identifies genomic regions that may harbor structural variants by integrating evidence from split reads, discordant read pairs, template-length anomalies, and copy-number variation.  It then prepares local assemblies of these regions for structural variant calling.  In addition to the reads that align to these regions, reads sharing kmers (fixed-length subsequences) with the reads aligned in these regions are extracted to produce the local assemblies. The local assemblies are done with FermiLite, and the assembled contigs are aligned to reference with BWA-MEM. The output is a file of aligned contigs from local assemblies to be used in calling structural variants.

  Tool homepage: https://gatk.broadinstitute.org/
inputs:
  - id: aligner_index_image
    type: File
    inputBinding:
      position: 101
      prefix: --aligner-index-image
    doc: bwa-mem index image file
  - id: input
    type:
      type: array
      items: File
      inputBinding:
        prefix: --input
    inputBinding:
      position: 101
    doc: BAM/SAM/CRAM file containing reads This argument must be specified at least
      once.
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
      - pattern: .crai
        required: false
      - pattern: ^.crai
        required: false
      - pattern: .sbi
        required: false
  - id: kmers_to_ignore
    type: File
    inputBinding:
      position: 101
      prefix: --kmers-to-ignore
    doc: file containing ubiquitous kmer list. see FindBadGenomicKmersSpark to generate
      it.
  - id: output
    type: string
    inputBinding:
      position: 101
      prefix: --output
    doc: sam file for aligned contigs
  - id: adapter_sequence
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --adapter-sequence
    doc: Adapter sequence.
  - id: allowed_short_fragment_overhang
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --allowed-short-fragment-overhang
    doc: 'Proper pairs have the positive strand read upstream of the negative strand
      read, but we allow this much slop for short fragments. Default value: 10.'
  - id: assembled_contigs_output_order
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --assembled-contigs-output-order
    doc: 'sorting order to be used for the output assembly alignments SAM/BAM file
      (currently only coordinate or query name is supported) Default value: coordinate.
      Possible values: {unsorted, queryname, coordinate, duplicate, unknown}'
  - id: assembly_to_mapped_size_ratio_guess
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --assembly-to-mapped-size-ratio-guess
    doc: 'Guess at the ratio of reads in the final assembly to the number reads mapped
      to the interval. Default value: 7.'
  - id: breakpoint_evidence_dir
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --breakpoint-evidence-dir
    doc: directory for evidence output
  - id: breakpoint_intervals
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --breakpoint-intervals
    doc: file for breakpoint intervals output
  - id: cleaner_max_copy_number
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --cleaner-max-copy-number
    doc: 'KmerCleaner maximum copy number (not count, but copy number) for a kmer.
      Kmers observed too frequently are probably mismapped or ubiquitous. Default
      value: 4.'
  - id: cleaner_max_intervals
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --cleaner-max-intervals
    doc: 'KmerCleaner maximum number of intervals for a localizing kmer. If a kmer
      occurs in too many intervals, it isn''t sufficiently local. Default value: 3.'
  - id: cleaner_min_kmer_count
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --cleaner-min-kmer-count
    doc: 'KmerCleaner minimum kmer count for a localizing kmer. If we see it less
      often than this many times, we''re guessing it''s erroneous. Default value:
      4.'
  - id: cross_contigs_to_ignore
    type:
      - 'null'
      - File
    inputBinding:
      position: 101
      prefix: --cross-contigs-to-ignore
    doc: file containing alt contig names that will be ignored when looking for inter-contig
      pairs
  - id: disable_sequence_dictionary_validation
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --disable-sequence-dictionary-validation
    doc: 'If specified, do not check the sequence dictionaries from our inputs for
      compatibility. Use at your own risk! Default value: false. Possible values:
      {true, false}'
  - id: exclude_intervals
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --exclude-intervals
    inputBinding:
      position: 101
    doc: One or more genomic intervals to exclude from processing This argument may
      be specified 0 or more times.
  - id: exclusion_interval_padding
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --exclusion-interval-padding
    doc: 'Exclusion interval padding. Default value: 0.'
  - id: exclusion_intervals
    type:
      - 'null'
      - File
    inputBinding:
      position: 101
      prefix: --exclusion-intervals
    doc: file of reference intervals to exclude
  - id: external_evidence
    type:
      - 'null'
      - File
    inputBinding:
      position: 101
      prefix: --external-evidence
    doc: external evidence input file
  - id: external_evidence_uncertainty
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --external-evidence-uncertainty
    doc: 'Uncertainty in location of external evidence. Default value: 150.'
  - id: external_evidence_weight
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --external-evidence-weight
    doc: 'Weight to give external evidence. Default value: 10.'
  - id: fastq_dir
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --fastq-dir
    doc: output dir for assembled fastqs
  - id: high_coverage_intervals
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --high-coverage-intervals
    doc: file for high-coverage intervals output
  - id: high_depth_coverage_factor
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --high-depth-coverage-factor
    doc: 'We filter out contiguous regions of the genome that have coverage of at
      least high-depth-coverage-factor * avg-coverage and a peak coverage of high-depth-coverage-peak-factor
      * avg-coverage, because the reads mapped to those regions tend to be non-local
      and high depth prevents accurate assembly. Default value: 3.'
  - id: high_depth_coverage_peak_factor
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --high-depth-coverage-peak-factor
    doc: 'We filter out contiguous regions of the genome that have coverage of at
      least high-depth-coverage-factor * avg-coverage and a peak coverage of high-depth-coverage-peak-factor
      * avg-coverage, because the reads mapped to those regions tend to be non-local
      and high depth prevents accurate assembly. Default value: 7.'
  - id: include_mapping_location
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --include-mapping-location
      valueFrom: '$(self ? ''true'' : ''false'')'
    doc: 'Include read mapping location in FASTQ files. Default value: true. Possible
      values: {true, false}'
  - id: interval_only_assembly
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --interval-only-assembly
    doc: 'Don''t look for extra reads mapped outside the interval. Default value:
      false. Possible values: {true, false}'
  - id: intervals
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --intervals
    inputBinding:
      position: 101
    doc: One or more genomic intervals over which to operate This argument may be
      specified 0 or more times.
  - id: k_size
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --k-size
    doc: 'Kmer size. Default value: 51.'
  - id: kmer_intervals
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --kmer-intervals
    doc: file for kmer intervals output
  - id: kmer_max_dust_score
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --kmer-max-dust-score
    doc: 'Maximum kmer DUST score. Default value: 49.'
  - id: max_fastq_size
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --max-fastq-size
    doc: 'Maximum total bases in FASTQs that can be assembled. Default value: 3000000.'
  - id: max_tracked_fragment_length
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --max-tracked-fragment-length
    doc: 'Largest fragment size that will be explicitly counted in determining fragment
      size statistics. Default value: 2000.'
  - id: min_coherent_evidence_coverage_ratio
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --min-coherent-evidence-coverage-ratio
    doc: 'Minimum weight of the evidence that shares a distal target locus to validate
      the evidence, as a ratio of the mean coverage in the BAM. The default value
      is coherent-count / mean coverage ~ 7 / 42.9 ~ 0.163 Default value: 0.1633408753260167.'
  - id: min_evidence_coverage_ratio
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --min-evidence-coverage-ratio
    doc: 'Minimum weight of the corroborating read evidence to validate some single
      piece of evidence, as a ratio of the mean coverage in the BAM. The default value
      is overlap-count / mean coverage ~ 15 / 42.9 ~ 0.350 Default value: 0.35001616141289293.'
  - id: min_evidence_mapq
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --min-evidence-mapq
    doc: 'The minimum mapping quality for reads used to gather evidence of breakpoints.
      Default value: 20.'
  - id: min_evidence_match_length
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --min-evidence-match-length
    doc: 'The minimum length of the matched portion of an interesting alignment. Reads
      that don''t match at least this many reference bases won''t be used in gathering
      evidence. Default value: 45.'
  - id: min_kmers_per_interval
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --min-kmers-per-interval
    doc: 'Minimum number of localizing kmers in a valid interval. Default value: 5.'
  - id: qname_intervals_for_assembly
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --qname-intervals-for-assembly
    doc: file for mapped qname intervals output
  - id: qname_intervals_mapped
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --qname-intervals-mapped
    doc: file for mapped qname intervals output
  - id: read_metadata
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --read-metadata
    doc: output file for read metadata
  - id: reference
    type:
      - 'null'
      - File
    inputBinding:
      position: 101
      prefix: --reference
    doc: Reference sequence
    secondaryFiles:
      - pattern: .fai
        required: false
      - pattern: ^.dict
        required: false
      - pattern: .gzi
        required: false
      - pattern: ^^.dict
        required: false
  - id: run_without_gaps_annotation
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --run-without-gaps-annotation
    doc: 'Allow evidence filter to run without gaps annotation (assume no gaps). Default
      value: false. Possible values: {true, false}'
  - id: run_without_umap_s100_annotation
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --run-without-umap-s100-annotation
    doc: 'Allow evidence filter to run without annotation for single-read mappability
      of 100-mers (assume all mappable). Default value: false. Possible values: {true,
      false}'
  - id: sv_evidence_filter_model_file
    type:
      - 'null'
      - File
    inputBinding:
      position: 101
      prefix: --sv-evidence-filter-model-file
    doc: Path to xgboost classifier model file for evidence filtering
  - id: sv_evidence_filter_threshold_probability
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --sv-evidence-filter-threshold-probability
    doc: 'Minimum classified probability for a piece of evidence to pass xgboost evidence
      filter Default value: 0.92.'
  - id: sv_genome_gaps_file
    type:
      - 'null'
      - File
    inputBinding:
      position: 101
      prefix: --sv-genome-gaps-file
    doc: Path to file enumerating gaps in the reference genome, used by classifier
      to score evidence for filtering. To use classifier without specifying gaps file,
      pass the flag --run-without-gaps-annotation
  - id: sv_genome_umap_s100_file
    type:
      - 'null'
      - File
    inputBinding:
      position: 101
      prefix: --sv-genome-umap-s100-file
    doc: Path to single read 100-mer mappability file in the reference genome, used
      by classifier to score evidence for filtering. To use classifier without specifying
      mappability file, pass the flag --run-without-umap-s100-annotation
  - id: target_link_file
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --target-link-file
    doc: output file for non-assembled breakpoints in bedpe format
  - id: unfiltered_breakpoint_evidence_dir
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --unfiltered-breakpoint-evidence-dir
    doc: directory for evidence output
  - id: write_gfas
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --write-gfas
    doc: 'Write GFA representation of assemblies in fastq-dir. Default value: false.
      Possible values: {true, false}'
  - id: expand_assembly_graph
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --expand-assembly-graph
      valueFrom: '$(self ? ''true'' : ''false'')'
    doc: 'Traverse assembly graph and produce contigs for all paths. Default value:
      true. Possible values: {true, false}'
  - id: pop_variant_bubbles
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --pop-variant-bubbles
    doc: 'Aggressively simplify local assemblies, ignoring small variants. Default
      value: false. Possible values: {true, false}'
  - id: remove_shadowed_contigs
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --remove-shadowed-contigs
      valueFrom: '$(self ? ''true'' : ''false'')'
    doc: 'Simplify local assemblies by removing contigs shadowed by similar contigs.
      Default value: true. Possible values: {true, false}'
  - id: z_dropoff
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --z-dropoff
    doc: 'ZDropoff (see Bwa mem manual) for contig alignment. Default value: 20.'
outputs:
  - id: output_output
    type: File
    doc: sam file for aligned contigs
    outputBinding:
      glob: $(inputs.output)
  - id: breakpoint_evidence_dir_out
    type:
      - 'null'
      - Directory
    doc: directory for evidence output
    outputBinding:
      glob: $(inputs.breakpoint_evidence_dir)
  - id: breakpoint_intervals_out
    type:
      - 'null'
      - File
    doc: file for breakpoint intervals output
    outputBinding:
      glob: $(inputs.breakpoint_intervals)
  - id: fastq_dir_out
    type:
      - 'null'
      - Directory
    doc: output dir for assembled fastqs
    outputBinding:
      glob: $(inputs.fastq_dir)
  - id: high_coverage_intervals_out
    type:
      - 'null'
      - File
    doc: file for high-coverage intervals output
    outputBinding:
      glob: $(inputs.high_coverage_intervals)
  - id: kmer_intervals_out
    type:
      - 'null'
      - File
    doc: file for kmer intervals output
    outputBinding:
      glob: $(inputs.kmer_intervals)
  - id: qname_intervals_for_assembly_out
    type:
      - 'null'
      - File
    doc: file for mapped qname intervals output
    outputBinding:
      glob: $(inputs.qname_intervals_for_assembly)
  - id: qname_intervals_mapped_out
    type:
      - 'null'
      - File
    doc: file for mapped qname intervals output
    outputBinding:
      glob: $(inputs.qname_intervals_mapped)
  - id: read_metadata_out
    type:
      - 'null'
      - File
    doc: output file for read metadata
    outputBinding:
      glob: $(inputs.read_metadata)
  - id: target_link_file_out
    type:
      - 'null'
      - File
    doc: output file for non-assembled breakpoints in bedpe format
    outputBinding:
      glob: $(inputs.target_link_file)
  - id: unfiltered_breakpoint_evidence_dir_out
    type:
      - 'null'
      - Directory
    doc: directory for evidence output
    outputBinding:
      glob: $(inputs.unfiltered_breakpoint_evidence_dir)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://gatk.broadinstitute.org/
$namespaces:
  s: https://schema.org/
