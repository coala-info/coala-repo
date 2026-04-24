cwlVersion: v1.2
class: CommandLineTool
baseCommand: riboloco
label: riboloco
doc: "riboloco is a tool for analyzing ribosome profiling data to identify translation
  initiation sites and quantify ribosome occupancy.\n\nTool homepage: https://github.com/Delayed-Gitification/riboloco.git"
inputs:
  - id: allow_out_of_frame
    type:
      - 'null'
      - boolean
    doc: Allow out of frame offsets to be assigned
    inputBinding:
      position: 101
      prefix: --allow_out_of_frame
  - id: ambiguity
    type:
      - 'null'
      - float
    doc: Much much better the best r value must be compared to the second best 
      for an offset to be confidently assigned. Default = 0.8, i.e. the r value 
      of second best offset must be less than 0.8x the value of the best offset.
      Lower values are more stringent. Should be less than 1, and more than 0
    inputBinding:
      position: 101
      prefix: --ambiguity
  - id: conversion_types_list
    type:
      - 'null'
      - type: array
        items: string
    doc: Types to output. Can specify an offset with colon, eg 28_0:-12. Using 
      this command will cause other types to be ignored, unless you also use 
      --keep_all_valid
    inputBinding:
      position: 101
      prefix: --conversion_types_list
  - id: four_column_bed
    type:
      - 'null'
      - boolean
    doc: select if using a four column bed with the strand in the 4th column
    inputBinding:
      position: 101
      prefix: --four_column_bed
  - id: frameness_ratio
    type:
      - 'null'
      - float
    doc: The level of enrichment near the start codon versus downstream for a 
      read type to be reported as potentially having strong bias towards out of 
      frame ribosomes. Default = 1.2 i.e. 20percent
    inputBinding:
      position: 101
      prefix: --frameness_ratio
  - id: generate_reference
    type:
      - 'null'
      - boolean
    doc: Activates reference generation mode - use this mode to make a reference
      before converting bed files to single nucleotide resolution
    inputBinding:
      position: 101
      prefix: --generate_reference
  - id: ignore
    type:
      - 'null'
      - type: array
        items: string
    doc: Read types to ignore. Can add multiple with a colon separator. Eg -ig 
      27_2:23_1.
    inputBinding:
      position: 101
      prefix: --ignore
  - id: info
    type:
      - 'null'
      - File
    doc: Info file on transcripts. This should be a tab separated file with 
      details on the CDS within each transcript. It should contain the columns 
      'transcript_id', 'cds_start' and 'cds_stop'. The coordinates MUST be 
      1-based!
    inputBinding:
      position: 101
      prefix: --info
  - id: keep_all_valid
    type:
      - 'null'
      - boolean
    doc: This option (only applicable during conversion mode) keeps all valid 
      read types (i.e. all those that pass periodicity and abundance filters) 
      even when specific read lengths and offsets are set.
    inputBinding:
      position: 101
      prefix: --keep_all_valid
  - id: keep_read_types_distinct
    type:
      - 'null'
      - boolean
    doc: Write out a single bedgraph, but keep the read types distinct (useful 
      for downstreamanalysis). Default = False
    inputBinding:
      position: 101
      prefix: --keep_read_types_distinct
  - id: kl_length
    type:
      - 'null'
      - int
    doc: The number of codons to use for KL-based determination of offsets. By 
      default = 2 i.e. the P and A sites.
    inputBinding:
      position: 101
      prefix: --kl_length
  - id: max_A_offset
    type:
      - 'null'
      - int
    doc: The maximum offset length from the 3' end of the E site (not the A 
      site). Length is measured in nt. Default = -22
    inputBinding:
      position: 101
      prefix: --max_A_offset
  - id: max_distance
    type:
      - 'null'
      - int
    doc: Maximum distance in nucleotides around start and stop codons for which 
      offsets are attempted to be calculated. Default is 20. Twenty is plenty.
    inputBinding:
      position: 101
      prefix: --max_distance
  - id: max_offset
    type:
      - 'null'
      - int
    doc: The maximum offset which is analysed when plotting. Length is measured 
      in nt. Default = -40
    inputBinding:
      position: 101
      prefix: --max_offset
  - id: min_A_offset
    type:
      - 'null'
      - int
    doc: The miniumum offset length from the 3' end of the E site. (Not the A 
      site) Length is measured in nt. Default = 3
    inputBinding:
      position: 101
      prefix: --min_A_offset
  - id: min_abundance
    type:
      - 'null'
      - float
    doc: Minimum abundance of read length/frame to be included in final output. 
      Default is 0.01. Set to zero to disable. This can me lower than 
      --min_abundance_ref, the rationale being that you want to use abundant 
      read lengths to build the reference, but any read length that matches the 
      reference well should be included in the final file.
    inputBinding:
      position: 101
      prefix: --min_abundance
  - id: min_abundance_ref
    type:
      - 'null'
      - float
    doc: Minimum fraction of total reads that a read type must represent for 
      calculation of a reference offset (using start and stop codon enrichment) 
      to be attempted. Default=0.1 (10pc). Warning - using low values may 
      promote inclusion of reads which are primarily out of frame. Recommended 
      to keep above 0.05. Read fractions are calculated for reads within the 
      annotated CDS - UTRs are ignored.
    inputBinding:
      position: 101
      prefix: --min_abundance_ref
  - id: min_counts_start
    type:
      - 'null'
      - int
    doc: The minimum number of counts of a given read type at the start codon 
      for a read's offset to be confidently assigned. Default=25
    inputBinding:
      position: 101
      prefix: --min_counts_start
  - id: min_counts_stop
    type:
      - 'null'
      - int
    doc: The minimum number of counts of a given read type at the stop codon for
      a read's offset to be confidently assigned. Default=25. To block stop 
      offsets being used, set to large number eg 100000
    inputBinding:
      position: 101
      prefix: --min_counts_stop
  - id: min_offset
    type:
      - 'null'
      - int
    doc: The miniumum which is analysed when plotting Length is measured in nt. 
      Default = 10
    inputBinding:
      position: 101
      prefix: --min_offset
  - id: min_ratio_start
    type:
      - 'null'
      - float
    doc: The minimum ratio of the start codon counts of a given read type versus
      the previous position for an offset based on the start codon to be 
      confidently assigned. Default=4
    inputBinding:
      position: 101
      prefix: --min_ratio_start
  - id: min_ratio_stop
    type:
      - 'null'
      - float
    doc: The minimum ratio of the stop codon counts of a given read type versus 
      the next position for an offset based on the stop codon to be confidently 
      assigned. Default=4
    inputBinding:
      position: 101
      prefix: --min_ratio_stop
  - id: min_score
    type:
      - 'null'
      - float
    doc: The minimum correlation between the reference and the RUST ratios for 
      the assigned offset for the file to be written. Default = 0.7
    inputBinding:
      position: 101
      prefix: --min_score
  - id: mismatches
    type:
      - 'null'
      - boolean
    doc: Whether to consider first nt mismatches. Only available when a bam file
      is provided
    inputBinding:
      position: 101
      prefix: --mismatches
  - id: monosome_priority
    type:
      - 'null'
      - boolean
    doc: During reference generation mode, and if a .csv of sample files is 
      passed to the function, this option ensures that only monosome files, i.e.
      those with 'Mon' in the sample name(!), are used for reference generation.
    inputBinding:
      position: 101
      prefix: --monosome_priority
  - id: no_iterative_improvement
    type:
      - 'null'
      - boolean
    doc: By default, when using RUST ratio correlations to determine offsets, 
      when new matches are found they are added to the reference. This option 
      stops this behaviour
    inputBinding:
      position: 101
      prefix: --no_iterative_improvement
  - id: oof_plot_end
    type:
      - 'null'
      - int
    doc: How far downstream of the annotated start to look for out of frame 
      reads. Default=2000.
    inputBinding:
      position: 101
      prefix: --oof_plot_end
  - id: oof_plot_start
    type:
      - 'null'
      - int
    doc: How far downstream of the annotated start to look for out of frame 
      reads. Default=0. Set to negative values to search for uORFs
    inputBinding:
      position: 101
      prefix: --oof_plot_start
  - id: oof_plot_stride
    type:
      - 'null'
      - int
    doc: How wide each of the windows in the oof heatmap should be in 
      nucleotides. Default=50nt
    inputBinding:
      position: 101
      prefix: --oof_plot_stride
  - id: oof_smooth_window
    type:
      - 'null'
      - int
    doc: Rolling average smoothing for oof heatmap
    inputBinding:
      position: 101
      prefix: --oof_smooth_window
  - id: orf_file
    type:
      - 'null'
      - File
    doc: An orf csv generated with riboloco_find_orfs. Supplying this will 
      activate more intensive searching for out of frame ribosomes.
    inputBinding:
      position: 101
      prefix: --orf_file
  - id: periodicity
    type:
      - 'null'
      - float
    doc: Periodicity filter - the minimum ratio of reads in the major frame to 
      the minor frame for a given read length to pass filtering. Default is 2; 
      higher numbers are more stringent. Set to 1 to remove filtering
    inputBinding:
      position: 101
      prefix: --periodicity
  - id: plot_graphs
    type:
      - 'null'
      - boolean
    doc: When selected, dislocate plots various graphs and heatmaps which may be
      useful for downstream analysis, or to verify accuracy of offset 
      assignments.
    inputBinding:
      position: 101
      prefix: --plot_graphs
  - id: read_type
    type:
      - 'null'
      - type: array
        items: string
    doc: Set the read type for which the reference is calculated in reference 
      generation mode.Additionally, you can specify the offset with a colon, eg 
      28_0:-12.
    inputBinding:
      position: 101
      prefix: --read_type
  - id: reference
    type:
      - 'null'
      - type: array
        items: File
    doc: Pre-computed reference file csv, generated by dislocate in 'generate 
      reference' mode. Multiple references can be specified by adding a colon 
      between files. Optional when running in conversion mode.
    inputBinding:
      position: 101
      prefix: --reference
  - id: reference_use_KL
    type:
      - 'null'
      - boolean
    doc: Use KL divergence to find best offset during reference generation
    inputBinding:
      position: 101
      prefix: --reference_use_KL
  - id: sample_dir
    type:
      - 'null'
      - Directory
    doc: Directory of the input files. This optional argument can be useful when
      passing a csv of filenames to -s in reference generation mode.
    inputBinding:
      position: 101
      prefix: --sample_dir
  - id: samples
    type:
      - 'null'
      - string
    doc: In reference generation mode this may either be a .csv file of samples 
      (you MUST ensure that the file is of '.csv' otherwise it will not be 
      recognised) or a single bed file. In conversion mode it must be a single 
      bed file. Bed files should be transcriptome-aligned; only reads in the + 
      strand are used. Bed files should be 6 column, with transcript_id, start, 
      end, and strand in columns 1, 2, 3 and 6 respectively (the default output 
      from bedtools' 'bamtobed'). Bed files can be in .gzip format if desired.
    inputBinding:
      position: 101
      prefix: --samples
  - id: save_stats
    type:
      - 'null'
      - boolean
    doc: Save a csv of the r values for each type, read and offset.
    inputBinding:
      position: 101
      prefix: --save_stats
  - id: transcript_fasta
    type:
      - 'null'
      - File
    doc: Fasta file of transcripts
    inputBinding:
      position: 101
      prefix: --transcript_fasta
  - id: use_KL
    type:
      - 'null'
      - boolean
    doc: Use KL divergence to determine best A site offset during assignment
    inputBinding:
      position: 101
      prefix: --use_KL
  - id: use_stop
    type:
      - 'null'
      - boolean
    doc: If argument is used, riboloco will attempt to assign offsets based on 
      stop codon as well as the start codon. Riboloco will use this value during
      reference generation if either it is consistent with the start codon 
      determined offset, or if no start codon-based offset could be determined 
      (e.g. with disomes)
    inputBinding:
      position: 101
      prefix: --use_stop
  - id: verbose
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --verbose
  - id: write_full_data
    type:
      - 'null'
      - boolean
    doc: Write out the raw bed/bam file reads with read type and info
    inputBinding:
      position: 101
      prefix: --write_full_data
  - id: write_individual_files
    type:
      - 'null'
      - boolean
    doc: When selected, dislocate also writes individual bedgraph files for each
      read length/frame. This could be useful for downstream analysis.
    inputBinding:
      position: 101
      prefix: --write_individual_files
outputs:
  - id: output
    type: File
    doc: Output file
    outputBinding:
      glob: $(inputs.output)
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: The directory to save outputs.
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/riboloco:0.3.10--pyhdfd78af_0
