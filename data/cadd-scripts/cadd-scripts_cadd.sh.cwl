cwlVersion: v1.2
class: CommandLineTool
baseCommand: cadd-scripts_cadd.sh
label: cadd-scripts_cadd.sh
doc: "CADD version 1.7\n\nTool homepage: https://github.com/kircherlab/CADD-scripts"
inputs:
  - id: infile
    type: File
    doc: input vcf of vcf.gz file (required)
    inputBinding:
      position: 1
  - id: caddversion
    type:
      - 'null'
      - string
    doc: 'CADD version (only v1.7 possible with this set of scripts [default: v1.7])'
    inputBinding:
      position: 102
      prefix: -v
  - id: cores
    type:
      - 'null'
      - int
    doc: 'number of cores that snakemake is allowed to use [default: 1]'
    inputBinding:
      position: 102
      prefix: -c
  - id: genomebuild
    type:
      - 'null'
      - string
    doc: 'genome build (supported are GRCh37 and GRCh38 [default: GRCh38])'
    inputBinding:
      position: 102
      prefix: -g
  - id: include_annotation
    type:
      - 'null'
      - boolean
    doc: include annotation in output
    inputBinding:
      position: 102
      prefix: -a
  - id: keep_temp_dir
    type:
      - 'null'
      - boolean
    doc: do not remove temporary directory for debug puroposes
    inputBinding:
      position: 102
      prefix: -d
  - id: print_basic_snakemake_info
    type:
      - 'null'
      - boolean
    doc: print basic information about snakemake run
    inputBinding:
      position: 102
      prefix: -q
  - id: print_full_snakemake_info
    type:
      - 'null'
      - boolean
    doc: print full information about the snakemake run
    inputBinding:
      position: 102
      prefix: -p
  - id: singularity_apptainer_args
    type:
      - 'null'
      - string
    doc: singularity/apptainer arguments, e.g. "--bind /data/mnt/x --nv" 
      [default "" but will always add "--bind "]
    inputBinding:
      position: 102
      prefix: -r
  - id: use_conda_only
    type:
      - 'null'
      - boolean
    doc: use conda only (no apptainer/singularity)
    inputBinding:
      position: 102
      prefix: -m
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: out tsv.gz file (generated from input file name if not set)
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cadd-scripts:1.7.3--hdfd78af_0
