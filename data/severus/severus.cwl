cwlVersion: v1.2
class: CommandLineTool
baseCommand: severus
label: severus
doc: "Find breakpoints and build breakpoint graph from a bam file\n\nTool homepage:
  https://github.com/KolmogorovLab/Severus"
inputs:
  - id: PON
    type:
      - 'null'
      - File
    doc: Uses PON data
    inputBinding:
      position: 101
      prefix: --PON
  - id: TIN_ratio
    type:
      - 'null'
      - float
    doc: Tumor in normal ratio
    inputBinding:
      position: 101
      prefix: --TIN-ratio
  - id: between_junction_ins
    type:
      - 'null'
      - boolean
    doc: reports unmapped sequence between breakpoints
    inputBinding:
      position: 101
      prefix: --between-junction-ins
  - id: bp_cluster_size
    type:
      - 'null'
      - int
    doc: maximum distance in bp cluster
    inputBinding:
      position: 101
      prefix: --bp-cluster-size
  - id: control_bam
    type:
      - 'null'
      - type: array
        items: File
    doc: path to the control bam file (e.g. normal, must be indexed)
    inputBinding:
      position: 101
      prefix: --control-bam
  - id: control_cov_thr
    type:
      - 'null'
      - float
    doc: Min normal coverage
    inputBinding:
      position: 101
      prefix: --control-cov-thr
  - id: control_sample
    type:
      - 'null'
      - type: array
        items: string
    doc: Sample name for the control bam
    inputBinding:
      position: 101
      prefix: --control-sample
  - id: ins_to_tra
    type:
      - 'null'
      - boolean
    doc: converts insertions to translocations if mapping is known
    inputBinding:
      position: 101
      prefix: --ins-to-tra
  - id: junction_vcf
    type:
      - 'null'
      - boolean
    doc: Outputs a junction vcf in which all DELs, DUPs and INVs are represented
      as a BND
    inputBinding:
      position: 101
      prefix: --junction-vcf
  - id: low_quality
    type:
      - 'null'
      - boolean
    doc: Uses set of parameters optimized for the analysis with lower quality
    inputBinding:
      position: 101
      prefix: --low-quality
  - id: max_genomic_len
    type:
      - 'null'
      - int
    doc: maximum length of genomic segment to form connected components
    inputBinding:
      position: 101
      prefix: --max-genomic-len
  - id: max_read_error
    type:
      - 'null'
      - float
    doc: maximum base alignment error
    inputBinding:
      position: 101
      prefix: --max-read-error
  - id: max_unmapped_seq
    type:
      - 'null'
      - int
    doc: maximum length of unmapped sequence between two mapped segments (if 
      --between-junction-ins is selected the unmapped sequnce will be reported 
      in the vcf))
    inputBinding:
      position: 101
      prefix: --max-unmapped-seq
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: minimum mapping quality for aligned segment
    inputBinding:
      position: 101
      prefix: --min-mapq
  - id: min_reference_flank
    type:
      - 'null'
      - int
    doc: minimum distance between a breakpoint and reference ends
    inputBinding:
      position: 101
      prefix: --min-reference-flank
  - id: min_support
    type:
      - 'null'
      - int
    doc: minimum reads supporting double breakpoint
    inputBinding:
      position: 101
      prefix: --min-support
  - id: min_sv_size
    type:
      - 'null'
      - int
    doc: minimim size for sv
    inputBinding:
      position: 101
      prefix: --min-sv-size
  - id: no_ins_seq
    type:
      - 'null'
      - boolean
    doc: do not output insertion sequences to the vcf file
    inputBinding:
      position: 101
      prefix: --no-ins-seq
  - id: out_dir
    type: Directory
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --out-dir
  - id: output_LOH
    type:
      - 'null'
      - boolean
    doc: outputs a bed file with predicted LOH regions
    inputBinding:
      position: 101
      prefix: --output-LOH
  - id: output_read_ids
    type:
      - 'null'
      - boolean
    doc: to output supporting read ids
    inputBinding:
      position: 101
      prefix: --output-read-ids
  - id: phasing_vcf
    type:
      - 'null'
      - File
    doc: path to vcf file used for phasing (if using haplotype specific SV 
      calling)
    inputBinding:
      position: 101
      prefix: --phasing-vcf
  - id: reference_adjacencies
    type:
      - 'null'
      - boolean
    doc: draw reference adjacencies
    inputBinding:
      position: 101
      prefix: --reference-adjacencies
  - id: resolve_overlaps
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --resolve-overlaps
  - id: single_bp
    type:
      - 'null'
      - boolean
    doc: Add hagning breakpoints
    inputBinding:
      position: 101
      prefix: --single-bp
  - id: target_bam
    type:
      type: array
      items: File
    doc: path to one or multiple target bam files (e.g. tumor, must be indexed)
    inputBinding:
      position: 101
      prefix: --target-bam
  - id: target_sample
    type:
      - 'null'
      - type: array
        items: string
    doc: Sample name for the target bams
    inputBinding:
      position: 101
      prefix: --target-sample
  - id: threads
    type:
      - 'null'
      - int
    doc: number of parallel threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: use_supplementary_tag
    type:
      - 'null'
      - boolean
    doc: Uses haplotype tag in supplementary alignments
    inputBinding:
      position: 101
      prefix: --use-supplementary-tag
  - id: vaf_thr
    type:
      - 'null'
      - float
    doc: Tumor in normal ratio
    inputBinding:
      position: 101
      prefix: --vaf-thr
  - id: vntr_bed
    type:
      - 'null'
      - File
    doc: bed file with tandem repeat locations
    inputBinding:
      position: 101
      prefix: --vntr-bed
  - id: whitelist
    type:
      - 'null'
      - File
    doc: Outputs all the SVs within the bed file
    inputBinding:
      position: 101
      prefix: --whitelist
  - id: write_alignments
    type:
      - 'null'
      - boolean
    doc: write read alignments to file
    inputBinding:
      position: 101
      prefix: --write-alignments
  - id: write_collapsed_dup
    type:
      - 'null'
      - boolean
    doc: outputs a bed file with identified collapsed duplication regions
    inputBinding:
      position: 101
      prefix: --write-collapsed-dup
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/severus:1.6--pyhdfd78af_0
stdout: severus.out
