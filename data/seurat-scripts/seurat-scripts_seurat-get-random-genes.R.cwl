cwlVersion: v1.2
class: CommandLineTool
baseCommand: seurat-get-random-genes.R
label: seurat-scripts_seurat-get-random-genes.R
doc: "Fetch a set of random genes from a serialized Seurat object. The set is random but reproducible (fixed seed 42). The script takes three positional arguments and prints no help.\n\nTool homepage: https://github.com/ebi-gene-expression-group/r-seurat-scripts"
inputs:
  - id: input_object_file
    type: File
    doc: Input file with a serialized Seurat object (RDS).
    inputBinding:
      position: 1
  - id: output_text_file
    type: string
    doc: Output text file with one gene name per line.
    inputBinding:
      position: 2
  - id: ngenes
    type: int
    doc: Number of random genes to fetch.
    inputBinding:
      position: 3
outputs:
  - id: genes_file
    type: File
    doc: Text file with the random gene names.
    outputBinding:
      glob: $(inputs.output_text_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
