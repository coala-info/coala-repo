cwlVersion: v1.2
class: CommandLineTool
baseCommand: makeTagDirectory
label: homer_makeTagDirectory
doc: "Create a platform-independent tag directory from alignment files (BED, eland, bowtie, SAM, BAM) for later HOMER analysis\n\nTool homepage: http://homer.ucsd.edu/homer/index.html"
inputs:
  - id: tag_directory_name
    type: string
    doc: 'Name of the tag directory to create'
    inputBinding:
      position: 1
  - id: alignment_files
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Alignment files (BED, SAM, bowtie, eland; gz, bz2, zip accepted; BAM needs samtools in the image). Not needed with -d, -t or -update'
    inputBinding:
      position: 2
  - id: fragLength
    type:
      - 'null'
      - string
    doc: 'estimated fragment length (a number), given (use read lengths) or pe (use the paired-end length); default treats the sample as single read ChIP-Seq'
    inputBinding:
      position: 103
      prefix: '-fragLength'
  - id: format
    type:
      - 'null'
      - string
    doc: 'alignment format: bed, sam, bowtie, eland_result, eland_export, eland_extended, mCpGbed, allC, bismark or HiCsummary (auto-detected if not set)'
    inputBinding:
      position: 103
      prefix: '-format'
  - id: force5th
    type:
      - 'null'
      - boolean
    doc: '5th column of the BED file contains the number of reads mapping to the position'
    inputBinding:
      position: 103
      prefix: '-force5th'
  - id: unique
    type:
      - 'null'
      - boolean
    doc: 'sam: keep a read if there is a single best alignment based on mapq'
    inputBinding:
      position: 103
      prefix: '-unique'
  - id: mapq
    type:
      - 'null'
      - int
    doc: 'sam: minimum mapq for -unique (default: 10, negative values use AS:i:/XS:i:)'
    inputBinding:
      position: 103
      prefix: '-mapq'
  - id: keepOne
    type:
      - 'null'
      - boolean
    doc: 'sam: keep one of the best alignments even if others exist'
    inputBinding:
      position: 103
      prefix: '-keepOne'
  - id: keepAll
    type:
      - 'null'
      - boolean
    doc: 'sam: include all alignments in the SAM file'
    inputBinding:
      position: 103
      prefix: '-keepAll'
  - id: mis
    type:
      - 'null'
      - int
    doc: 'sam: maximum allowed mismatches (default: no limit, uses the MD:Z: tag)'
    inputBinding:
      position: 103
      prefix: '-mis'
  - id: sspe
    type:
      - 'null'
      - boolean
    doc: 'sam: strand specific, paired-end reads (flips the strand of the 2nd read to match)'
    inputBinding:
      position: 103
      prefix: '-sspe'
  - id: read1
    type:
      - 'null'
      - boolean
    doc: 'sam: only analyze the 1st read for paired-end sequencing'
    inputBinding:
      position: 103
      prefix: '-read1'
  - id: read2
    type:
      - 'null'
      - boolean
    doc: 'sam: only analyze the 2nd read for paired-end sequencing'
    inputBinding:
      position: 103
      prefix: '-read2'
  - id: rmsoft
    type:
      - 'null'
      - boolean
    doc: 'sam: clip soft clipped regions from reads (default: assume the read extends/mismatches)'
    inputBinding:
      position: 103
      prefix: '-rmsoft'
  - id: omitSN
    type:
      - 'null'
      - boolean
    doc: 'sam: ignore alignments with splicing/soft clipping, i.e. use for csRNA-seq'
    inputBinding:
      position: 103
      prefix: '-omitSN'
  - id: minCounts
    type:
      - 'null'
      - int
    doc: 'bismark: minimum number of reads to report mC/C ratios (default: 10)'
    inputBinding:
      position: 103
      prefix: '-minCounts'
  - id: mCcontext
    type:
      - 'null'
      - string
    doc: 'bismark: only use C''s in this context: CG, CHG, CHH or all (default: CG)'
    inputBinding:
      position: 103
      prefix: '-mCcontext'
  - id: flip
    type:
      - 'null'
      - boolean
    doc: 'flip the strand of each read, i.e. might want to use with some RNA-seq'
    inputBinding:
      position: 103
      prefix: '-flip'
  - id: totalReads
    type:
      - 'null'
      - string
    doc: 'set the effective total number of reads: a number, all (includes multimappers) or default'
    inputBinding:
      position: 103
      prefix: '-totalReads'
  - id: d
    type:
      - 'null'
      - type: array
        items: Directory
    doc: 'existing tag directories to add to the new tag directory'
    inputBinding:
      position: 103
      prefix: '-d'
  - id: t
    type:
      - 'null'
      - type: array
        items: File
    doc: 'tag files (i.e. *.tags.tsv) to add to the new tag directory'
    inputBinding:
      position: 103
      prefix: '-t'
  - id: single
    type:
      - 'null'
      - boolean
    doc: 'create a single tags.tsv file for all chromosomes (i.e. if there are more than 100 chromosomes)'
    inputBinding:
      position: 103
      prefix: '-single'
  - id: update
    type:
      - 'null'
      - boolean
    doc: 'use the current tag directory for QC/processing, do not parse new alignment files'
    inputBinding:
      position: 103
      prefix: '-update'
  - id: tbp
    type:
      - 'null'
      - int
    doc: 'maximum tags per bp (default: no maximum)'
    inputBinding:
      position: 103
      prefix: '-tbp'
  - id: precision
    type:
      - 'null'
      - int
    doc: 'number of decimal places to use for tag totals: 1, 2 or 3 (default: 1)'
    inputBinding:
      position: 103
      prefix: '-precision'
  - id: minlen
    type:
      - 'null'
      - int
    doc: 'filter out reads shorter than this'
    inputBinding:
      position: 103
      prefix: '-minlen'
  - id: maxlen
    type:
      - 'null'
      - int
    doc: 'filter out reads longer than this'
    inputBinding:
      position: 103
      prefix: '-maxlen'
  - id: genome
    type:
      - 'null'
      - string
      - File
      - Directory
    doc: 'genome version (use list to show available genomes), or a FASTA file or directory of FASTA files for a custom genome'
    inputBinding:
      position: 103
      prefix: '-genome'
  - id: checkGC
    type:
      - 'null'
      - boolean
    doc: 'check sequence bias (requires -genome)'
    inputBinding:
      position: 103
      prefix: '-checkGC'
  - id: freqStart
    type:
      - 'null'
      - int
    doc: 'offset to start calculating frequency (default: -50)'
    inputBinding:
      position: 103
      prefix: '-freqStart'
  - id: freqEnd
    type:
      - 'null'
      - int
    doc: 'distance past the fragment length to calculate frequency (default: 50)'
    inputBinding:
      position: 103
      prefix: '-freqEnd'
  - id: oligoStart
    type:
      - 'null'
      - int
    doc: 'oligo bias start'
    inputBinding:
      position: 103
      prefix: '-oligoStart'
  - id: oligoEnd
    type:
      - 'null'
      - int
    doc: 'oligo bias end'
    inputBinding:
      position: 103
      prefix: '-oligoEnd'
  - id: normGC
    type:
      - 'null'
      - string
      - File
    doc: 'target GC profile file (i.e. tagGCcontent.txt from a control experiment), or default to match the genomic GC distribution'
    inputBinding:
      position: 103
      prefix: '-normGC'
  - id: normFixedOligo
    type:
      - 'null'
      - string
      - File
    doc: 'oligo frequency file to normalize 5'' end bias, or default'
    inputBinding:
      position: 103
      prefix: '-normFixedOligo'
  - id: normLength
    type:
      - 'null'
      - File
    doc: 'target length profile file (i.e. tagLengthDistribution.txt from a control experiment)'
    inputBinding:
      position: 103
      prefix: '-normLength'
  - id: minNormRatio
    type:
      - 'null'
      - float
    doc: 'minimum deflation ratio of tag counts (default: 0.25)'
    inputBinding:
      position: 103
      prefix: '-minNormRatio'
  - id: maxNormRatio
    type:
      - 'null'
      - float
    doc: 'maximum inflation ratio of tag counts (default: 2.0)'
    inputBinding:
      position: 103
      prefix: '-maxNormRatio'
  - id: iterNorm
    type:
      - 'null'
      - float
    doc: 'set -minNormRatio/-maxNormRatio to 0 and 1 and iteratively normalize until the distribution is no more than this fraction different from the target, i.e. 0.1 (default: off)'
    inputBinding:
      position: 103
      prefix: '-iterNorm'
  - id: filterReads
    type:
      - 'null'
      - type: array
        items: string
    doc: 'filter reads based on the oligo sequence in the genome: three values, sequence, offset and keep or remove'
    inputBinding:
      position: 103
      prefix: '-filterReads'
  - id: removePEbg
    type:
      - 'null'
      - boolean
    doc: 'HiC: remove paired end tags within 1.5x fragment length on the same chromosome'
    inputBinding:
      position: 103
      prefix: '-removePEbg'
  - id: PEbgLength
    type:
      - 'null'
      - int
    doc: 'HiC: remove paired end reads facing one another within this distance (default: 1.5x fragment length)'
    inputBinding:
      position: 103
      prefix: '-PEbgLength'
  - id: restrictionSite
    type:
      - 'null'
      - string
    doc: 'HiC: restriction site sequence, i.e. AAGCTT for HindIII; assigns data within 1.5x fragment length to sites (needs a genome)'
    inputBinding:
      position: 103
      prefix: '-restrictionSite'
  - id: rsmis
    type:
      - 'null'
      - int
    doc: 'HiC: mismatches allowed in the restriction site (default: 0)'
    inputBinding:
      position: 103
      prefix: '-rsmis'
  - id: both
    type:
      - 'null'
      - boolean
    doc: 'HiC: keep reads near restriction sites on both ends'
    inputBinding:
      position: 103
      prefix: '-both'
  - id: one
    type:
      - 'null'
      - boolean
    doc: 'HiC: keep reads near a restriction site on one end'
    inputBinding:
      position: 103
      prefix: '-one'
  - id: onlyOne
    type:
      - 'null'
      - boolean
    doc: 'HiC: keep reads near a restriction site on only one end'
    inputBinding:
      position: 103
      prefix: '-onlyOne'
  - id: none
    type:
      - 'null'
      - boolean
    doc: 'HiC: keep reads near no restriction site'
    inputBinding:
      position: 103
      prefix: '-none'
  - id: removeSelfLigation
    type:
      - 'null'
      - boolean
    doc: 'HiC: remove reads linking the same restriction fragment'
    inputBinding:
      position: 103
      prefix: '-removeSelfLigation'
  - id: removeRestrictionEnds
    type:
      - 'null'
      - boolean
    doc: 'HiC: remove reads starting on a restriction fragment'
    inputBinding:
      position: 103
      prefix: '-removeRestrictionEnds'
  - id: assignMidPoint
    type:
      - 'null'
      - boolean
    doc: 'HiC: place reads in the middle of the restriction fragments'
    inputBinding:
      position: 103
      prefix: '-assignMidPoint'
  - id: restrictionSiteLength
    type:
      - 'null'
      - int
    doc: 'HiC: maximum distance from the restriction site (default: 1.5x fragment length)'
    inputBinding:
      position: 103
      prefix: '-restrictionSiteLength'
  - id: removeSpikes
    type:
      - 'null'
      - type: array
        items: int
    doc: 'HiC: remove tags from regions with more than a number of times the average tags per size bp: two values, size in bp and the number (suggested: 10000 8)'
    inputBinding:
      position: 103
      prefix: '-removeSpikes'
  - id: bowtiePE
    type:
      - 'null'
      - boolean
    doc: 'HiC: paired-end alignments in a bowtie alignment file (the last character of the read name is 0 or 1)'
    inputBinding:
      position: 103
      prefix: '-bowtiePE'
outputs:
  - id: tag_directory
    type: Directory
    doc: 'The new tag directory (tagInfo.txt, tag files, QC tables)'
    outputBinding:
      glob: $(inputs.tag_directory_name)
  - id: log
    type: stdout
    doc: 'Program messages written to standard output'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/homer:5.1--pl5262h9948957_0
stdout: homer_makeTagDirectory.out
