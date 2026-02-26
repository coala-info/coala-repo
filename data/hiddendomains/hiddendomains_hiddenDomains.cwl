cwlVersion: v1.2
class: CommandLineTool
baseCommand: hiddenDomains
label: hiddendomains_hiddenDomains
doc: "Call enriched domains from sequencing data.\n\nTool homepage: http://hiddendomains.sourceforge.net/"
inputs:
  - id: bin_width
    type:
      - 'null'
      - int
    doc: The width of the bin. Default is 1000bp.
    default: 1000
    inputBinding:
      position: 101
      prefix: --b
  - id: chrom_info_file
    type: File
    doc: ChromInfo.txt. If you get an out of bounds error when uploading a bed 
      file to the UCSC genome browser, you can use this option to trim the 
      bounds to the size of the chromosomes. ChromInfo.txt should be a tab 
      delimited file with the chromosome names in the first column and their 
      sizes in the second column.
    inputBinding:
      position: 101
      prefix: --g
  - id: control_reads
    type:
      - 'null'
      - File
    doc: A BED or BAM file that contains aligned read reads. Use the -B option 
      to speicfy BED format. BAM format is the default.
    inputBinding:
      position: 101
      prefix: --c
  - id: control_reads_binned
    type:
      - 'null'
      - File
    doc: If you have already binned your control reads, you can pass them in 
      with this option and they will be used directly.
    inputBinding:
      position: 101
      prefix: --C
  - id: input_is_bed
    type:
      - 'null'
      - boolean
    doc: 'The input file(s) is(are) in BED format (the default is BAM). NOTE: All
      read files have to have to same format (either BED or BAM). Use binReads.pl
      as a stand alone program if you have a more complicated set up.'
    inputBinding:
      position: 101
      prefix: --B
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: The minimum MAPQ score. Default is 30.
    default: 30
    inputBinding:
      position: 101
      prefix: --q
  - id: min_posterior
    type:
      - 'null'
      - float
    doc: 'Toss out parts of domains that have posterior values that are less than
      MIN_POSTERIOR. You can set this to any value you want, but for reference, domainsToBed
      bins according the following scale: >= 0.9, 0.9 > posterior >= 0.8, 0.8 > posterior
      >= 0.7, 0.7 > posterior >= min posterior for significance. The default value
      is 0; everything is merged by default.'
    default: 0
    inputBinding:
      position: 101
      prefix: --p
  - id: output_prefix
    type: string
    doc: 'hiddenDomains generates four or five files with names that start with OutputPrefix.
      1) "_domains.txt": A text file with all of the enriched domains and posterior
      probabilities. 2) "_vis.bed": A BED file for visualization, which contains one
      line per significantly enriched bin - this allows for color coding based on
      the posterior probability. 3) "_analysis.bed": The second BED file is for analysis,
      and this merges all consecutive bins with posterior probabiliites greater than
      MIN_POSTERIOR (as specified with the -p option) or the default value, 0 - which
      merges all consecutive significat bins. 4) "_treatment_bins.txt": A file with
      the read counts per bin. 5) "_control_bins.txt": A file with the read counts
      per bin.'
    inputBinding:
      position: 101
      prefix: --o
  - id: treatment_reads
    type: File
    doc: A BED or BAM file that contains aligned read reads. Use the -B option 
      to speicfy BED format. BAM format is the default.
    inputBinding:
      position: 101
      prefix: --t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hiddendomains:3.1--pl526r36_0
stdout: hiddendomains_hiddenDomains.out
