cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - clair.py
  - ExtractVariantCandidates
label: clair_ExtractVariantCandidates
doc: "Generate 1-based variant candidates using alignments\n\nTool homepage: https://github.com/HKU-BAL/Clair"
inputs:
  - id: bam_fn
    type: File
    doc: "Sorted BAM file input"
    secondaryFiles:
      - pattern: ".bai"
        required: true
    inputBinding:
      position: 101
      prefix: --bam_fn
  - id: ref_fn
    type: File
    doc: "Reference fasta file input"
    secondaryFiles:
      - pattern: ".fai"
        required: false
    inputBinding:
      position: 101
      prefix: --ref_fn
  - id: bed_fn
    type:
      - 'null'
      - File
    doc: "Call variant only in these regions, works in intersection with ctgName, ctgStart and ctgEnd"
    inputBinding:
      position: 101
      prefix: --bed_fn
  - id: can_fn
    type: string
    doc: "Pile-up count output file name (gzip-compressed text)"
    inputBinding:
      position: 101
      prefix: --can_fn
  - id: var_fn
    type:
      - 'null'
      - File
    doc: "Candidate sites VCF file input (gzip-compressed), if provided, will choose candidate +/- 1 or +/- 2. Use together with gen4Training."
    inputBinding:
      position: 101
      prefix: --var_fn
  - id: threshold
    type:
      - 'null'
      - float
    doc: "Minimum allele frequence of the 1st non-reference allele for a site to be considered as a condidate site, default: 0.125000"
    inputBinding:
      position: 101
      prefix: --threshold
  - id: minCoverage
    type:
      - 'null'
      - float
    doc: "Minimum coverage required to call a variant, default: 4.000000"
    inputBinding:
      position: 101
      prefix: --minCoverage
  - id: minMQ
    type:
      - 'null'
      - int
    doc: "Minimum Mapping Quality. Mapping quality lower than the setting will be filtered, default: 0"
    inputBinding:
      position: 101
      prefix: --minMQ
  - id: gen4Training
    type:
      - 'null'
      - boolean
    doc: "Output all genome positions as candidate for model training (Set --threshold to 0)"
    inputBinding:
      position: 101
      prefix: --gen4Training
  - id: outputProb
    type:
      - 'null'
      - float
    doc: "output probability"
    inputBinding:
      position: 101
      prefix: --outputProb
  - id: ctgName
    type:
      - 'null'
      - string
    doc: "The name of sequence to be processed"
    inputBinding:
      position: 101
      prefix: --ctgName
  - id: ctgStart
    type:
      - 'null'
      - int
    doc: "The 1-based starting position of the sequence to be processed"
    inputBinding:
      position: 101
      prefix: --ctgStart
  - id: ctgEnd
    type:
      - 'null'
      - int
    doc: "The 1-based inclusive ending position of the sequence to be processed"
    inputBinding:
      position: 101
      prefix: --ctgEnd
  - id: samtools
    type:
      - 'null'
      - string
    doc: "Path to the 'samtools', default: samtools"
    inputBinding:
      position: 101
      prefix: --samtools
outputs:
  - id: candidates
    type: File
    doc: "Variant candidate list (gzip-compressed)"
    outputBinding:
      glob: "$(inputs.can_fn)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clair:2.1.1--hdfd78af_1
