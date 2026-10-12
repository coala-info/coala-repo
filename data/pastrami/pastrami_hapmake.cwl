cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pastrami.py
  - hapmake
label: pastrami_hapmake
doc: "Create haplotypes\n\nTool homepage: https://github.com/healthdisparities/pastrami"
inputs:
  - id: map_dir
    type:
      - 'null'
      - Directory
    doc: "Directory containing genetic maps: chr1.map, chr2.map, etc"
    inputBinding:
      position: 101
      prefix: --map-dir
  - id: min_snps
    type:
      - 'null'
      - int
    doc: "Minimum number of SNPs in a haplotype block (default: 7)"
    inputBinding:
      position: 101
      prefix: --min-snps
  - id: max_snps
    type:
      - 'null'
      - int
    doc: "Maximum number of SNPs in a haplotype block (default: 20)"
    inputBinding:
      position: 101
      prefix: --max-snps
  - id: max_rate
    type:
      - 'null'
      - float
    doc: "Maximum recombination rate (default: 0.3)"
    inputBinding:
      position: 101
      prefix: --max-rate
  - id: log_file_path
    type:
      - 'null'
      - string
    doc: "File containing log information (default: run.log)"
    inputBinding:
      position: 102
      prefix: --log-file
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of concurrent threads (default: 4)"
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Print program progress information on screen"
    inputBinding:
      position: 101
      prefix: --verbose
  - id: haplotypes_path
    type: string
    doc: "Output file containing haplotypes (default: out.haplotypes)"
    inputBinding:
      position: 103
      prefix: --haplotypes
outputs:
  - id: haplotypes
    type: File
    doc: "Output file containing haplotypes"
    outputBinding:
      glob: $(inputs.haplotypes_path)
  - id: log_file
    type:
      - 'null'
      - File
    doc: "File containing log information"
    outputBinding:
      glob: $(inputs.log_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pastrami:1.0.1--pyh67a8953_0
