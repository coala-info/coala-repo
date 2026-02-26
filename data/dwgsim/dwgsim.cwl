cwlVersion: v1.2
class: CommandLineTool
baseCommand: dwgsim
label: dwgsim
doc: "short read simulator\n\nTool homepage: https://github.com/nh13/DWGSIM"
inputs:
  - id: in_ref_fa
    type: File
    doc: Input reference FASTA file
    inputBinding:
      position: 1
  - id: out_prefix
    type: string
    doc: Output prefix for generated files
    inputBinding:
      position: 2
  - id: base_quality_stddev
    type:
      - 'null'
      - float
    doc: standard deviation of the base quality scores
    default: 2.0
    inputBinding:
      position: 103
      prefix: -Q
  - id: candidate_mutations_bed_file
    type:
      - 'null'
      - File
    doc: the bed-like file set of candidate mutations
    inputBinding:
      position: 103
      prefix: -b
  - id: candidate_mutations_vcf_file
    type:
      - 'null'
      - File
    doc: the vcf file set of candidate mutations (use pl tag for strand)
    inputBinding:
      position: 103
      prefix: -v
  - id: distance_stddev
    type:
      - 'null'
      - int
    doc: standard deviation of the distance for pairs
    default: 50
    inputBinding:
      position: 103
      prefix: -s
  - id: error_rate_read1
    type:
      - 'null'
      - float
    doc: per base/color/flow error rate of the first read
    default: 0.02
    inputBinding:
      position: 103
      prefix: -e
  - id: error_rate_read2
    type:
      - 'null'
      - float
    doc: per base/color/flow error rate of the second read
    default: 0.02
    inputBinding:
      position: 103
      prefix: -E
  - id: fastq_output_type
    type:
      - 'null'
      - int
    doc: 'output type for the FASTQ files: 0: interleaved (bfast) and per-read-end
      (bwa), 1: per-read-end (bwa) only, 2: interleaved (bfast) only'
    default: 0
    inputBinding:
      position: 103
      prefix: -o
  - id: fixed_base_quality
    type:
      - 'null'
      - string
    doc: a fixed base quality to apply (single character)
    inputBinding:
      position: 103
      prefix: -q
  - id: generate_mutations_file_only
    type:
      - 'null'
      - boolean
    doc: generate a mutations file only
    default: false
    inputBinding:
      position: 103
      prefix: -M
  - id: haploid_mode
    type:
      - 'null'
      - boolean
    doc: haploid mode
    default: false
    inputBinding:
      position: 103
      prefix: -H
  - id: indel_extension_probability
    type:
      - 'null'
      - float
    doc: probability an indel is extended
    default: 0.3
    inputBinding:
      position: 103
      prefix: -X
  - id: indel_fraction
    type:
      - 'null'
      - float
    doc: fraction of mutations that are indels
    default: 0.1
    inputBinding:
      position: 103
      prefix: -R
  - id: ion_torrent_flow_order
    type:
      - 'null'
      - string
    doc: the flow order for Ion Torrent data
    inputBinding:
      position: 103
      prefix: -f
  - id: max_ns_per_read
    type:
      - 'null'
      - int
    doc: maximum number of Ns allowed in a given read
    default: 0
    inputBinding:
      position: 103
      prefix: -n
  - id: mean_coverage
    type:
      - 'null'
      - float
    doc: mean coverage across available positions (-1 to disable)
    default: 100.0
    inputBinding:
      position: 103
      prefix: -C
  - id: min_indel_length
    type:
      - 'null'
      - int
    doc: the minimum length indel
    default: 1
    inputBinding:
      position: 103
      prefix: -I
  - id: mutation_rate
    type:
      - 'null'
      - float
    doc: rate of mutations
    default: 0.001
    inputBinding:
      position: 103
      prefix: -r
  - id: mutations_txt_file
    type:
      - 'null'
      - File
    doc: the mutations txt file to re-create
    inputBinding:
      position: 103
      prefix: -m
  - id: num_read_pairs
    type:
      - 'null'
      - int
    doc: number of read pairs (-1 to disable)
    default: -1
    inputBinding:
      position: 103
      prefix: -N
  - id: outer_distance
    type:
      - 'null'
      - int
    doc: outer distance between the two ends for pairs
    default: 500
    inputBinding:
      position: 103
      prefix: -d
  - id: paired_end_orientation
    type:
      - 'null'
      - int
    doc: 'generate paired end reads with orientation: 0: default, 1: same strand,
      2: opposite strand'
    default: 0
    inputBinding:
      position: 103
      prefix: -S
  - id: random_dna_read_probability
    type:
      - 'null'
      - float
    doc: probability of a random DNA read
    default: 0.05
    inputBinding:
      position: 103
      prefix: -y
  - id: random_seed
    type:
      - 'null'
      - int
    doc: random seed (-1 uses the current time)
    default: -1
    inputBinding:
      position: 103
      prefix: -z
  - id: read1_genomic_strand
    type:
      - 'null'
      - int
    doc: 'generate paired end reads with read one: 0: default, 1: forward genomic
      strand, 2: reverse genomic strand'
    default: 0
    inputBinding:
      position: 103
      prefix: -A
  - id: read1_length
    type:
      - 'null'
      - int
    doc: length of the first read
    default: 70
    inputBinding:
      position: 103
      prefix: '-1'
  - id: read2_length
    type:
      - 'null'
      - int
    doc: length of the second read
    default: 70
    inputBinding:
      position: 103
      prefix: '-2'
  - id: read_prefix
    type:
      - 'null'
      - string
    doc: a read prefix to prepend to each read name
    inputBinding:
      position: 103
      prefix: -P
  - id: regions_to_cover_bed
    type:
      - 'null'
      - File
    doc: the bed of regions to cover
    inputBinding:
      position: 103
      prefix: -x
  - id: somatic_mutation_frequency
    type:
      - 'null'
      - float
    doc: frequency of given mutation to simulate low fequency somatic mutations
    default: 0.5
    inputBinding:
      position: 103
      prefix: -F
  - id: technology_type
    type:
      - 'null'
      - int
    doc: 'generate reads for: 0: Illumina, 1: SOLiD, 2: Ion Torrent'
    default: 0
    inputBinding:
      position: 103
      prefix: -c
  - id: use_inner_distance
    type:
      - 'null'
      - boolean
    doc: use the inner distance instead of the outer distance for pairs
    default: false
    inputBinding:
      position: 103
      prefix: -i
  - id: use_per_base_error_rate_ion_torrent
    type:
      - 'null'
      - boolean
    doc: use a per-base error rate for Ion Torrent data
    default: false
    inputBinding:
      position: 103
      prefix: -B
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dwgsim:1.1.14--h96c455f_2
stdout: dwgsim.out
