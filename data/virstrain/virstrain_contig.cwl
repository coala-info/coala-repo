cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - virstrain_contig
label: virstrain_contig
doc: "VirStrain strain-level identification from assembled contigs, using a contig
  database.\n\nTool homepage: https://github.com/liaoherui/VirStrain"
inputs:
  - id: input_contigs
    type: File
    doc: Input contig fasta data --- Required
    inputBinding:
      position: 1
      prefix: --input_contigs
  - id: db_dir
    type: Directory
    doc: Database dir --- Required
    inputBinding:
      position: 2
      prefix: --database_dir
  - id: out_dir
    type:
      - 'null'
      - string
    doc: 'Output dir (default: current dir/VirStrain_Out)'
    inputBinding:
      position: 3
      prefix: --output_dir
  - id: sf_cutoff
    type:
      - 'null'
      - float
    doc: 'The cutoff of filtering one site (default: 0.05)'
    inputBinding:
      position: 4
      prefix: --site_filter_cutoff
  - id: rk_site
    type:
      - 'null'
      - int
    doc: 'If set to 1, then VirStrain will sort the most possible strain by matches
      to the sites. (default: 0)'
    inputBinding:
      position: 5
      prefix: --rank_by_sites
  - id: hm_virus
    type:
      - 'null'
      - string
    doc: 'If the virus has high mutation rate, use this option. (default: Not use)'
    inputBinding:
      position: 6
      prefix: --high_mutation_virus
outputs:
  - id: out_dir_dir
    type:
      - 'null'
      - Directory
    doc: 'Output dir (default: current dir/VirStrain_Out)'
    outputBinding:
      glob: $(inputs.out_dir)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/virstrain:1.17--pyhdfd78af_1
stdout: virstrain_contig.out
