cwlVersion: v1.2
class: CommandLineTool
baseCommand: eqtlbma_avg_bfs
label: eqtlbma_eqtlbma_avg_bfs
doc: "Averages the raw BFs over the grid only, or over both the grid and the configurations, and can also compute posteriors.\n\nTool homepage: https://github.com/timflutre/eqtlbma"
inputs:
  - id: data_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input files, staged in the working directory so that names and patterns resolve
  - id: verbose
    type:
      - 'null'
      - int
    doc: "verbosity level (0/default=1/2/3)"
    inputBinding:
      position: 101
      prefix: --verbose
  - id: in_pattern
    type: string
    doc: "pattern to glob '_l10abfs_raw' files from 'eqtlbma_bf'"
    inputBinding:
      position: 101
      prefix: --in
  - id: gwts
    type:
      - 'null'
      - File
    doc: "file with grid weights (one per line, only the value)"
    inputBinding:
      position: 101
      prefix: --gwts
  - id: gtk
    type:
      - 'null'
      - string
    doc: "index/indices of grid weights to keep (all by default), e.g. '1+3+5+7+9'"
    inputBinding:
      position: 101
      prefix: --gtk
  - id: model
    type:
      - 'null'
      - string
    doc: "which model (default=configs/types)"
    inputBinding:
      position: 101
      prefix: --model
  - id: nsubgrp
    type:
      - 'null'
      - int
    doc: "number of subgroups"
    inputBinding:
      position: 101
      prefix: --nsubgrp
  - id: dim
    type:
      - 'null'
      - int
    doc: "dimension of the model (nb of active configs or types)"
    inputBinding:
      position: 101
      prefix: --dim
  - id: cwts
    type:
      - 'null'
      - File
    doc: "file with configuration weights (one per line, name<sep>value)"
    inputBinding:
      position: 101
      prefix: --cwts
  - id: tswts
    type:
      - 'null'
      - File
    doc: "file with type and subgroup weights (one per line, name<sep>value)"
    inputBinding:
      position: 101
      prefix: --tswts
  - id: save
    type:
      - 'null'
      - string
    doc: "precise what to save (bf/post/bf+post)"
    inputBinding:
      position: 101
      prefix: --save
  - id: pi0
    type:
      - 'null'
      - float
    doc: "proba for a gene to have no eQTL in any subgroup"
    inputBinding:
      position: 101
      prefix: --pi0
  - id: post
    type:
      - 'null'
      - string
    doc: "save various kinds of posterior probabilities (e.g. 'a+b')"
    inputBinding:
      position: 101
      prefix: --post
  - id: gene
    type:
      - 'null'
      - File
    doc: "file with subset of gene(s) to keep (one per line)"
    inputBinding:
      position: 101
      prefix: --gene
  - id: snp
    type:
      - 'null'
      - File
    doc: "file with subset of snp(s) to keep (one per line)"
    inputBinding:
      position: 101
      prefix: --snp
  - id: gene_snp
    type:
      - 'null'
      - File
    doc: "file with subset of gene-snp pair(s) to keep (gene<tab>snp, one per line)"
    inputBinding:
      position: 101
      prefix: --gene-snp
  - id: bestsnp
    type:
      - 'null'
      - int
    doc: "report the best SNP(s) per gene (0 all, 1 single best, 2 best SNPs up to 0.95 probability)"
    inputBinding:
      position: 101
      prefix: --bestsnp
  - id: bestdim
    type:
      - 'null'
      - boolean
    doc: "report the best config/type per SNP (and its posterior)"
    inputBinding:
      position: 101
      prefix: --bestdim
  - id: alldim
    type:
      - 'null'
      - boolean
    doc: "report also BF and/or posterior for all dimensions (configs or types)"
    inputBinding:
      position: 101
      prefix: --alldim
  - id: out_path
    type: string
    doc: "name of the output file (gzipped)"
    inputBinding:
      position: 101
      prefix: --out
  - id: thread
    type:
      - 'null'
      - int
    doc: "number of threads (default=1)"
    inputBinding:
      position: 101
      prefix: --thread
outputs:
  - id: out
    type: File
    doc: Output file (gzipped)
    outputBinding:
      glob: $(inputs.out_path)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: '$(inputs.data_files ? inputs.data_files : [])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eqtlbma:1.3.3--h3dbd7e7_0
stdout: eqtlbma_eqtlbma_avg_bfs.out
