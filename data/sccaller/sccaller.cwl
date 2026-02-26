cwlVersion: v1.2
class: CommandLineTool
baseCommand: sccaller
label: sccaller
doc: "SCcaller, v2.0.0; Xiao Dong, biosinodx@gmail.com, xiao.dong@einstein.yu.edu;
  Yujue Wang, spsc83@gmail.com\n\nTool homepage: https://github.com/biosinodx/SCcaller"
inputs:
  - id: bam_file
    type: File
    doc: bamfile of a single cell
    inputBinding:
      position: 101
      prefix: --bam
  - id: bias
    type:
      - 'null'
      - float
    doc: default theta (bias) for SNVs whose theta cannot be estimated. 
      Default=0.75
    default: 0.75
    inputBinding:
      position: 101
      prefix: --bias
  - id: bulk_bam_file
    type:
      - 'null'
      - File
    doc: bamfile of bulk DNA sequencing
    inputBinding:
      position: 101
      prefix: --bulk
  - id: bulk_min_depth
    type:
      - 'null'
      - int
    doc: 'min. reads for bulk. Default: 20'
    default: 20
    inputBinding:
      position: 101
      prefix: --bulk_min_depth
  - id: bulk_min_mapq
    type:
      - 'null'
      - int
    doc: 'min mapQ for bulk. Default: 20'
    default: 20
    inputBinding:
      position: 101
      prefix: --bulk_min_mapq
  - id: bulk_min_variant_reads
    type:
      - 'null'
      - int
    doc: 'min. num. variant supporting reads for bulk. Default: 1'
    default: 1
    inputBinding:
      position: 101
      prefix: --bulk_min_var
  - id: cpu_num
    type:
      - 'null'
      - int
    doc: 'num. processes. Default: 1'
    default: 1
    inputBinding:
      position: 101
      prefix: --cpu_num
  - id: fasta_file
    type: File
    doc: fasta file of reference genome
    inputBinding:
      position: 101
      prefix: --fasta
  - id: first_chromosome
    type:
      - 'null'
      - int
    doc: 'first chromosome as sorted as in fasta file to analyze (1-based). Default:
      the first chr. in the fasta'
    inputBinding:
      position: 101
      prefix: --head
  - id: lambda_bias_estimation
    type:
      - 'null'
      - int
    doc: lambda for bias estimation. Default=10000
    default: 10000
    inputBinding:
      position: 101
      prefix: --lamb
  - id: last_chromosome
    type:
      - 'null'
      - int
    doc: 'last chromosome as sorted as in fasta file to analyze (1-based). Default:
      the last chr. in the fasta'
    inputBinding:
      position: 101
      prefix: --tail
  - id: min_allelic_fraction
    type:
      - 'null'
      - float
    doc: min. allelic fraction considered. Default=0.03
    default: 0.03
    inputBinding:
      position: 101
      prefix: --null
  - id: min_depth
    type:
      - 'null'
      - int
    doc: 'min. reads. Default: 10'
    default: 10
    inputBinding:
      position: 101
      prefix: --min_depth
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: 'min. mapQ. Default: 40'
    default: 40
    inputBinding:
      position: 101
      prefix: --mapq
  - id: min_read_depth_known_snp
    type:
      - 'null'
      - int
    doc: 'min. read depth of known heterogous SNP called from bulk when choosing -t
      dbsnp. Default: 20. Recommand: 10,15,20, depending on average read depth'
    default: 20
    inputBinding:
      position: 101
      prefix: --RD
  - id: min_variant_reads
    type:
      - 'null'
      - int
    doc: 'min. num. variant supporting reads. Default: 4'
    default: 4
    inputBinding:
      position: 101
      prefix: --minvar
  - id: num_splits_per_chromosome
    type:
      - 'null'
      - int
    doc: 'num. splits per chromosome for multi-process computing. Default: 100'
    default: 100
    inputBinding:
      position: 101
      prefix: --work_num
  - id: output_format
    type:
      - 'null'
      - string
    doc: 'output file format. bed or vcf. Default: vcf'
    default: vcf
    inputBinding:
      position: 101
      prefix: --format
  - id: pileup_engine
    type:
      - 'null'
      - string
    doc: 'pileup engine. samtools or pysam. Default: pysam'
    default: pysam
    inputBinding:
      position: 101
      prefix: --engine
  - id: snp_in
    type: File
    doc: 'Candidate snp input file, either from dbsnp data or heterozygous snp (hsnp)
      data of the bulk, for known heterogous call. file type: bed (1-based) or vcf.'
    inputBinding:
      position: 101
      prefix: --snp_in
  - id: snp_type
    type: string
    doc: SNP type for --snp_in. It could be either "dbsnp" or "hsnp". When 
      choosing dbsnp, --bulk bulk_bamfile is required.
    inputBinding:
      position: 101
      prefix: --snp_type
  - id: work_dir
    type:
      - 'null'
      - Directory
    doc: 'work dir. Default: ./'
    default: ./
    inputBinding:
      position: 101
      prefix: --wkdir
outputs:
  - id: output_file
    type: File
    doc: output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sccaller:2.0.0--0
