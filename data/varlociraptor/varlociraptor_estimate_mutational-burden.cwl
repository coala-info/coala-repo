cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - varlociraptor
  - estimate
  - mutational-burden
label: varlociraptor_estimate_mutational-burden
doc: 'Estimate mutational burden. Takes Varlociraptor calls (must be annotated with
  e.g. VEP but using ANN instead of CSQ) from standard input and prints the estimate
  in Vega-lite JSON format (or a TSV table) to standard output.


  Tool homepage: https://varlociraptor.github.io'
inputs:
  - id: calls
    type: File
    doc: Varlociraptor calls in BCF format (standard input).
  - id: coding_genome_size
    type:
      - 'null'
      - float
    doc: 'Size (in bases) of the covered coding genome. [default: 3e7]'
    inputBinding:
      position: 100
      prefix: --coding-genome-size
  - id: vaf_cutoff
    type:
      - 'null'
      - float
    doc: 'Minimal variant allelic fraction to consider for mutli-sample barplot [default:
      0.2]'
    inputBinding:
      position: 100
      prefix: --vaf-cutoff
  - id: events
    type:
      - 'null'
      - type: array
        items: string
    doc: Events to consider (e.g. SOMATIC_TUMOR).
    inputBinding:
      position: 100
      prefix: --events
  - id: mode
    type:
      - 'null'
      - string
    doc: 'How to output to STDOUT (as stratified curve, histogram, or multi-sample
      barplot, or TSV table): hist, curve, multibar, table'
    inputBinding:
      position: 100
      prefix: --mode
  - id: sample
    type:
      - 'null'
      - type: array
        items: string
    doc: Name(s) of the sample(s) in the given VCF/BCF. Multiple samples can be given
      when using the multibar plot mode.
    inputBinding:
      position: 100
      prefix: --sample
outputs:
  - id: burden
    type: stdout
    doc: Mutational burden estimate
stdin: $(inputs.calls.path)
stdout: mutational-burden.out
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varlociraptor:8.9.5--h24073b4_0
