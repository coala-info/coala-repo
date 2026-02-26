cwlVersion: v1.2
class: CommandLineTool
baseCommand: haploview
label: haploview
doc: "Haploview 4.2 Command line options\n\nTool homepage: https://www.broadinstitute.org/haploview/haploview"
inputs:
  - id: aggressive_num_markers
    type:
      - 'null'
      - int
    doc: Specifies whether to use 2-marker haplotype tags or 2 and 3-marker 
      haplotype tags.
    inputBinding:
      position: 101
      prefix: -aggressiveNumMarkers
  - id: batch_file
    type:
      - 'null'
      - File
    doc: Batch mode. Each line in batch file should contain a genotype file 
      followed by an optional info file, separated by a space.
    inputBinding:
      position: 101
      prefix: -batch
  - id: block_4_gam_cut
    type:
      - 'null'
      - float
    doc: 4 Gamete block cutoff for frequency of 4th pairwise haplotype.
    inputBinding:
      position: 101
      prefix: -block4GamCut
  - id: block_cut_high_ci
    type:
      - 'null'
      - float
    doc: Gabriel 'Strong LD' high confidence interval D' cutoff.
    inputBinding:
      position: 101
      prefix: -blockCutHighCI
  - id: block_cut_low_ci
    type:
      - 'null'
      - float
    doc: Gabriel 'Strong LD' low confidence interval D' cutoff.
    inputBinding:
      position: 101
      prefix: -blockCutLowCI
  - id: block_inform_frac
    type:
      - 'null'
      - float
    doc: Gabriel fraction of informative markers required to be in LD.
    inputBinding:
      position: 101
      prefix: -blockInformFrac
  - id: block_maf_thresh
    type:
      - 'null'
      - float
    doc: Gabriel MAF threshold.
    inputBinding:
      position: 101
      prefix: -blockMAFThresh
  - id: block_output
    type:
      - 'null'
      - string
    doc: Output type. Gabriel, 4 gamete, spine output or all 3. default is 
      Gabriel.
    default: Gabriel
    inputBinding:
      position: 101
      prefix: -blockoutput
  - id: block_rec_high_ci
    type:
      - 'null'
      - float
    doc: Gabriel recombination high confidence interval D' cutoff.
    inputBinding:
      position: 101
      prefix: -blockRecHighCI
  - id: block_spine_dp
    type:
      - 'null'
      - float
    doc: Solid Spine blocks D' cutoff for 'Strong LD
    inputBinding:
      position: 101
      prefix: -blockSpineDP
  - id: blocks_file
    type:
      - 'null'
      - File
    doc: Blocks file (or http:// location), one block per line, will force 
      output for these blocks
    inputBinding:
      position: 101
      prefix: -blocks
  - id: capture_alleles_file
    type:
      - 'null'
      - File
    doc: Capture only the alleles contained in a file (or http:// location) of 
      one marker name per line.
    inputBinding:
      position: 101
      prefix: -captureAlleles
  - id: chromosome
    type:
      - 'null'
      - string
    doc: Specifies the chromosome for this file or download
    inputBinding:
      position: 101
      prefix: -chromosome
  - id: custom_assoc_file
    type:
      - 'null'
      - File
    doc: Loads a set of custom tests for association.
    inputBinding:
      position: 101
      prefix: -customAssoc
  - id: design_scores_file
    type:
      - 'null'
      - File
    doc: Specify design scores in a file (or http:// location) of one marker 
      name and one score per line
    inputBinding:
      position: 101
      prefix: -designScores
  - id: dont_add_tags
    type:
      - 'null'
      - boolean
    doc: Only uses forced in tags.
    inputBinding:
      position: 101
      prefix: -dontaddtags
  - id: end_pos
    type:
      - 'null'
      - int
    doc: Specifies the end position in kb for this HapMap download
    inputBinding:
      position: 101
      prefix: -endpos
  - id: exclude_markers
    type:
      - 'null'
      - string
    doc: 'Specify markers (in range 1-N where N is total number of markers) to be
      skipped for all analyses. Format: 1,2,5..12'
    inputBinding:
      position: 101
      prefix: -excludeMarkers
  - id: exclude_tags
    type:
      - 'null'
      - string
    doc: Excludes a comma separated list of marker names from being used as 
      tags.
    inputBinding:
      position: 101
      prefix: -excludeTags
  - id: exclude_tags_file
    type:
      - 'null'
      - File
    doc: Excludes a file (or http:// location) of one marker name per line from 
      being used as tags.
    inputBinding:
      position: 101
      prefix: -excludeTagsFile
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: Indicates that phased input files use GZIP compression
    inputBinding:
      position: 101
      prefix: -gzip
  - id: hap_thresh
    type:
      - 'null'
      - float
    doc: Only output haps with at least this frequency
    inputBinding:
      position: 101
      prefix: -hapthresh
  - id: hapmap_download
    type:
      - 'null'
      - boolean
    doc: Specify a phased HapMap download
    inputBinding:
      position: 101
      prefix: -hapmapDownload
  - id: hapmap_file
    type:
      - 'null'
      - File
    doc: Specify an input file (or http:// location) in HapMap format
    inputBinding:
      position: 101
      prefix: -hapmap
  - id: haps_file
    type:
      - 'null'
      - File
    doc: Specify an input file (or http:// location) in .haps format
    inputBinding:
      position: 101
      prefix: -haps
  - id: hw_cutoff
    type:
      - 'null'
      - float
    doc: Exclude markers with a HW p-value smaller than <threshold>. <threshold>
      is a value between 0 and 1.
    default: 0.001
    inputBinding:
      position: 101
      prefix: -hwcutoff
  - id: include_tags
    type:
      - 'null'
      - string
    doc: Forces in a comma separated list of marker names as tags.
    inputBinding:
      position: 101
      prefix: -includeTags
  - id: include_tags_file
    type:
      - 'null'
      - File
    doc: Forces in a file (or http:// location) of one marker name per line as 
      tags.
    inputBinding:
      position: 101
      prefix: -includeTagsFile
  - id: info_file
    type:
      - 'null'
      - File
    doc: Specify a marker info file (or http:// location)
    inputBinding:
      position: 101
      prefix: -info
  - id: info_track
    type:
      - 'null'
      - boolean
    doc: Downloads and displays HapMap info track on PNG image output
    inputBinding:
      position: 101
      prefix: -infoTrack
  - id: ld_color_scheme
    type:
      - 'null'
      - string
    doc: 'Specify an LD color scheme. <argument> should be one of: DEFAULT, RSQ, DPALT,
      GAB, GAM'
    inputBinding:
      position: 101
      prefix: -ldcolorscheme
  - id: ld_values
    type:
      - 'null'
      - string
    doc: Specify what to print in LD image output. default is DPrime
    default: DPRIME
    inputBinding:
      position: 101
      prefix: -ldvalues
  - id: log_file
    type:
      - 'null'
      - File
    doc: Specify a logfile name
    default: haploview.log
    inputBinding:
      position: 101
      prefix: -log
  - id: map_file
    type:
      - 'null'
      - File
    doc: Specify a map file or binary map file (or http:// location)
    inputBinding:
      position: 101
      prefix: -map
  - id: max_distance
    type:
      - 'null'
      - int
    doc: Maximum comparison distance in kilobases (integer).
    default: 500
    inputBinding:
      position: 101
      prefix: -maxdistance
  - id: max_mendel
    type:
      - 'null'
      - int
    doc: Markers with more than <integer> Mendel errors will be excluded.
    default: 1
    inputBinding:
      position: 101
      prefix: -maxMendel
  - id: max_num_tags
    type:
      - 'null'
      - int
    doc: Only selects <n> best tags.
    inputBinding:
      position: 101
      prefix: -maxNumTags
  - id: memory
    type:
      - 'null'
      - int
    doc: allocates <memsize> megabytes of memory
    default: 512
    inputBinding:
      position: 101
      prefix: -memory
  - id: min_design_scores
    type:
      - 'null'
      - float
    doc: Specify a minimum design score threshold.
    inputBinding:
      position: 101
      prefix: -mindesignscores
  - id: min_geno
    type:
      - 'null'
      - float
    doc: Exclude markers with less than <threshold> valid data. <threshold> is a
      value between 0 and 1.
    default: 0.75
    inputBinding:
      position: 101
      prefix: -minGeno
  - id: min_maf
    type:
      - 'null'
      - float
    doc: Minimum minor allele frequency to include a marker. <threshold> is a 
      value between 0 and 0.5.
    default: 0.001
    inputBinding:
      position: 101
      prefix: -minMAF
  - id: min_tag_distance
    type:
      - 'null'
      - int
    doc: Specify a Minimum distance in bases between picked tags.
    inputBinding:
      position: 101
      prefix: -mintagdistance
  - id: missing_cutoff
    type:
      - 'null'
      - float
    doc: Exclude individuals with more than <threshold> fraction missing data. 
      <threshold> is a value between 0 and 1.
    default: 0.5
    inputBinding:
      position: 101
      prefix: -missingCutoff
  - id: nogui
    type:
      - 'null'
      - boolean
    doc: Command line output only
    inputBinding:
      position: 101
      prefix: -nogui
  - id: non_snp
    type:
      - 'null'
      - boolean
    doc: Specify that the accompanying PLINK file is non-SNP based output
    inputBinding:
      position: 101
      prefix: -nonSNP
  - id: output_fileroot
    type:
      - 'null'
      - string
    doc: Specify a fileroot to be used for all output files
    inputBinding:
      position: 101
      prefix: -out
  - id: panel
    type:
      - 'null'
      - string
    doc: Specifies the analysis panel for this HapMap download
    inputBinding:
      position: 101
      prefix: -panel
  - id: pedigree_file
    type:
      - 'null'
      - File
    doc: Specify an input file (or http:// location) in pedigree file format
    inputBinding:
      position: 101
      prefix: -pedfile
  - id: phased_hapmap_data_file
    type:
      - 'null'
      - File
    doc: Specify a HapMap PHASE data file (or http:// location)
    inputBinding:
      position: 101
      prefix: -phasedhmpdata
  - id: phased_hapmap_legend_file
    type:
      - 'null'
      - File
    doc: Specify a HapMap PHASE legend file (or http:// location)
    inputBinding:
      position: 101
      prefix: -phasedhmplegend
  - id: phased_hapmap_sample_file
    type:
      - 'null'
      - File
    doc: Specify a HapMap PHASE sample file (or http:// location)
    inputBinding:
      position: 101
      prefix: -phasedhmpsample
  - id: plink_file
    type:
      - 'null'
      - File
    doc: Specify a PLINK or other results file (or http:// location)
    inputBinding:
      position: 101
      prefix: -plink
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet mode- doesnt print any warnings or information to screen
    inputBinding:
      position: 101
      prefix: -quiet
  - id: release
    type:
      - 'null'
      - string
    doc: Specifies the HapMap phase for this HapMap download
    default: '21'
    inputBinding:
      position: 101
      prefix: -release
  - id: select_cols
    type:
      - 'null'
      - boolean
    doc: Activate the preloading column filter for PLINK loads
    inputBinding:
      position: 101
      prefix: -selectCols
  - id: skip_check
    type:
      - 'null'
      - boolean
    doc: Skips the various genotype file checks
    inputBinding:
      position: 101
      prefix: -skipcheck
  - id: spacing
    type:
      - 'null'
      - float
    doc: Proportional spacing of markers in LD display. <threshold> is a value 
      between 0 (no spacing) and 1 (max spacing).
    default: 0
    inputBinding:
      position: 101
      prefix: -spacing
  - id: start_pos
    type:
      - 'null'
      - int
    doc: Specifies the start position in kb for this HapMap download
    inputBinding:
      position: 101
      prefix: -startpos
  - id: tag_lod_cutoff
    type:
      - 'null'
      - float
    doc: Tagger LOD cutoff for creating multimarker tag haplotypes.
    inputBinding:
      position: 101
      prefix: -taglodcutoff
  - id: tag_rsq_cutoff
    type:
      - 'null'
      - float
    doc: Tagger r^2 cutoff.
    inputBinding:
      position: 101
      prefix: -tagrsqcutoff
  - id: track_file
    type:
      - 'null'
      - File
    doc: Specify an input analysis track file (or http:// location)
    inputBinding:
      position: 101
      prefix: -track
outputs:
  - id: dprime
    type:
      - 'null'
      - File
    doc: Outputs LD text to <fileroot>.LD
    outputBinding:
      glob: $(inputs.dprime)
  - id: png
    type:
      - 'null'
      - File
    doc: Outputs LD display to <fileroot>.LD.PNG
    outputBinding:
      glob: $(inputs.png)
  - id: compressed_png
    type:
      - 'null'
      - File
    doc: Outputs compressed LD display to <fileroot>.LD.PNG
    outputBinding:
      glob: $(inputs.compressed_png)
  - id: svg
    type:
      - 'null'
      - File
    doc: Outputs svg format LD display to <fileroot>.LD.SVG
    outputBinding:
      glob: $(inputs.svg)
  - id: check
    type:
      - 'null'
      - File
    doc: Outputs marker checks to <fileroot>.CHECK
    outputBinding:
      glob: $(inputs.check)
  - id: ind_check
    type:
      - 'null'
      - File
    doc: Outputs genotype percent per individual to <fileroot>.INDCHECK
    outputBinding:
      glob: $(inputs.ind_check)
  - id: mendel
    type:
      - 'null'
      - File
    doc: Outputs Mendel error information to <fileroot>.MENDEL
    outputBinding:
      glob: $(inputs.mendel)
  - id: male_hets
    type:
      - 'null'
      - File
    doc: Outputs male heterozygote information to <fileroot>.MALEHETS
    outputBinding:
      glob: $(inputs.male_hets)
  - id: assoc_cc
    type:
      - 'null'
      - File
    doc: Outputs case control association results to <fileroot>.ASSOC and 
      <fileroot>.HAPASSOC
    outputBinding:
      glob: $(inputs.assoc_cc)
  - id: assoc_tdt
    type:
      - 'null'
      - File
    doc: Outputs trio association results to <fileroot>.ASSOC and 
      <fileroot>.HAPASSOC
    outputBinding:
      glob: $(inputs.assoc_tdt)
  - id: perm_tests
    type:
      - 'null'
      - File
    doc: Performs <numtests> permutations on default association tests (or 
      custom tests if a custom association file is specified) and writes to 
      <fileroot>.PERMUT
    outputBinding:
      glob: $(inputs.perm_tests)
  - id: pairwise_tagging
    type:
      - 'null'
      - File
    doc: Generates pairwise tagging information in <fileroot>.TAGS and .TESTS
    outputBinding:
      glob: $(inputs.pairwise_tagging)
  - id: aggressive_tagging
    type:
      - 'null'
      - File
    doc: As above but generates 2-marker haplotype tags unless specified 
      otherwise by -aggressiveNumMarkers
    outputBinding:
      glob: $(inputs.aggressive_tagging)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haploview:4.2--hdfd78af_1
