cwlVersion: v1.2
class: CommandLineTool
baseCommand: munge_sumstats.py
label: ldsc_munge_sumstats.py
doc: "munge_sumstats.py is a script for munging summary statistics for LD Score Regression.\n\
  \nTool homepage: https://github.com/bulik/ldsc/"
inputs:
  - id: a1
    type:
      - 'null'
      - string
    doc: 'Name of A1 column (if not a name that ldsc understands). NB: case insensitive.'
    inputBinding:
      position: 101
      prefix: --a1
  - id: a1_inc
    type:
      - 'null'
      - boolean
    doc: A1 is the increasing allele.
    inputBinding:
      position: 101
      prefix: --a1-inc
  - id: a2
    type:
      - 'null'
      - string
    doc: 'Name of A2 column (if not a name that ldsc understands). NB: case insensitive.'
    inputBinding:
      position: 101
      prefix: --a2
  - id: chunksize
    type:
      - 'null'
      - int
    doc: Chunksize.
    inputBinding:
      position: 101
      prefix: --chunksize
  - id: daner
    type:
      - 'null'
      - boolean
    doc: Use this flag to parse Stephan Ripke's daner* file format.
    inputBinding:
      position: 101
      prefix: --daner
  - id: daner_n
    type:
      - 'null'
      - boolean
    doc: Use this flag to parse more recent daner* formatted files, which 
      include sample size column 'Nca' and 'Nco'.
    inputBinding:
      position: 101
      prefix: --daner-n
  - id: frq
    type:
      - 'null'
      - string
    doc: 'Name of FRQ or MAF column (if not a name that ldsc understands). NB: case
      insensitive.'
    inputBinding:
      position: 101
      prefix: --frq
  - id: ignore
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma-separated list of column names to ignore.
    inputBinding:
      position: 101
      prefix: --ignore
  - id: info
    type:
      - 'null'
      - string
    doc: 'Name of INFO column (if not a name that ldsc understands). NB: case insensitive.'
    inputBinding:
      position: 101
      prefix: --info
  - id: info_list
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Comma-separated list of INFO columns. Will filter on the mean. NB: case
      insensitive.'
    inputBinding:
      position: 101
      prefix: --info-list
  - id: info_min
    type:
      - 'null'
      - float
    doc: Minimum INFO score.
    inputBinding:
      position: 101
      prefix: --info-min
  - id: keep_maf
    type:
      - 'null'
      - boolean
    doc: Keep the MAF column (if one exists).
    inputBinding:
      position: 101
      prefix: --keep-maf
  - id: maf_min
    type:
      - 'null'
      - float
    doc: Minimum MAF.
    inputBinding:
      position: 101
      prefix: --maf-min
  - id: merge_alleles
    type:
      - 'null'
      - File
    doc: 'Same as --merge, except the file should have three columns: SNP, A1, A2,
      and all alleles will be matched to the --merge-alleles file alleles.'
    inputBinding:
      position: 101
      prefix: --merge-alleles
  - id: n
    type:
      - 'null'
      - int
    doc: Sample size If this option is not set, will try to infer the sample 
      size from the input file. If the input file contains a sample size column,
      and this flag is set, the argument to this flag has priority.
    inputBinding:
      position: 101
      prefix: --N
  - id: n_cas
    type:
      - 'null'
      - int
    doc: Number of cases. If this option is not set, will try to infer the 
      number of cases from the input file. If the input file contains a number 
      of cases column, and this flag is set, the argument to this flag has 
      priority.
    inputBinding:
      position: 101
      prefix: --N-cas
  - id: n_cas_col
    type:
      - 'null'
      - string
    doc: 'Name of N column (if not a name that ldsc understands). NB: case insensitive.'
    inputBinding:
      position: 101
      prefix: --N-cas-col
  - id: n_col
    type:
      - 'null'
      - string
    doc: 'Name of N column (if not a name that ldsc understands). NB: case insensitive.'
    inputBinding:
      position: 101
      prefix: --N-col
  - id: n_con
    type:
      - 'null'
      - int
    doc: Number of controls. If this option is not set, will try to infer the 
      number of controls from the input file. If the input file contains a 
      number of controls column, and this flag is set, the argument to this flag
      has priority.
    inputBinding:
      position: 101
      prefix: --N-con
  - id: n_con_col
    type:
      - 'null'
      - string
    doc: 'Name of N column (if not a name that ldsc understands). NB: case insensitive.'
    inputBinding:
      position: 101
      prefix: --N-con-col
  - id: n_min
    type:
      - 'null'
      - int
    doc: Minimum N (sample size). Default is (90th percentile N) / 2.
    default: (90th percentile N) / 2
    inputBinding:
      position: 101
      prefix: --n-min
  - id: no_alleles
    type:
      - 'null'
      - boolean
    doc: Don't require alleles. Useful if only unsigned summary statistics are 
      available and the goal is h2 / partitioned h2 estimation rather than rg 
      estimation.
    inputBinding:
      position: 101
      prefix: --no-alleles
  - id: nstudy
    type:
      - 'null'
      - string
    doc: 'Name of NSTUDY column (if not a name that ldsc understands). NB: case insensitive.'
    inputBinding:
      position: 101
      prefix: --nstudy
  - id: nstudy_min
    type:
      - 'null'
      - int
    doc: 'Minimum # of studies. Default is to remove everything below the max, unless
      there is an N column, in which case do nothing.'
    inputBinding:
      position: 101
      prefix: --nstudy-min
  - id: out
    type:
      - 'null'
      - string
    doc: Output filename prefix.
    inputBinding:
      position: 101
      prefix: --out
  - id: p
    type:
      - 'null'
      - string
    doc: 'Name of p-value column (if not a name that ldsc understands). NB: case insensitive.'
    inputBinding:
      position: 101
      prefix: --p
  - id: signed_sumstats
    type:
      - 'null'
      - string
    doc: 'Name of signed sumstat column, comma null value (e.g., Z,0 or OR,1). NB:
      case insensitive.'
    inputBinding:
      position: 101
      prefix: --signed-sumstats
  - id: snp
    type:
      - 'null'
      - string
    doc: 'Name of SNP column (if not a name that ldsc understands). NB: case insensitive.'
    inputBinding:
      position: 101
      prefix: --snp
  - id: sumstats
    type:
      - 'null'
      - File
    doc: Input filename.
    inputBinding:
      position: 101
      prefix: --sumstats
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ldsc:1.0.1--py_0
stdout: ldsc_munge_sumstats.py.out
