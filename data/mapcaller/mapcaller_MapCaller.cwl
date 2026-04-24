cwlVersion: v1.2
class: CommandLineTool
baseCommand: MapCaller
label: mapcaller_MapCaller
doc: "MapCaller v0.9.9.41\n\nTool homepage: https://github.com/hsinnan75/MapCaller"
inputs:
  - id: apply_variant_filters
    type:
      - 'null'
      - boolean
    doc: apply variant filters (under test)
    inputBinding:
      position: 101
      prefix: -filter
  - id: bam_output_file
    type:
      - 'null'
      - File
    doc: BAM output filename
    inputBinding:
      position: 101
      prefix: -bam
  - id: detect_somatic_mutations
    type:
      - 'null'
      - boolean
    doc: detect somatic mutations
    inputBinding:
      position: 101
      prefix: -somatic
  - id: fragment_size
    type:
      - 'null'
      - int
    doc: sequencing fragment size
    inputBinding:
      position: 101
      prefix: -size
  - id: gapped_alignment_algorithm
    type:
      - 'null'
      - string
    doc: 'gapped alignment algorithm (option: nw|ksw2)'
    inputBinding:
      position: 101
      prefix: -alg
  - id: gvcf_mode
    type:
      - 'null'
      - boolean
    doc: GVCF mode
    inputBinding:
      position: 101
      prefix: -gvcf
  - id: index_prefix
    type: string
    doc: BWT_Index_Prefix
    inputBinding:
      position: 101
      prefix: -i
  - id: interlaced_paired_end_reads
    type:
      - 'null'
      - boolean
    doc: paired-end reads are interlaced in the same file
    inputBinding:
      position: 101
      prefix: -p
  - id: log_file
    type:
      - 'null'
      - File
    doc: log filename
    inputBinding:
      position: 101
      prefix: -log
  - id: max_clip_size
    type:
      - 'null'
      - int
    doc: maximal clip size at either ends
    inputBinding:
      position: 101
      prefix: -maxclip
  - id: max_indel_size
    type:
      - 'null'
      - int
    doc: maximal indel size
    inputBinding:
      position: 101
      prefix: -indel
  - id: max_mismatch_rate
    type:
      - 'null'
      - float
    doc: maximal mismatch rate in read alignment
    inputBinding:
      position: 101
      prefix: -maxmm
  - id: max_pcr_duplicates
    type:
      - 'null'
      - int
    doc: maximal PCR duplicates
    inputBinding:
      position: 101
      prefix: -dup
  - id: min_alt_allele_count
    type:
      - 'null'
      - int
    doc: minimal ALT allele count
    inputBinding:
      position: 101
      prefix: -ad
  - id: min_cnv_size
    type:
      - 'null'
      - int
    doc: the minimal cnv size to be reported
    inputBinding:
      position: 101
      prefix: -min_cnv
  - id: min_gap_size
    type:
      - 'null'
      - int
    doc: the minimal gap(unmapped) size to be reported
    inputBinding:
      position: 101
      prefix: -min_gap
  - id: no_vcf_output
    type:
      - 'null'
      - boolean
    doc: No VCF output
    inputBinding:
      position: 101
      prefix: -no_vcf
  - id: output_multiple_alignments
    type:
      - 'null'
      - boolean
    doc: output multiple alignments
    inputBinding:
      position: 101
      prefix: -m
  - id: ploidy
    type:
      - 'null'
      - int
    doc: number of sets of chromosomes in a cell (1:monoploid, 2:diploid)
    inputBinding:
      position: 101
      prefix: -ploidy
  - id: read_files_1
    type:
      type: array
      items: File
    doc: 'files with #1 mates reads (format:fa, fq, fq.gz)'
    inputBinding:
      position: 101
      prefix: -f
  - id: read_files_2
    type:
      - 'null'
      - type: array
        items: File
    doc: 'files with #2 mates reads (format:fa, fq, fq.gz)'
    inputBinding:
      position: 101
      prefix: -f2
  - id: reference_file
    type:
      - 'null'
      - File
    doc: Reference filename (format:fa)
    inputBinding:
      position: 101
      prefix: -r
  - id: report_monomorphic
    type:
      - 'null'
      - boolean
    doc: report all loci which do not have any potential alternates.
    inputBinding:
      position: 101
      prefix: -monomorphic
  - id: sam_output_file
    type:
      - 'null'
      - File
    doc: SAM output filename
    inputBinding:
      position: 101
      prefix: -sam
  - id: sample_id
    type:
      - 'null'
      - string
    doc: assign sample id
    inputBinding:
      position: 101
      prefix: -id
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: -t
  - id: vcf_output_file
    type:
      - 'null'
      - File
    doc: VCF output filename
    inputBinding:
      position: 101
      prefix: -vcf
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mapcaller:0.9.9.41--h13024bc_6
stdout: mapcaller_MapCaller.out
