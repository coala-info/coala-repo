cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - varlociraptor
  - estimate
  - contamination
label: varlociraptor_estimate_contamination
doc: 'Estimate contamination between samples (still experimental). Takes two samples,
  the presumably contaminated one and the contaminating one, and calculates the posterior
  distribution of the contamination fraction, which is printed into a TSV table.


  Tool homepage: https://varlociraptor.github.io'
inputs:
  - id: sample
    type:
      - 'null'
      - File
    doc: Presumably contaminated sample (varlociraptor observations BCF).
    inputBinding:
      position: 100
      prefix: --sample
  - id: contaminant
    type:
      - 'null'
      - File
    doc: Presumably contaminating sample (varlociraptor observations BCF).
    inputBinding:
      position: 100
      prefix: --contaminant
  - id: output_path
    type:
      - 'null'
      - string
    doc: Output file; if not specified, output is printed to STDOUT.
    inputBinding:
      position: 100
      prefix: --output
  - id: output_max_vaf_variants
    type:
      - 'null'
      - string
    doc: Path to store TSV of variant positions with maximum VAF in the contaminated
      sample (for QC).
    inputBinding:
      position: 100
      prefix: --output-max-vaf-variants
  - id: output_plot
    type:
      - 'null'
      - string
    doc: Path to store vega-lite plot of contamination/purity.
    inputBinding:
      position: 100
      prefix: --output-plot
  - id: prior_considered_cells
    type:
      - 'null'
      - int
    doc: Number of cells considered for the prior estimate (see --prior-estimate).
    inputBinding:
      position: 100
      prefix: --prior-considered-cells
  - id: prior_estimate
    type:
      - 'null'
      - float
    doc: Prior estimate of the contamination (1-purity). Has to be used together with
      the number of cells considered for the estimate (--prior-considered-cells).
    inputBinding:
      position: 100
      prefix: --prior-estimate
outputs:
  - id: contamination_tsv
    type: stdout
    doc: Contamination fraction posterior as TSV (standard output)
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file when --output is given
    outputBinding:
      glob: $(inputs.output_path)
  - id: plot_file
    type:
      - 'null'
      - File
    doc: Vega-lite plot of contamination/purity
    outputBinding:
      glob: $(inputs.output_plot)
  - id: max_vaf_variants_file
    type:
      - 'null'
      - File
    doc: TSV of variant positions with maximum VAF
    outputBinding:
      glob: $(inputs.output_max_vaf_variants)
stdout: contamination.tsv
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varlociraptor:8.9.5--h24073b4_0
