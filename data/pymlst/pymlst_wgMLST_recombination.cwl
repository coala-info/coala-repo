cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wgMLST
  - recombination
label: pymlst_wgMLST_recombination
doc: "Searches potential gene recombinations from wgMLST database export.\n\nTool homepage: https://github.com/bvalot/pyMLST"
inputs:
  - id: genes
    type: File
    doc: "Gene list (output of wgMLST gene)"
    inputBinding:
      position: 1
  - id: alignment
    type: File
    doc: "Alignment in fasta format (output of wgMLST msa)"
    inputBinding:
      position: 2
  - id: output_path
    type: ['null', string]
    doc: "Output number of variations by genes (default:stdout)."
    inputBinding:
      position: 10
      prefix: --output
outputs:
  - id: output
    type: ['null', File]
    doc: "Number of variations by gene written with output_path"
    outputBinding:
      glob: "$(inputs.output_path)"
  - id: stdout
    type: stdout
    doc: "Standard output (result when no output file is given)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pymlst:2.2.2--pyhdfd78af_0
stdout: pymlst_wgMLST_recombination.out
