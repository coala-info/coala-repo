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
      - int
    doc: 1 includes reads info, 0 does not (just for evaluation). Default 1.
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
      of each concerned bacteria. It is staged writable, because localhgt writes
      index files beside it.
    inputBinding:
      position: 101
      prefix: -r
      valueFrom: $(self.basename)
  - id: refine_fastq
    type:
      - 'null'
      - int
    doc: 1 refines the input fastq file using fastp (recommended), 0 does not. Default 0.
    inputBinding:
      position: 101
      prefix: --refine_fq
  - id: retain_xa_tag
    type:
      - 'null'
      - int
    doc: 1 retains reads with the XA tag, 0 does not. Default 1.
    inputBinding:
      position: 101
      prefix: -a
  - id: sample_name
    type: string?
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
      - int
    doc: 1 uses kmers to extract the HGT-related segment, 0 uses the original reference. Default 1.
    inputBinding:
      position: 101
      prefix: --use_kmer
  - id: output_folder_path
    type: string?
    doc: Output folder.
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: output_folder
    type: Directory?
    doc: Output folder.
    outputBinding:
      glob: $(inputs.output_folder_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.reference_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/localhgt:1.0.1--h9948957_3
