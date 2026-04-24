cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - python
  - peakzilla.py
label: peakzilla_peakzilla.py
doc: "Identify peaks from ChIP-seq data using a model-based approach.\n\nTool homepage:
  https://github.com/steinmann/peakzilla"
inputs:
  - id: chip_bed
    type: File
    doc: ChIP-seq data in BED format
    inputBinding:
      position: 1
  - id: control_bed
    type: File
    doc: Control data in BED format
    inputBinding:
      position: 2
  - id: bedpe
    type:
      - 'null'
      - boolean
    doc: input is paired end and in BEDPE format
    inputBinding:
      position: 103
      prefix: --bedpe
  - id: enrichment_cutoff
    type:
      - 'null'
      - float
    doc: minimum cutoff for fold enrichment
    inputBinding:
      position: 103
      prefix: --enrichment_cutoff
  - id: fragment_size
    type:
      - 'null'
      - int
    doc: manually set fragment size in bp
    inputBinding:
      position: 103
      prefix: --fragment_size
  - id: gaussian
    type:
      - 'null'
      - boolean
    doc: use empirical model estimate instead of gaussian
    inputBinding:
      position: 103
      prefix: --gaussian
  - id: log
    type:
      - 'null'
      - File
    doc: directory/filename to store log file to
    inputBinding:
      position: 103
      prefix: --log
  - id: model_peaks
    type:
      - 'null'
      - int
    doc: number of most highly enriched regions used to estimate peak size
    inputBinding:
      position: 103
      prefix: --model_peaks
  - id: negative
    type:
      - 'null'
      - boolean
    doc: write negative peaks to negative_peaks.tsv
    inputBinding:
      position: 103
      prefix: --negative
  - id: score_cutoff
    type:
      - 'null'
      - float
    doc: minimum cutoff for peak score
    inputBinding:
      position: 103
      prefix: --score_cutoff
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/peakzilla:1.0--py36_1
stdout: peakzilla_peakzilla.py.out
