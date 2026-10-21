cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rtg
  - cgsim
label: rtg-tools_rtg_cgsim
doc: 'Simulate Complete Genomics Inc sequencing reads. Supports the original 35 bp read structure (5-10-10-10), and the newer 29 bp read structure (10-9-10). Tool homepage: https://github.com/RealTimeGenomics/rtg-tools'
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input
    type: Directory
    doc: 'SDF containing input genome'
    inputBinding:
      position: 101
      prefix: --input
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
    doc: 'maximum fragment size (Default is 500)'
    inputBinding:
      position: 101
      prefix: --max-fragment-size
  - id: min_fragment_size
    type:
      - 'null'
      - int
    doc: 'minimum fragment size (Default is 350)'
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
  - id: cg_read_version
    type: int
    doc: 'select Complete Genomics read structure version, 1 (35 bp) or 2 (29 bp)'
    inputBinding:
      position: 101
      prefix: --cg-read-version
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
stdout: rtg-tools_rtg_cgsim.out
