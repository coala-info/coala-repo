cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - merge_midas.py
  - species
label: midas_merge_midas_species
doc: "Merge species abundance results across samples into species abundance matrices.\n\nTool homepage:\
  \ https://github.com/snayfach/MIDAS"
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
  - id: sample_depth
    type:
      - 'null'
      - float
    doc: Minimum per-sample marker-gene-depth for estimating species prevalence (1.0).
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
  - id: outdir
    type: string
    doc: Directory for output files.
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
