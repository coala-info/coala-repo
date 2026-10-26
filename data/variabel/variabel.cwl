cwlVersion: v1.2
class: CommandLineTool
baseCommand: variabel
label: variabel
doc: "Variabel applies a complexity filter and an allele frequency filter to VCF files\
  \ to eliminate noise and retain true variants.\n\nTool homepage: https://gitlab.com/treangenlab/variabel"
inputs:
  - id: input_vcfs
    type:
      type: array
      items: File
    doc: The input vcf file(s). If single input .txt is provided instead, it is
      expected to be a list of vcf file paths.
    inputBinding:
      position: 100
  - id: ref
    type: File
    doc: The reference genome to use (fasta format)
    inputBinding:
      position: 101
  - id: out
    type: string
    doc: The output vcf directory
    inputBinding:
      position: 102
      prefix: --out
  - id: min_af_change
    type:
      - 'null'
      - float
    doc: The minimum observed allele frequency change required to keep a variant
    inputBinding:
      position: 102
      prefix: --min-af-change
  - id: min_samp_count
    type:
      - 'null'
      - int
    doc: The minimum number of samples a variant must appear in
    inputBinding:
      position: 102
      prefix: --min-samp-count
  - id: safe_freq_thresh
    type:
      - 'null'
      - float
    doc: Any variant occuring in a sample with AF greater than this threshold 
      will not be discarded in the AF filtering step
    inputBinding:
      position: 102
      prefix: --safe-freq-thresh
  - id: complexity_k
    type:
      - 'null'
      - int
    doc: Window for shannon entropy calculation. For an indel at position i with
      length d, the two entropy windows will be [i-(k-1)*d] and [i+1, i+k*d+1]
    inputBinding:
      position: 102
      prefix: --complexity-k
  - id: min_entropy_cutoff
    type:
      - 'null'
      - float
    doc: The shannon entropy below which indel variants are discarded
    inputBinding:
      position: 102
      prefix: --min-entropy-cutoff
  - id: lofreq_filter
    type:
      - 'null'
      - boolean
    doc: Preprocess VCF files with LoFreq's set of defaults filters. This 
      includes strand bias.
    inputBinding:
      position: 102
      prefix: --lofreq-filter
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: More verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_dir
    type: Directory
    doc: The output vcf directory
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/variabel:1.0.0--hdfd78af_0
