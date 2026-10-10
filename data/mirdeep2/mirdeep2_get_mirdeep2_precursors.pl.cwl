cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - get_mirdeep2_precursors.pl
label: mirdeep2_get_mirdeep2_precursors.pl
doc: "Extract the precursor, mature or star sequences (fasta) and genome coordinates (bed) of novel, known and not detected miRNAs from a miRDeep2 result csv file\n\nTool homepage: https://github.com/rajewsky-lab/mirdeep2"
inputs:
  - id: result_csv
    type: File
    doc: miRDeep2 result file (result_<time>.csv)
    inputBinding:
      position: 101
      prefix: -r
  - id: min_score
    type:
      - 'null'
      - int
    doc: Output only precursors with a miRDeep2 score >= this integer
    inputBinding:
      position: 102
      prefix: -s
  - id: max_score
    type:
      - 'null'
      - int
    doc: Output only precursors with a score < this integer
    inputBinding:
      position: 103
      prefix: -t
  - id: dna
    type:
      - 'null'
      - boolean
    doc: Output DNA instead of RNA
    inputBinding:
      position: 104
      prefix: -d
  - id: simple_id
    type:
      - 'null'
      - boolean
    doc: Make a simple id with the name only
    inputBinding:
      position: 105
      prefix: -p
  - id: mature
    type:
      - 'null'
      - boolean
    doc: Get the mature sequences instead of the precursors
    inputBinding:
      position: 106
      prefix: -m
  - id: star
    type:
      - 'null'
      - boolean
    doc: Get the star sequences instead of the precursors
    inputBinding:
      position: 107
      prefix: -k
  - id: track_name
    type:
      - 'null'
      - string
    doc: Track name for the bed files
    inputBinding:
      position: 108
      prefix: -T
  - id: outdir
    type:
      - 'null'
      - string
    doc: Output directory (default result_mirnas)
    default: result_mirnas
    inputBinding:
      position: 109
      prefix: -o
outputs:
  - id: fasta_files
    type:
      - type: array
        items: File
    doc: Sequences of the novel, known and not detected miRNAs
    outputBinding:
      glob: $(inputs.outdir)/*.fa
  - id: bed_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Genome coordinates of the novel and known miRNAs
    outputBinding:
      glob: $(inputs.outdir)/*.bed
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
