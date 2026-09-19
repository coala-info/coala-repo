cwlVersion: v1.2
class: CommandLineTool
baseCommand: tophat
label: tophat
doc: "TopHat maps short sequences from spliced transcripts to whole genomes.\n\nTool
  homepage: http://ccb.jhu.edu/software/tophat"
inputs:
  - id: bowtie_index
    type: File
    doc: Bowtie2 index. Give any file whose name root is the index base name (e.g.
      the genome FASTA); the six .bt2 files are staged with it.
    secondaryFiles:
      - $(self.nameroot + '.1.bt2')
      - $(self.nameroot + '.2.bt2')
      - $(self.nameroot + '.3.bt2')
      - $(self.nameroot + '.4.bt2')
      - $(self.nameroot + '.rev.1.bt2')
      - $(self.nameroot + '.rev.2.bt2')
    inputBinding:
      position: 101
      valueFrom: $(self.dirname + '/' + self.nameroot)
  - id: reads1
    type:
      type: array
      items: File
    doc: Files containing reads
    inputBinding:
      position: 102
      itemSeparator: ','
  - id: reads2
    type:
      - 'null'
      - type: array
        items: File
    doc: Files containing mate pairs
    inputBinding:
      position: 103
      itemSeparator: ','
  - id: quals1
    type:
      - 'null'
      - type: array
        items: File
    doc: Quality value files for reads1
    inputBinding:
      position: 104
      itemSeparator: ','
  - id: quals2
    type:
      - 'null'
      - type: array
        items: File
    doc: Quality value files for reads2
    inputBinding:
      position: 105
      itemSeparator: ','
  - id: bowtie1
    type:
      - 'null'
      - boolean
    doc: Use bowtie1 instead of bowtie2
    inputBinding:
      position: 10
      prefix: --bowtie1
  - id: color
    type:
      - 'null'
      - boolean
    doc: Solid - color space
    inputBinding:
      position: 10
      prefix: --color
  - id: fusion_search
    type:
      - 'null'
      - boolean
    doc: Enable fusion search
    inputBinding:
      position: 10
      prefix: --fusion-search
  - id: gtf
    type:
      - 'null'
      - File
    doc: GTF/GFF with known transcripts
    inputBinding:
      position: 10
      prefix: --GTF
  - id: library_type
    type:
      - 'null'
      - string
    doc: Library type (fr-unstranded, fr-firststrand, fr-secondstrand)
    inputBinding:
      position: 10
      prefix: --library-type
  - id: mate_inner_dist
    type:
      - 'null'
      - int
    doc: The expected (mean) inner distance between mate pairs
    inputBinding:
      position: 10
      prefix: --mate-inner-dist
  - id: max_deletion_length
    type:
      - 'null'
      - int
    doc: The maximum deletion length
    inputBinding:
      position: 10
      prefix: --max-deletion-length
  - id: max_insertion_length
    type:
      - 'null'
      - int
    doc: The maximum insertion length
    inputBinding:
      position: 10
      prefix: --max-insertion-length
  - id: max_intron_length
    type:
      - 'null'
      - int
    doc: The maximum intron length
    inputBinding:
      position: 10
      prefix: --max-intron-length
  - id: max_multihits
    type:
      - 'null'
      - int
    doc: Instructs TopHat to allow up to this many alignments to the reference 
      for a given read
    inputBinding:
      position: 10
      prefix: --max-multihits
  - id: min_anchor
    type:
      - 'null'
      - int
    doc: TopHat will report junctions spanned by reads with at least this many 
      bases on each side of the junction
    inputBinding:
      position: 10
      prefix: --min-anchor
  - id: min_intron_length
    type:
      - 'null'
      - int
    doc: The minimum intron length
    inputBinding:
      position: 10
      prefix: --min-intron-length
  - id: no_convert_bam
    type:
      - 'null'
      - boolean
    doc: Do not output bam format. Output is <output_dir>/accepted_hits.sam
    inputBinding:
      position: 10
      prefix: --no-convert-bam
  - id: no_novel_juncs
    type:
      - 'null'
      - boolean
    doc: Only look for junctions indicated in the supplied GTF file
    inputBinding:
      position: 10
      prefix: --no-novel-juncs
  - id: no_sort_bam
    type:
      - 'null'
      - boolean
    doc: Output BAM is not coordinate-sorted
    inputBinding:
      position: 10
      prefix: --no-sort-bam
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 10
      prefix: --num-threads
  - id: phred64_quals
    type:
      - 'null'
      - boolean
    doc: Use Phred64 scale for quality scores
    inputBinding:
      position: 10
      prefix: --phred64-quals
  - id: prefilter_multihits
    type:
      - 'null'
      - boolean
    doc: For -G/--GTF option, enable an initial bowtie search against the genome
    inputBinding:
      position: 10
      prefix: --prefilter-multihits
  - id: quals
    type:
      - 'null'
      - boolean
    doc: Quality values are provided in separate files
    inputBinding:
      position: 10
      prefix: --quals
  - id: raw_juncs
    type:
      - 'null'
      - File
    doc: Provide raw junctions file
    inputBinding:
      position: 10
      prefix: --raw-juncs
  - id: read_edit_dist
    type:
      - 'null'
      - int
    doc: Final read alignments having more than these many edit distance are 
      discarded
    inputBinding:
      position: 10
      prefix: --read-edit-dist
  - id: read_gap_length
    type:
      - 'null'
      - int
    doc: Final read alignments having more than these many total length of gaps 
      are discarded
    inputBinding:
      position: 10
      prefix: --read-gap-length
  - id: read_mismatches
    type:
      - 'null'
      - int
    doc: Final read alignments having more than these many mismatches are 
      discarded
    inputBinding:
      position: 10
      prefix: --read-mismatches
  - id: resume
    type:
      - 'null'
      - Directory
    doc: Try to resume execution from a previous run
    inputBinding:
      position: 10
      prefix: --resume
  - id: rg_id
    type:
      - 'null'
      - string
    doc: Read group ID
    inputBinding:
      position: 10
      prefix: --rg-id
  - id: rg_sample
    type:
      - 'null'
      - string
    doc: Sample ID
    inputBinding:
      position: 10
      prefix: --rg-sample
  - id: solexa_quals
    type:
      - 'null'
      - boolean
    doc: Use Solexa scale for quality scores
    inputBinding:
      position: 10
      prefix: --solexa-quals
  - id: splice_mismatches
    type:
      - 'null'
      - int
    doc: The maximum number of mismatches that may appear in the anchor region 
      of a spliced alignment
    inputBinding:
      position: 10
      prefix: --splice-mismatches
  - id: suppress_hits
    type:
      - 'null'
      - boolean
    doc: Suppress hits
    inputBinding:
      position: 10
      prefix: --suppress-hits
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: Name of the directory tophat uses for temporary files (a plain name, not a
      host path).
    inputBinding:
      position: 10
      prefix: --tmp-dir
  - id: transcriptome_index
    type:
      - 'null'
      - string
    doc: Transcriptome bowtie index
    inputBinding:
      position: 10
      prefix: --transcriptome-index
  - id: transcriptome_max_hits
    type:
      - 'null'
      - int
    doc: Maximum multihits for transcriptome
    inputBinding:
      position: 10
      prefix: --transcriptome-max-hits
  - id: transcriptome_only
    type:
      - 'null'
      - boolean
    doc: Map only to the transcriptome
    inputBinding:
      position: 10
      prefix: --transcriptome-only
  - id: output_dir_path
    type: string
    default: tophat_out
    doc: Name of the output directory tophat creates (a plain name, not a host path).
    inputBinding:
      position: 11
      prefix: --output-dir
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_dir_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tophat:2.1.1--py27_3
