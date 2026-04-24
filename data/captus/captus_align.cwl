cwlVersion: v1.2
class: CommandLineTool
baseCommand: captus align
label: captus_align
doc: "Captus-assembly: Align; collect, align, and curate aligned markers\n\nTool homepage:
  https://github.com/edgardomortiz/Captus"
inputs:
  - id: align_method
    type:
      - 'null'
      - string
    doc: "For MAFFT's algorithms see: https://mafft.cbrc.jp/alignment/software/algorithms/algorithms.html
      For MUSCLE's algorithms see: https://drive5.com/muscle5/manual/commands.html"
    inputBinding:
      position: 101
      prefix: --align_method
  - id: captus_extractions_dir
    type: Directory
    doc: Path to the output directory that contains the assemblies and 
      extractions from previous steps of Captus-assembly. This directory is 
      called '02_assemblies' if you did not specify a different name during the 
      'assemble' or 'extract' steps
    inputBinding:
      position: 101
      prefix: --captus_extractions_dir
  - id: clipkit_gaps
    type:
      - 'null'
      - float
    doc: Gappyness threshold per position. Accepted values between 0 and 1. This
      argument is ignored when using the 'kpi' and 'kpic' algorithms or 
      intermediate steps that use 'smart-gap', the higher the value the more 
      columns are preserved
    inputBinding:
      position: 101
      prefix: --clipkit_gaps
  - id: clipkit_method
    type:
      - 'null'
      - string
    doc: ClipKIT's algorithm, see 
      https://jlsteenwyk.com/ClipKIT/advanced/index.html#modes
    inputBinding:
      position: 101
      prefix: --clipkit_method
  - id: clipkit_path
    type:
      - 'null'
      - string
    doc: Path to ClipKIT
    inputBinding:
      position: 101
      prefix: --clipkit_path
  - id: collect_only
    type:
      - 'null'
      - boolean
    doc: Only collect the markers from the extraction folder and exit (skips 
      addition of reference target sequences and subsequent steps)
    inputBinding:
      position: 101
      prefix: --collect_only
  - id: concurrent
    type:
      - 'null'
      - string
    doc: Captus will attempt to execute this many alignments concurrently. CPUs 
      will be divided by this value for each individual process. If set to 
      'auto', Captus will set as many processes as to at least have 2 threads 
      available for each MAFFT or MUSCLE process
    inputBinding:
      position: 101
      prefix: --concurrent
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable debugging mode, parallelization is disabled so errors are logged
      to screen
    inputBinding:
      position: 101
      prefix: --debug
  - id: disable_codon_align
    type:
      - 'null'
      - boolean
    doc: Do not align nucleotide coding sequences based on their protein 
      alignment
    inputBinding:
      position: 101
      prefix: --disable_codon_align
  - id: disable_taper
    type:
      - 'null'
      - boolean
    doc: Disable the TAPER algorithm for masking for erroneous regions in 
      alignments, see https://doi.org/10.1111/2041-210X.13696
    inputBinding:
      position: 101
      prefix: --disable_taper
  - id: ends_only
    type:
      - 'null'
      - boolean
    doc: Trim only the ends of the alignments (do not trim internal gaps)
    inputBinding:
      position: 101
      prefix: --ends_only
  - id: filter_method
    type:
      - 'null'
      - string
    doc: Methods for filtering paralogous sequences
    inputBinding:
      position: 101
      prefix: --filter_method
  - id: formats
    type:
      - 'null'
      - string
    doc: Which alignment format(s) to prepare for each marker category, you can 
      provide a comma-separated list, no spaces
    inputBinding:
      position: 101
      prefix: --formats
  - id: keep_all
    type:
      - 'null'
      - boolean
    doc: Do not delete any intermediate files
    inputBinding:
      position: 101
      prefix: --keep_all
  - id: keep_w_refs
    type:
      - 'null'
      - boolean
    doc: Keep the directories containing the alignments that include target 
      reference sequences. The deletion of these directories is performed after 
      alignments are filtered for paralogs and before trimming. Enable if you 
      plan to repeat the paralog filtering in the future with '--redo_from 
      filtering'
    inputBinding:
      position: 101
      prefix: --keep_w_refs
  - id: mafft_leavegappyregion
    type:
      - 'null'
      - boolean
    doc: Do not align gappy regions, will only be used if a MAFFT algorithm is 
      selected
    inputBinding:
      position: 101
      prefix: --mafft_leavegappyregion
  - id: mafft_path
    type:
      - 'null'
      - string
    doc: Path to MAFFT
    inputBinding:
      position: 101
      prefix: --mafft_path
  - id: mafft_unalignlevel
    type:
      - 'null'
      - float
    doc: Use a value greater than 0 but lower than 1 (recommended 0.8)if the 
      input data is expected to be globally conserved but locally contaminated 
      by unrelated segments. When value is different than 0, the method 
      '--mafft_globalpair' will be used. Consider also enabling 
      '--mafft_leavegappyregion'
    inputBinding:
      position: 101
      prefix: --mafft_unalignlevel
  - id: markers
    type:
      - 'null'
      - string
    doc: Which markers to align, you can provide a comma-separated list, no 
      spaces
    inputBinding:
      position: 101
      prefix: --markers
  - id: max_paralogs
    type:
      - 'null'
      - int
    doc: Maximum number of secondary hits (copies) per sample to import from the
      extraction step. Large numbers of marker copies per sample can increase 
      alignment times. Hits (copies) are ranked from best to worst during the 
      'extract' step. -1 disables the removal of paralogs and aligns them all, 
      which might be useful if you expect very high ploidy levels for example
    inputBinding:
      position: 101
      prefix: --max_paralogs
  - id: min_coverage
    type:
      - 'null'
      - float
    doc: Minimum coverage of sequence as proportion of the mean of sequence 
      lengths in the alignment, ignoring gaps. Accepted values between 0 and 1. 
      After ClipKIT finishes trimming columns, Captus will also remove short 
      sequences below this threshold
    inputBinding:
      position: 101
      prefix: --min_coverage
  - id: min_data_per_column
    type:
      - 'null'
      - int
    doc: Minimum number of non-missing sites per column. When this parameter is 
      > 0, Captus will dynamically calculate a '--clipkit_gaps' threshold per 
      alignment to keep this minimum amount of data per column
    inputBinding:
      position: 101
      prefix: --min_data_per_column
  - id: min_samples
    type:
      - 'null'
      - int
    doc: Minimum number of samples in a marker to proceed with alignment. 
      Markers with fewer samples will be skipped
    inputBinding:
      position: 101
      prefix: --min_samples
  - id: muscle_path
    type:
      - 'null'
      - string
    doc: Path to MUSCLE
    inputBinding:
      position: 101
      prefix: --muscle_path
  - id: outgroup
    type:
      - 'null'
      - string
    doc: Outgroup sample names, separated by commas, no spaces. Since 
      phylogenetic programs usually root the resulting trees at the first taxon 
      in the alignment, Captus will place these samples at the beggining of 
      every alignment in the given order
    inputBinding:
      position: 101
      prefix: --outgroup
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite previous results
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: ram
    type:
      - 'null'
      - string
    doc: "Maximum RAM in GB (e.g.: 4.5) dedicated to Captus, 'auto' uses 99% of available
      RAM"
    inputBinding:
      position: 101
      prefix: --ram
  - id: redo_from
    type:
      - 'null'
      - string
    doc: Repeat analysis from a particular stage
    inputBinding:
      position: 101
      prefix: --redo_from
  - id: show_more
    type:
      - 'null'
      - boolean
    doc: Show individual alignment information during the run. Detailed 
      information is written regardless to the log
    inputBinding:
      position: 101
      prefix: --show_more
  - id: taper_conservative
    type:
      - 'null'
      - boolean
    doc: Enable the more conservative mode of TAPER. Captus uses the aggressive 
      mode by default, see 'correction_multi_aggressive.jl' at 
      https://github.com/chaoszhang/TAPER
    inputBinding:
      position: 101
      prefix: --taper_conservative
  - id: taper_cutoff
    type:
      - 'null'
      - float
    doc: TAPER cutoff threshold, values greater than 1.0 are recommended, the 
      lower the value the more aggressive the correction, 3.0 recommended by 
      TAPER's authors
    inputBinding:
      position: 101
      prefix: --taper_cutoff
  - id: taper_unfiltered
    type:
      - 'null'
      - boolean
    doc: Enable TAPER correction even for alignments than have not been 
      paralog-filtered, TAPER is only able to distinguish error when an 
      unfiltered alignment contains copies of the locus that are not extremely 
      divergent
    inputBinding:
      position: 101
      prefix: --taper_unfiltered
  - id: threads
    type:
      - 'null'
      - string
    doc: Maximum number of CPUs dedicated to Captus, 'auto' uses all available 
      CPUs
    inputBinding:
      position: 101
      prefix: --threads
  - id: timeout
    type:
      - 'null'
      - int
    doc: Maximum allowed time in seconds for a single alignment
    inputBinding:
      position: 101
      prefix: --timeout
  - id: tolerance
    type:
      - 'null'
      - float
    doc: Only applicable to the 'informed' filter. If the selected copy's 
      identity to the most commonly chosen reference target is below this number
      of Standard Deviations from the mean, it will also be removed (the lower 
      the number the stricter the filter). The previous default value of 4.0 
      works well for broad taxonomic scopes, but tends to remove the outgroup in
      family and genus-level studies. -1 disables this filter
    inputBinding:
      position: 101
      prefix: --tolerance
outputs:
  - id: out
    type:
      - 'null'
      - Directory
    doc: Output directory name
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/captus:1.6.3--pyh05cac1d_0
