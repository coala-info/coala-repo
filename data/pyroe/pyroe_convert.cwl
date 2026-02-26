cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyroe_convert
label: pyroe_convert
doc: "Convert quantification data to various formats.\n\nTool homepage: https://github.com/COMBINE-lab/pyroe"
inputs:
  - id: quant_dir
    type: Directory
    doc: The input quantification directory containing the matrix to be 
      converted.
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: The output name where the quantification matrix should be written. For 
      `csvs` output format, this will be a directory. For all others, it will be
      a file.
    inputBinding:
      position: 2
  - id: geneid_to_name
    type:
      - 'null'
      - File
    doc: A 2 column tab-separated list of gene ID to gene name mappings. 
      Providing this file will project gene IDs to gene names in the output.
    inputBinding:
      position: 103
      prefix: --geneid-to-name
  - id: output_format
    type:
      - 'null'
      - string
    doc: The format in which the output should be written, one of {'h5ad', 
      'csvs', 'loom', 'zarr'}.
    inputBinding:
      position: 103
      prefix: --output-format
  - id: output_structure
    type:
      - 'null'
      - string
    doc: The structure that U,S and A counts should occupy in the output matrix.
    inputBinding:
      position: 103
      prefix: --output-structure
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyroe:0.9.3--pyhdfd78af_0
stdout: pyroe_convert.out
