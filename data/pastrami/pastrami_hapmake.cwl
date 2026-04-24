cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pastrami.py
  - hapmake
label: pastrami_hapmake
doc: "Generate haplotype blocks based on genetic maps and SNP constraints\n\nTool
  homepage: https://github.com/healthdisparities/pastrami"
inputs:
  - id: map_dir
    type: Directory
    doc: 'Directory containing genetic maps: chr1.map, chr2.map, etc'
    inputBinding:
      position: 101
      prefix: --map-dir
  - id: max_rate
    type:
      - 'null'
      - float
    doc: Maximum recombination rate
    inputBinding:
      position: 101
      prefix: --max-rate
  - id: max_snps
    type:
      - 'null'
      - int
    doc: Maximum number of SNPs in a haplotype block
    inputBinding:
      position: 101
      prefix: --max-snps
  - id: min_snps
    type:
      - 'null'
      - int
    doc: Minimum number of SNPs in a haplotype block
    inputBinding:
      position: 101
      prefix: --min-snps
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of concurrent threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print program progress information on screen
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: haplotypes
    type:
      - 'null'
      - File
    doc: Output file containing haplotypes
    outputBinding:
      glob: $(inputs.haplotypes)
  - id: log_file
    type:
      - 'null'
      - File
    doc: File containing log information
    outputBinding:
      glob: $(inputs.log_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pastrami:1.0.1--pyh67a8953_0
