cwlVersion: v1.2
class: CommandLineTool
baseCommand: odgi_heaps
label: odgi_heaps
doc: "Extract matrix of path pangenome coverage permutations for power law regression.\n\
  \nTool homepage: https://github.com/vgteam/odgi"
inputs:
  - id: bed_targets
    type:
      - 'null'
      - File
    doc: BED file over path space of the graph, describing a subset of the graph
      to consider.
    inputBinding:
      position: 101
      prefix: --bed-targets
  - id: group_by_haplotype
    type:
      - 'null'
      - boolean
    doc: Following PanSN naming (sample#hap#ctg), group by haplotype (2nd 
      field).
    inputBinding:
      position: 101
      prefix: --group-by-haplotype
  - id: group_by_sample
    type:
      - 'null'
      - boolean
    doc: Following PanSN naming (sample#hap#ctg), group by sample (1st field).
    inputBinding:
      position: 101
      prefix: --group-by-sample
  - id: idx
    type: File
    doc: Load the succinct variation graph in ODGI format from this *FILE*. The 
      file name usually ends with *.og*. It also accepts GFAv1, but the 
      on-the-fly conversion to the ODGI format requires additional time!
    inputBinding:
      position: 101
      prefix: --idx
  - id: min_node_depth
    type:
      - 'null'
      - int
    doc: 'Exclude nodes with less than this path depth (default: 0).'
    inputBinding:
      position: 101
      prefix: --min-node-depth
  - id: n_permutations
    type:
      - 'null'
      - int
    doc: Number of permutations to run.
    inputBinding:
      position: 101
      prefix: --n-permutations
  - id: path_groups
    type:
      - 'null'
      - File
    doc: Group paths as described in two-column FILE, with columns path.name and
      group.name.
    inputBinding:
      position: 101
      prefix: --path-groups
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Write the current progress to stderr.
    inputBinding:
      position: 101
      prefix: --progress
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for parallel operations.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
stdout: odgi_heaps.out
