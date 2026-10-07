cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cnvkit.py
  - fix
label: cnvkit_fix
doc: "Combine target and antitarget coverages and correct for biases. Adjust raw coverage data according to the given reference, correct potential biases and re-center.\n\nTool homepage: https://github.com/etal/cnvkit"
inputs:
  - id: target
    type: File
    doc: "Target coverage file (.targetcoverage.cnn)."
    inputBinding:
      position: 1
  - id: antitarget
    type: File
    doc: "Antitarget coverage file (.antitargetcoverage.cnn)."
    inputBinding:
      position: 2
  - id: reference
    type: File
    doc: "Reference coverage (.cnn)."
    inputBinding:
      position: 3
  - id: cluster
    type:
      - 'null'
      - boolean
    doc: "Compare and use cluster-specific values present in the reference profile. (Requires that the reference profile was built with the --cluster option.)"
    inputBinding:
      position: 101
      prefix: --cluster
  - id: sample_id
    type:
      - 'null'
      - string
    doc: "Sample ID for target/antitarget files. Otherwise inferred from file names."
    inputBinding:
      position: 101
      prefix: --sample-id
  - id: no_gc
    type:
      - 'null'
      - boolean
    doc: "Skip GC correction."
    inputBinding:
      position: 101
      prefix: --no-gc
  - id: no_edge
    type:
      - 'null'
      - boolean
    doc: "Skip edge-effect correction."
    inputBinding:
      position: 101
      prefix: --no-edge
  - id: no_rmask
    type:
      - 'null'
      - boolean
    doc: "Skip RepeatMasker correction."
    inputBinding:
      position: 101
      prefix: --no-rmask
  - id: output
    type: string
    doc: "Output file name."
    inputBinding:
      position: 101
      prefix: --output
  - id: diploid_parx_genome
    type:
      - 'null'
      - string
    doc: "Considers the given human genome's PAR of chromosome X as autosomal. Example: 'grch38'"
    inputBinding:
      position: 101
      prefix: --diploid-parx-genome
  - id: smoothing_window_fraction
    type:
      - 'null'
      - float
    doc: "If specified, sets the smoothing window fraction for rolling median bias smoothing based on traits. Otherwise, defaults to 1/sqrt(len(data))."
    inputBinding:
      position: 101
      prefix: --smoothing-window-fraction
outputs:
  - id: output_out
    type:
      - 'null'
      - File
    doc: "Output file name."
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1
