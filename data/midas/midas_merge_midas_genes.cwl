cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - merge_midas.py
  - genes
label: midas_merge_midas_genes
doc: "Merge pangenome gene content results across samples into gene presence/absence and copy-number matrices.\n\
  \nTool homepage: https://github.com/snayfach/MIDAS"
inputs:
  - id: input_dirs
    type:
      type: array
      items: Directory
    doc: Sample directories output by run_midas.py (given to -i as a comma-separated list, -t list).
    inputBinding:
      position: 101
      prefix: -i
      itemSeparator: ','
  - id: db
    type:
      - 'null'
      - Directory
    doc: Path to reference database. By default, the MIDAS_DB environmental variable is used.
    inputBinding:
      position: 101
      prefix: -d
  - id: min_samples
    type:
      - 'null'
      - int
    doc: All species with >= MIN_SAMPLES (1).
    inputBinding:
      position: 101
      prefix: --min_samples
  - id: species_id
    type:
      - 'null'
      - string
    doc: Comma-separated list of species ids.
    inputBinding:
      position: 101
      prefix: --species_id
  - id: max_species
    type:
      - 'null'
      - int
    doc: Maximum number of species to merge. Useful for testing (use all).
    inputBinding:
      position: 101
      prefix: --max_species
  - id: sample_depth
    type:
      - 'null'
      - float
    doc: Minimum read-depth across all genes with non-zero coverage (1.0).
    inputBinding:
      position: 101
      prefix: --sample_depth
  - id: max_samples
    type:
      - 'null'
      - int
    doc: Maximum number of samples to process. Useful for testing (use all).
    inputBinding:
      position: 101
      prefix: --max_samples
  - id: cluster_pid
    type:
      - 'null'
      - int
    doc: 'Gene clustering identity of the pan-genome: 75, 80, 85, 90, 95 or 99 (default 95).'
    inputBinding:
      position: 101
      prefix: --cluster_pid
  - id: min_copy
    type:
      - 'null'
      - float
    doc: Genes >= MIN_COPY are classified as present; genes < MIN_COPY as absent (0.35).
    inputBinding:
      position: 101
      prefix: --min_copy
  - id: outdir
    type: string
    doc: Directory for output files. A subdirectory will be created for each species_id.
    inputBinding:
      position: 201
arguments:
  - prefix: -t
    valueFrom: list
outputs:
  - id: out_dir
    type: Directory
    doc: Output directory with the results.
    outputBinding:
      glob: $(inputs.outdir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/midas:1.3.2--py35_0
