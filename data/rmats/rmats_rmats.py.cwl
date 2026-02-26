cwlVersion: v1.2
class: CommandLineTool
baseCommand: rmats.py
label: rmats_rmats.py
doc: "rMATS-turbo\n\nTool homepage: http://rnaseq-mats.sourceforge.net"
inputs:
  - id: allow_clipping
    type:
      - 'null'
      - boolean
    doc: Allow alignments with soft or hard clipping to be used
    inputBinding:
      position: 101
      prefix: --allow-clipping
  - id: anchor_length
    type:
      - 'null'
      - int
    doc: The "anchor length" or "overhang length" used when counting the number 
      of reads spanning splice junctions. A minimum number of "anchor length" 
      nucleotides must be mapped to each end of a given splice junction. The 
      minimum value is 1 and the default value is set to 1 to make use of all 
      possible splice junction reads.
    default: 1
    inputBinding:
      position: 101
      prefix: --anchorLength
  - id: b1
    type:
      - 'null'
      - File
    doc: A text file containing a comma separated list of the BAM files for 
      sample_1. (Only if using BAM)
    inputBinding:
      position: 101
      prefix: --b1
  - id: b2
    type:
      - 'null'
      - File
    doc: A text file containing a comma separated list of the BAM files for 
      sample_2. (Only if using BAM)
    inputBinding:
      position: 101
      prefix: --b2
  - id: bindex
    type:
      - 'null'
      - Directory
    doc: The directory name of the STAR binary indices (name of the directory 
      that contains the suffix array file). (Only if using fastq)
    inputBinding:
      position: 101
      prefix: --bi
  - id: cstat
    type:
      - 'null'
      - float
    doc: 'The cutoff splicing difference. The cutoff used in the null hypothesis test
      for differential alternative splicing. The default is 0.0001 for 0.01% difference.
      Valid: 0 <= cutoff < 1. Does not apply to the paired stats model'
    default: 0.0001
    inputBinding:
      position: 101
      prefix: --cstat
  - id: darts_cutoff
    type:
      - 'null'
      - float
    doc: The cutoff of delta-PSI in the DARTS model. The output posterior 
      probability is P(abs(delta_psi) > cutoff). The default is 0.05
    default: 0.05
    inputBinding:
      position: 101
      prefix: --darts-cutoff
  - id: darts_model
    type:
      - 'null'
      - boolean
    doc: Use the DARTS statistical model
    inputBinding:
      position: 101
      prefix: --darts-model
  - id: fixed_event_set
    type:
      - 'null'
      - Directory
    doc: A directory containing fromGTF.[AS].txt files to be used instead of 
      detecting a new set of events
    inputBinding:
      position: 101
      prefix: --fixed-event-set
  - id: gtf
    type:
      - 'null'
      - File
    doc: An annotation of genes and transcripts in GTF format
    inputBinding:
      position: 101
      prefix: --gtf
  - id: individual_counts
    type:
      - 'null'
      - boolean
    doc: Output individualCounts.[AS_Event].txt files and add the individual 
      count columns to [AS_Event].MATS.JC.txt
    inputBinding:
      position: 101
      prefix: --individual-counts
  - id: lib_type
    type:
      - 'null'
      - string
    doc: Library type. Use fr-firststrand or fr-secondstrand for strand-specific
      data. Only relevant to the prep step, not the post step.
    default: fr-unstranded
    inputBinding:
      position: 101
      prefix: --libType
  - id: mel
    type:
      - 'null'
      - int
    doc: Maximum Exon Length. Only impacts --novelSS behavior.
    default: 500
    inputBinding:
      position: 101
      prefix: --mel
  - id: mil
    type:
      - 'null'
      - int
    doc: Minimum Intron Length. Only impacts --novelSS behavior.
    default: 50
    inputBinding:
      position: 101
      prefix: --mil
  - id: novelss
    type:
      - 'null'
      - boolean
    doc: Enable detection of novel splice sites (unannotated splice sites). 
      Default is no detection of novel splice sites
    default: false
    inputBinding:
      position: 101
      prefix: --novelSS
  - id: nthread
    type:
      - 'null'
      - int
    doc: The number of threads. The optimal number of threads should be equal to
      the number of CPU cores.
    default: 1
    inputBinding:
      position: 101
      prefix: --nthread
  - id: od
    type:
      - 'null'
      - Directory
    doc: The directory for final output from the post step
    inputBinding:
      position: 101
      prefix: --od
  - id: paired_stats
    type:
      - 'null'
      - boolean
    doc: Use the paired stats model
    inputBinding:
      position: 101
      prefix: --paired-stats
  - id: read_length
    type:
      - 'null'
      - int
    doc: The length of each read. Required parameter, with the value set 
      according to the RNA-seq read length
    inputBinding:
      position: 101
      prefix: --readLength
  - id: read_type
    type:
      - 'null'
      - string
    doc: 'Type of read used in the analysis: either "paired" for paired-end data or
      "single" for single-end data.'
    default: paired
    inputBinding:
      position: 101
      prefix: -t
  - id: s1
    type:
      - 'null'
      - File
    doc: A text file containing a comma separated list of the FASTQ files for 
      sample_1. If using paired reads the format is ":" to separate pairs and 
      "," to separate replicates. (Only if using fastq)
    inputBinding:
      position: 101
      prefix: --s1
  - id: s2
    type:
      - 'null'
      - File
    doc: A text file containing a comma separated list of the FASTQ files for 
      sample_2. If using paired reads the format is ":" to separate pairs and 
      "," to separate replicates. (Only if using fastq)
    inputBinding:
      position: 101
      prefix: --s2
  - id: statoff
    type:
      - 'null'
      - boolean
    doc: Skip the statistical analysis
    inputBinding:
      position: 101
      prefix: --statoff
  - id: task
    type:
      - 'null'
      - string
    doc: 'Specify which step(s) of rMATS-turbo to run. Default: both. prep: preprocess
      BAM files and generate .rmats files. post: load .rmats files into memory, detect
      and count alternative splicing events, and calculate P value (if not --statoff).
      both: prep + post. inte (integrity): check that the BAM filenames recorded by
      the prep task(s) match the BAM filenames for the current command line. stat:
      run statistical test on existing output files'
    default: both
    inputBinding:
      position: 101
      prefix: --task
  - id: tmp
    type:
      - 'null'
      - Directory
    doc: The directory for intermediate output such as ".rmats" files from the 
      prep step
    inputBinding:
      position: 101
      prefix: --tmp
  - id: tophat_anchor
    type:
      - 'null'
      - int
    doc: The "anchor length" or "overhang length" used in the aligner. At least 
      "anchor length" nucleotides must be mapped to each end of a given splice 
      junction. The default is 1. (Only if using fastq)
    default: 1
    inputBinding:
      position: 101
      prefix: --tophatAnchor
  - id: tstat
    type:
      - 'null'
      - int
    doc: The number of threads for the statistical model. If not set then the 
      value of --nthread is used
    inputBinding:
      position: 101
      prefix: --tstat
  - id: variable_read_length
    type:
      - 'null'
      - boolean
    doc: Allow reads with lengths that differ from --readLength to be processed.
      --readLength will still be used to determine IncFormLen and SkipFormLen
    inputBinding:
      position: 101
      prefix: --variable-read-length
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rmats:4.3.0--py311hf2f0b74_5
stdout: rmats_rmats.py.out
