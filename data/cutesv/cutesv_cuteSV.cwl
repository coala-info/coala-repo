cwlVersion: v1.2
class: CommandLineTool
baseCommand: cuteSV
label: cutesv_cuteSV
doc: "Long-read-based human genomic structural variation detection with cuteSV.\n\n\
  Tool homepage: https://github.com/tjiangHIT/cuteSV"
inputs:
  - id: bam_file
    type:
      - 'null'
      - File
    doc: Sorted .bam file from NGMLR or Minimap2.
    inputBinding:
      position: 1
  - id: reference
    type: File
    doc: The reference genome in fasta format.
    inputBinding:
      position: 2
  - id: work_dir
    type: Directory
    doc: Work-directory for distributed jobs
    inputBinding:
      position: 3
  - id: batches
    type:
      - 'null'
      - int
    doc: Batch of genome segmentation interval.
    default: 10000000
    inputBinding:
      position: 104
      prefix: --batches
  - id: diff_ratio_filtering_tra
    type:
      - 'null'
      - float
    doc: Filter breakpoints with basepair identity less than [0.6] for 
      translocation.
    default: 0.6
    inputBinding:
      position: 104
      prefix: --diff_ratio_filtering_TRA
  - id: diff_ratio_merging_del
    type:
      - 'null'
      - float
    doc: Do not merge breakpoints with basepair identity more than [0.5] for 
      deletion.
    default: 0.5
    inputBinding:
      position: 104
      prefix: --diff_ratio_merging_DEL
  - id: diff_ratio_merging_ins
    type:
      - 'null'
      - float
    doc: Do not merge breakpoints with basepair identity more than [0.3] for 
      insertion.
    default: 0.3
    inputBinding:
      position: 104
      prefix: --diff_ratio_merging_INS
  - id: genotype
    type:
      - 'null'
      - boolean
    doc: Enable to generate genotypes.
    inputBinding:
      position: 104
      prefix: --genotype
  - id: gt_round
    type:
      - 'null'
      - int
    doc: Maximum round of iteration for alignments searching if perform 
      genotyping.
    default: 500
    inputBinding:
      position: 104
      prefix: --gt_round
  - id: ignore_sequence
    type:
      - 'null'
      - boolean
    doc: Do not output sequences for SVs.
    inputBinding:
      position: 104
      prefix: --ignore_sequence
  - id: include_bed
    type:
      - 'null'
      - File
    doc: Optional given bed file. Only detect SVs in regions in the BED file.
    default: 'NULL'
    inputBinding:
      position: 104
      prefix: -include_bed
  - id: ivcf
    type:
      - 'null'
      - File
    doc: The force calling module was disabled in cuteSV, please install cuteFC 
      (https://github.com/Meltpinkg/cuteFC) to achieve SV force 
      calling/regenotyping.
    inputBinding:
      position: 104
      prefix: -Ivcf
  - id: max_cluster_bias_del
    type:
      - 'null'
      - int
    doc: Maximum distance to cluster read together for deletion.
    default: 200
    inputBinding:
      position: 104
      prefix: --max_cluster_bias_DEL
  - id: max_cluster_bias_dup
    type:
      - 'null'
      - int
    doc: Maximum distance to cluster read together for duplication.
    default: 500
    inputBinding:
      position: 104
      prefix: --max_cluster_bias_DUP
  - id: max_cluster_bias_ins
    type:
      - 'null'
      - int
    doc: Maximum distance to cluster read together for insertion.
    default: 100
    inputBinding:
      position: 104
      prefix: --max_cluster_bias_INS
  - id: max_cluster_bias_inv
    type:
      - 'null'
      - int
    doc: Maximum distance to cluster read together for inversion.
    default: 500
    inputBinding:
      position: 104
      prefix: --max_cluster_bias_INV
  - id: max_cluster_bias_tra
    type:
      - 'null'
      - int
    doc: Maximum distance to cluster read together for translocation.
    default: 50
    inputBinding:
      position: 104
      prefix: --max_cluster_bias_TRA
  - id: max_size
    type:
      - 'null'
      - int
    doc: Maximum size of SV to be reported. All SVs are reported when using -1.
    default: 100000
    inputBinding:
      position: 104
      prefix: --max_size
  - id: max_split_parts
    type:
      - 'null'
      - int
    doc: Maximum number of split segments a read may be aligned before it is 
      ignored. All split segments are considered when using -1. (Recommand -1 
      when applying assembly-based alignment.)
    default: 7
    inputBinding:
      position: 104
      prefix: --max_split_parts
  - id: merge_del_threshold
    type:
      - 'null'
      - int
    doc: Maximum distance of deletion signals to be merged. In our paper, I used
      -md 500 to process HG002 real human sample data.
    default: 0
    inputBinding:
      position: 104
      prefix: --merge_del_threshold
  - id: merge_ins_threshold
    type:
      - 'null'
      - int
    doc: Maximum distance of insertion signals to be merged. In our paper, I 
      used -mi 500 to process HG002 real human sample data.
    default: 100
    inputBinding:
      position: 104
      prefix: --merge_ins_threshold
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Minimum mapping quality value of alignment to be taken into account.
    default: 20
    inputBinding:
      position: 104
      prefix: --min_mapq
  - id: min_read_len
    type:
      - 'null'
      - int
    doc: Ignores reads that only report alignments with not longer than bp.
    default: 500
    inputBinding:
      position: 104
      prefix: --min_read_len
  - id: min_siglength
    type:
      - 'null'
      - int
    doc: Minimum length of SV signal to be extracted.
    default: 10
    inputBinding:
      position: 104
      prefix: --min_siglength
  - id: min_size
    type:
      - 'null'
      - int
    doc: Minimum size of SV to be reported.
    default: 30
    inputBinding:
      position: 104
      prefix: --min_size
  - id: min_support
    type:
      - 'null'
      - int
    doc: Minimum number of reads that support a SV to be reported.
    default: 10
    inputBinding:
      position: 104
      prefix: --min_support
  - id: read_range
    type:
      - 'null'
      - int
    doc: The interval range for counting reads distribution.
    default: 1000
    inputBinding:
      position: 104
      prefix: --read_range
  - id: remain_reads_ratio
    type:
      - 'null'
      - float
    doc: The ratio of reads remained in cluster. Set lower when the alignment 
      data have high quality but recommand over 0.5.
    default: 1.0
    inputBinding:
      position: 104
      prefix: --remain_reads_ratio
  - id: report_readid
    type:
      - 'null'
      - boolean
    doc: Enable to report supporting read ids for each SV.
    inputBinding:
      position: 104
      prefix: --report_readid
  - id: retain_work_dir
    type:
      - 'null'
      - boolean
    doc: Enable to retain temporary folder and files.
    inputBinding:
      position: 104
      prefix: --retain_work_dir
  - id: sample
    type:
      - 'null'
      - string
    doc: Sample name/id
    inputBinding:
      position: 104
      prefix: --sample
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    default: 16
    inputBinding:
      position: 104
      prefix: --threads
  - id: write_old_sigs
    type:
      - 'null'
      - boolean
    doc: Enable to write sigs file in temporary folder for legacy 
      compatibilities.
    inputBinding:
      position: 104
      prefix: --write_old_sigs
outputs:
  - id: output_vcf
    type: File
    doc: Output VCF format file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cutesv:2.1.3--pyhdfd78af_0
