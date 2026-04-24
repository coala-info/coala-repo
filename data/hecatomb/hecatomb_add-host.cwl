cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hecatomb
  - add-host
label: hecatomb_add-host
doc: "Add a new host genome to use with Hecatomb\n\nTool homepage: https://github.com/shandley/hecatomb"
inputs:
  - id: snake_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional arguments for Snakemake
    inputBinding:
      position: 1
  - id: conda_prefix
    type:
      - 'null'
      - Directory
    doc: Custom conda env directory
    inputBinding:
      position: 102
      prefix: --conda-prefix
  - id: configfile
    type:
      - 'null'
      - string
    doc: Custom config file
    inputBinding:
      position: 102
      prefix: --configfile
  - id: host_fasta
    type: File
    doc: Host genome fasta file
    inputBinding:
      position: 102
      prefix: --host-fa
  - id: host_name
    type: string
    doc: Name for your host genome
    inputBinding:
      position: 102
      prefix: --host
  - id: no_use_conda
    type:
      - 'null'
      - boolean
    doc: Use conda for Snakemake rules
    inputBinding:
      position: 102
      prefix: --no-use-conda
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory
    inputBinding:
      position: 102
      prefix: --output
  - id: profile
    type:
      - 'null'
      - string
    doc: Snakemake profile
    inputBinding:
      position: 102
      prefix: --profile
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 102
      prefix: --threads
  - id: use_conda
    type:
      - 'null'
      - boolean
    doc: Use conda for Snakemake rules
    inputBinding:
      position: 102
      prefix: --use-conda
  - id: workflow_profile
    type:
      - 'null'
      - string
    doc: Custom config file
    inputBinding:
      position: 102
      prefix: --workflow-profile
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hecatomb:1.3.4--pyh7e72e81_0
stdout: hecatomb_add-host.out
