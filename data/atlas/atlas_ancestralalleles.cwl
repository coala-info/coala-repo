cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - atlas
  - ancestralAlleles
label: atlas_ancestralalleles
doc: "Writing a FASTA file with the ancestral allele of every locus, from an ATLAS alleleCounts file.\n\nTool homepage: https://bitbucket.org/wegmannlab/atlas"
inputs:
  - id: allele_counts
    type: File
    doc: "Allele counts file from ATLAS alleleCounts (--outFormat withAlleles)."
    inputBinding:
      position: 1
      prefix: --alleleCounts
  - id: fasta_index
    type: File
    doc: "FASTA index (.fai) of the reference genome."
    inputBinding:
      position: 1
      prefix: --fastaIndex
  - id: minor_count_maximum
    type:
      - 'null'
      - int
    doc: "Maximum minor allele count still accepting the major allele as ancestral."
    inputBinding:
      position: 1
      prefix: --minorCountMaximum
  - id: total_count_minimum
    type:
      - 'null'
      - int
    doc: "Minimum total allele count to accept the major allele as ancestral."
    inputBinding:
      position: 1
      prefix: --totalCountMinimum
  - id: population
    type:
      - 'null'
      - string
    doc: "Population in the allele counts file to use."
    inputBinding:
      position: 1
      prefix: --population
  - id: out_prefix
    type: string
    doc: "Prefix for all output files (ATLAS --out)."
    default: "atlas_ancestralAlleles"
    inputBinding:
      position: 1
      prefix: --out
outputs:
  - id: log
    type: stdout
    doc: ATLAS progress report (standard output).
  - id: ancestral_fasta
    type: File
    doc: "FASTA file with ancestral alleles (N where unknown)."
    secondaryFiles:
      - pattern: .fai
        required: false
    outputBinding:
      glob: $(inputs.out_prefix).fasta
  - id: parameters
    type:
      - 'null'
      - File
    doc: "Parameters used for the run."
    outputBinding:
      glob: $(inputs.out_prefix).parameters
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/atlas:2.0.1--hadca570_0
stdout: atlas_ancestralalleles.log
