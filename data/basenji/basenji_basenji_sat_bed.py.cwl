cwlVersion: v1.2
class: CommandLineTool
baseCommand: [basenji_sat_bed.py]
label: basenji_basenji_sat_bed.py
doc: "Perform an in silico saturation mutagenesis of sequences in a BED file.\n\nTool homepage: https://github.com/calico/basenji"
inputs:
  - id: params_file
    type: File
    doc: Model parameters JSON file
    inputBinding:
      position: 10
  - id: model_file
    type: File
    doc: Trained model weights file (h5)
    inputBinding:
      position: 11
  - id: bed_file
    type: File
    doc: BED file of regions to mutate (centred on each region)
    inputBinding:
      position: 12
  - id: genome_fasta
    type:
      - 'null'
      - File
    doc: 'Genome FASTA for sequences [Default: none]'
    inputBinding:
      position: 1
      prefix: -f
    secondaryFiles:
      - pattern: .fai
        required: false
  - id: mut_len
    type:
      - 'null'
      - int
    doc: 'Length of center sequence to mutate [Default: 0]'
    inputBinding:
      position: 1
      prefix: -l
  - id: out_dir
    type: string
    doc: 'Output directory [Default: sat_mut]'
    inputBinding:
      position: 1
      prefix: -o
    default: sat_mut
  - id: plots
    type:
      - 'null'
      - boolean
    doc: 'Make heatmap plots [Default: False]'
    inputBinding:
      position: 1
      prefix: --plots
  - id: processes
    type:
      - 'null'
      - int
    doc: Number of processes, passed by multi script
    inputBinding:
      position: 1
      prefix: -p
  - id: mut_down
    type:
      - 'null'
      - int
    doc: 'Nucleotides downstream of center sequence to mutate [Default: 0]'
    inputBinding:
      position: 1
      prefix: -d
  - id: rc
    type:
      - 'null'
      - boolean
    doc: 'Ensemble forward and reverse complement predictions [Default: False]'
    inputBinding:
      position: 1
      prefix: --rc
  - id: shifts
    type:
      - 'null'
      - string
    doc: 'Ensemble prediction shifts [Default: 0]'
    inputBinding:
      position: 1
      prefix: --shifts=
      separate: false
  - id: stats
    type:
      - 'null'
      - string
    doc: 'Comma-separated list of stats to save. [Default: sum]'
    inputBinding:
      position: 1
      prefix: --stats=
      separate: false
  - id: targets_file
    type:
      - 'null'
      - File
    doc: File specifying target indexes and labels in table format
    inputBinding:
      position: 1
      prefix: -t
  - id: mut_up
    type:
      - 'null'
      - int
    doc: 'Nucleotides upstream of center sequence to mutate [Default: 0]'
    inputBinding:
      position: 1
      prefix: -u
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.out_dir)
  - id: scores
    type:
      - 'null'
      - File
    doc: Saturation mutagenesis scores (HDF5)
    outputBinding:
      glob: $(inputs.out_dir)/scores.h5
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/basenji:0.6--pyhdfd78af_0
