cwlVersion: v1.2
class: CommandLineTool
baseCommand: vamos
label: vamos_read
doc: "Vamos is a tool for VNTR analysis.\n\nTool homepage: https://github.com/ChaissonLab/vamos"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print out debug information.
    inputBinding:
      position: 101
      prefix: --debug
  - id: force_phasing
    type:
      - 'null'
      - boolean
    doc: Force phasing of reads even if a HP tag is present.
    inputBinding:
      position: 101
      prefix: -P
  - id: indel_penalty
    type:
      - 'null'
      - float
    doc: Penalty of indel in dynamic programming (double)
    inputBinding:
      position: 101
      prefix: -d
  - id: input_bam
    type:
      - 'null'
      - File
    doc: Input indexed bam file.
    inputBinding:
      position: 101
      prefix: -b
  - id: max_coverage
    type:
      - 'null'
      - int
    doc: Maximum coverage to call a tandem repeat.
    inputBinding:
      position: 101
      prefix: -C
  - id: max_locus_length
    type:
      - 'null'
      - int
    doc: Maximum length locus to compute annotation for (10000)
    inputBinding:
      position: 101
      prefix: -L
  - id: min_alt_coverage_snv
    type:
      - 'null'
      - int
    doc: Minimum alt coverage to allow a SNV to be called (3).
    inputBinding:
      position: 101
      prefix: -a
  - id: min_total_coverage_snv
    type:
      - 'null'
      - int
    doc: Minimum total coverage to allow a SNV to be called (6).
    inputBinding:
      position: 101
      prefix: -M
  - id: mismatch_penalty
    type:
      - 'null'
      - float
    doc: Penalty of mismatch in dynamic programming (double)
    inputBinding:
      position: 101
      prefix: -c
  - id: naive
    type:
      - 'null'
      - boolean
    doc: 'Specify the naive version of code to do the annotation, DEFAULT: faster
      implementation.'
    inputBinding:
      position: 101
      prefix: --naive
  - id: output_consensus
    type:
      - 'null'
      - boolean
    doc: Output assembly/read consensus sequence in each call.
    inputBinding:
      position: 101
      prefix: -S
  - id: output_reconstructed_tr
    type:
      - 'null'
      - boolean
    doc: Output reconstructed TR sequence from decomposition in each call.
    inputBinding:
      position: 101
      prefix: -E
  - id: phase_flank_reads
    type:
      - 'null'
      - int
    doc: Phase flank- how many bases on each side of a VNTR to collect SNVs to 
      phase (default=15000)
    inputBinding:
      position: 101
      prefix: -p
  - id: refine_reference
    type:
      - 'null'
      - File
    doc: Refine start and end pos by realigning to reference FILE (same as 
      mapped reference).
    inputBinding:
      position: 101
      prefix: -R
  - id: sample_name
    type:
      - 'null'
      - string
    doc: Sample name.
    inputBinding:
      position: 101
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads.
    inputBinding:
      position: 101
      prefix: -t
  - id: vntrs_region_motifs
    type:
      - 'null'
      - File
    doc: 'File containing region coordinate and motifs of each VNTR locus. The file
      format: columns `chrom,start,end,motifs` are tab-delimited. Column `motifs`
      is a comma-separated (no spaces) list of motifs for this VNTR.'
    inputBinding:
      position: 101
      prefix: -r
  - id: zero_based
    type:
      - 'null'
      - boolean
    doc: Treat input regions as zero based (e.g. TRExplorer catalog and standard
      BED files).
    inputBinding:
      position: 101
      prefix: -Z
outputs:
  - id: output_vcf
    type:
      - 'null'
      - File
    doc: Output vcf file.
    outputBinding:
      glob: $(inputs.output_vcf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vamos:3.0.6--h7f5d12c_0
