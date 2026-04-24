cwlVersion: v1.2
class: CommandLineTool
baseCommand: vt discover
label: vt_discover
doc: "Discovers variants from reads in a BAM file.\n\nTool homepage: https://github.com/Aikoyori/ProgrammingVTuberLogos"
inputs:
  - id: base_quality_cutoff
    type:
      - 'null'
      - int
    doc: base quality cutoff for bases
    inputBinding:
      position: 101
      prefix: -q
  - id: evidence_count_cutoff
    type:
      - 'null'
      - int
    doc: evidence count cutoff for candidate allele
    inputBinding:
      position: 101
      prefix: -e
  - id: fractional_evidence_cutoff
    type:
      - 'null'
      - float
    doc: fractional evidence cutoff for candidate allele
    inputBinding:
      position: 101
      prefix: -f
  - id: input_bam
    type: File
    doc: input BAM file
    inputBinding:
      position: 101
      prefix: -b
  - id: intervals
    type:
      - 'null'
      - string
    doc: intervals
    inputBinding:
      position: 101
      prefix: -i
  - id: intervals_file
    type:
      - 'null'
      - File
    doc: file containing list of intervals
    inputBinding:
      position: 101
      prefix: -I
  - id: mapq_cutoff
    type:
      - 'null'
      - int
    doc: MAPQ cutoff for alignments
    inputBinding:
      position: 101
      prefix: -m
  - id: reference_fasta
    type: File
    doc: reference sequence fasta file
    inputBinding:
      position: 101
      prefix: -r
  - id: sample_id
    type: string
    doc: sample ID
    inputBinding:
      position: 101
      prefix: -s
  - id: variant_types
    type:
      - 'null'
      - string
    doc: variant types
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output_vcf
    type:
      - 'null'
      - File
    doc: output VCF file
    outputBinding:
      glob: $(inputs.output_vcf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vt:2015.11.10--2
