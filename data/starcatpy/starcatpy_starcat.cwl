cwlVersion: v1.2
class: CommandLineTool
baseCommand: starcat
label: starcatpy_starcat
doc: "A tool for analyzing gene expression patterns.\n\nTool homepage: https://github.com/immunogenomics/starCAT"
inputs:
  - id: counts
    type:
      - 'null'
      - File
    doc: Input (cell x gene) counts matrix as df.npz, tab delimited text file, 
      or anndata file (h5ad)
    inputBinding:
      position: 101
      prefix: --counts
  - id: name
    type:
      - 'null'
      - string
    doc: Name for analysis. All output will be placed in [output-dir]/[name]...
    inputBinding:
      position: 101
      prefix: --name
  - id: reference
    type:
      - 'null'
      - File
      - string
    doc: File containing a reference set of GEPs by genes (*.tsv/.csv/.txt) OR 
      the name of a default reference to use (ex. TCAT.V1).
    inputBinding:
      position: 101
      prefix: --reference
  - id: scores
    type:
      - 'null'
      - File
    doc: Optional path to yaml file for calculating score add-ons. Not necessary
      for pre-built references
    inputBinding:
      position: 101
      prefix: --scores
  - id: output_dir_path
    type:
      - 'null'
      - string
    inputBinding:
      position: 102
      prefix: --output-dir
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory. All output will be placed in [output-dir]/[name]...
    outputBinding:
      glob: $(inputs.output_dir_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - |
        ${
          if (inputs.output_dir_path) {
            return [{"entryname": inputs.output_dir_path, "entry": {"class": "Directory", "basename": inputs.output_dir_path, "listing": []}, "writable": true}];
          }
          return [];
        }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/starcatpy:1.0.9--pyh7e72e81_0
