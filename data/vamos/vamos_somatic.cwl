cwlVersion: v1.2
class: CommandLineTool
baseCommand: vamos
label: vamos_somatic
doc: "Vamos is a tool for VNTR analysis.\n\nTool homepage: https://github.com/ChaissonLab/vamos"
inputs:
  - id: subcommand
    type: string
    doc: Subcommand to run (contig, read, somatic, or -m for version)
    inputBinding:
      position: 1
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print out debug information.
    inputBinding:
      position: 102
      prefix: --debug
  - id: force_phasing
    type:
      - 'null'
      - boolean
    doc: Force phasing of reads even if a HP tag is present.
    inputBinding:
      position: 102
      prefix: -P
  - id: indel_penalty
    type:
      - 'null'
      - float
    doc: Penalty of indel in dynamic programming (double).
    default: 1.0
    inputBinding:
      position: 102
      prefix: -d
  - id: input_bam
    type:
      - 'null'
      - File
    doc: Input indexed bam file.
    inputBinding:
      position: 102
      prefix: -b
  - id: max_coverage_call_repeat
    type:
      - 'null'
      - int
    doc: Maximum coverage to call a tandem repeat.
    inputBinding:
      position: 102
      prefix: -C
  - id: max_locus_length
    type:
      - 'null'
      - int
    doc: Maximum length locus to compute annotation for.
    default: 10000
    inputBinding:
      position: 102
      prefix: -L
  - id: min_alt_coverage_snv
    type:
      - 'null'
      - int
    doc: Minimum alt coverage to allow a SNV to be called.
    inputBinding:
      position: 102
      prefix: -a
  - id: min_total_coverage_snv
    type:
      - 'null'
      - int
    doc: Minimum total coverage to allow a SNV to be called.
    inputBinding:
      position: 102
      prefix: -M
  - id: mismatch_penalty
    type:
      - 'null'
      - float
    doc: Penalty of mismatch in dynamic programming (double).
    default: 1.0
    inputBinding:
      position: 102
      prefix: -c
  - id: naive_implementation
    type:
      - 'null'
      - boolean
    doc: 'Specify the naive version of code to do the annotation, DEFAULT: faster
      implementation.'
    inputBinding:
      position: 102
      prefix: --naive
  - id: output_consensus_sequence
    type:
      - 'null'
      - boolean
    doc: Output assembly/read consensus sequence in each call.
    inputBinding:
      position: 102
      prefix: -S
  - id: output_reconstructed_sequence
    type:
      - 'null'
      - boolean
    doc: Output reconstructed TR sequence from decomposition in each call.
    inputBinding:
      position: 102
      prefix: -E
  - id: phase_flank
    type:
      - 'null'
      - int
    doc: 'Range of flanking sequences which is used in the phasing step. DEFAULT:
      15000 bps.'
    default: 15000
    inputBinding:
      position: 102
      prefix: -p
  - id: reference_file
    type:
      - 'null'
      - File
    doc: Refine start and end pos by realigning to reference FILE (same as 
      mapped reference).
    inputBinding:
      position: 102
      prefix: -R
  - id: sample_name
    type:
      - 'null'
      - string
    doc: Sample name.
    inputBinding:
      position: 102
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads.
    default: 1
    inputBinding:
      position: 102
      prefix: -t
  - id: version_motif_set
    type:
      - 'null'
      - boolean
    doc: Display version of efficient motif set.
    inputBinding:
      position: 102
      prefix: -m
  - id: vntrs_region_motifs
    type:
      - 'null'
      - File
    doc: 'File containing region coordinate and motifs of each VNTR locus. The file
      format: columns `chrom,start,end,motifs` are tab-delimited. Column `motifs`
      is a comma-separated (no spaces) list of motifs for this VNTR.'
    inputBinding:
      position: 102
      prefix: -r
  - id: zero_based
    type:
      - 'null'
      - boolean
    doc: Treat input regions as zero based (e.g. TRExplorer catalog and standard
      BED files).
    inputBinding:
      position: 102
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
