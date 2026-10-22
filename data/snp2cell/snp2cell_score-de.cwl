cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - snp2cell
  - score-de
label: snp2cell_score-de
doc: "Add an anndata object to the s2c object, find differentially expressed genes and propagate the gene scores across the network. Then the DE scores and previously computed SNP scores are combined and statistics are computed based on random permutations.\n\nTool homepage: https://github.com/Teichlab/snp2cell"
inputs:
  - id: s2c_obj
    type: File
    doc: "path to SNP2CELL object (staged writable; the command updates it in place)"
    inputBinding:
      position: 1
  - id: anndata
    type: File
    doc: "path to anndata object"
    inputBinding:
      position: 2
  - id: groupby
    type:
      - 'null'
      - string
    doc: "`ad.obs` column with annotation for computing differential expression (default annot)"
    inputBinding:
      position: 3
  - id: run_lognorm
    type:
      - 'null'
      - boolean
    doc: log-normalise counts
    inputBinding:
      position: 4
      prefix: --run-lognorm
  - id: no_run_lognorm
    type:
      - 'null'
      - boolean
    doc: do not log-normalise counts (default)
    inputBinding:
      position: 4
      prefix: --no-run-lognorm
  - id: use_raw
    type:
      - 'null'
      - boolean
    doc: use `ad.raw` attribute
    inputBinding:
      position: 4
      prefix: --use-raw
  - id: no_use_raw
    type:
      - 'null'
      - boolean
    doc: do not use `ad.raw` attribute (default)
    inputBinding:
      position: 4
      prefix: --no-use-raw
  - id: group
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --group
          separate: true
    doc: "restrict to groups of `groupby`; may be set multiple times; default is to use all groups"
    inputBinding:
      position: 4
  - id: reference
    type:
      - 'null'
      - string
    doc: "reference group to compare against; default is to compare against the rest"
    inputBinding:
      position: 4
      prefix: --reference
  - id: method
    type:
      - 'null'
      - string
    doc: "method for DE calculation (default wilcoxon)"
    inputBinding:
      position: 4
      prefix: --method
  - id: rank_by
    type:
      - 'null'
      - string
    doc: "rank DE scores by absolute value, up- or downregulation: abs, up or down (default up)"
    inputBinding:
      position: 4
      prefix: --rank-by
  - id: snp_score_key
    type:
      - 'null'
      - string
    doc: "key for accessing saved snp scores in object (default snp_score)"
    inputBinding:
      position: 4
      prefix: --snp-score-key
  - id: n_cpu
    type:
      - 'null'
      - int
    doc: "number of cpus to use"
    inputBinding:
      position: 4
      prefix: --n-cpu
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr
    type: stderr
    doc: Standard error (log messages)
  - id: s2c_obj_out
    type: File
    doc: The SNP2CELL object after the command
    outputBinding:
      glob: $(inputs.s2c_obj.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.s2c_obj)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snp2cell:0.3.0--pyhdfd78af_0
stdout: snp2cell_score-de.out
stderr: snp2cell_score-de.err
