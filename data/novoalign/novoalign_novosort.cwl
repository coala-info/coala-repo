cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - novosort
label: novoalign_novosort
doc: "Multi-threaded BAM sort/merge with duplicate marking.\n\nTool homepage:
  http://www.novocraft.com/products/novoalign/"
inputs:
  - id: input_bams
    type:
      type: array
      items: File
    doc: Input BAM file(s) to sort or merge.
    inputBinding:
      position: 100
  - id: output
    type: string
    doc: Name of the sorted output BAM file. Use this option if you want an
      index file created.
    inputBinding:
      position: 1
      prefix: --output
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of processor cores to use.
    inputBinding:
      position: 2
      prefix: --threads
  - id: tmpdir
    type:
      - 'null'
      - string
    doc: Folder to be used for temporary files. Defaults to $TMPDIR if set or /tmp
    inputBinding:
      position: 3
      prefix: --tmpdir
  - id: ram
    type:
      - 'null'
      - string
    doc: Memory to be used for sort buffer, for example 2G. Defaults to 50% of
      RAM on the server.
    inputBinding:
      position: 4
      prefix: --ram
  - id: rg
    type:
      - 'null'
      - string
    doc: An @RG record to add or replace existing @RGs, for example
      "@RG\tID:..."
    inputBinding:
      position: 5
      prefix: --rg
  - id: strand
    type:
      - 'null'
      - boolean
    doc: Use strand as part of sort key.
    inputBinding:
      position: 6
      prefix: --strand
  - id: forcesort
    type:
      - 'null'
      - boolean
    doc: Sort even if @HD indicates reads are already coordinate sorted.
    inputBinding:
      position: 7
      prefix: --forcesort
  - id: assumesorted
    type:
      - 'null'
      - boolean
    doc: Assume input files are already sorted even if @HD does not show
      coordinate sorted.
    inputBinding:
      position: 8
      prefix: --assumesorted
  - id: compression
    type:
      - 'null'
      - int
    doc: Compression level for final BAM in range 0-9.
    inputBinding:
      position: 9
      prefix: --compression
  - id: tmpcompression
    type:
      - 'null'
      - int
    doc: Compression level for temporary BAM in range 0-9. Defaults to 1.
    inputBinding:
      position: 10
      prefix: --tmpcompression
  - id: index
    type:
      - 'null'
      - boolean
    doc: Create a bam index file. Requires use of the output option. Only valid
      for coordinate sort order.
    inputBinding:
      position: 11
      prefix: --index
  - id: namesort
    type:
      - 'null'
      - boolean
    doc: Sort on read name rather than alignment coordinate.
    inputBinding:
      position: 12
      prefix: --namesort
  - id: bufsize
    type:
      - 'null'
      - string
    doc: File buffer size, a multiple of 4096. Default 2Mbytes.
    inputBinding:
      position: 13
      prefix: --bufsize
  - id: bowtiehack
    type:
      - 'null'
      - boolean
    doc: Avoid Mate Not Found error on Bowtie alignments due to incorrect
      setting of strand flags.
    inputBinding:
      position: 14
      prefix: --bowtiehack
  - id: delayflush
    type:
      - 'null'
      - boolean
    doc: Sorted buffers will not be flushed to temporary files until they are
      needed for additional reads.
    inputBinding:
      position: 15
      prefix: --delayflush
  - id: callable_regions
    type:
      - 'null'
      - string
    doc: "Output a BED file of callable regions: fn,min,max,mapq."
    inputBinding:
      position: 16
      prefix: --callableRegions
  - id: remove_duplicates
    type:
      - 'null'
      - boolean
    doc: Remove alignments for duplicate reads.
    inputBinding:
      position: 17
      prefix: --removeDuplicates
  - id: mark_duplicates
    type:
      - 'null'
      - boolean
    doc: Mark alignments for duplicate reads.
    inputBinding:
      position: 18
      prefix: --markDuplicates
  - id: keep_tags
    type:
      - 'null'
      - boolean
    doc: Keep SAM tags added for duplicate detection, Z5 and Zq.
    inputBinding:
      position: 19
      prefix: --keepTags
  - id: pcr_free
    type:
      - 'null'
      - boolean
    doc: All libraries are PCR free. Only checks for optical and same tile duplicates.
    inputBinding:
      position: 20
      prefix: --pcrFree
  - id: optical_only
    type:
      - 'null'
      - boolean
    doc: Only checks for optical duplicates.
    inputBinding:
      position: 21
      prefix: --opticalOnly
  - id: unique_tags
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --uniqueTags
    doc: SAM tags identifying a unique molecule or cell, tag[:options]. Can be
      used more than once.
    inputBinding:
      position: 22
  - id: umi
    type:
      - 'null'
      - boolean
    doc: UMI is part of the Illumina read header.
    inputBinding:
      position: 23
      prefix: --UMI
  - id: consensus
    type:
      - 'null'
      - string
    doc: Enable calling of consensus reads for duplicate groups, with a comma
      separated list of options.
    inputBinding:
      position: 24
      prefix: --consensus
  - id: u15off
    type:
      - 'null'
      - boolean
    doc: Turn off the use of 15bp of unmapped reads in paired read signature.
    inputBinding:
      position: 25
      prefix: --u15off
  - id: exclude_secondaries
    type:
      - 'null'
      - boolean
    doc: Secondary alignments are not subject to duplicate removal.
    inputBinding:
      position: 26
      prefix: --excludeSecondaries
  - id: include_se
    type:
      - 'null'
      - boolean
    doc: Single end reads are also subject to duplicate removal.
    inputBinding:
      position: 27
      prefix: --includeSE
  - id: strand_specific
    type:
      - 'null'
      - boolean
    doc: Paired end duplicate detection is strand specific.
    inputBinding:
      position: 28
      prefix: --strandSpecific
  - id: read_name_regex
    type:
      - 'null'
      - string
    doc: Regular expression for parsing Lane, Tile, X and Y coordinates from a
      read name. Set to Off to disable optical duplicate detection.
    inputBinding:
      position: 29
      prefix: --readNameRegex
  - id: optical_duplicate_distance
    type:
      - 'null'
      - int
    doc: X/Y distance for duplicate reads to be counted as optical duplicates.
      Set to 0 to disable. Default 100.
    inputBinding:
      position: 30
      prefix: --opticalDuplicateDistance
  - id: min_base_quality
    type:
      - 'null'
      - int
    doc: Minimum base quality to be summed for read ranking.
    inputBinding:
      position: 31
      prefix: --minBaseQuality
  - id: stats
    type:
      - 'null'
      - string
    doc: File name for duplicate statistics in tsv format.
    inputBinding:
      position: 32
      prefix: --stats
outputs:
  - id: sorted_bam
    type: File
    doc: Sorted (or merged) BAM file
    secondaryFiles:
      - pattern: .bai
        required: false
    outputBinding:
      glob: $(inputs.output)
  - id: stats_file
    type:
      - 'null'
      - File
    doc: Duplicate statistics
    outputBinding:
      glob: $(inputs.stats)
  - id: stderr
    type: stderr
    doc: Run log written to standard error
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/novoalign:4.03.04--h43eeafb_3
stderr: novoalign_novosort.log
