cwlVersion: v1.2
class: CommandLineTool
baseCommand: prooverlap
label: prooverlap
doc: "ProOvErlap\n\nTool homepage: https://github.com/ngualand/ProOvErlap"
inputs:
  - id: alpha
    type:
      - 'null'
      - float
    doc: Relative Influence of the overlap fraction/distance (with respect to 
      ranking) in weightRanked test, only if --WeightRanking is active, must be 
      between 0 and 1
    inputBinding:
      position: 101
      prefix: --alpha
  - id: ascending_rank_order
    type:
      - 'null'
      - boolean
    doc: Activate the Sort Ascending in RankTest analysis
    inputBinding:
      position: 101
      prefix: --Ascending_RankOrder
  - id: background
    type:
      - 'null'
      - File
    doc: Background bed file (must contain 6 or more columns), should be a 
      superset from wich input bed file is derived
    inputBinding:
      position: 101
      prefix: --background
  - id: bed
    type:
      - 'null'
      - File
    doc: BED file, only to test genomic localization of founded overlap, bed 
      file will be used to test enrichment in different genomic regions, 
      annotation must be stored as 4th column in bed file, i.e name field
    inputBinding:
      position: 101
      prefix: --bed
  - id: exclude_downstream
    type:
      - 'null'
      - boolean
    doc: Exclude downstream region in closest mode, only for stranded files, not
      compatible with exclude_upstream
    inputBinding:
      position: 101
      prefix: --exclude_downstream
  - id: exclude_intervals
    type:
      - 'null'
      - File
    doc: Exclude regions overlapping with regions in the supplied BED file
    inputBinding:
      position: 101
      prefix: --exclude_intervals
  - id: exclude_ov
    type:
      - 'null'
      - boolean
    doc: Exclude overlapping regions between Input and Target file in closest 
      mode
    inputBinding:
      position: 101
      prefix: --exclude_ov
  - id: exclude_upstream
    type:
      - 'null'
      - boolean
    doc: Exclude upstream region in closest mode, only for stranded files, not 
      compatible with exclude_downstream
    inputBinding:
      position: 101
      prefix: --exclude_upstream
  - id: generate_bg
    type:
      - 'null'
      - boolean
    doc: This option activatates the generation of random bed intervals to test 
      enrichment against, use this instead of background. Use only if background
      file cannot be used or is not available
    inputBinding:
      position: 101
      prefix: --generate_bg
  - id: genome
    type:
      - 'null'
      - File
    doc: Genome fasta file used to retrieve sequence features like AT or GC 
      content and length, needed only for length or AT/GC content tests
    inputBinding:
      position: 101
      prefix: --genome
  - id: genomic_localization
    type:
      - 'null'
      - boolean
    doc: Test also the genomic localization and enrichment of founded overlaps, 
      i.e TSS,Promoter,exons,introns,UTRs - Available only in intersect mode. 
      Must provide a GTF file to extract genomic regions (--gtf), alternatively 
      directly provide a bed file (--bed) with custom annotations
    inputBinding:
      position: 101
      prefix: --GenomicLocalization
  - id: gtf
    type:
      - 'null'
      - File
    doc: 'GTF file, only to test genomic localization of founded overlap, gtf file
      will be used to create genomic regions: promoter, tss, exons, intron, 3UTR and
      5UTR'
    inputBinding:
      position: 101
      prefix: --gtf
  - id: input
    type: File
    doc: Input bed file, must contain 6 or more columns, name and score can be 
      placeholder but score is required in --RankTest mode, strand is used only 
      if some strandess test are requested
    inputBinding:
      position: 101
      prefix: --input
  - id: mode
    type: string
    doc: 'Define mode: intersect or closest: intersect count the number of overlapping
      elements while closest test the distance. In closest mode if a feature overlap
      a target the distance is 0, use --exclude_ov to test only for non-overlapping
      regions'
    inputBinding:
      position: 101
      prefix: --mode
  - id: orientation
    type:
      - 'null'
      - string
    doc: 'Name of test(s) to be performed: concordant, discordant, strandless, or
      a combination of them. If multiple tests are required tests names must be comma
      separated, no space allowed'
    inputBinding:
      position: 101
      prefix: --orientation
  - id: ov_fraction
    type:
      - 'null'
      - float
    doc: Minimum overlap required as a fraction from input BED file to consider 
      2 features as overlapping. Default is 1E-9 (i.e. 1bp)
    default: '1E-9'
    inputBinding:
      position: 101
      prefix: --ov_fraction
  - id: randomization
    type:
      - 'null'
      - int
    doc: 'Number of randomization, default: 100'
    default: 100
    inputBinding:
      position: 101
      prefix: --randomization
  - id: rank_test
    type:
      - 'null'
      - boolean
    doc: Activates the Ranking analyis, require BED to contain numerical value 
      in 4th column
    inputBinding:
      position: 101
      prefix: --RankTest
  - id: targets
    type:
      type: array
      items: File
    doc: Target bed file(s) (must contain 6 or more columns) to test enrichement
      against, if multiple files are supplied N independent test against each 
      file are conducted, file names must be comma separated, the name of the 
      file will be use as the name output
    inputBinding:
      position: 101
      prefix: --targets
  - id: test_at_gc
    type:
      - 'null'
      - boolean
    doc: Test AT and GC content
    inputBinding:
      position: 101
      prefix: --test_AT_GC
  - id: test_lengths
    type:
      - 'null'
      - boolean
    doc: Test feature length
    inputBinding:
      position: 101
      prefix: --test_lengths
  - id: thread
    type:
      - 'null'
      - int
    doc: Number of Threads for parallel computation
    inputBinding:
      position: 101
      prefix: --thread
  - id: tmp
    type:
      - 'null'
      - Directory
    doc: Temporary directory for storing intermediate files. Default is current 
      working directory
    default: current working directory
    inputBinding:
      position: 101
      prefix: --tmp
  - id: w
    type:
      - 'null'
      - float
    doc: Strength of the Weight for the ranking test, only if --WeightRanking is
      active, must be between 0 and 1
    inputBinding:
      position: 101
      prefix: --w
  - id: weight_ranking
    type:
      - 'null'
      - boolean
    doc: Weight the ranking test, this is done by increase or decrease the score
      value in the BED file based on their relative rank and/or distance and/or 
      fractional overlap
    inputBinding:
      position: 101
      prefix: --WeightRanking
outputs:
  - id: outfile
    type: File
    doc: Full path to the output file to store final results in tab format
    outputBinding:
      glob: $(inputs.outfile)
  - id: outdir
    type: Directory
    doc: Full path to output directory to store tables for plot, it is suggested
      to use a different directory for each analysis. It will be created
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prooverlap:0.1.2--pyhdfd78af_0
