cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - svtools
  - copynumber
label: svtools_copynumber
doc: 'Add copy number annotations (from CNVnator) to a VCF file.


  Tool homepage: https://github.com/hall-lab/svtools'
inputs:
  - id: coordinates
    type: File
    doc: File containing coordinate for which to retrieve copynumber (required)
    inputBinding:
      position: 101
      prefix: --coordinates
  - id: root_file
    type: File
    doc: CNVnator .root histogram file (required)
    inputBinding:
      position: 101
      prefix: --root
  - id: window
    type: int
    doc: CNVnator window size (required)
    inputBinding:
      position: 101
      prefix: --window
  - id: sample
    type: string
    doc: Sample to annotate (required)
    inputBinding:
      position: 101
      prefix: --sample
  - id: cnvnator
    type: string
    doc: Path to cnvnator binary for the cnvnator used by speedseq (required)
    inputBinding:
      position: 101
      prefix: --cnvnator
  - id: input_vcf
    type:
      - 'null'
      - File
    doc: VCF input
    inputBinding:
      position: 101
      prefix: --input
  - id: output_vcf
    type:
      - 'null'
      - string
    doc: 'Output VCF to write (default: stdout)'
    inputBinding:
      position: 101
      prefix: --output
  - id: tempdir
    type:
      - 'null'
      - string
    doc: Directory for temp file downloads
    inputBinding:
      position: 101
      prefix: --tempdir
outputs:
  - id: out_vcf
    type:
      - 'null'
      - File
    doc: Annotated VCF
    outputBinding:
      glob: $(inputs.output_vcf)
  - id: stdout
    type: stdout
    doc: Output when --output is not given
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svtools:0.5.1--py_0
stdout: svtools_copynumber.out
