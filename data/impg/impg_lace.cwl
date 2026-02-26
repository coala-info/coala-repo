cwlVersion: v1.2
class: CommandLineTool
baseCommand: impg_lace
label: impg_lace
doc: "Lace files together (graphs or VCFs)\n\nTool homepage: https://github.com/pangenome/impg"
inputs:
  - id: compress
    type:
      - 'null'
      - string
    doc: Output compression format (none, gzip, bgzip, zstd, auto)
    default: auto
    inputBinding:
      position: 101
      prefix: --compress
  - id: file_list
    type:
      - 'null'
      - File
    doc: Text file containing input file paths (one per line)
    inputBinding:
      position: 101
      prefix: --file-list
  - id: fill_gaps
    type:
      - 'null'
      - int
    doc: 'Gap filling mode: 0=none, 1=middle gaps only, 2=all gaps (requires --sequence-files
      or --sequence-list for end gaps, GFA mode only)'
    default: 0
    inputBinding:
      position: 101
      prefix: --fill-gaps
  - id: format
    type:
      - 'null'
      - string
    doc: Input file format (gfa, vcf, auto)
    default: auto
    inputBinding:
      position: 101
      prefix: --format
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: List of input files (space-separated)
    inputBinding:
      position: 101
      prefix: --files
  - id: reference
    type:
      - 'null'
      - File
    doc: Reference (FASTA or AGC) file for validating contig lengths in VCF 
      files
    inputBinding:
      position: 101
      prefix: --reference
  - id: sequence_files
    type:
      - 'null'
      - type: array
        items: File
    doc: List of sequence file paths (FASTA or AGC) (required for 'gfa', 'maf', 
      and 'fasta')
    inputBinding:
      position: 101
      prefix: --sequence-files
  - id: sequence_list
    type:
      - 'null'
      - File
    doc: Path to a text file containing paths to sequence files (FASTA or AGC) 
      (required for 'gfa', 'maf', and 'fasta')
    inputBinding:
      position: 101
      prefix: --sequence-list
  - id: skip_validation
    type:
      - 'null'
      - boolean
    doc: Skip path range length validation (faster but may miss data integrity 
      issues)
    inputBinding:
      position: 101
      prefix: --skip-validation
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: Directory for temporary files
    inputBinding:
      position: 101
      prefix: --temp-dir
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads for parallel processing
    default: 4
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - int
    doc: Verbosity level (0 = error, 1 = info, 2 = debug)
    default: 0
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type: File
    doc: Output file path
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/impg:0.3.3--hdb3fbb7_0
