cwlVersion: v1.2
class: CommandLineTool
baseCommand: panacus_growth
label: panacus_growth
doc: "Calculate growth curve from coverage histogram\n\nTool homepage: https://github.com/marschall-lab/panacus"
inputs:
  - id: file
    type: File
    doc: EITHER graph in GFA1 format, accepts also compressed (.gz) file OR a 
      histogram as a .tsv
    inputBinding:
      position: 1
  - id: coverage
    type:
      - 'null'
      - type: array
        items: string
    doc: Ignore all countables with a coverage lower than the specified 
      threshold. The coverage of a countable corresponds to the number of 
      path/walk that contain it. Repeated appearances of a countable in the same
      path/walk are counted as one. You can pass a comma-separated list of 
      coverage thresholds, each one will produce a separated growth curve (e.g.,
      --coverage 2,3). Use --quorum to set a threshold in conjunction with each 
      coverage (e.g., --quorum 0.5,0.9)
    default: '1'
    inputBinding:
      position: 102
      prefix: --coverage
  - id: exclude
    type:
      - 'null'
      - File
    doc: Exclude bp/node/edge in growth count that intersect with paths 
      (1-column list) or path coordinates (3- or 12-column BED-file) provided by
      the given file; all intersecting bp/node/edge will be exluded also in 
      other paths not part of the given list (ONLY IN GFA MODE)
    inputBinding:
      position: 102
      prefix: --exclude
  - id: groupby
    type:
      - 'null'
      - File
    doc: Merge counts from paths by path-group mapping from given tab-separated 
      two-column file (ONLY IN GFA MODE)
    inputBinding:
      position: 102
      prefix: --groupby
  - id: groupby_haplotype
    type:
      - 'null'
      - boolean
    doc: Merge counts from paths belonging to same haplotype (ONLY IN GFA MODE)
    inputBinding:
      position: 102
      prefix: --groupby-haplotype
  - id: groupby_sample
    type:
      - 'null'
      - boolean
    doc: Merge counts from paths belonging to same sample (ONLY IN GFA MODE)
    inputBinding:
      position: 102
      prefix: --groupby-sample
  - id: include_histogram
    type:
      - 'null'
      - boolean
    doc: Also include histogram in output (ONLY IN GFA MODE)
    inputBinding:
      position: 102
      prefix: --hist
  - id: quorum
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Unlike the --coverage parameter, which specifies a minimum constant number
      of paths for all growth point m (1 <= m <= num_paths), --quorum adjust the threshold
      based on m. At each m, a countable is counted in the average growth if the countable
      is contained in at least floor(m*quorum) paths. Example: A quorum of 0.9 requires
      a countable to be in 90% of paths for each subset size m. At m=10, it must appear
      in at least 9 paths. At m=100, it must appear in at least 90 paths. A quorum
      of 1 (100%) requires presence in all paths of the subset, corresponding to the
      core. Default: 0, a countable counts if it is present in any path at each growth
      point. Specify multiple quorum values with a comma-separated list (e.g., --quorum
      0.5,0.9). Use --coverage to set static path thresholds in conjunction with variable
      quorum percentages (e.g., --coverage 5,10).'
    default: '0'
    inputBinding:
      position: 102
      prefix: --quorum
  - id: subset
    type:
      - 'null'
      - File
    doc: Produce counts by subsetting the graph to a given list of paths 
      (1-column list) or path coordinates (3- or 12-column BED file) (ONLY IN 
      GFA MODE)
    inputBinding:
      position: 102
      prefix: --subset
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Set the number of threads used (default: use all threads)'
    default: 0
    inputBinding:
      position: 102
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Set the number of threads used (default: use all threads)'
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panacus:0.4.1--hc1c3326_0
stdout: panacus_growth.out
