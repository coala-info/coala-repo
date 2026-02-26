cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wg-blimp
  - run-snakemake
label: wg-blimp_run-snakemake
doc: "Run the Snakemake pipeline from command line. Sample names are either passed
  as comma seperated lists or are read from text files if --use-sample-files parameter
  is set. Annotation files are automatically downloaded if necessary.\n\nTool homepage:
  https://github.com/MarWoes/wg-blimp"
inputs:
  - id: fastq_dir
    type: Directory
    doc: Directory containing FASTQ files
    inputBinding:
      position: 1
  - id: reference_fasta
    type: File
    doc: Reference FASTA file
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
    doc: Output directory
    inputBinding:
      position: 5
  - id: aligner
    type:
      - 'null'
      - string
    doc: Select aligner to be used.
    inputBinding:
      position: 106
      prefix: --aligner
  - id: cluster
    type:
      - 'null'
      - string
    doc: Submission command snakemake uses for cluster usage. Setting this 
      parameter enables snakemake's cluster mode.
    inputBinding:
      position: 106
      prefix: --cluster
  - id: cores
    type: int
    doc: The number of cores to use for running the pipeline. In cluster mode, 
      this sets cores used per node.
    inputBinding:
      position: 106
      prefix: --cores
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Only dry-run the pipeline.
    inputBinding:
      position: 106
      prefix: --dry-run
  - id: genome_build
    type:
      - 'null'
      - string
    doc: Build of the reference used for annotation.
    inputBinding:
      position: 106
      prefix: --genome_build
  - id: nodes
    type:
      - 'null'
      - int
    doc: Number of nodes to use in cluster mode.
    inputBinding:
      position: 106
      prefix: --nodes
  - id: use_sample_files
    type:
      - 'null'
      - boolean
    doc: Load sample names from text files instead of passing them as a 
      comma-seperated list.
    inputBinding:
      position: 106
      prefix: --use-sample-files
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wg-blimp:0.10.0--pyh5e36f6f_0
stdout: wg-blimp_run-snakemake.out
