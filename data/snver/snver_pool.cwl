cwlVersion: v1.2
class: CommandLineTool
baseCommand: snver-pool
label: snver_pool
doc: "SNVerPool: calls SNVs and indels in pooled sequencing data from a directory
  of BAM files.\n\nTool homepage: http://snver.sourceforge.net/"
inputs:
  - id: input_directory
    type: Directory
    doc: Input directory, which contains a batch of standard bam files (with
      their .bai index files)
    inputBinding:
      position: 101
      prefix: -i
  - id: reference_file
    type: File
    secondaryFiles:
      - .fai
    doc: reference file
    inputBinding:
      position: 101
      prefix: -r
  - id: pool_info_file
    type:
      - 'null'
      - File
    doc: pool info file (preferred)
    inputBinding:
      position: 101
      prefix: -c
  - id: num_haploids
    type:
      - 'null'
      - int
    doc: the number of haploids (required when option "-c" is not given)
    inputBinding:
      position: 101
      prefix: -n
  - id: target_region_bed_file
    type:
      - 'null'
      - File
    doc: target region bed file
    inputBinding:
      position: 101
      prefix: -l
  - id: prefix_output_file
    type:
      - 'null'
      - string
    default: snver_pool_out
    doc: prefix output file
    inputBinding:
      position: 101
      prefix: -o
  - id: mapping_quality_threshold
    type:
      - 'null'
      - int
    doc: mapping quality threshold
    inputBinding:
      position: 101
      prefix: -mq
  - id: base_quality_threshold
    type:
      - 'null'
      - int
    doc: base quality threshold
    inputBinding:
      position: 101
      prefix: -bq
  - id: strand_bias_threshold
    type:
      - 'null'
      - float
    doc: strand bias threshold
    inputBinding:
      position: 101
      prefix: -s
  - id: fisher_exact_threshold
    type:
      - 'null'
      - float
    doc: fisher exact threshold
    inputBinding:
      position: 101
      prefix: -f
  - id: p_value_threshold
    type:
      - 'null'
      - string
    doc: p-value threshold
    inputBinding:
      position: 101
      prefix: -p
  - id: min_reads_per_strand
    type:
      - 'null'
      - int
    doc: at least how many reads supporting each strand for alternative allele
    inputBinding:
      position: 101
      prefix: -a
  - id: allele_frequency_threshold
    type:
      - 'null'
      - float
    doc: allele frequency threshold
    inputBinding:
      position: 101
      prefix: -t
  - id: inactivate_s_f_threshold
    type:
      - 'null'
      - int
    doc: inactivate -s and -f above this threshold
    inputBinding:
      position: 101
      prefix: -u
  - id: dbsnp_info
    type:
      - 'null'
      - string
    doc: 'path for dbSNP, column number of chr, pos and snp_id (format: dbsnp,1,2,3)'
    inputBinding:
      position: 101
      prefix: -db
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: prefix_output_file_files
    type:
      type: array
      items: File
    doc: Files written with the prefix given in prefix_output_file
    outputBinding:
      glob: $(inputs.prefix_output_file)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snver:0.5.3--0
stdout: snver_pool.out
