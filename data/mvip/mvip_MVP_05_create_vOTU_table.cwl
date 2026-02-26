cwlVersion: v1.2
class: CommandLineTool
baseCommand: mvip_MVP_05_create_vOTU_table
label: mvip_MVP_05_create_vOTU_table
doc: "Merge all the CoverM output tables and create a set of viral OTU tables based
  on the cutoffs (i.e., horizontal coverage) and filtration mode (i.e., conservative
  and relaxed).\n\nTool homepage: https://gitlab.com/ccoclet/mvp"
inputs:
  - id: covered_fraction
    type:
      - 'null'
      - type: array
        items: float
    doc: minimum covered fraction for filtering
    default: 0.1 0.5 0.9
    inputBinding:
      position: 101
      prefix: --covered_fraction
  - id: filtration
    type:
      - 'null'
      - string
    doc: Filtration level (relaxed or conservative).
    default: conservative
    inputBinding:
      position: 101
      prefix: --filtration
  - id: host_viral_genes_ratio
    type:
      - 'null'
      - float
    doc: the maximum ratio of host genes to viral genes required to consider a 
      row as a virus prediction
    default: 1
    inputBinding:
      position: 101
      prefix: --host_viral_genes_ratio
  - id: metadata_path
    type: File
    doc: Path to your metadata that you want to use to run MVP.
    inputBinding:
      position: 101
      prefix: --metadata
  - id: normalization
    type:
      - 'null'
      - string
    doc: Metrics to normalize
    inputBinding:
      position: 101
      prefix: --normalization
  - id: viral_min_genes
    type:
      - 'null'
      - int
    doc: the minimum number of viral genes required to consider a row as a virus
      prediction
    default: 1
    inputBinding:
      position: 101
      prefix: --viral_min_genes
  - id: working_directory_path
    type: Directory
    doc: Path to your working directory where you want to run MVP.
    inputBinding:
      position: 101
      prefix: --input
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mvip:1.1.5--pyhdfd78af_1
stdout: mvip_MVP_05_create_vOTU_table.out
