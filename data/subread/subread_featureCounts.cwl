cwlVersion: v1.2
class: CommandLineTool
baseCommand: featureCounts
label: subread_featureCounts
doc: "Assign mapped reads or fragments (paired-end data) to genomic features such as genes and exons, and count them.\n\nTool homepage: http://subread.sourceforge.net/"
inputs:
  - id: annotation
    type: File
    doc: Name of an annotation file. GTF/GFF format by default. See -F option for more format information. Gzipped file is also accepted.
    inputBinding:
      position: 1
      prefix: -a
  - id: output_file
    type: string
    doc: "Name of output file including read counts. A separate file including summary statistics of counting results is also included in the output ('<string>.summary')."
    inputBinding:
      position: 1
      prefix: -o
  - id: alignments
    type:
      type: array
      items: File
    doc: A list of SAM or BAM format files. They can be either name or location sorted.
    inputBinding:
      position: 101
  - id: annotation_format
    type:
      - 'null'
      - string
    doc: "Format of the provided annotation file: GTF (or compatible GFF format) or SAF. GTF by default."
    inputBinding:
      position: 1
      prefix: -F
  - id: feature_type
    type:
      - 'null'
      - string
    doc: "Feature type(s) in a GTF annotation, separated by ',' with no space. 'exon' by default."
    inputBinding:
      position: 1
      prefix: -t
  - id: attribute_type
    type:
      - 'null'
      - string
    doc: "Attribute type in GTF annotation. 'gene_id' by default."
    inputBinding:
      position: 1
      prefix: -g
  - id: extra_attributes
    type:
      - 'null'
      - string
    doc: "Extra attribute types from the provided GTF annotation to include in the counting output, separated by comma."
    inputBinding:
      position: 1
      prefix: --extraAttributes
  - id: chr_alias
    type:
      - 'null'
      - File
    doc: Chromosome name alias file (two-column comma-delimited text) to match chr names in annotation with those in the reads.
    inputBinding:
      position: 1
      prefix: -A
  - id: feature_level
    type:
      - 'null'
      - boolean
    doc: Perform read counting at feature level (e.g. counting reads for exons rather than genes).
    inputBinding:
      position: 1
      prefix: -f
  - id: overlap
    type:
      - 'null'
      - boolean
    doc: Assign reads to all their overlapping meta-features (or features if -f is specified).
    inputBinding:
      position: 1
      prefix: -O
  - id: min_overlap
    type:
      - 'null'
      - int
    doc: Minimum number of overlapping bases in a read that is required for read assignment. 1 by default.
    inputBinding:
      position: 1
      prefix: --minOverlap
  - id: frac_overlap
    type:
      - 'null'
      - float
    doc: "Minimum fraction of overlapping bases in a read that is required for read assignment [0,1]. 0 by default."
    inputBinding:
      position: 1
      prefix: --fracOverlap
  - id: frac_overlap_feature
    type:
      - 'null'
      - float
    doc: "Minimum fraction of overlapping bases in a feature that is required for read assignment [0,1]. 0 by default."
    inputBinding:
      position: 1
      prefix: --fracOverlapFeature
  - id: largest_overlap
    type:
      - 'null'
      - boolean
    doc: Assign reads to a meta-feature/feature that has the largest number of overlapping bases.
    inputBinding:
      position: 1
      prefix: --largestOverlap
  - id: non_overlap
    type:
      - 'null'
      - int
    doc: Maximum number of non-overlapping bases in a read (or a read pair) that is allowed when being assigned to a feature.
    inputBinding:
      position: 1
      prefix: --nonOverlap
  - id: non_overlap_feature
    type:
      - 'null'
      - int
    doc: Maximum number of non-overlapping bases in a feature that is allowed in read assignment.
    inputBinding:
      position: 1
      prefix: --nonOverlapFeature
  - id: read_extension5
    type:
      - 'null'
      - int
    doc: "Reads are extended upstream by this number of bases from their 5' end."
    inputBinding:
      position: 1
      prefix: --readExtension5
  - id: read_extension3
    type:
      - 'null'
      - int
    doc: "Reads are extended upstream by this number of bases from their 3' end."
    inputBinding:
      position: 1
      prefix: --readExtension3
  - id: read2pos
    type:
      - 'null'
      - int
    doc: "Reduce reads to their 5' most base (5) or 3' most base (3) before counting."
    inputBinding:
      position: 1
      prefix: --read2pos
  - id: multi_mapping
    type:
      - 'null'
      - boolean
    doc: Multi-mapping reads will also be counted (NH tag is used to detect them).
    inputBinding:
      position: 1
      prefix: -M
  - id: fraction
    type:
      - 'null'
      - boolean
    doc: Assign fractional counts to features. Must be used together with -M or -O or both.
    inputBinding:
      position: 1
      prefix: --fraction
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: The minimum mapping quality score a read must satisfy in order to be counted. 0 by default.
    inputBinding:
      position: 1
      prefix: -Q
  - id: split_only
    type:
      - 'null'
      - boolean
    doc: "Count split alignments only (CIGAR containing 'N')."
    inputBinding:
      position: 1
      prefix: --splitOnly
  - id: non_split_only
    type:
      - 'null'
      - boolean
    doc: "Count only non-split alignments (CIGAR without 'N')."
    inputBinding:
      position: 1
      prefix: --nonSplitOnly
  - id: primary
    type:
      - 'null'
      - boolean
    doc: Count primary alignments only.
    inputBinding:
      position: 1
      prefix: --primary
  - id: ignore_dup
    type:
      - 'null'
      - boolean
    doc: Ignore duplicate reads in read counting.
    inputBinding:
      position: 1
      prefix: --ignoreDup
  - id: strand
    type:
      - 'null'
      - string
    doc: "Perform strand-specific read counting: 0 (unstranded), 1 (stranded) or 2 (reversely stranded), or comma-separated values per input file. 0 by default."
    inputBinding:
      position: 1
      prefix: -s
  - id: junction_counts
    type:
      - 'null'
      - boolean
    doc: "Count number of reads supporting each exon-exon junction; saved to '<output_file>.jcounts'."
    inputBinding:
      position: 1
      prefix: -J
  - id: genome_fasta
    type:
      - 'null'
      - File
    doc: FASTA-format file with the reference sequences used in read mapping; can be used with -J to improve junction counting.
    inputBinding:
      position: 1
      prefix: -G
  - id: paired_end
    type:
      - 'null'
      - boolean
    doc: Libraries are assumed to contain paired-end reads.
    inputBinding:
      position: 1
      prefix: -p
  - id: count_read_pairs
    type:
      - 'null'
      - boolean
    doc: Count fragments (templates) instead of reads; applicable for paired-end reads.
    inputBinding:
      position: 1
      prefix: --countReadPairs
  - id: both_ends_mapped
    type:
      - 'null'
      - boolean
    doc: Only count read pairs that have both ends aligned.
    inputBinding:
      position: 1
      prefix: -B
  - id: check_fragment_length
    type:
      - 'null'
      - boolean
    doc: Check validity of paired-end distance when counting read pairs (use -d and -D).
    inputBinding:
      position: 1
      prefix: -P
  - id: min_fragment_length
    type:
      - 'null'
      - int
    doc: "Minimum fragment/template length, 50 by default."
    inputBinding:
      position: 1
      prefix: -d
  - id: max_fragment_length
    type:
      - 'null'
      - int
    doc: "Maximum fragment/template length, 600 by default."
    inputBinding:
      position: 1
      prefix: -D
  - id: no_chimeric
    type:
      - 'null'
      - boolean
    doc: Do not count read pairs that have their two ends mapping to different chromosomes or to different strands.
    inputBinding:
      position: 1
      prefix: -C
  - id: donotsort
    type:
      - 'null'
      - boolean
    doc: Do not sort reads in BAM/SAM input; reads of the same pair must be next to each other.
    inputBinding:
      position: 1
      prefix: --donotsort
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of the threads. 1 by default.
    inputBinding:
      position: 1
      prefix: -T
  - id: by_read_group
    type:
      - 'null'
      - boolean
    doc: Assign reads by read group (RG tag required).
    inputBinding:
      position: 1
      prefix: --byReadGroup
  - id: long_reads
    type:
      - 'null'
      - boolean
    doc: Count long reads such as Nanopore and PacBio reads.
    inputBinding:
      position: 1
      prefix: -L
  - id: read_assignment_format
    type:
      - 'null'
      - string
    doc: "Output detailed assignment results for each read or read-pair in one of the formats CORE, SAM or BAM."
    inputBinding:
      position: 1
      prefix: -R
  - id: read_assignment_dir
    type:
      - 'null'
      - string
    doc: "Directory to save the detailed assignment results. If unspecified, the directory where counting results are saved is used."
    inputBinding:
      position: 1
      prefix: --Rpath
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: Directory under which intermediate files are saved (later removed).
    inputBinding:
      position: 1
      prefix: --tmpDir
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Output verbose information for debugging.
    inputBinding:
      position: 1
      prefix: --verbose
outputs:
  - id: counts
    type: File
    doc: Read counts per feature
    outputBinding:
      glob: $(inputs.output_file)
  - id: summary
    type: File
    doc: Summary statistics of counting results
    outputBinding:
      glob: $(inputs.output_file).summary
  - id: junction_counts_out
    type:
      - 'null'
      - File
    doc: Exon-exon junction counts (with -J)
    outputBinding:
      glob: $(inputs.output_file).jcounts
  - id: read_assignments
    type:
      - 'null'
      - type: array
        items: File
    doc: Detailed assignment results for each read (with -R)
    outputBinding:
      glob:
        - '*.featureCounts'
        - '*.featureCounts.bam'
        - '*.featureCounts.sam'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/subread:2.1.1--h577a1d6_0
