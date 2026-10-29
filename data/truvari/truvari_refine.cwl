cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - truvari
  - refine
label: truvari_refine
doc: "Automated Truvari bench result refinement with phab variant harmonization\n\nTool homepage: https://github.com/ACEnglish/truvari"
inputs:
  - id: align
    type:
      - 'null'
      - type: enum
        symbols:
          - mafft
          - wfa
          - poa
    doc: Alignment method for phab (poa)
    inputBinding:
      position: 1
      prefix: "-a"
  - id: use_original_vcfs
    type:
      - 'null'
      - boolean
    doc: Use original input VCFs instead of filtered tp/fn/fps
    inputBinding:
      position: 1
      prefix: "-u"
  - id: write_phab
    type:
      - 'null'
      - boolean
    doc: Use phab variant representations for counting/outputs
    inputBinding:
      position: 1
      prefix: "-w"
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use (4)
    inputBinding:
      position: 1
      prefix: "-t"
  - id: buffer
    type:
      - 'null'
      - int
    doc: Amount of buffer around refined regions (100)
    inputBinding:
      position: 1
      prefix: "-b"
  - id: reference
    type:
      - 'null'
      - File
    secondaryFiles:
      - pattern: .fai
        required: false
      - pattern: .gzi
        required: false
    doc: Indexed fasta used to call variants (optional if bench -f was used)
    inputBinding:
      position: 1
      prefix: "-f"
  - id: regions
    type:
      - 'null'
      - File
    doc: Regions to refine (candidate.refine.bed)
    inputBinding:
      position: 1
      prefix: "-r"
  - id: coords
    type:
      - 'null'
      - type: enum
        symbols:
          - R
          - O
    doc: Which bed file coordinates to use, Regions or includebed Original (R)
    inputBinding:
      position: 1
      prefix: "-c"
  - id: subset
    type:
      - 'null'
      - boolean
    doc: Only report metrics from the refined regions
    inputBinding:
      position: 1
      prefix: "-S"
  - id: mafft_params
    type:
      - 'null'
      - string
    doc: Parameters for mafft, wrap in a single quote (--auto --thread 1)
    inputBinding:
      position: 1
      prefix: "-m"
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Verbose logging
    inputBinding:
      position: 1
      prefix: "--debug"
  - id: dir
    type: Directory
    doc: Truvari bench directory (refinement results are written into a copy of it)
    inputBinding:
      position: 2
outputs:
  - id: refined_dir
    type: Directory
    doc: Bench directory with refinement results (refine.base.vcf.gz, refine.comp.vcf.gz, refine.region.txt, phab_bench, ...)
    outputBinding:
      glob: "$(inputs.dir.basename)"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: "$(inputs.dir)"
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/truvari:5.4.0--pyhdfd78af_0
