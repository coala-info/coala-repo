cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - odgi
  - pav
label: odgi_pav
doc: "Presence/absence variants (PAVs). It prints to stdout a TSV table with the 'PAV
  ratios'. For a given path range 'PR' and path 'P', the 'PAV ratio' is the ratio
  between the sum of the lengths of the nodes in 'PR' that are crossed by 'P' divided
  by the sum of the lengths of all the nodes in 'PR'. Each node is considered only
  once.\n\nTool homepage: https://github.com/vgteam/odgi"
inputs:
  - id: bed_file
    type: File
    doc: Find PAVs in the path range(s) specified in the given BED FILE.
    inputBinding:
      position: 101
      prefix: --bed-file
  - id: binary_values
    type:
      - 'null'
      - float
    doc: Print 1 if the PAV ratio is greater than or equal to the specified 
      THRESHOLD, else 0.
    inputBinding:
      position: 101
      prefix: --binary-values
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
  - id: matrix_output
    type:
      - 'null'
      - boolean
    doc: Emit the PAV ratios in a matrix, with path ranges as rows and 
      paths/groups as columns.
    inputBinding:
      position: 101
      prefix: --matrix-output
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
stdout: odgi_pav.out
