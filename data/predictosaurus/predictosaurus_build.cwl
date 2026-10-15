cwlVersion: v1.2
class: CommandLineTool
baseCommand: predictosaurus
arguments:
  - position: 2
    valueFrom: build
label: predictosaurus_build
doc: "Build a full variant graph out of VCF files and store it\n\nTool homepage: https://github.com/fxwiegand/predictosaurus"
inputs:
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use (global option, placed before the subcommand; default all available cores)
    inputBinding:
      position: 1
      prefix: --threads
  - id: calls
    type: File
    doc: Path to the calls file
    inputBinding:
      position: 101
      prefix: --calls
  - id: min_prob_present
    type:
      - 'null'
      - float
    doc: Minimum probability for a variant to be considered in the graph
    inputBinding:
      position: 101
      prefix: --min-prob-present
  - id: min_vaf
    type:
      - 'null'
      - float
    doc: Minimum VAF for a variant to be kept. The maximum VAF across samples 
      must meet or exceed this threshold
    inputBinding:
      position: 101
      prefix: --min-vaf
  - id: observations
    type:
      - 'null'
      - type: array
        items: observation_entry
    doc: One or more observation files, each with its sample name; rendered as
      `--observations sample=observations.vcf`. Make sure the sample names match
      the sample names in the calls file
    inputBinding:
      position: 101
      prefix: --observations
      valueFrom: |
        $(self.map(function (e) { return e.sample + '=' + e.observation_file.path; }))
  - id: verbose
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --verbose
  - id: output_path
    type: string
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: File
    doc: Path to the output file containing the impact graph
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: SchemaDefRequirement
    types:
      - name: observation_entry
        type: record
        fields:
          - name: sample
            type: string
            doc: Sample name, as in the calls file
          - name: observation_file
            type: File
            doc: Observation file (VCF or BCF) for this sample
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/predictosaurus:0.8.4--hbcba35e_0
