cwlVersion: v1.2
class: CommandLineTool
baseCommand: svict
label: svict
doc: "Structural Variant in ctDNA Sequencing Data\n\nTool homepage: https://github.com/vpc-ccg/svict"
inputs:
  - id: anchor_length
    type:
      - 'null'
      - int
    doc: Anchor length. Intervals shorter than this value would be discarded in 
      interval chaining procedure for locating contigs
    inputBinding:
      position: 101
      prefix: --anchor
  - id: annotation_gtf
    type:
      - 'null'
      - File
    doc: GTF file. Enables annotation of SV calls and fusion identification.
    inputBinding:
      position: 101
      prefix: --annotation
  - id: assembler_overlap
    type:
      - 'null'
      - int
    doc: The minimum lenth of overlaps between 2 reads in 
      overlap-layout-consensus contig assembly
    inputBinding:
      position: 101
      prefix: --assembler_overlap
  - id: dump_contigs
    type:
      - 'null'
      - boolean
    doc: Dump contigs in fastq format for mapping.
    inputBinding:
      position: 101
      prefix: --dump_contigs
  - id: ignore_indel
    type:
      - 'null'
      - boolean
    doc: Ignore indels in the input BAM/SAM (I and D in cigar) when extracting 
      potential breakpoints.
    inputBinding:
      position: 101
      prefix: --no_indel
  - id: input_file
    type: File
    doc: Input alignment file. This file should be a sorted SAM or BAM file.
    inputBinding:
      position: 101
      prefix: --input
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: k-mer length to index and remap assembled contigs to reference genome
    inputBinding:
      position: 101
      prefix: --kmer
  - id: max_length
    type:
      - 'null'
      - int
    doc: Max SV length
    inputBinding:
      position: 101
      prefix: --max_length
  - id: max_support
    type:
      - 'null'
      - int
    doc: The maximum number of supporting reads required to be considered a SV, 
      could be used to filter out germline calls
    inputBinding:
      position: 101
      prefix: --max_support
  - id: min_length
    type:
      - 'null'
      - int
    doc: Min SV length
    inputBinding:
      position: 101
      prefix: --min_length
  - id: min_soft_clip
    type:
      - 'null'
      - int
    doc: Minimum soft clip length for a read to be considered as unmapped or 
      incorrectly mapped to be extracted for contig assembly
    inputBinding:
      position: 101
      prefix: --min_sc
  - id: min_support
    type:
      - 'null'
      - int
    doc: The minimum number of supporting reads required to be considered a SV
    inputBinding:
      position: 101
      prefix: --min_support
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Prefix of output file
    inputBinding:
      position: 101
      prefix: --output
  - id: print_reads
    type:
      - 'null'
      - boolean
    doc: Print all contigs and associated reads as additional output 
      out.vcf.reads, out is the prefix specified in -o|--output, when activated.
    inputBinding:
      position: 101
      prefix: --print_reads
  - id: print_stats
    type:
      - 'null'
      - boolean
    doc: Print statistics of detected SV calls and fusions to stderr.
    inputBinding:
      position: 101
      prefix: --print_stats
  - id: reference_genome
    type: File
    doc: Reference geneome that the reads are algined to.
    inputBinding:
      position: 101
      prefix: --reference
  - id: resume
    type:
      - 'null'
      - boolean
    doc: Resume at the interval chaining stage with mapped contigs.
    inputBinding:
      position: 101
      prefix: --resume
  - id: sub_optimal
    type:
      - 'null'
      - int
    doc: For a contig, SViCT will report all paths which are not worse than the 
      optimal by c on the DAGs to achieve potentially better sensitivity. See 
      "Interval Chaining for Optimal Mapping" in publication (default 0 - 
      co-optimals only, negative value disables).
    inputBinding:
      position: 101
      prefix: --sub_optimal
  - id: uncertainty
    type:
      - 'null'
      - int
    doc: Uncertainty around the breakpoint position. See "Interval Chaining for 
      Optimal Mapping" in publication
    inputBinding:
      position: 101
      prefix: --uncertainty
  - id: use_heuristic
    type:
      - 'null'
      - boolean
    doc: Use clustering heuristic (good for data with PCR duplicates).
    inputBinding:
      position: 101
      prefix: --heuristic
  - id: window_size
    type:
      - 'null'
      - int
    doc: The size of the sliding window collecting all reads with 
      soft-clip/split positions in it to form the breakpoint specific cluster 
      for contig assembly. Larger window size could assign a read to more 
      clusters for potentially higher sensitivity with the cost of increased 
      running time
    inputBinding:
      position: 101
      prefix: --window_size
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svict:1.0.1--h077b44d_6
stdout: svict.out
