cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - truvari
  - anno
  - grm
label: truvari_anno_grm
doc: "Maps graph edge kmers with BWA to assess Graph Reference Mappability\n\nTool homepage: https://github.com/ACEnglish/truvari"
inputs:
  - id: input_vcf
    type: File
    secondaryFiles:
      - .tbi
    doc: Input VCF
    inputBinding:
      position: 1
      prefix: "-i"
  - id: reference
    type: File
    secondaryFiles:
      - .fai
      - .amb
      - .ann
      - .bwt
      - .pac
      - .sa
    doc: BWA indexed reference
    inputBinding:
      position: 1
      prefix: "-r"
  - id: regions
    type:
      - 'null'
      - File
    doc: Bed file of regions to parse (None)
    inputBinding:
      position: 1
      prefix: "-R"
  - id: output
    type:
      - 'null'
      - string
    default: results.jl
    doc: Output dataframe (results.jl)
    inputBinding:
      position: 1
      prefix: "-o"
  - id: kmersize
    type:
      - 'null'
      - int
    doc: Size of kmer to map (50)
    inputBinding:
      position: 1
      prefix: "-k"
  - id: min_size
    type:
      - 'null'
      - int
    doc: Minimum size of variants to map (25)
    inputBinding:
      position: 1
      prefix: "-m"
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads (1)
    inputBinding:
      position: 1
      prefix: "-t"
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Verbose logging
    inputBinding:
      position: 1
      prefix: "--debug"
outputs:
  - id: output_joblib
    type: File
    doc: Joblib DataFrame of kmer mappability
    outputBinding:
      glob: "$(inputs.output)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/truvari:5.4.0--pyhdfd78af_0
