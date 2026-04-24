cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnaseqc
label: rna-seqc_rnaseqc
doc: "RNASeQC 2.4.2\n\nTool homepage: https://github.com/broadinstitute/rnaseqc"
inputs:
  - id: gtf_file
    type: File
    doc: The input GTF file containing features to check the bam against
    inputBinding:
      position: 1
  - id: bam_file
    type: File
    doc: The input SAM/BAM file containing reads to process
    inputBinding:
      position: 2
  - id: output_directory
    type: Directory
    doc: Output directory
    inputBinding:
      position: 3
  - id: base_mismatch
    type:
      - 'null'
      - int
    doc: 'Set the maximum number of allowed mismatches between a read and the reference
      sequence. Reads with more than this number of mismatches are excluded from coverage
      metrics. Default: 6'
    inputBinding:
      position: 104
      prefix: --base-mismatch
  - id: bed_file
    type:
      - 'null'
      - File
    doc: Optional input BED file containing non-overlapping exons used for 
      fragment size calculations
    inputBinding:
      position: 104
      prefix: --bed
  - id: chimeric_distance
    type:
      - 'null'
      - int
    doc: 'Set the maximum accepted distance between read mates. Mates beyond this
      distance will be counted as chimeric pairs. Default: 2000000 [bp]'
    inputBinding:
      position: 104
      prefix: --chimeric-distance
  - id: chimeric_tag
    type:
      - 'null'
      - string
    doc: Reads maked with the specified tag will be labeled as Chimeric. 
      Defaults to 'mC' for STAR
    inputBinding:
      position: 104
      prefix: --chimeric-tag
  - id: coverage_mask
    type:
      - 'null'
      - int
    doc: 'Sets how many bases at both ends of a transcript are masked out when computing
      per-base exon coverage. Default: 500bp'
    inputBinding:
      position: 104
      prefix: --coverage-mask
  - id: detection_threshold
    type:
      - 'null'
      - int
    doc: "Number of counts on a gene to consider the gene 'detected'. Additionally,
      genes below this limit are excluded from 3' bias computation. Default: 5 reads"
    inputBinding:
      position: 104
      prefix: --detection-threshold
  - id: exclude_chimeric
    type:
      - 'null'
      - boolean
    doc: Exclude chimeric reads from the read counts
    inputBinding:
      position: 104
      prefix: --exclude-chimeric
  - id: fasta_file
    type:
      - 'null'
      - File
    doc: Optional input FASTA/FASTQ file containing the reference sequence used 
      for parsing CRAM files
    inputBinding:
      position: 104
      prefix: --fasta
  - id: filter_tag
    type:
      - 'null'
      - type: array
        items: string
    doc: Filter out reads with the specified tag.
    inputBinding:
      position: 104
      prefix: --tag
  - id: fragment_samples
    type:
      - 'null'
      - int
    doc: 'Set the number of samples to take when computing fragment sizes. Requires
      the --bed argument. Default: 1000000'
    inputBinding:
      position: 104
      prefix: --fragment-samples
  - id: gene_length
    type:
      - 'null'
      - int
    doc: 'Set the minimum size of a gene for bias calculation. Genes below this size
      are ignored in the calculation. Default: 600 [bp]'
    inputBinding:
      position: 104
      prefix: --gene-length
  - id: legacy
    type:
      - 'null'
      - boolean
    doc: Use legacy counting rules. Gene and exon counts match output of 
      RNA-SeQC 1.1.9
    inputBinding:
      position: 104
      prefix: --legacy
  - id: mapping_quality
    type:
      - 'null'
      - int
    doc: 'Set the lower bound on read quality for exon coverage counting. Reads below
      this number are excluded from coverage metrics. Default: 255'
    inputBinding:
      position: 104
      prefix: --mapping-quality
  - id: offset
    type:
      - 'null'
      - int
    doc: "Set the offset into the gene for the 3' and 5' windows in bias calculation.
      A positive value shifts the 3' and 5' windows towards eachother, while a negative
      value shifts them apart. Default: 150 [bp]"
    inputBinding:
      position: 104
      prefix: --offset
  - id: output_coverage
    type:
      - 'null'
      - boolean
    doc: If this flag is provided, coverage statistics for each transcript will 
      be written to a table. Otherwise, only summary coverage statistics are 
      generated and added to the metrics table
    inputBinding:
      position: 104
      prefix: --coverage
  - id: output_rpkm
    type:
      - 'null'
      - boolean
    doc: Output gene RPKM values instead of TPMs
    inputBinding:
      position: 104
      prefix: --rpkm
  - id: sample_name
    type:
      - 'null'
      - string
    doc: "The name of the current sample. Default: The bam's filename"
    inputBinding:
      position: 104
      prefix: --sample
  - id: stranded
    type:
      - 'null'
      - string
    doc: Use strand-specific metrics. Only features on the same strand of a read
      will be considered. Allowed values are 'RF', 'rf', 'FR', and 'fr'
    inputBinding:
      position: 104
      prefix: --stranded
  - id: unpaired
    type:
      - 'null'
      - boolean
    doc: Allow unpaired reads to be quantified. Required for single-end 
      libraries
    inputBinding:
      position: 104
      prefix: --unpaired
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Give some feedback about what's going on. Supply this argument twice 
      for progress updates while parsing the bam
    inputBinding:
      position: 104
      prefix: --verbose
  - id: window_size
    type:
      - 'null'
      - int
    doc: "Set the size of the 3' and 5' windows in bias calculation. Default: 100
      [bp]"
    inputBinding:
      position: 104
      prefix: --window-size
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rna-seqc:2.4.2--h29c0135_1
stdout: rna-seqc_rnaseqc.out
