cwlVersion: v1.2
class: CommandLineTool
baseCommand: gsmap_format_sumstats
label: gsmap_format_sumstats
doc: "Format GWAS summary statistics for use with gsMap.\n\nTool homepage: https://github.com/LeonSong1995/gsMap"
inputs:
  - id: a1
    type:
      - 'null'
      - string
    doc: Name of effect allele column (if not a name that gsMap understands)
    inputBinding:
      position: 101
      prefix: --a1
  - id: a2
    type:
      - 'null'
      - string
    doc: Name of none-effect allele column (if not a name that gsMap 
      understands)
    inputBinding:
      position: 101
      prefix: --a2
  - id: beta
    type:
      - 'null'
      - string
    doc: Name of gwas beta column (if not a name that gsMap understands).
    inputBinding:
      position: 101
      prefix: --beta
  - id: chr
    type:
      - 'null'
      - string
    doc: Name of SNP chromosome column (if not a name that gsMap understands)
    inputBinding:
      position: 101
      prefix: --chr
  - id: chunksize
    type:
      - 'null'
      - int
    doc: Chunk size for loading dbsnp file
    inputBinding:
      position: 101
      prefix: --chunksize
  - id: dbsnp
    type:
      - 'null'
      - File
    doc: Path to reference dnsnp file
    inputBinding:
      position: 101
      prefix: --dbsnp
  - id: format
    type:
      - 'null'
      - string
    doc: Format of output data
    inputBinding:
      position: 101
      prefix: --format
  - id: frq
    type:
      - 'null'
      - string
    doc: Name of A1 ferquency column (if not a name that gsMap understands)
    inputBinding:
      position: 101
      prefix: --frq
  - id: info
    type:
      - 'null'
      - string
    doc: Name of info column (if not a name that gsMap understands)
    inputBinding:
      position: 101
      prefix: --info
  - id: info_min
    type:
      - 'null'
      - float
    doc: Minimum INFO score.
    inputBinding:
      position: 101
      prefix: --info_min
  - id: keep_chr_pos
    type:
      - 'null'
      - boolean
    doc: Keep SNP chromosome and position columns in the output data
    inputBinding:
      position: 101
      prefix: --keep_chr_pos
  - id: maf_min
    type:
      - 'null'
      - float
    doc: Minimum MAF.
    inputBinding:
      position: 101
      prefix: --maf_min
  - id: n
    type:
      - 'null'
      - string
    doc: Name of sample size column (if not a name that gsMap understands)
    inputBinding:
      position: 101
      prefix: --n
  - id: or_val
    type:
      - 'null'
      - string
    doc: Name of gwas OR column (if not a name that gsMap understands)
    inputBinding:
      position: 101
      prefix: --OR
  - id: p
    type:
      - 'null'
      - string
    doc: Name of p-value column (if not a name that gsMap understands)
    inputBinding:
      position: 101
      prefix: --p
  - id: pos
    type:
      - 'null'
      - string
    doc: Name of SNP positions column (if not a name that gsMap understands)
    inputBinding:
      position: 101
      prefix: --pos
  - id: se
    type:
      - 'null'
      - string
    doc: Name of gwas standar error of beta column (if not a name that gsMap 
      understands)
    inputBinding:
      position: 101
      prefix: --se
  - id: se_or
    type:
      - 'null'
      - string
    doc: Name of standar error of OR column (if not a name that gsMap 
      understands)
    inputBinding:
      position: 101
      prefix: --se_OR
  - id: snp
    type:
      - 'null'
      - string
    doc: Name of snp column (if not a name that gsMap understands)
    inputBinding:
      position: 101
      prefix: --snp
  - id: sumstats
    type: File
    doc: Path to gwas summary data
    inputBinding:
      position: 101
      prefix: --sumstats
  - id: z
    type:
      - 'null'
      - string
    doc: Name of gwas Z-statistics column (if not a name that gsMap understands)
    inputBinding:
      position: 101
      prefix: --z
outputs:
  - id: out
    type: File
    doc: Path to save the formatted gwas data
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gsmap:1.73.7--pyhdfd78af_0
