cwlVersion: v1.2
class: CommandLineTool
baseCommand: sniffles
label: telr_sniffles
doc: "Structural Variant Caller\n\nTool homepage: https://github.com/bergmanlab/telr"
inputs:
  - id: allelefreq
    type:
      - 'null'
      - float
    doc: Threshold on allele frequency (0-1).
    inputBinding:
      position: 101
      prefix: --allelefreq
  - id: ccs_reads
    type:
      - 'null'
      - boolean
    doc: Preset CCS Pacbio setting. (Beta)
    inputBinding:
      position: 101
      prefix: --ccs_reads
  - id: cluster
    type:
      - 'null'
      - boolean
    doc: Enables Sniffles to phase SVs that occur on the same reads
    inputBinding:
      position: 101
      prefix: --cluster
  - id: cluster_support
    type:
      - 'null'
      - int
    doc: Minimum number of reads supporting clustering of SV.
    inputBinding:
      position: 101
      prefix: --cluster_support
  - id: cs_string
    type:
      - 'null'
      - boolean
    doc: Enables the scan of CS string instead of Cigar and MD.
    inputBinding:
      position: 101
      prefix: --cs_string
  - id: del_ratio
    type:
      - 'null'
      - float
    doc: Estimated ration of deletions per read (0-1).
    inputBinding:
      position: 101
      prefix: --del_ratio
  - id: genotype
    type:
      - 'null'
      - boolean
    doc: 'Inactivated: Automatically true.'
    inputBinding:
      position: 101
      prefix: --genotype
  - id: ignore_sd
    type:
      - 'null'
      - boolean
    doc: Ignores the sd based filtering.
    inputBinding:
      position: 101
      prefix: --ignore_sd
  - id: input_vcf
    type:
      - 'null'
      - File
    doc: Input VCF file name. Enable force calling
    inputBinding:
      position: 101
      prefix: --Ivcf
  - id: ins_ratio
    type:
      - 'null'
      - float
    doc: Estimated ratio of insertions per read (0-1).
    inputBinding:
      position: 101
      prefix: --ins_ratio
  - id: mapped_reads
    type: File
    doc: Sorted bam File
    inputBinding:
      position: 101
      prefix: --mapped_reads
  - id: max_diff_per_window
    type:
      - 'null'
      - int
    doc: Maximum differences per 100bp.
    inputBinding:
      position: 101
      prefix: --max_diff_per_window
  - id: max_dist_aln_events
    type:
      - 'null'
      - int
    doc: Maximum distance between alignment (indel) events.
    inputBinding:
      position: 101
      prefix: --max_dist_aln_events
  - id: max_distance
    type:
      - 'null'
      - int
    doc: Maximum distance to group SV together.
    inputBinding:
      position: 101
      prefix: --max_distance
  - id: max_num_splits
    type:
      - 'null'
      - int
    doc: Maximum number of splits per read to be still taken into account.
    inputBinding:
      position: 101
      prefix: --max_num_splits
  - id: min_het_af
    type:
      - 'null'
      - float
    doc: Threshold on allele frequency (0-1).
    inputBinding:
      position: 101
      prefix: --min_het_af
  - id: min_homo_af
    type:
      - 'null'
      - float
    doc: Threshold on allele frequency (0-1).
    inputBinding:
      position: 101
      prefix: --min_homo_af
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum length of SV to be reported.
    inputBinding:
      position: 101
      prefix: --min_length
  - id: min_seq_size
    type:
      - 'null'
      - int
    doc: Discard read if non of its segment is larger then this.
    inputBinding:
      position: 101
      prefix: --min_seq_size
  - id: min_support
    type:
      - 'null'
      - int
    doc: Minimum number of reads that support a SV.
    inputBinding:
      position: 101
      prefix: --min_support
  - id: min_zmw
    type:
      - 'null'
      - int
    doc: Discard SV that are not supported by at least x zmws. This applies only
      for PacBio recognizable reads.
    inputBinding:
      position: 101
      prefix: --min_zmw
  - id: minmapping_qual
    type:
      - 'null'
      - int
    doc: Minimum Mapping Quality.
    inputBinding:
      position: 101
      prefix: --minmapping_qual
  - id: not_report_seq
    type:
      - 'null'
      - boolean
    doc: Dont report sequences for indels in vcf output. (Beta version!)
    inputBinding:
      position: 101
      prefix: --not_report_seq
  - id: num_reads_report
    type:
      - 'null'
      - int
    doc: 'Report up to N reads that support the SV in the vcf file. -1: report all.'
    inputBinding:
      position: 101
      prefix: --num_reads_report
  - id: report_bnd
    type:
      - 'null'
      - boolean
    doc: Dont report BND instead use Tra in vcf output.
    inputBinding:
      position: 101
      prefix: --report_BND
  - id: report_seq
    type:
      - 'null'
      - boolean
    doc: Inactivated (see not_report_seq).
    inputBinding:
      position: 101
      prefix: --report-seq
  - id: report_str
    type:
      - 'null'
      - boolean
    doc: Enables the report of str. (alpha testing)
    inputBinding:
      position: 101
      prefix: --report_str
  - id: skip_parameter_estimation
    type:
      - 'null'
      - boolean
    doc: Enables the scan if only very few reads are present.
    inputBinding:
      position: 101
      prefix: --skip_parameter_estimation
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    inputBinding:
      position: 101
      prefix: --threads
  - id: tmp_file
    type:
      - 'null'
      - File
    doc: path to temporary file otherwise Sniffles will use the current 
      directory.
    inputBinding:
      position: 101
      prefix: --tmp_file
outputs:
  - id: vcf_output
    type:
      - 'null'
      - File
    doc: VCF output file name
    outputBinding:
      glob: $(inputs.vcf_output)
  - id: bedpe_output
    type:
      - 'null'
      - File
    doc: bedpe output file name
    outputBinding:
      glob: $(inputs.bedpe_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/telr:1.1--pyhdfd78af_0
