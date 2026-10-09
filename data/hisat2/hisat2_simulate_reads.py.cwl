cwlVersion: v1.2
class: CommandLineTool
baseCommand: hisat2_simulate_reads.py
label: hisat2_simulate_reads.py
doc: "Simulate reads from GENOME (fasta) and GTF files\n\nTool homepage:
  https://daehwankimlab.github.io/hisat2"
inputs:
  - id: genome_file
    type: File
    doc: input GENOME file
    inputBinding:
      position: 1
  - id: gtf_file
    type: File
    doc: input GTF file
    inputBinding:
      position: 2
  - id: snp_file
    type: File
    doc: input SNP file
    inputBinding:
      position: 3
  - id: base_fname
    type: string
    doc: output base filename
    inputBinding:
      position: 4
  - id: dna
    type:
      - 'null'
      - boolean
    doc: 'DNA-seq reads (default: RNA-seq reads)'
    inputBinding:
      position: 0
      prefix: --dna
  - id: single_end
    type:
      - 'null'
      - boolean
    doc: 'single-end reads (default: paired-end reads)'
    inputBinding:
      position: 0
      prefix: --single-end
  - id: read_length
    type:
      - 'null'
      - int
    doc: 'read length (default: 100)'
    inputBinding:
      position: 0
      prefix: --read-length
  - id: fragment_length
    type:
      - 'null'
      - int
    doc: 'fragment length (default: 250)'
    inputBinding:
      position: 0
      prefix: --fragment-length
  - id: num_fragment
    type:
      - 'null'
      - int
    doc: 'number of fragments (default: 1000000)'
    inputBinding:
      position: 0
      prefix: --num-fragment
  - id: expr_profile
    type:
      - 'null'
      - string
    doc: 'expression profile: flux or constant (default: flux)'
    inputBinding:
      position: 0
      prefix: --expr-profile
  - id: repeat_info
    type:
      - 'null'
      - File
    doc: repeat information filename
    inputBinding:
      position: 0
      prefix: --repeat-info
  - id: error_rate
    type:
      - 'null'
      - float
    doc: 'per-base sequencing error rate (%) (default: 0.0)'
    inputBinding:
      position: 0
      prefix: --error-rate
  - id: max_mismatch
    type:
      - 'null'
      - int
    doc: 'max mismatches due to sequencing errors (default: 3)'
    inputBinding:
      position: 0
      prefix: --max-mismatch
  - id: random_seed
    type:
      - 'null'
      - int
    doc: 'random seeding value (default: 0)'
    inputBinding:
      position: 0
      prefix: --random-seed
  - id: snp_prob
    type:
      - 'null'
      - float
    doc: 'probability of a read including a snp when the read spans the snp ranging
      from 0.0 to 1.0 (default: 1.0)'
    inputBinding:
      position: 0
      prefix: --snp-prob
  - id: sanity_check
    type:
      - 'null'
      - boolean
    doc: sanity check
    inputBinding:
      position: 0
      prefix: --sanity-check
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: also print some statistics to stderr
    inputBinding:
      position: 0
      prefix: --verbose
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Simulated reads (FASTQ-like files) and read annotations
    outputBinding:
      glob: $(inputs.base_fname)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hisat2:2.2.3--h8471819_0
