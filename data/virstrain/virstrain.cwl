cwlVersion: v1.2
class: CommandLineTool
baseCommand: VirStrain.py
label: virstrain
doc: "An RNA virus strain-level identification tool for short reads.\n\nTool homepage:
  https://github.com/liaoherui/VirStrain"
inputs:
  - id: close_fig
    type:
      - 'null'
      - int
    doc: 'If set to 1, then VirStrain will not generate figures. (default: 0)'
    inputBinding:
      position: 101
      prefix: --turn_off_figures
  - id: db_dir
    type: Directory
    doc: Database dir --- Required
    inputBinding:
      position: 101
      prefix: --database_dir
  - id: hm_virus
    type:
      - 'null'
      - string
    doc: 'If the virus has high mutation rate, use this option. (default: Not use)'
    inputBinding:
      position: 101
      prefix: --high_mutation_virus
  - id: input_reads
    type: File
    doc: Input fastq data --- Required
    inputBinding:
      position: 101
      prefix: --input_reads
  - id: input_reads2
    type:
      - 'null'
      - File
    doc: Input fastq data for PE reads.
    inputBinding:
      position: 101
      prefix: --input_reads2
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: 'Output dir (default: current dir/VirStrain_Out)'
    inputBinding:
      position: 101
      prefix: --output_dir
  - id: rk_site
    type:
      - 'null'
      - int
    doc: 'If set to 1, then VirStrain will sort the most possible strain by matches
      to the sites. (default: 0)'
    inputBinding:
      position: 101
      prefix: --rank_by_sites
  - id: sf_cutoff
    type:
      - 'null'
      - float
    doc: 'The cutoff of filtering one site (default: 0.05)'
    inputBinding:
      position: 101
      prefix: --site_filter_cutoff
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/virstrain:1.17--pyhdfd78af_1
stdout: virstrain.out
