cwlVersion: v1.2
class: CommandLineTool
baseCommand: java -jar SNVerIndividual.jar
label: snver
doc: "SNVerIndividual Usage\n\nTool homepage: http://snver.sourceforge.net/"
inputs:
  - id: alt_ref_ratio_threshold
    type:
      - 'null'
      - float
    doc: discard locus with ratio of alt/ref below the threshold
    inputBinding:
      position: 101
      prefix: -b
  - id: base_quality_threshold
    type:
      - 'null'
      - int
    doc: base quality threshold
    inputBinding:
      position: 101
      prefix: -bq
  - id: dbsnp_info
    type:
      - 'null'
      - string
    doc: 'path for dbSNP, column number of chr, pos and snp_id (format: dbsnp,1,2,3)'
    inputBinding:
      position: 101
      prefix: -db
  - id: fisher_exact_threshold
    type:
      - 'null'
      - float
    doc: fisher exact threshold
    inputBinding:
      position: 101
      prefix: -f
  - id: heterozygosity
    type:
      - 'null'
      - float
    doc: heterozygosity
    inputBinding:
      position: 101
      prefix: -het
  - id: inactivate_s_f_threshold
    type:
      - 'null'
      - int
    doc: inactivate -s and -f above this threshold
    inputBinding:
      position: 101
      prefix: -u
  - id: input_file
    type: File
    doc: Input file must be a standard bam file
    inputBinding:
      position: 101
      prefix: -i
  - id: mapping_quality_threshold
    type:
      - 'null'
      - int
    doc: mapping quality threshold
    inputBinding:
      position: 101
      prefix: -mq
  - id: min_reads_per_strand
    type:
      - 'null'
      - int
    doc: at least how many reads supporting each strand for alternative allele
    inputBinding:
      position: 101
      prefix: -a
  - id: num_haploids
    type:
      - 'null'
      - int
    doc: the number of haploids
    inputBinding:
      position: 101
      prefix: -n
  - id: p_value_threshold
    type:
      - 'null'
      - string
    doc: p-value threshold
    inputBinding:
      position: 101
      prefix: -p
  - id: prefix_output_file
    type:
      - 'null'
      - string
    doc: prefix output file
    inputBinding:
      position: 101
      prefix: -o
  - id: reference_file
    type: File
    doc: reference file
    inputBinding:
      position: 101
      prefix: -r
  - id: strand_bias_threshold
    type:
      - 'null'
      - float
    doc: strand bias threshold
    inputBinding:
      position: 101
      prefix: -s
  - id: target_region_bed_file
    type:
      - 'null'
      - File
    doc: target region bed file
    inputBinding:
      position: 101
      prefix: -l
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snver:0.5.3--0
stdout: snver.out
