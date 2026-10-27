cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vt
  - index
label: vt_index
doc: "Indexes a VCF.GZ or BCF file.\n\nTool homepage: https://github.com/atks/vt"
inputs:
  - id: input_vcf
    type: File
    doc: Input VCF.GZ or BCF file
    inputBinding:
      position: 1
  - id: print_options
    type:
      - 'null'
      - boolean
    doc: print options and summary
    inputBinding:
      position: 102
      prefix: -p
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: indexed_file
    type: File
    doc: The input file with its new index (.tbi for VCF.GZ, .csi for BCF)
    secondaryFiles:
      - pattern: .tbi
        required: false
      - pattern: .csi
        required: false
    outputBinding:
      glob: $(inputs.input_vcf.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_vcf)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vt:2015.11.10--2
stdout: vt_index.out
