cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phyluce_genetrees_sort_multilocus_bootstraps
label: phyluce_phyluce_genetrees_sort_multilocus_bootstraps
doc: "Sorts RAxML bootstrap output into multi-locus bootstrap replicates.\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: input
    type: Directory
    doc: "The input directory containing bootstrap replicates for each locus"
    inputBinding:
      position: 1
      prefix: --input
  - id: bootstrap_replicates
    type: File
    doc: "The file containing bootstrap replicate sampling"
    inputBinding:
      position: 2
      prefix: --bootstrap_replicates
  - id: output
    type: string
    doc: "The output directory to multi-locus bootstraps. The program requires that it already exists, so it is created in the working directory before the run."
    inputBinding:
      position: 3
      prefix: --output
outputs:
  - id: output_dir
    type: Directory
    doc: "The directory with the multi-locus bootstrap replicate files (boot000, boot001, ...)."
    outputBinding:
      glob: "$(inputs.output)"
  - id: stdout_log
    type: File
    doc: "Standard output of the program."
    outputBinding:
      glob: "sort_multilocus_bootstraps.stdout.txt"
stdout: sort_multilocus_bootstraps.stdout.txt
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '$({"class": "Directory", "basename": inputs.output, "listing": []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
