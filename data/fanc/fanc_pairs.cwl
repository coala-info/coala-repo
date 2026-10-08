cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fanc
  - pairs
label: fanc_pairs
doc: "Process and filter read pairs: build a FAN-C Pairs object from two name-sorted SAM/BAM files, a HiC-Pro or 4DN pairs file, and filter it.\n\nTool homepage: https://github.com/vaquerizaslab/fanc"
inputs:
  - id: input
    type:
      type: array
      items: File
    doc: "Two SAM/BAM files (paired-end reads, sorted by read name), a HiC-Pro pairs file, a 4D Nucleome pairs file, or an existing FAN-C Pairs object."
    inputBinding:
      position: 1
  - id: output
    type:
      - 'null'
      - string
    doc: "Output FAN-C Pairs file. Leave empty to filter a single existing Pairs object in place (a writable copy is returned)."
    inputBinding:
      position: 2
  - id: genome
    type:
      - 'null'
      - File
    doc: "Path to region-based file (BED, GFF, ...) containing the non-overlapping regions to be used for Hi-C binning. Typically restriction-enzyme fragments. Alternatively: Path to genome file (FASTA, folder with FASTA, HDF5 file), which will be used in conjunction with the type of restriction enzyme to calculate fragments directly."
    inputBinding:
      position: 20
      prefix: --genome
  - id: restriction_enzyme
    type:
      - 'null'
      - string
    doc: "Name of the restriction enzyme used in the experiment, e.g. HindIII, or MboI. Case-sensitive, only necessary when --genome is provided as FASTA. Restriction names can be any supported by Biopython, which obtains data from REBASE (http://rebase.neb.com/rebase/rebase.html). Separate multiple restriction enzymes with \",\""
    inputBinding:
      position: 20
      prefix: --restriction_enzyme
  - id: filter_unmappable
    type:
      - 'null'
      - boolean
    doc: "Filter read pairs where one or both halves are unmappable. Only applies to SAM/BAM input!"
    inputBinding:
      position: 20
      prefix: --filter-unmappable
  - id: filter_multimapping
    type:
      - 'null'
      - boolean
    doc: "Filter reads that map multiple times. If the other mapping locations have a lower score than the best one, the best read is kept. Only applies to SAM/BAM input!"
    inputBinding:
      position: 20
      prefix: --filter-multimapping
  - id: filter_multimapping_strict
    type:
      - 'null'
      - boolean
    doc: "Strictly filter reads that map multiple times. Only applies to SAM/BAM input!"
    inputBinding:
      position: 20
      prefix: --filter-multimapping-strict
  - id: filter_quality
    type:
      - 'null'
      - float
    doc: "Cutoff for the minimum mapping quality of a read. For numbers larger than 1, will filter on MAPQ. If a number between 0 and 1 is provided, will filter on the AS tag instead of mapping quality (only BWA). The quality cutoff is then interpreted as the fraction of bases that have to be matched for any given read. Only applies to SAM/BAM input! Default: no mapping quality filter."
    inputBinding:
      position: 20
      prefix: --filter-quality
  - id: filter_contaminant
    type:
      - 'null'
      - File
    doc: "Filter contaminating reads from other organism. Path to mapped SAM/BAM file. Will filter out reads with the same name. Only applies to SAM/BAM input! Default: no contaminant filter"
    inputBinding:
      position: 20
      prefix: --filter-contaminant
  - id: filter_inward
    type:
      - 'null'
      - int
    doc: "Minimum distance for inward-facing read pairs. Default: no inward ligation error filter"
    inputBinding:
      position: 20
      prefix: --filter-inward
  - id: filter_outward
    type:
      - 'null'
      - int
    doc: "Minimum distance for outward-facing read pairs. Default: no outward ligation error filter"
    inputBinding:
      position: 20
      prefix: --filter-outward
  - id: filter_ligation_auto
    type:
      - 'null'
      - boolean
    doc: "Auto-guess settings for inward/outward read pair filters. Overrides --filter-outward and --filter- inward if set. This is highly experimental and known to overshoot in some cases. It is generally recommended to specify cutoffs manually."
    inputBinding:
      position: 20
      prefix: --filter-ligation-auto
  - id: filter_re_distance
    type:
      - 'null'
      - int
    doc: "Maximum distance for a read to the nearest restriction site. Default: no RE distance filter"
    inputBinding:
      position: 20
      prefix: --filter-re-distance
  - id: filter_self_ligations
    type:
      - 'null'
      - boolean
    doc: "Remove read pairs representing self-ligated fragments.Default: no self-ligation filter."
    inputBinding:
      position: 20
      prefix: --filter-self-ligations
  - id: filter_pcr_duplicates
    type:
      - 'null'
      - int
    doc: "If specified, filter read pairs for PCR duplicates. Parameter determines distance between alignment starts below which they are considered starting at same position. Sensible values are between 1 and 5. Default: no PCR duplicates filter"
    inputBinding:
      position: 20
      prefix: --filter-pcr-duplicates
  - id: statistics
    type:
      - 'null'
      - string
    doc: "Path for saving filter statistics"
    inputBinding:
      position: 20
      prefix: --statistics
  - id: reset_filters
    type:
      - 'null'
      - boolean
    doc: "Remove all filters from the ReadPairs object."
    inputBinding:
      position: 20
      prefix: --reset-filters
  - id: statistics_plot
    type:
      - 'null'
      - string
    doc: "Path for saving filter statistics plot (PDF)"
    inputBinding:
      position: 20
      prefix: --statistics-plot
  - id: re_dist_plot
    type:
      - 'null'
      - string
    doc: "Plot the distribution of restriction site distances of all read pairs (sum left and right read)."
    inputBinding:
      position: 20
      prefix: --re-dist-plot
  - id: ligation_error_plot
    type:
      - 'null'
      - string
    doc: "Plot the relative orientation of read pairs mapped to the reference genome as a fraction of reads oriented in the same direction. Allows the identification of ligation errors as a function of genomic distance."
    inputBinding:
      position: 20
      prefix: --ligation-error-plot
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use for extracting fragment information. Default: 1"
    inputBinding:
      position: 20
      prefix: --threads
  - id: batch_size
    type:
      - 'null'
      - int
    doc: "Batch size for read pairs to be submitted to individual processes. Default: 1000000"
    inputBinding:
      position: 20
      prefix: --batch-size
  - id: no_check_sorted
    type:
      - 'null'
      - boolean
    doc: "Assume SAM files are sorted and do not check if that is actually the case"
    inputBinding:
      position: 20
      prefix: --no-check-sorted
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: "If the specified output file exists, it will be overwritten without warning."
    inputBinding:
      position: 20
      prefix: --force-overwrite
  - id: bwa
    type:
      - 'null'
      - boolean
    doc: "Use filters appropriate for BWA and not Bowtie2. This will typically be identified automatically from the SAM/BAM header. Set this flag if you are having problems during filtering (typically 0 reads pass the filtering threshold)."
    inputBinding:
      position: 20
      prefix: --bwa
  - id: work_in_tmp
    type:
      - 'null'
      - boolean
    doc: "Work in temporary directory"
    inputBinding:
      position: 20
      prefix: --work-in-tmp
outputs:
  - id: pairs
    type: File
    doc: "FAN-C Pairs object."
    outputBinding:
      glob: "$(inputs.output ? inputs.output : inputs.input[0].basename)"
  - id: statistics_file
    type:
      - 'null'
      - File
    doc: "Filter statistics."
    outputBinding:
      glob: $(inputs.statistics)
  - id: statistics_plot_file
    type:
      - 'null'
      - File
    doc: "Filter statistics plot (PDF)."
    outputBinding:
      glob: $(inputs.statistics_plot)
  - id: re_dist_plot_file
    type:
      - 'null'
      - File
    doc: "Restriction site distance plot."
    outputBinding:
      glob: $(inputs.re_dist_plot)
  - id: ligation_error_plot_file
    type:
      - 'null'
      - File
    doc: "Ligation error plot."
    outputBinding:
      glob: $(inputs.ligation_error_plot)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |-
      ${ if (inputs.output == null) { return [{"entry": inputs.input[0], "writable": true}]; } return []; }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
