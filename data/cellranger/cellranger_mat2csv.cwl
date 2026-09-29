cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cellranger
  - mat2csv
label: cellranger_mat2csv
doc: Tool for converting feature-barcode matrices from sparse format to dense 
  CSV format, for use by external programs.
inputs:
  - id: input_path
    type: File
    doc: Path to a Cell Ranger feature-barcode matrix. Can be either a 
      feature-barcode h5 file (recommended) or a path to a MEX Cell Ranger 
      output folder.
    inputBinding:
      position: 1
  - id: output_csv
    type: string
    doc: Output CSV file.
    inputBinding:
      position: 2
  - id: genome
    type:
      - 'null'
      - string
    doc: Specify which genome to extract. This only applies to multi-genome h5 
      input files.
    inputBinding:
      position: 103
      prefix: --genome
outputs:
  - id: out_output_csv
    type: File
    doc: Output CSV file.
    outputBinding:
      glob: $(inputs.output_csv)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: cumulusprod/cellranger:10.1.0
s:url: https://github.com/10XGenomics/cellranger
$namespaces:
  s: https://schema.org/
