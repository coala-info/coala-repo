cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fuc
  - vcf-call
label: fuc_vcf-call
doc: "Call SNVs and indels from BAM files.\n\nTool homepage: https://github.com/sbslee/fuc"
inputs:
  - id: fasta
    type: File
    doc: Reference FASTA file.
    inputBinding:
      position: 1
  - id: bams
    type:
      type: array
      items: File
    doc: One or more input BAM files. Alternatively, you can provide a text file
      (.txt, .tsv, .csv, or .list) containing one BAM file per line.
    inputBinding:
      position: 2
  - id: dir_path
    type:
      - 'null'
      - Directory
    doc: By default, intermediate files (likelihoods.bcf, calls.bcf, and 
      calls.normalized.bcf) will be stored in a temporary directory, which is 
      automatically deleted after creating final VCF. If you provide a directory
      path, intermediate files will be stored there.
    inputBinding:
      position: 103
      prefix: --dir-path
  - id: gap_frac
    type:
      - 'null'
      - float
    doc: 'Minimum fraction of gapped reads for calling indels (default: 0.002).'
    default: 0.002
    inputBinding:
      position: 103
      prefix: --gap_frac
  - id: group_samples
    type:
      - 'null'
      - File
    doc: By default, all samples are assumed to come from a single population. 
      This option allows to group samples into populations and apply the HWE 
      assumption within but not across the populations. To use this option, 
      provide a tab-delimited text file with sample names in the first column 
      and group names in the second column. If '--group-samples -' is given 
      instead, no HWE assumption is made at all and single-sample calling is 
      performed. Note that in low coverage data this inflates the rate of false 
      positives. Therefore, make sure you know what you are doing.
    inputBinding:
      position: 103
      prefix: --group-samples
  - id: max_depth
    type:
      - 'null'
      - int
    doc: 'At a position, read maximally this number of reads per input file (default:
      250).'
    default: 250
    inputBinding:
      position: 103
      prefix: --max-depth
  - id: min_mq
    type:
      - 'null'
      - int
    doc: 'Minimum mapping quality for an alignment to be used (default: 1).'
    default: 1
    inputBinding:
      position: 103
      prefix: --min-mq
  - id: regions
    type:
      - 'null'
      - type: array
        items: string
    doc: By default, the command looks at each genomic position with coverage in
      BAM files, which can be excruciatingly slow for large files (e.g. whole 
      genome sequencing). Therefore, use this argument to only call variants in 
      given regions. Each region must have the format chrom:start-end and be a 
      half-open interval with (start, end]. This means, for example, 
      chr1:100-103 will extract positions 101, 102, and 103. Alternatively, you 
      can provide a BED file (compressed or uncompressed) to specify regions. 
      Note that the 'chr' prefix in contig names (e.g. 'chr1' vs. '1') will be 
      automatically added or removed as necessary to match the input BAM's 
      contig names.
    inputBinding:
      position: 103
      prefix: --regions
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
stdout: fuc_vcf-call.out
