cwlVersion: v1.2
class: CommandLineTool
baseCommand: valet_valet.py
label: valet_valet.py
doc: "VAriant calling evaLuatIon Tool (VALET) - evaluates variant calling performance
  by comparing VCF files against a reference and alignment data.\n\nTool homepage:
  https://github.com/marbl/VALET"
inputs:
  - id: intervals
    type:
      - 'null'
      - File
    doc: Intervals file (BED format) to restrict evaluation
    inputBinding:
      position: 101
      prefix: --intervals
  - id: reference
    type: File
    doc: Reference genome file (FASTA)
    inputBinding:
      position: 101
      prefix: --ref
  - id: sam
    type: File
    doc: Input SAM or BAM file
    inputBinding:
      position: 101
      prefix: --sam
  - id: sample_name
    type:
      - 'null'
      - string
    doc: Name of the sample for reporting
    inputBinding:
      position: 101
      prefix: --sample-name
  - id: vcf
    type: File
    doc: Input VCF file to evaluate
    inputBinding:
      position: 101
      prefix: --vcf
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Directory to write output files
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/valet:1.0--3
