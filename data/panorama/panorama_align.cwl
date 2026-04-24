cwlVersion: v1.2
class: CommandLineTool
baseCommand: panorama align
label: panorama_align
doc: "Perform sequence alignment between pangenome gene families using MMseqs2 with
  support for both inter-pangenome and all-against-all alignment modes.\n\nTool homepage:
  https://github.com/labgem/panorama"
inputs:
  - id: align_cov_mode
    type:
      - 'null'
      - int
    doc: 'Coverage mode: 0=query, 1=target, 2=shorter seq, 3=longer seq, 4=query and
      target, 5=shorter and longer seq.'
    inputBinding:
      position: 101
      prefix: --align_cov_mode
  - id: align_coverage
    type:
      - 'null'
      - float
    doc: Minimum coverage percentage threshold (0.0-1.0).
    inputBinding:
      position: 101
      prefix: --align_coverage
  - id: align_identity
    type:
      - 'null'
      - float
    doc: Minimum identity percentage threshold (0.0-1.0).
    inputBinding:
      position: 101
      prefix: --align_identity
  - id: all_against_all
    type: boolean
    doc: Perform all-against-all alignment including intra-pangenome 
      comparisons. Cannot be used with --inter_pangenomes
    inputBinding:
      position: 101
      prefix: --all_against_all
  - id: disable_prog_bar
    type:
      - 'null'
      - boolean
    doc: disables the progress bars
    inputBinding:
      position: 101
      prefix: --disable_prog_bar
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force writing in output directory and in pangenome output file.
    inputBinding:
      position: 101
      prefix: --force
  - id: inter_pangenomes
    type: boolean
    doc: Perform inter-pangenome alignment only (exclude intra-pangenome 
      comparisons). Cannot be used with --all_against_all
    inputBinding:
      position: 101
      prefix: --inter_pangenomes
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: Keep temporary files after completion (useful for debugging)
    inputBinding:
      position: 101
      prefix: --keep_tmp
  - id: log
    type:
      - 'null'
      - File
    doc: log output file
    inputBinding:
      position: 101
      prefix: --log
  - id: pangenomes_file
    type: File
    doc: Path to TSV file containing list of pangenome .h5 files to process
    inputBinding:
      position: 101
      prefix: --pangenomes
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads for parallel processing.
    inputBinding:
      position: 101
      prefix: --threads
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: Directory for temporary files.
    inputBinding:
      position: 101
      prefix: --tmpdir
  - id: verbose
    type:
      - 'null'
      - int
    doc: Indicate verbose level (0 for warning and errors only, 1 for info, 2 
      for debug)
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory where alignment results will be written
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panorama:1.0.0--pyhdfd78af_0
