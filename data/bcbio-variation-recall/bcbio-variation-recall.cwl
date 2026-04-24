cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bcbio-variation-recall
  - recall
label: bcbio-variation-recall
doc: "Recall variants from a BAM file at known positions defined in a VCF file.\n\n\
  Tool homepage: https://github.com/chapmanb/bcbio.variation.recall"
inputs:
  - id: ref_file
    type: File
    doc: Reference FASTA file
    inputBinding:
      position: 1
  - id: bed_file
    type: File
    doc: BED file of regions to recall
    inputBinding:
      position: 2
  - id: sample_name
    type: string
    doc: Name of the sample being recalled
    inputBinding:
      position: 3
  - id: bam_file
    type: File
    doc: Input BAM file
    inputBinding:
      position: 4
  - id: vcf_file
    type: File
    doc: Input VCF file with positions to recall
    inputBinding:
      position: 5
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of cores to use
    inputBinding:
      position: 106
      prefix: --cores
  - id: mem
    type:
      - 'null'
      - int
    doc: Memory in GB to use
    inputBinding:
      position: 106
      prefix: --mem
outputs:
  - id: out_file
    type: File
    doc: Output VCF file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcbio-variation-recall:0.2.6--0
