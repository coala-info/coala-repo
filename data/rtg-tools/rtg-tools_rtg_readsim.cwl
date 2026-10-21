cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rtg
  - readsim
label: rtg-tools_rtg_readsim
doc: 'Generates reads from a reference genome. Tool homepage: https://github.com/RealTimeGenomics/rtg-tools'
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input
    type: Directory
    doc: 'SDF containing input genome'
    inputBinding:
      position: 101
      prefix: --input
  - id: machine
    type: string
    doc: 'select the sequencing technology to model. Allowed values are [illumina_se, illumina_pe, complete_genomics, complete_genomics_2, 454_pe, 454_se, iontorrent]'
    inputBinding:
      position: 101
      prefix: --machine
  - id: output
    type: string
    doc: 'name for reads output SDF'
    inputBinding:
      position: 101
      prefix: --output
  - id: abundance
    type:
      - 'null'
      - boolean
    doc: 'if set, the user-supplied distribution represents desired abundance'
    inputBinding:
      position: 101
      prefix: --abundance
  - id: allow_unknowns
    type:
      - 'null'
      - boolean
    doc: 'allow reads to be drawn from template fragments containing unknown nucleotides'
    inputBinding:
      position: 101
      prefix: --allow-unknowns
  - id: coverage
    type:
      - 'null'
      - float
    doc: 'coverage, must be positive'
    inputBinding:
      position: 101
      prefix: --coverage
  - id: distribution
    type:
      - 'null'
      - File
    doc: 'file containing probability distribution for sequence selection'
    inputBinding:
      position: 101
      prefix: --distribution
  - id: dna_fraction
    type:
      - 'null'
      - boolean
    doc: 'if set, the user-supplied distribution represents desired DNA fraction'
    inputBinding:
      position: 101
      prefix: --dna-fraction
  - id: max_fragment_size
    type:
      - 'null'
      - int
    doc: 'maximum fragment size (Default is 250)'
    inputBinding:
      position: 101
      prefix: --max-fragment-size
  - id: min_fragment_size
    type:
      - 'null'
      - int
    doc: 'minimum fragment size (Default is 200)'
    inputBinding:
      position: 101
      prefix: --min-fragment-size
  - id: n_rate
    type:
      - 'null'
      - float
    doc: 'rate that the machine will generate new unknowns in the read (Default is 0.0)'
    inputBinding:
      position: 101
      prefix: --n-rate
  - id: num_reads
    type:
      - 'null'
      - int
    doc: 'number of reads to be generated'
    inputBinding:
      position: 101
      prefix: --num-reads
  - id: taxonomy_distribution
    type:
      - 'null'
      - File
    doc: 'file containing probability distribution for sequence selection expressed by taxonomy id'
    inputBinding:
      position: 101
      prefix: --taxonomy-distribution
  - id: left_read_length
    type:
      - 'null'
      - int
    doc: 'target read length on the left side (Illumina PE)'
    inputBinding:
      position: 101
      prefix: --left-read-length
  - id: right_read_length
    type:
      - 'null'
      - int
    doc: 'target read length on the right side (Illumina PE)'
    inputBinding:
      position: 101
      prefix: --right-read-length
  - id: read_length
    type:
      - 'null'
      - int
    doc: 'target read length, must be positive (Illumina SE)'
    inputBinding:
      position: 101
      prefix: --read-length
  - id: n454_max_total_size
    type:
      - 'null'
      - int
    doc: 'maximum 454 read length (in paired end case the sum of the left and the right read lengths)'
    inputBinding:
      position: 101
      prefix: --454-max-total-size
  - id: n454_min_total_size
    type:
      - 'null'
      - int
    doc: 'minimum 454 read length (in paired end case the sum of the left and the right read lengths)'
    inputBinding:
      position: 101
      prefix: --454-min-total-size
  - id: ion_max_total_size
    type:
      - 'null'
      - int
    doc: 'maximum IonTorrent read length'
    inputBinding:
      position: 101
      prefix: --ion-max-total-size
  - id: ion_min_total_size
    type:
      - 'null'
      - int
    doc: 'minimum IonTorrent read length'
    inputBinding:
      position: 101
      prefix: --ion-min-total-size
  - id: comment
    type:
      - 'null'
      - string
    doc: 'comment to include in the generated SDF'
    inputBinding:
      position: 101
      prefix: --comment
  - id: no_names
    type:
      - 'null'
      - boolean
    doc: 'do not create read names in the output SDF'
    inputBinding:
      position: 101
      prefix: --no-names
  - id: no_qualities
    type:
      - 'null'
      - boolean
    doc: 'do not create read qualities in the output SDF'
    inputBinding:
      position: 101
      prefix: --no-qualities
  - id: qual_range
    type:
      - 'null'
      - string
    doc: 'set the range of base quality values permitted e.g.: 3-40 (Default is fixed qualities corresponding to overall machine base error rate)'
    inputBinding:
      position: 101
      prefix: --qual-range
  - id: sam_rg
    type:
      - 'null'
      - string
    doc: 'file containing a single valid read group SAM header line or a string in the form "@RG\tID:READGROUP1\tSM:BACT_SAMPLE\tPL:ILLUMINA"'
    inputBinding:
      position: 101
      prefix: --sam-rg
  - id: seed
    type:
      - 'null'
      - int
    doc: 'seed for random number generator'
    inputBinding:
      position: 101
      prefix: --seed
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: reads_sdf
    type: Directory
    doc: Output reads SDF directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
stdout: rtg-tools_rtg_readsim.out
