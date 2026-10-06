cwlVersion: v1.2
class: CommandLineTool
baseCommand: [basenji_sat_vcf.py]
label: basenji_basenji_sat_vcf.py
doc: "Perform an in silico saturated mutagenesis of the sequences surrounding variants given in a VCF\
  \ file.\n\nTool homepage: https://github.com/calico/basenji"
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
  - id: vcf_file
    type: File
    doc: VCF file of variants; sequences centred on each variant are mutated
    inputBinding:
      position: 12
  - id: figure_width
    type:
      - 'null'
      - int
    doc: 'Figure width [Default: 20]'
    inputBinding:
      position: 1
      prefix: -f
  - id: genome1_fasta
    type:
      - 'null'
      - File
    doc: Genome FASTA from which major allele sequences will be drawn
    inputBinding:
      position: 1
      prefix: --f1=
      separate: false
    secondaryFiles: &id001
      - pattern: .fai
        required: false
  - id: genome2_fasta
    type:
      - 'null'
      - File
    doc: Genome FASTA from which minor allele sequences will be drawn
    inputBinding:
      position: 1
      prefix: --f2=
      separate: false
    secondaryFiles: *id001
  - id: mut_len
    type:
      - 'null'
      - int
    doc: 'Length of centered sequence to mutate [Default: 200]'
    inputBinding:
      position: 1
      prefix: -l
  - id: out_dir
    type: string
    doc: 'Output directory [Default: sat_vcf]'
    inputBinding:
      position: 1
      prefix: -o
    default: sat_vcf
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
