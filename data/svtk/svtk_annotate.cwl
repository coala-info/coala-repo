cwlVersion: v1.2
class: CommandLineTool
baseCommand: svtk
label: svtk_annotate
doc: "Annotate resolved SV with genic effects and noncoding hits.\n\nTool homepage:
  https://github.com/talkowski-lab/svtk"
inputs:
  - id: vcf
    type: File
    doc: Structural variants.
    inputBinding:
      position: 1
  - id: annotated_vcf
    type: File
    doc: Annotated variants.
    inputBinding:
      position: 2
  - id: gencode
    type:
      - 'null'
      - File
    doc: Gencode gene annotations (GTF).
    inputBinding:
      position: 103
      prefix: --gencode
  - id: noncoding
    type:
      - 'null'
      - File
    doc: Noncoding elements (bed). Columns = 
      chr,start,end,element_class,element_name
    inputBinding:
      position: 103
      prefix: --noncoding
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svtk:0.0.20190615--py39hbcbf7aa_7
stdout: svtk_annotate.out
