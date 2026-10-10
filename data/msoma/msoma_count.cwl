cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - msoma
  - count
label: msoma_count
doc: "Create counts file from BAM file for somatic variant calling. Uses samtools and
  bamUtils piped implementation.\n\nTool homepage: https://github.com/AkeyLab/mSOMA"
inputs:
  - id: input_bam
    type: File
    doc: Input BAM file
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
    inputBinding:
      position: 200
  - id: fasta
    type: File
    doc: Path to reference fasta file
    secondaryFiles:
      - pattern: .fai
        required: false
    inputBinding:
      position: 101
      prefix: --fasta
  - id: bed
    type: File
    doc: Path to bed file for callable regions
    inputBinding:
      position: 101
      prefix: --bed
  - id: seq_length
    type: int
    doc: Read length
    inputBinding:
      position: 101
      prefix: --seq-length
  - id: output_path
    type:
      - 'null'
      - string
    doc: Path to write counts file
    inputBinding:
      position: 101
      prefix: --output
  - id: min_mq
    type:
      - 'null'
      - int
    doc: Minimum mapping quality
    inputBinding:
      position: 101
      prefix: --min-MQ
  - id: require_flags
    type:
      - 'null'
      - int
    doc: Require bitwise SAM flags
    inputBinding:
      position: 101
      prefix: --require-flags
  - id: exclude_flags
    type:
      - 'null'
      - int
    doc: Exclude bitwise SAM flags
    inputBinding:
      position: 101
      prefix: --exclude-flags
  - id: ntrim
    type:
      - 'null'
      - int
    doc: Number of bases to trim from both ends of the reads
    inputBinding:
      position: 101
      prefix: --ntrim
  - id: max_indel
    type:
      - 'null'
      - int
    doc: Maximum number of indel bases allowed in a read
    inputBinding:
      position: 101
      prefix: --max-indel
  - id: mismatch_frac
    type:
      - 'null'
      - float
    doc: Maximum fraction of mismatch bases allowed in a read
    inputBinding:
      position: 101
      prefix: --mismatch-frac
  - id: softclip_frac
    type:
      - 'null'
      - float
    doc: Maximum fraction of softclipped bases allowed in a read
    inputBinding:
      position: 101
      prefix: --softclip-frac
  - id: min_bq
    type:
      - 'null'
      - int
    doc: Minimum base quality for pileup
    inputBinding:
      position: 101
      prefix: --min-BQ
  - id: min_depth
    type:
      - 'null'
      - int
    doc: Minimum depth for pileup
    inputBinding:
      position: 101
      prefix: --min-depth
  - id: max_alt_allele
    type:
      - 'null'
      - int
    doc: Maximum number of alternate alleles allowed per locus
    inputBinding:
      position: 101
      prefix: --max-alt-allele
  - id: qname_whitelist
    type:
      - 'null'
      - File
    doc: Path to QNAME whitelist file, only reads with QNAMEs in this file will be counted
    inputBinding:
      position: 101
      prefix: --qname-whitelist
  - id: mpileup_intermediate
    type:
      - 'null'
      - string
    doc: Path to write intermediate mpileup file for debugging, default is to not write
    inputBinding:
      position: 101
      prefix: --mpileup-intermediate
outputs:
  - id: counts_file
    type:
      - 'null'
      - File
    doc: Counts file
    outputBinding:
      glob: $(inputs.output_path)
  - id: mpileup_file
    type:
      - 'null'
      - File
    doc: Intermediate mpileup file
    outputBinding:
      glob: $(inputs.mpileup_intermediate)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msoma:0.1.2--pyhdfd78af_0
stdout: msoma_count.out
