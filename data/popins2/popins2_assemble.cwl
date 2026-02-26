cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - popins2
  - assemble
label: popins2_assemble
doc: "Assembly of unmapped reads.\n\nTool homepage: https://github.com/kehrlab/PopIns2"
inputs:
  - id: bam_file
    type: File
    doc: BAM file containing reads to assemble.
    inputBinding:
      position: 1
  - id: adapters
    type:
      - 'null'
      - string
    doc: 'Enable adapter removal for Illumina reads. Default: no adapter removal.
      One of HiSeq and HiSeqX.'
    inputBinding:
      position: 102
      prefix: --adapters
  - id: filter
    type:
      - 'null'
      - int
    doc: Treat reads aligned to all but the first INT reference sequences after 
      remapping as high-quality aligned even if their alignment quality is low. 
      Recommended for non-human reference sequences.
    inputBinding:
      position: 102
      prefix: --filter
  - id: memory
    type:
      - 'null'
      - string
    doc: Maximum memory per thread for samtools sort; suffix K/M/G recognized.
    default: 768M
    inputBinding:
      position: 102
      prefix: --memory
  - id: prefix
    type:
      - 'null'
      - File
    doc: Path to the sample directories.
    default: .
    inputBinding:
      position: 102
      prefix: --prefix
  - id: reference
    type:
      - 'null'
      - File
    doc: 'Remap reads to this reference before assembly. Default: no remapping. Valid
      filetypes are: fa, fna, fasta, and gz.'
    inputBinding:
      position: 102
      prefix: --reference
  - id: sample
    type:
      - 'null'
      - string
    doc: 'An ID for the sample. Default: retrieval from BAM file header.'
    inputBinding:
      position: 102
      prefix: --sample
  - id: skip_assembly
    type:
      - 'null'
      - boolean
    doc: Skip assembly per sample.
    inputBinding:
      position: 102
      prefix: --skip-assembly
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for BWA and samtools sort. In range [1..inf].
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: use_spades
    type:
      - 'null'
      - boolean
    doc: 'Use the SPAdes assembler. Default: Minia.'
    inputBinding:
      position: 102
      prefix: --use-spades
  - id: use_velvet
    type:
      - 'null'
      - boolean
    doc: 'Use the velvet assembler. Default: Minia.'
    inputBinding:
      position: 102
      prefix: --use-velvet
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/popins2:0.13.0--h077b44d_0
stdout: popins2_assemble.out
