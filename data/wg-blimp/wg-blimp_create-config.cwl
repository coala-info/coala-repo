cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wg-blimp
  - create-config
label: wg-blimp_create-config
doc: "Create a config YAML file for running the Snakemake pipeline. Sample names are
  either passed as comma seperated lists or are read from text files if --use-sample-files
  parameter is set. Annotation files are automatically downloaded if necessary.\n\n\
  Tool homepage: https://github.com/MarWoes/wg-blimp"
inputs:
  - id: fastq_dir
    type: Directory
    doc: Directory containing FASTQ files
    inputBinding:
      position: 1
  - id: reference_fasta
    type: File
    doc: Path to the reference FASTA file
    inputBinding:
      position: 2
  - id: group1
    type: string
    doc: First group of samples (comma-separated list or file path)
    inputBinding:
      position: 3
  - id: group2
    type: string
    doc: Second group of samples (comma-separated list or file path)
    inputBinding:
      position: 4
  - id: output_dir
    type: Directory
    doc: Output directory for the config file
    inputBinding:
      position: 5
  - id: target_yaml
    type: File
    doc: Output YAML file name
    inputBinding:
      position: 6
  - id: aligner
    type:
      - 'null'
      - string
    doc: Select aligner to be used.
    inputBinding:
      position: 107
      prefix: --aligner
  - id: cores_per_job
    type: int
    doc: The number of cores to use per job.
    inputBinding:
      position: 107
      prefix: --cores-per-job
  - id: genome_build
    type:
      - 'null'
      - string
    doc: Build of the reference used for annotation.
    inputBinding:
      position: 107
      prefix: --genome_build
  - id: use_sample_files
    type:
      - 'null'
      - boolean
    doc: Load sample names from text files instead of passing them as a 
      comma-seperated list.
    inputBinding:
      position: 107
      prefix: --use-sample-files
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wg-blimp:0.10.0--pyh5e36f6f_0
stdout: wg-blimp_create-config.out
