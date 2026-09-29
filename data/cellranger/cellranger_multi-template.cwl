cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cellranger
  - multi-template
label: cellranger_multi-template
doc: Output cellranger multi config CSV template for analyzing Single Cell Gene 
  Expression with Feature Barcode Technology, Flex Gene Expression, on-chip 
  multiplexing, hashing with Antibody Capture, or Single Cell Immune Profiling 
  data.
inputs:
  - id: parameters
    type:
      - 'null'
      - boolean
    doc: See descriptions of all parameters
    inputBinding:
      position: 101
      prefix: --parameters
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: cumulusprod/cellranger:10.1.0
stdout: cellranger_multi-template.out
s:url: https://github.com/10XGenomics/cellranger
$namespaces:
  s: https://schema.org/
