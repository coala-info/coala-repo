cwlVersion: v1.2
class: CommandLineTool
baseCommand: svtk_bedcluster
label: svtk_bedcluster
doc: "Cluster a bed of structural variants based on reciprocal overlap.\n\nTool homepage:
  https://github.com/talkowski-lab/svtk"
inputs:
  - id: bed
    type: File
    doc: 'SV calls to cluster. Columns: #chr, start, end, name, sample, svtype'
    inputBinding:
      position: 1
  - id: frac
    type:
      - 'null'
      - float
    doc: Minimum reciprocal overlap fraction to link variants.
    inputBinding:
      position: 102
      prefix: --frac
  - id: intersection
    type:
      - 'null'
      - File
    doc: Pre-computed self-intersection of bed.
    inputBinding:
      position: 102
      prefix: --intersection
  - id: merge_coordinates
    type:
      - 'null'
      - boolean
    doc: Report median of start and end positions in each cluster as final 
      coordinates of cluster.
    inputBinding:
      position: 102
      prefix: --merge-coordinates
  - id: prefix
    type:
      - 'null'
      - string
    doc: Cluster ID prefix
    inputBinding:
      position: 102
      prefix: --prefix
  - id: region
    type:
      - 'null'
      - string
    doc: Region to cluster (chrom:start-end). Requires tabixed bed.
    inputBinding:
      position: 102
      prefix: --region
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: Temporary directory
    inputBinding:
      position: 102
      prefix: --tmpdir
outputs:
  - id: fout
    type:
      - 'null'
      - File
    doc: Clustered bed.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svtk:0.0.20190615--py39hbcbf7aa_7
