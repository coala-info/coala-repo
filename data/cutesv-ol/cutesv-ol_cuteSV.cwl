cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cuteSV
label: cutesv-ol_cuteSV
doc: "Two-step cuteSV shipped with cuteSV-OL: --mode 1 extracts SV signatures from
  a sorted BAM into the work directory, --mode 2 clusters the collected signatures
  into an output VCF.\n\nTool homepage: https://github.com/120L022331/cuteSV-OL"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |-
      ${
        if (inputs.existing_work_dir) {
          return [{entry: inputs.existing_work_dir, entryname: inputs.work_dir, writable: true}];
        }
        return [{entry: {class: "Directory", basename: inputs.work_dir,
                 listing: [{class: "Directory", basename: "signatures", listing: []}]},
                 writable: true}];
      }
inputs:
  - id: mode
    type: string
    doc: 'convert cutesv to two steps: 1 = extract signatures from the BAM, 2 = 
      cluster signatures and write the VCF'
    inputBinding:
      position: 1
      prefix: --mode
  - id: input_bam
    type:
      - 'null'
      - File
    secondaryFiles:
      - .bai
    doc: Sorted .bam file from NGMLR or Minimap2 (mode 1).
    inputBinding:
      position: 1
      prefix: --input
  - id: reference
    type: File
    secondaryFiles:
      - .fai
    doc: The reference genome in fasta format.
    inputBinding:
      position: 1
      prefix: --reference
  - id: output
    type:
      - 'null'
      - string
    doc: Output VCF format file (mode 2).
    inputBinding:
      position: 1
      prefix: --output
  - id: work_dir
    type: string
    doc: Work-directory for distributed jobs. Created with an empty signatures 
      folder, or a copy of existing_work_dir under this name.
    default: cutesv_work_dir
    inputBinding:
      position: 1
      prefix: --work_dir
      valueFrom: $(self + '/')
  - id: existing_work_dir
    type:
      - 'null'
      - Directory
    doc: Work directory from earlier runs (signatures from mode 1) to continue 
      in; staged writable under the work_dir name.
  - id: bam_name
    type:
      - 'null'
      - string
    doc: bam_name (prefix of the signature files written in mode 1)
    inputBinding:
      position: 1
      prefix: --bam_name
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.[16]
    inputBinding:
      position: 1
      prefix: --threads
  - id: batches
    type:
      - 'null'
      - int
    doc: Batch of genome segmentation interval.[10000000]
    inputBinding:
      position: 1
      prefix: --batches
  - id: sample
    type:
      - 'null'
      - string
    doc: Sample name/id
    inputBinding:
      position: 1
      prefix: --sample
  - id: retain_work_dir
    type:
      - 'null'
      - boolean
    doc: Enable to retain temporary folder and files.
    inputBinding:
      position: 1
      prefix: --retain_work_dir
  - id: write_old_sigs
    type:
      - 'null'
      - boolean
    doc: Enable to write sigs file in temporary folder for legacy 
      compatibilities.
    inputBinding:
      position: 1
      prefix: --write_old_sigs
  - id: report_readid
    type:
      - 'null'
      - boolean
    doc: Enable to report supporting read ids for each SV.
    inputBinding:
      position: 1
      prefix: --report_readid
  - id: ignore_sequence
    type:
      - 'null'
      - boolean
    doc: Do not output sequences for SVs.
    inputBinding:
      position: 1
      prefix: --ignore_sequence
  - id: max_split_parts
    type:
      - 'null'
      - int
    doc: Maximum number of split segments a read may be aligned before it is 
      ignored. All split segments are considered when using -1.[7]
    inputBinding:
      position: 1
      prefix: --max_split_parts
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Minimum mapping quality value of alignment to be taken into 
      account.[20]
    inputBinding:
      position: 1
      prefix: --min_mapq
  - id: min_read_len
    type:
      - 'null'
      - int
    doc: Ignores reads that only report alignments with not longer than 
      bp.[500]
    inputBinding:
      position: 1
      prefix: --min_read_len
  - id: merge_del_threshold
    type:
      - 'null'
      - int
    doc: Maximum distance of deletion signals to be merged.[0]
    inputBinding:
      position: 1
      prefix: --merge_del_threshold
  - id: merge_ins_threshold
    type:
      - 'null'
      - int
    doc: Maximum distance of insertion signals to be merged.[100]
    inputBinding:
      position: 1
      prefix: --merge_ins_threshold
  - id: include_bed
    type:
      - 'null'
      - File
    doc: Optional given bed file. Only detect SVs in regions in the BED file. 
      [NULL]
    inputBinding:
      position: 1
      prefix: -include_bed
  - id: min_support
    type:
      - 'null'
      - int
    doc: Minimum number of reads that support a SV to be reported.[10]
    inputBinding:
      position: 1
      prefix: --min_support
  - id: min_size
    type:
      - 'null'
      - int
    doc: Minimum size of SV to be reported.[30]
    inputBinding:
      position: 1
      prefix: --min_size
  - id: max_size
    type:
      - 'null'
      - int
    doc: Maximum size of SV to be reported. All SVs are reported when using 
      -1. [100000]
    inputBinding:
      position: 1
      prefix: --max_size
  - id: min_siglength
    type:
      - 'null'
      - int
    doc: Minimum length of SV signal to be extracted.[10]
    inputBinding:
      position: 1
      prefix: --min_siglength
  - id: genotype
    type:
      - 'null'
      - boolean
    doc: Enable to generate genotypes.
    inputBinding:
      position: 1
      prefix: --genotype
  - id: gt_round
    type:
      - 'null'
      - int
    doc: Maximum round of iteration for alignments searching if perform 
      genotyping.[500]
    inputBinding:
      position: 1
      prefix: --gt_round
  - id: read_range
    type:
      - 'null'
      - int
    doc: The interval range for counting reads distribution.[1000]
    inputBinding:
      position: 1
      prefix: --read_range
  - id: ivcf
    type:
      - 'null'
      - File
    doc: The force calling module was disabled in cuteSV, please install cuteFC
      to achieve SV force calling/regenotyping.
    inputBinding:
      position: 1
      prefix: -Ivcf
  - id: max_cluster_bias_ins
    type:
      - 'null'
      - int
    doc: Maximum distance to cluster read together for insertion.[100]
    inputBinding:
      position: 1
      prefix: --max_cluster_bias_INS
  - id: diff_ratio_merging_ins
    type:
      - 'null'
      - float
    doc: Do not merge breakpoints with basepair identity more than [0.3] for 
      insertion.
    inputBinding:
      position: 1
      prefix: --diff_ratio_merging_INS
  - id: max_cluster_bias_del
    type:
      - 'null'
      - int
    doc: Maximum distance to cluster read together for deletion.[200]
    inputBinding:
      position: 1
      prefix: --max_cluster_bias_DEL
  - id: diff_ratio_merging_del
    type:
      - 'null'
      - float
    doc: Do not merge breakpoints with basepair identity more than [0.5] for 
      deletion.
    inputBinding:
      position: 1
      prefix: --diff_ratio_merging_DEL
  - id: max_cluster_bias_inv
    type:
      - 'null'
      - int
    doc: Maximum distance to cluster read together for inversion.[500]
    inputBinding:
      position: 1
      prefix: --max_cluster_bias_INV
  - id: max_cluster_bias_dup
    type:
      - 'null'
      - int
    doc: Maximum distance to cluster read together for duplication.[500]
    inputBinding:
      position: 1
      prefix: --max_cluster_bias_DUP
  - id: max_cluster_bias_tra
    type:
      - 'null'
      - int
    doc: Maximum distance to cluster read together for translocation.[50]
    inputBinding:
      position: 1
      prefix: --max_cluster_bias_TRA
  - id: diff_ratio_filtering_tra
    type:
      - 'null'
      - float
    doc: Filter breakpoints with basepair identity less than [0.6] for 
      translocation.
    inputBinding:
      position: 1
      prefix: --diff_ratio_filtering_TRA
  - id: remain_reads_ratio
    type:
      - 'null'
      - float
    doc: The ratio of reads remained in cluster. Set lower when the alignment 
      data have high quality but recommand over 0.5.[1.0]
    inputBinding:
      position: 1
      prefix: --remain_reads_ratio
outputs:
  - id: output_vcf
    type:
      - 'null'
      - File
    doc: Output VCF format file (mode 2).
    outputBinding:
      glob: $(inputs.output)
  - id: work_dir_out
    type:
      - 'null'
      - Directory
    doc: Work directory with the SV signatures (input for mode 2)
    outputBinding:
      glob: $(inputs.work_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cutesv-ol:1.0.2--py312h7b50bb2_0
