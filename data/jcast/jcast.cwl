cwlVersion: v1.2
class: CommandLineTool
baseCommand: jcast
label: jcast
doc: "retrieves transcript splice junctionsand translates them into amino acid sequences\n\
  \nTool homepage: https://github.com/ed-lau/jcast"
inputs:
  - id: rmats_folder
    type: Directory
    doc: path to folder storing rMATS output
    inputBinding:
      position: 1
  - id: gtf_file
    type: File
    doc: path to Ensembl gtf file
    inputBinding:
      position: 2
  - id: genome
    type: File
    doc: path to genome file
    inputBinding:
      position: 3
  - id: canonical
    type:
      - 'null'
      - boolean
    doc: write out canonical protein sequence even if transcriptslices are 
      untranslatable
    inputBinding:
      position: 104
      prefix: --canonical
  - id: distribution_for_low_end_histogram
    type:
      - 'null'
      - string
    doc: Switch on distribution to use for low end of histogram, 0 for Gamma, 
      anything else for LogNorm
    inputBinding:
      position: 104
      prefix: --g_or_ln
  - id: model
    type:
      - 'null'
      - boolean
    doc: models junction read count cutoff using a Gaussian mixture model
    inputBinding:
      position: 104
      prefix: --model
  - id: output_files
    type:
      - 'null'
      - string
    doc: name of the output files
    inputBinding:
      position: 104
      prefix: --out
  - id: qvalue_thresholds
    type:
      - 'null'
      - type: array
        items: float
    doc: take junctions with rMATS fdr within this threshold
      - 0
      - 1
    inputBinding:
      position: 104
      prefix: --qvalue
  - id: read_cutoff
    type:
      - 'null'
      - int
    doc: the lowest skipped junction read count for a junction to be translated
    inputBinding:
      position: 104
      prefix: --read
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jcast:0.3.5--pyhdfd78af_0
stdout: jcast.out
