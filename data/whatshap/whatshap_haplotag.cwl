cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - whatshap
  - haplotag
label: whatshap_haplotag
doc: "Tag reads by haplotype\n\nTool homepage: https://whatshap.readthedocs.io"
inputs:
  - id: vcf
    type: File
    doc: VCF file with phased variants (must be gzip-compressed and indexed)
    inputBinding:
      position: 1
  - id: alignments
    type: File
    doc: BAM/CRAM file with alignments to be tagged by haplotype
    inputBinding:
      position: 2
  - id: ignore_linked_read
    type:
      - 'null'
      - boolean
    doc: Ignore linkage information stored in BX tags of the reads.
    inputBinding:
      position: 103
      prefix: --ignore-linked-read
  - id: ignore_read_groups
    type:
      - 'null'
      - boolean
    doc: Ignore read groups in BAM/CRAM header and assume all reads come from 
      the same sample.
    inputBinding:
      position: 103
      prefix: --ignore-read-groups
  - id: linked_read_distance_cutoff
    type:
      - 'null'
      - int
    doc: 'Assume reads with identical BX tags belong to different read clouds if their
      distance is larger than LINKEDREADDISTANCE (default: 50000).'
    inputBinding:
      position: 103
      prefix: --linked-read-distance-cutoff
  - id: no_reference
    type:
      - 'null'
      - boolean
    doc: Detect alleles without requiring a reference, at the expense of phasing
      quality (in particular for long reads)
    inputBinding:
      position: 103
      prefix: --no-reference
  - id: no_supplementary_strand_match
    type:
      - 'null'
      - boolean
    doc: Allow for strands missmatch between supplementary and primary alignment
      records during the tag copying onto the supplementary.
    inputBinding:
      position: 103
      prefix: --no-supplementary-strand-match
  - id: out_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for output file writing (passed to pysam). For
      optimal performance, instead pipe output into 'samtools view' to compress.
    inputBinding:
      position: 103
      prefix: --out-threads
  - id: output_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for output file writing (passed to pysam). For
      optimal performance, instead pipe output into 'samtools view' to compress.
    inputBinding:
      position: 103
      prefix: --output-threads
  - id: ploidy
    type:
      - 'null'
      - int
    doc: 'Ploidy (default: 2).'
    inputBinding:
      position: 103
      prefix: --ploidy
  - id: reference
    type:
      - 'null'
      - File
    doc: Reference file. Must be accompanied by .fai index (create with samtools
      faidx)
    inputBinding:
      position: 103
      prefix: --reference
  - id: regions
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify region(s) of interest to limit the tagging to reads/variants 
      overlapping those regions. You can specify a space-separated list of 
      regions in the form of chrom:start-end, chrom (consider entire 
      chromosome), or chrom:start (consider region from this start to end of 
      chromosome).
    inputBinding:
      position: 103
      prefix: --regions
  - id: sample
    type:
      - 'null'
      - type: array
        items: string
    doc: Name of a sample to phase. If not given, all samples in the input VCF 
      are phased. Can be used multiple times.
    inputBinding:
      position: 103
      prefix: --sample
  - id: skip_missing_contigs
    type:
      - 'null'
      - boolean
    doc: Skip reads that map to a contig that does not exist in the VCF
    inputBinding:
      position: 103
      prefix: --skip-missing-contigs
  - id: supplementary_distance_threshold
    type:
      - 'null'
      - int
    doc: 'Maximum distance between supplementary alignment record and a primary one
      for the tag copying onto the supplementary to be attempted. (default: 100,000)'
    inputBinding:
      position: 103
      prefix: --supplementary-distance
  - id: tag_supplementary
    type:
      - 'null'
      - string
    doc: 'How to tag supplementary alignments. `skip`: do not tag; `copy-primary`
      or value omitted: tag same as primary; `independent-or-skip`: treat as independent
      alignment; `independent-or-copy-primary`: treat as independent alignment, but
      if fails, tag same as primary. Default: skip'
    inputBinding:
      position: 103
      prefix: --tag-supplementary
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file. If omitted, use standard output.
    outputBinding:
      glob: $(inputs.output)
  - id: output_haplotag_list
    type:
      - 'null'
      - File
    doc: Write assignments of read names to haplotypes (tab separated) to given 
      output file. If filename ends in .gz, then output is gzipped.
    outputBinding:
      glob: $(inputs.output_haplotag_list)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/whatshap:2.8--py39h2de1943_0
