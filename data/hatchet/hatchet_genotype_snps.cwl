cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hatchet
  - genotype-snps
label: hatchet_genotype_snps
doc: "Genotype and call SNPs in a matched-normal sample.

Tool homepage: https://github.com/raphael-group/hatchet"
inputs:
  - id: normal
    type: File
    secondaryFiles:
      - '.bai'
    doc: BAM file corresponding to matched normal sample
    inputBinding:
      position: 10
      prefix: -N
  - id: reference
    type: File
    secondaryFiles:
      - '.fai'
      - '^.dict'
    doc: Human reference genome of BAMs
    inputBinding:
      position: 10
      prefix: -r
  - id: samtools
    type:
      - 'null'
      - string
    doc: "Path to the directory to \"samtools\" executable (default: samtools is called as it is in $PATH)"
    inputBinding:
      position: 10
      prefix: -st
  - id: bcftools
    type:
      - 'null'
      - string
    doc: "Path to the directory of \"bcftools\" executable (default: bcftools is called as it is in $PATH)"
    inputBinding:
      position: 10
      prefix: -bt
  - id: snps
    type:
      - 'null'
      - File
    doc: "List of SNPs to consider in the normal sample (default: heterozygous SNPs are inferred from the normal sample)"
    inputBinding:
      position: 10
      prefix: -R
  - id: processes
    type:
      - 'null'
      - int
    doc: "Number of available parallel processes (default: 2)"
    inputBinding:
      position: 10
      prefix: -j
  - id: readquality
    type:
      - 'null'
      - int
    doc: "Minimum mapping quality for an aligned read to be considered (default: 0)"
    inputBinding:
      position: 10
      prefix: -q
  - id: basequality
    type:
      - 'null'
      - int
    doc: "Minimum base quality for a base to be considered (default: 11)"
    inputBinding:
      position: 10
      prefix: -Q
  - id: mincov
    type:
      - 'null'
      - int
    doc: "Minimum coverage for SNPs to be considered (default: 0)"
    inputBinding:
      position: 10
      prefix: -c
  - id: maxcov
    type:
      - 'null'
      - int
    doc: "Maximum coverage for SNPs to be considered (default: 1000, suggested: twice the values of expected average coverage)"
    inputBinding:
      position: 10
      prefix: -C
  - id: newbaq
    type:
      - 'null'
      - boolean
    doc: "Recompute alignment of reads on the fly during SNP calling (default: false)"
    inputBinding:
      position: 10
      prefix: -E
  - id: outputsnps
    type: string
    doc: Output folder for SNPs separated by chromosome (created in the working directory)
    inputBinding:
      position: 10
      prefix: -o
  - id: chromosomes
    type:
      - 'null'
      - type: array
        items: string
    doc: "One or more chromosomes to process (default: blank to process all chromosomes)"
    inputBinding:
      position: 10
      prefix: --chromosomes
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Use verbose log messages
    inputBinding:
      position: 10
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_snps
    type: Directory
    doc: Folder with one VCF of SNPs per chromosome
    outputBinding:
      glob: $(inputs.outputsnps)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.outputsnps)
        entry: '$({"class": "Directory", "basename": inputs.outputsnps, "listing": []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hatchet:2.1.2--py310h184ae93_0
stdout: hatchet_genotype_snps.out
