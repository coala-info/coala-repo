cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fuc
  - vcf-index
label: fuc_vcf-index
doc: "Index a VCF file.\n\nTool homepage: https://github.com/sbslee/fuc"
inputs:
  - id: vcf
    type: File
    doc: Input VCF file to be indexed. When an uncompressed file is given, the command
      will automatically create a BGZF compressed copy of the file (.gz) before indexing.
    inputBinding:
      position: 1
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force to overwrite the index file if it is already present.
    inputBinding:
      position: 102
      prefix: --force
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: tbi
    type: File
    doc: Tabix index of the compressed VCF (<vcf>.tbi, or <vcf>.gz.tbi when the input
      is uncompressed)
    outputBinding:
      glob: '${ return inputs.vcf.basename.endsWith(''.gz'') ? inputs.vcf.basename
        + ''.tbi'' : inputs.vcf.basename + ''.gz.tbi''; }'
  - id: bgzf_copy
    type:
      - 'null'
      - File
    doc: BGZF compressed copy of an uncompressed input VCF (<vcf>.gz)
    outputBinding:
      glob: '${ return inputs.vcf.basename.endsWith(''.gz'') ? [] : inputs.vcf.basename
        + ''.gz''; }'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
stdout: fuc_vcf-index.out
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.vcf)
        writable: true
  - class: InlineJavascriptRequirement
