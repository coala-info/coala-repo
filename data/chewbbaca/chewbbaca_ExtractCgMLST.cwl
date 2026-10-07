cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - chewBBACA.py
  - ExtractCgMLST
label: chewbbaca_ExtractCgMLST
doc: "Determine the set of loci that constitute the core genome.\n\nTool homepage: https://github.com/B-UMMI/chewBBACA"
inputs:
  - id: input_file
    type: File
    doc: "Path to the TSV file that contains the allelic profiles determined by the AlleleCall module."
    inputBinding:
      position: 1
      prefix: --input-file
  - id: output_directory
    type: string
    doc: "Path to the directory where the process will store the output files."
    default: "cgmlst_out"
    inputBinding:
      position: 1
      prefix: --output-directory
  - id: threshold
    type:
      - 'null'
      - type: array
        items: float
    doc: "Genes that constitute the core genome must be in a proportion of genomes that is at least equal to this value. Provide multiple values to compute the core genome for multiple threshold values. (default: [0.95, 0.99, 1])"
    inputBinding:
      position: 1
      prefix: --threshold
  - id: step
    type:
      - 'null'
      - int
    doc: "Number of profiles added in each iteration until all profiles are included. (default: 1)"
    inputBinding:
      position: 1
      prefix: --step
  - id: genes2remove
    type:
      - 'null'
      - File
    doc: "Path to a file with a list of gene IDs to exclude from the analysis (one gene identifier per line)."
    inputBinding:
      position: 1
      prefix: --genes2remove
  - id: genomes2remove
    type:
      - 'null'
      - File
    doc: "Path to a file with a list of genome IDs to exclude from the analysis (one genome identifier per line)."
    inputBinding:
      position: 1
      prefix: --genomes2remove
outputs:
  - id: results_dir
    type: Directory
    doc: "Core genome results directory."
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chewbbaca:3.5.1--pyhdfd78af_0
