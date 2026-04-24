cwlVersion: v1.2
class: CommandLineTool
baseCommand: mvip_MVP_02_filter_genomad_checkv
label: mvip_MVP_02_filter_genomad_checkv
doc: "Merge and filter geNomad and CheckV outputs.\n\nTool homepage: https://gitlab.com/ccoclet/mvp"
inputs:
  - id: host_viral_genes_ratio
    type:
      - 'null'
      - float
    doc: the maximum ratio of host genes to viral genes required to consider a 
      row as a virus prediction
    inputBinding:
      position: 101
      prefix: --host_viral_genes_ratio
  - id: metadata_path
    type: File
    doc: Path to your metadata that you want to use to run MVP.
    inputBinding:
      position: 101
      prefix: --metadata
  - id: sample_group
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Specific sample number(s) to run the script on (can be a comma-separated
      list: 1,2,6 for example). By default, MVP processes all datasets listed in the
      metadata file one after the other.'
    inputBinding:
      position: 101
      prefix: --sample_group
  - id: viral_min_genes
    type:
      - 'null'
      - int
    doc: the minimum number of viral genes required to consider a row as a virus
      prediction
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
stdout: mvip_MVP_02_filter_genomad_checkv.out
