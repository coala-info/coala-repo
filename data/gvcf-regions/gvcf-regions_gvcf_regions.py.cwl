cwlVersion: v1.2
class: CommandLineTool
baseCommand: gvcf_regions.py
label: gvcf-regions_gvcf_regions.py
doc: Output the called regions of a gvcf file to stdout in bed format.
inputs:
  - id: gvcf
    type: File
    doc: input gvcf file
    inputBinding:
      position: 1
  - id: gvcf_type
    type:
      - 'null'
      - string
    doc: "type of gvcf output. [unreported_is_called, ignore_phrases, min_GQ, min_QUAL,
      pass_phrases] presets: complete_genomics: [True, ['CNV', 'INS:ME'], None, None,
      ['PASS']]. freebayes: [False, None, None, None, ['PASS']]. gatk: [False, None,
      5, None, None]. platypus: [False, None, None, None, ['PASS', 'REFCALL']]."
    inputBinding:
      position: 102
      prefix: --gvcf_type
  - id: ignore_phrases
    type:
      - 'null'
      - type: array
        items: string
    doc: list of phrases considered as discarded, e.g., CNV, ME. A line that 
      contains any of the ignore phrases is discarded.
    inputBinding:
      position: 102
      prefix: --ignore_phrases
  - id: min_gq
    type:
      - 'null'
      - int
    doc: minimum GQ (Genotype Quality) considered as called
    inputBinding:
      position: 102
      prefix: --min_GQ
  - id: min_qual
    type:
      - 'null'
      - int
    doc: minimum QUAL considered as called
    inputBinding:
      position: 102
      prefix: --min_QUAL
  - id: pass_phrases
    type:
      - 'null'
      - type: array
        items: string
    doc: list of phrases considered as called, e.g., PASS, REFCALL. A line must 
      contain any of the pass phrases to be considered as called.
    inputBinding:
      position: 102
      prefix: --pass_phrases
  - id: unreported_is_called
    type:
      - 'null'
      - boolean
    doc: use this flag to treat unreported sites as called
    inputBinding:
      position: 102
      prefix: --unreported_is_called
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gvcf-regions:2016.06.23--py35_0
stdout: gvcf-regions_gvcf_regions.py.out
