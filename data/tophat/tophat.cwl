cwlVersion: v1.2
class: CommandLineTool
baseCommand: tophat
label: tophat
doc: "TopHat maps short sequences from spliced transcripts to whole genomes.\n\nTool
  homepage: http://ccb.jhu.edu/software/tophat"
inputs:
  - id: bowtie_index
    type: string
    doc: Bowtie index name/path
    inputBinding:
      position: 1
  - id: reads1
    type:
      type: array
      items: string
    doc: Comma-separated list of files containing reads
    inputBinding:
      position: 2
  - id: reads2
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma-separated list of files containing mate pairs
    inputBinding:
      position: 3
  - id: quals1
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma-separated list of quality values for reads1
    inputBinding:
      position: 4
  - id: quals2
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma-separated list of quality values for reads2
    inputBinding:
      position: 5
  - id: bowtie1
    type:
      - 'null'
      - boolean
    doc: Use bowtie1 instead of bowtie2
    inputBinding:
      position: 106
      prefix: --bowtie1
  - id: color
    type:
      - 'null'
      - boolean
    doc: Solid - color space
    inputBinding:
      position: 106
      prefix: --color
  - id: fusion_search
    type:
      - 'null'
      - boolean
    doc: Enable fusion search
    inputBinding:
      position: 106
      prefix: --fusion-search
  - id: gtf
    type:
      - 'null'
      - File
    doc: GTF/GFF with known transcripts
    inputBinding:
      position: 106
      prefix: --GTF
  - id: library_type
    type:
      - 'null'
      - string
    doc: Library type (fr-unstranded, fr-firststrand, fr-secondstrand)
    inputBinding:
      position: 106
      prefix: --library-type
  - id: mate_inner_dist
    type:
      - 'null'
      - int
    doc: The expected (mean) inner distance between mate pairs
    default: 50
    inputBinding:
      position: 106
      prefix: --mate-inner-dist
  - id: max_deletion_length
    type:
      - 'null'
      - int
    doc: The maximum deletion length
    default: 3
    inputBinding:
      position: 106
      prefix: --max-deletion-length
  - id: max_insertion_length
    type:
      - 'null'
      - int
    doc: The maximum insertion length
    default: 3
    inputBinding:
      position: 106
      prefix: --max-insertion-length
  - id: max_intron_length
    type:
      - 'null'
      - int
    doc: The maximum intron length
    default: 500000
    inputBinding:
      position: 106
      prefix: --max-intron-length
  - id: max_multihits
    type:
      - 'null'
      - int
    doc: Instructs TopHat to allow up to this many alignments to the reference 
      for a given read
    default: 20
    inputBinding:
      position: 106
      prefix: --max-multihits
  - id: min_anchor
    type:
      - 'null'
      - int
    doc: TopHat will report junctions spanned by reads with at least this many 
      bases on each side of the junction
    default: 8
    inputBinding:
      position: 106
      prefix: --min-anchor
  - id: min_intron_length
    type:
      - 'null'
      - int
    doc: The minimum intron length
    default: 50
    inputBinding:
      position: 106
      prefix: --min-intron-length
  - id: no_convert_bam
    type:
      - 'null'
      - boolean
    doc: Do not output bam format. Output is <output_dir>/accepted_hits.sam
    inputBinding:
      position: 106
      prefix: --no-convert-bam
  - id: no_novel_juncs
    type:
      - 'null'
      - boolean
    doc: Only look for junctions indicated in the supplied GTF file
    inputBinding:
      position: 106
      prefix: --no-novel-juncs
  - id: no_sort_bam
    type:
      - 'null'
      - boolean
    doc: Output BAM is not coordinate-sorted
    inputBinding:
      position: 106
      prefix: --no-sort-bam
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 1
    inputBinding:
      position: 106
      prefix: --num-threads
  - id: phred64_quals
    type:
      - 'null'
      - boolean
    doc: Use Phred64 scale for quality scores
    inputBinding:
      position: 106
      prefix: --phred64-quals
  - id: prefilter_multihits
    type:
      - 'null'
      - boolean
    doc: For -G/--GTF option, enable an initial bowtie search against the genome
    inputBinding:
      position: 106
      prefix: --prefilter-multihits
  - id: quals
    type:
      - 'null'
      - boolean
    doc: Quality values are provided in separate files
    inputBinding:
      position: 106
      prefix: --quals
  - id: raw_juncs
    type:
      - 'null'
      - File
    doc: Provide raw junctions file
    inputBinding:
      position: 106
      prefix: --raw-juncs
  - id: read_edit_dist
    type:
      - 'null'
      - int
    doc: Final read alignments having more than these many edit distance are 
      discarded
    default: 2
    inputBinding:
      position: 106
      prefix: --read-edit-dist
  - id: read_gap_length
    type:
      - 'null'
      - int
    doc: Final read alignments having more than these many total length of gaps 
      are discarded
    default: 2
    inputBinding:
      position: 106
      prefix: --read-gap-length
  - id: read_mismatches
    type:
      - 'null'
      - int
    doc: Final read alignments having more than these many mismatches are 
      discarded
    default: 2
    inputBinding:
      position: 106
      prefix: --read-mismatches
  - id: resume
    type:
      - 'null'
      - Directory
    doc: Try to resume execution from a previous run
    inputBinding:
      position: 106
      prefix: --resume
  - id: rg_id
    type:
      - 'null'
      - string
    doc: Read group ID
    inputBinding:
      position: 106
      prefix: --rg-id
  - id: rg_sample
    type:
      - 'null'
      - string
    doc: Sample ID
    inputBinding:
      position: 106
      prefix: --rg-sample
  - id: solexa_quals
    type:
      - 'null'
      - boolean
    doc: Use Solexa scale for quality scores
    inputBinding:
      position: 106
      prefix: --solexa-quals
  - id: splice_mismatches
    type:
      - 'null'
      - int
    doc: The maximum number of mismatches that may appear in the anchor region 
      of a spliced alignment
    default: 0
    inputBinding:
      position: 106
      prefix: --splice-mismatches
  - id: suppress_hits
    type:
      - 'null'
      - boolean
    doc: Suppress hits
    inputBinding:
      position: 106
      prefix: --suppress-hits
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Directory for temporary files
    inputBinding:
      position: 106
      prefix: --tmp-dir
  - id: transcriptome_index
    type:
      - 'null'
      - string
    doc: Transcriptome bowtie index
    inputBinding:
      position: 106
      prefix: --transcriptome-index
  - id: transcriptome_max_hits
    type:
      - 'null'
      - int
    doc: Maximum multihits for transcriptome
    default: 60
    inputBinding:
      position: 106
      prefix: --transcriptome-max-hits
  - id: transcriptome_only
    type:
      - 'null'
      - boolean
    doc: Map only to the transcriptome
    inputBinding:
      position: 106
      prefix: --transcriptome-only
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tophat:2.1.2--h3e6c209_0
