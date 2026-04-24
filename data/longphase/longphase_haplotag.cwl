cwlVersion: v1.2
class: CommandLineTool
baseCommand: haplotag
label: longphase_haplotag
doc: "Tag alignments with haplotype information based on SNP and SV data.\n\nTool
  homepage: https://github.com/twolinin/longphase"
inputs:
  - id: reads_file
    type: File
    doc: Input reads file (e.g., BAM or CRAM).
    inputBinding:
      position: 1
  - id: bam_file
    type: File
    doc: input bam file.
    inputBinding:
      position: 102
      prefix: --bam-file
  - id: log
    type:
      - 'null'
      - boolean
    doc: an additional log file records the result of each read.
    inputBinding:
      position: 102
      prefix: --log
  - id: mod_file
    type:
      - 'null'
      - File
    doc: input a modified VCF file (produced by longphase modcall and processed 
      by longphase phase).
    inputBinding:
      position: 102
      prefix: --mod-file
  - id: out_prefix
    type:
      - 'null'
      - string
    doc: prefix of phasing result.
    inputBinding:
      position: 102
      prefix: --out-prefix
  - id: output_cram
    type:
      - 'null'
      - boolean
    doc: the output file will be in the cram format.
    inputBinding:
      position: 102
      prefix: --cram
  - id: percentage_threshold
    type:
      - 'null'
      - float
    doc: the alignment will be tagged according to the haplotype corresponding 
      to most alleles. if the alignment has no obvious corresponding haplotype, 
      it will not be tagged.
    inputBinding:
      position: 102
      prefix: --percentageThreshold
  - id: quality_threshold
    type:
      - 'null'
      - int
    doc: not tag alignment if the mapping quality less than threshold.
    inputBinding:
      position: 102
      prefix: --qualityThreshold
  - id: reference
    type: File
    doc: reference fasta.
    inputBinding:
      position: 102
      prefix: --reference
  - id: region
    type:
      - 'null'
      - string
    doc: tagging include only reads/variants overlapping those regions. input 
      format:chrom (consider entire chromosome) chrom:start (consider region 
      from this start to end of chromosome) chrom:start-end
    inputBinding:
      position: 102
      prefix: --region
  - id: snp_file
    type: File
    doc: input SNP vcf file.
    inputBinding:
      position: 102
      prefix: --snp-file
  - id: sv_file
    type:
      - 'null'
      - File
    doc: input phased SV vcf file.
    inputBinding:
      position: 102
      prefix: --sv-file
  - id: sv_threshold
    type:
      - 'null'
      - float
    doc: relative difference threshold for read to support a SV.
    inputBinding:
      position: 102
      prefix: --sv-threshold
  - id: sv_window
    type:
      - 'null'
      - int
    doc: window size for evaluating surrounding CIGAR operations.
    inputBinding:
      position: 102
      prefix: --sv-window
  - id: tag_supplementary
    type:
      - 'null'
      - boolean
    doc: tag supplementary alignment.
    inputBinding:
      position: 102
      prefix: --tagSupplementary
  - id: threads
    type:
      - 'null'
      - int
    doc: number of thread.
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/longphase:2.0.1--hfc4162c_0
stdout: longphase_haplotag.out
