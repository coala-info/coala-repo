cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gfold
  - diff
label: gfold_diff
doc: "For each gene, calculate the GFOLD value and other statistics from the read
  count files written by gfold count (GFOLD, generalized fold change for ranking
  differentially expressed genes from RNA-seq data).\n\nTool homepage: https://zhanglab.tongji.edu.cn/softwares/GFOLD/index.html"
requirements:
  - class: InitialWorkDirRequirement
    listing: $(inputs.count_files)
inputs:
  - id: count_files
    type:
      type: array
      items: File
    doc: Read count files written by gfold count. Each file name must be a prefix
      from sample1 or sample2 followed by the suffix.
  - id: sample1
    type: string
    doc: The prefix for gene read count of the 1st group. Multiple prefixes are separated
      by commas
    inputBinding:
      position: 1
      prefix: -s1
  - id: sample2
    type: string
    doc: The prefix for gene read count of the 2nd group. Multiple prefixes are separated
      by commas
    inputBinding:
      position: 1
      prefix: -s2
  - id: suffix
    type: string
    doc: The suffix for gene read count file specified by sample1 and sample2
    inputBinding:
      position: 1
      prefix: -suf
  - id: description_file
    type:
      - 'null'
      - File
    doc: Gene description file. The first column holds gene descriptions and the
      second column holds gene IDs
    inputBinding:
      position: 1
      prefix: -d
  - id: accurate
    type:
      - 'null'
      - string
    doc: When no replicate is available, whether to use the accurate method to calculate
      the GFOLD value (T or F). Default T
    inputBinding:
      position: 1
      prefix: -acc
  - id: significance_cutoff
    type:
      - 'null'
      - double
    doc: The significant cutoff for fold change. Default 0.01
    inputBinding:
      position: 1
      prefix: -sc
  - id: burn_in
    type:
      - 'null'
      - int
    doc: For MCMC, the iterations for the burn-in phase. Default 1000
    inputBinding:
      position: 1
      prefix: -bi
  - id: sampling
    type:
      - 'null'
      - int
    doc: For MCMC, the iterations for the sampling phase. Default 1000
    inputBinding:
      position: 1
      prefix: -si
  - id: max_pairs
    type:
      - 'null'
      - int
    doc: The maximum number of selected pairs for calculating empirical FDR. Default
      20
    inputBinding:
      position: 1
      prefix: -r
  - id: normalization
    type:
      - 'null'
      - string
    doc: The way to do normalization (Count, DESeq or NO), or a comma separated list
      of normalization constants. Default DESeq
    inputBinding:
      position: 1
      prefix: -norm
  - id: verbose
    type:
      - 'null'
      - int
    doc: Verbose level. A larger value gives more information. Default 2
    inputBinding:
      position: 1
      prefix: -v
  - id: output_file_path
    type: string
    doc: The output file; a second file named <output>.ext is also written
    inputBinding:
      position: 2
      prefix: -o
outputs:
  - id: output_file
    type: File
    doc: GFOLD values per gene (GeneSymbol, GeneName, GFOLD, E-FDR, log2fdc, 1stRPKM,
      2ndRPKM)
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: output_ext_file
    type: File
    doc: Normalized read counts and gene description
    outputBinding:
      glob: $(inputs.output_file_path).ext
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfold:1.1.4--gsl1.16_1
