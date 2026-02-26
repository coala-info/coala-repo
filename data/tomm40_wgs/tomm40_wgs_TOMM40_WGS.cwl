cwlVersion: v1.2
class: CommandLineTool
baseCommand: TOMM40_WGS
label: tomm40_wgs_TOMM40_WGS
doc: "Genotyping TOMM40'523 Poly-T Polymorphisms Using Whole-Genome Sequencing\n\n\
  Tool homepage: https://github.com/RushAlz/TOMM40_WGS/"
inputs:
  - id: conda_create_envs_only
    type:
      - 'null'
      - boolean
    doc: Only creates the job-specific conda environments then exits
    inputBinding:
      position: 101
      prefix: --conda-create-envs-only
  - id: configfile
    type:
      - 'null'
      - File
    doc: 'YAML configuration file (default: config.yaml in script directory).'
    default: config.yaml
    inputBinding:
      position: 101
      prefix: --configfile
  - id: cores
    type:
      - 'null'
      - int
    doc: 'Number of cores to use (default: 1).'
    default: 1
    inputBinding:
      position: 101
      prefix: --cores
  - id: dryrun
    type:
      - 'null'
      - boolean
    doc: Do not execute anything
    inputBinding:
      position: 101
      prefix: --dryrun
  - id: genome_build
    type:
      - 'null'
      - string
    doc: Genome build.
    inputBinding:
      position: 101
      prefix: --genome_build
  - id: input_table
    type:
      - 'null'
      - File
    doc: TSV file with columns 'sample_id' and 'path' listing input files.
    inputBinding:
      position: 101
      prefix: --input_table
  - id: input_wgs
    type:
      - 'null'
      - type: array
        items: File
    doc: Input BAM/CRAM file(s). Can be a single file, glob pattern ("*.cram"; 
      quotes are mandatory).
    inputBinding:
      position: 101
      prefix: --input_wgs
  - id: keep_going
    type:
      - 'null'
      - boolean
    doc: Continue with independent jobs if a job fails
    inputBinding:
      position: 101
      prefix: --keep-going
  - id: ref_fasta
    type:
      - 'null'
      - File
    doc: Reference genome FASTA file.
    inputBinding:
      position: 101
      prefix: --ref_fasta
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tomm40_wgs:1.0.1--hdfd78af_0
