cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - localhgt
  - bkp
label: localhgt_bkp
doc: "Detect HGT breakpoints from metagenomic sequencing data.\n\nTool homepage: https://github.com/samtools/samtools"
inputs:
  - id: fq1
    type: File
    doc: Uncompressed fastq 1 file.
    inputBinding:
      position: 101
      prefix: --fq1
  - id: fq2
    type: File
    doc: Uncompressed fastq 2 file.
    inputBinding:
      position: 101
      prefix: --fq2
  - id: hit_ratio
    type:
      - 'null'
      - float
    doc: minimum fuzzy kmer match ratio to extract a reference fragment.
    inputBinding:
      position: 101
      prefix: --hit_ratio
  - id: include_read_info
    type:
      - 'null'
      - boolean
    doc: 1 indicates including reads info, 0 indicates not (just for 
      evaluation).
    inputBinding:
      position: 101
      prefix: --read_info
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: kmer length.
    inputBinding:
      position: 101
      prefix: -k
  - id: match_ratio
    type:
      - 'null'
      - float
    doc: minimum exact kmer match ratio to extract a reference fragment.
    inputBinding:
      position: 101
      prefix: --match_ratio
  - id: max_peak
    type:
      - 'null'
      - int
    doc: maximum candidate BKP count.
    inputBinding:
      position: 101
      prefix: --max_peak
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: minimum read mapping quality in BAM.
    inputBinding:
      position: 101
      prefix: -q
  - id: num_hash_functions
    type:
      - 'null'
      - int
    doc: number of hash functions (1-9).
    inputBinding:
      position: 101
      prefix: -e
  - id: reference_file
    type: File
    doc: Uncompressed reference file, which contains the representative genome 
      of each concerned bacteria.
    inputBinding:
      position: 101
      prefix: -r
  - id: refine_fastq
    type:
      - 'null'
      - boolean
    doc: 1 indicates refine the input fastq file using fastp (recommended).
    inputBinding:
      position: 101
      prefix: --refine_fq
  - id: retain_xa_tag
    type:
      - 'null'
      - boolean
    doc: 1 indicates retain reads with XA tag.
    inputBinding:
      position: 101
      prefix: -a
  - id: sample_name
    type: string
    doc: Sample name.
    inputBinding:
      position: 101
      prefix: -s
  - id: sample_proportion_or_count
    type:
      - 'null'
      - float
    doc: 'down-sample in kmer counting: (0-1) means sampling proportion, (>1) means
      sampling base count (bp).'
    inputBinding:
      position: 101
      prefix: --sample
  - id: seed
    type:
      - 'null'
      - int
    doc: seed to initialize a pseudorandom number generator.
    inputBinding:
      position: 101
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads.
    inputBinding:
      position: 101
      prefix: -t
  - id: use_kmer
    type:
      - 'null'
      - boolean
    doc: 1 means using kmer to extract HGT-related segment, 0 means using 
      original reference.
    inputBinding:
      position: 101
      prefix: --use_kmer
outputs:
  - id: output_folder
    type: Directory
    doc: Output folder.
    outputBinding:
      glob: $(inputs.output_folder)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/localhgt:1.0.1--h9948957_3
