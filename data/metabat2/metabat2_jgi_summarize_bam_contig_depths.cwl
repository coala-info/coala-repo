cwlVersion: v1.2
class: CommandLineTool
baseCommand: jgi_summarize_bam_contig_depths
label: metabat2_jgi_summarize_bam_contig_depths
doc: "Summarize BAM contig depths for MetaBAT2 binning.\n\nTool homepage: https://bitbucket.org/berkeleylab/metabat"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: bam_files
    type:
      type: array
      items: File
    doc: "Sorted BAM files of reads mapped to the assembly"
    inputBinding:
      position: 200
  - id: output_depth
    type: string
    doc: "The file to put the contig by bam depth matrix"
    default: depth.txt
    inputBinding:
      position: 1
      prefix: --outputDepth
  - id: checkpoint
    type: 
      - 'null'
      - boolean
    doc: "Write checkpoints for every bam processed"
    inputBinding:
      position: 2
      prefix: --checkpoint
  - id: percent_identity
    type: 
      - 'null'
      - int
    doc: "The minimum end-to-end % identity of qualifying reads. Default: 97"
    inputBinding:
      position: 3
      prefix: --percentIdentity
  - id: paired_contigs
    type: 
      - 'null'
      - string
    doc: "The file to output the sparse matrix of contigs which paired reads span"
    inputBinding:
      position: 4
      prefix: --pairedContigs
  - id: unmapped_fastq
    type: 
      - 'null'
      - string
    doc: "The prefix to output unmapped reads from each bam file suffixed by 'bamfile.bam.fastq.gz'"
    inputBinding:
      position: 5
      prefix: --unmappedFastq
  - id: no_intra_depth_variance
    type: 
      - 'null'
      - boolean
    doc: "Do not include variance from mean depth along the contig"
    inputBinding:
      position: 6
      prefix: --noIntraDepthVariance
  - id: show_depth
    type: 
      - 'null'
      - boolean
    doc: "Output a .depth file per bam for each contig base"
    inputBinding:
      position: 7
      prefix: --showDepth
  - id: min_map_qual
    type: 
      - 'null'
      - int
    doc: "The minimum mapping quality necessary to count the read as mapped. Default: 0"
    inputBinding:
      position: 8
      prefix: --minMapQual
  - id: weight_map_qual
    type: 
      - 'null'
      - float
    doc: "Weight per-base depth based on the MQ of the read (0.0 disables). Default: 0.0"
    inputBinding:
      position: 9
      prefix: --weightMapQual
  - id: include_edge_bases
    type: 
      - 'null'
      - boolean
    doc: "When calculating depth and variance, include the 1-readlength edges"
    inputBinding:
      position: 10
      prefix: --includeEdgeBases
  - id: max_edge_bases
    type: 
      - 'null'
      - int
    doc: "When calculating depth and variance, and not includeEdgeBases, the maximum length. Default: 75"
    inputBinding:
      position: 11
      prefix: --maxEdgeBases
  - id: reference_fasta
    type: 
      - 'null'
      - File
    doc: "The reference file (must be the same fasta that the bams used)"
    inputBinding:
      position: 12
      prefix: --referenceFasta
  - id: output_gc
    type: 
      - 'null'
      - string
    doc: "The file to print the gc coverage histogram (needs referenceFasta)"
    inputBinding:
      position: 13
      prefix: --outputGC
  - id: gc_window
    type: 
      - 'null'
      - int
    doc: "The sliding window size for GC calculations (needs referenceFasta)"
    inputBinding:
      position: 14
      prefix: --gcWindow
  - id: output_read_stats
    type: 
      - 'null'
      - string
    doc: "The file to print the per read statistics (needs referenceFasta)"
    inputBinding:
      position: 15
      prefix: --outputReadStats
  - id: output_kmers
    type: 
      - 'null'
      - string
    doc: "The file to print the perfect kmer counts (needs referenceFasta)"
    inputBinding:
      position: 16
      prefix: --outputKmers
  - id: shred_length
    type: 
      - 'null'
      - int
    doc: "The maximum length of the shreds"
    inputBinding:
      position: 17
      prefix: --shredLength
  - id: shred_depth
    type: 
      - 'null'
      - int
    doc: "The depth to generate overlapping shreds"
    inputBinding:
      position: 18
      prefix: --shredDepth
  - id: min_contig_length
    type: 
      - 'null'
      - int
    doc: "The mimimum length of contig to include for mapping and shredding"
    inputBinding:
      position: 19
      prefix: --minContigLength
  - id: min_contig_depth
    type: 
      - 'null'
      - float
    doc: "The minimum depth along contig at which to break the contig"
    inputBinding:
      position: 20
      prefix: --minContigDepth
outputs:
  - id: depth
    type: File
    doc: "Contig by BAM depth matrix (input for metabat2 --abdFile)"
    outputBinding:
      glob: $(inputs.output_depth)
  - id: paired_contigs_out
    type: ['null', File]
    doc: "Sparse matrix of contigs which paired reads span"
    outputBinding:
      glob: $(inputs.paired_contigs)
  - id: gc_out
    type: ['null', File]
    doc: "GC coverage histogram"
    outputBinding:
      glob: $(inputs.output_gc)
  - id: read_stats_out
    type: ['null', File]
    doc: "Per read statistics"
    outputBinding:
      glob: $(inputs.output_read_stats)
  - id: kmers_out
    type: ['null', File]
    doc: "Perfect kmer counts"
    outputBinding:
      glob: $(inputs.output_kmers)
  - id: unmapped_fastq_out
    type: File[]
    doc: "Unmapped reads written per BAM file"
    outputBinding:
      glob: $(inputs.unmapped_fastq)*
  - id: depth_files
    type: File[]
    doc: "Per-base depth files written by showDepth"
    outputBinding:
      glob: '*.depth'
  - id: log
    type: stderr
    doc: Standard error (progress log)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metabat2:2.18--h6f16272_0
stderr: jgi_summarize_bam_contig_depths.log
