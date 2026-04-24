cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - svaba
  - refilter
label: svaba_refilter
doc: "Refilter SVABA results\n\nTool homepage: https://github.com/walaj/svaba"
inputs:
  - id: bam
    type: File
    doc: BAM file used to grab header from
    inputBinding:
      position: 101
      prefix: --bam
  - id: dbsnp_vcf
    type:
      - 'null'
      - File
    doc: DBsnp database (VCF) to compare indels against
    inputBinding:
      position: 101
      prefix: --dbsnp-vcf
  - id: id_string
    type:
      - 'null'
      - string
    doc: String specifying the analysis ID to be used as part of ID common
    inputBinding:
      position: 101
      prefix: --id-string
  - id: input_bps
    type: File
    doc: Original bps.txt.gz file
    inputBinding:
      position: 101
      prefix: --input-bps
  - id: lod
    type:
      - 'null'
      - float
    doc: LOD cutoff to classify indel as non-REF (tests AF=0 vs 
      AF=MaxLikelihood(AF))
    inputBinding:
      position: 101
      prefix: --lod
  - id: lod_dbsnp
    type:
      - 'null'
      - float
    doc: LOD cutoff to classify indel as non-REF (tests AF=0 vs 
      AF=MaxLikelihood(AF)) at DBSnp indel site
    inputBinding:
      position: 101
      prefix: --lod-dbsnp
  - id: lod_somatic
    type:
      - 'null'
      - float
    doc: LOD cutoff to classify indel as somatic (tests AF=0 in normal vs 
      AF=ML(0.5))
    inputBinding:
      position: 101
      prefix: --lod-somatic
  - id: lod_somatic_dbsnp
    type:
      - 'null'
      - float
    doc: LOD cutoff to classify indel as somatic (tests AF=0 in normal vs 
      AF=ML(0.5)) at DBSnp indel site
    inputBinding:
      position: 101
      prefix: --lod-somatic-dbsnp
  - id: read_tracking
    type:
      - 'null'
      - string
    doc: Track supporting reads by qname. Increases file sizes.
    inputBinding:
      position: 101
      prefix: --read-tracking
  - id: scale_errors
    type:
      - 'null'
      - float
    doc: Scale the priors that a site is artifact at given repeat count. 0 means
      assume low (const) error rate
    inputBinding:
      position: 101
      prefix: --scale-errors
  - id: verbose
    type:
      - 'null'
      - int
    doc: Select verbosity level (0-4)
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svaba:1.2.0--h69ac913_1
stdout: svaba_refilter.out
