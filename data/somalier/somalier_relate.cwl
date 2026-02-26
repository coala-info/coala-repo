cwlVersion: v1.2
class: CommandLineTool
baseCommand: somalier_relate
label: somalier_relate
doc: "calculate relatedness among samples from extracted, genotype-like information\n\
  \nTool homepage: https://github.com/brentp/somalier"
inputs:
  - id: extracted_files
    type:
      - 'null'
      - type: array
        items: File
    doc: $sample.somalier files for each sample. the first 10 are tested as a 
      glob patterns
    inputBinding:
      position: 1
  - id: groups
    type:
      - 'null'
      - File
    doc: 'optional path  to expected groups of samples (e.g. tumor normal pairs).
      A group file is specified as comma-separated groups per line e.g.: normal1,tumor1a,tumor1b
      normal2,tumor2a'
    inputBinding:
      position: 102
      prefix: --groups
  - id: infer
    type:
      - 'null'
      - boolean
    doc: infer relationships 
      (https://github.com/brentp/somalier/wiki/pedigree-inference)
    inputBinding:
      position: 102
      prefix: --infer
  - id: min_ab
    type:
      - 'null'
      - float
    doc: hets sites must be between min-ab and 1 - min_ab. set this to 0.2 for 
      RNA-Seq data
    default: 0.3
    inputBinding:
      position: 102
      prefix: --min-ab
  - id: min_depth
    type:
      - 'null'
      - int
    doc: only genotype sites with at least this depth.
    default: 7
    inputBinding:
      position: 102
      prefix: --min-depth
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: output prefix for results.
    default: somalier
    inputBinding:
      position: 102
      prefix: --output-prefix
  - id: ped
    type:
      - 'null'
      - File
    doc: optional path to a ped/fam file indicating the expected relationships 
      among samples.
    inputBinding:
      position: 102
      prefix: --ped
  - id: sample_prefix
    type:
      - 'null'
      - type: array
        items: string
    doc: optional sample prefixes that can be removed to find identical samples.
      e.g. batch1-sampleA batch2-sampleA
    inputBinding:
      position: 102
      prefix: --sample-prefix
  - id: unknown
    type:
      - 'null'
      - boolean
    doc: set unknown genotypes to hom-ref. it is often preferable to use this 
      with VCF samples that were not jointly called
    inputBinding:
      position: 102
      prefix: --unknown
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/somalier:0.3.1--hc78c8e0_0
stdout: somalier_relate.out
