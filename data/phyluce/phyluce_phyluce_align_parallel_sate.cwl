cwlVersion: v1.2
class: CommandLineTool
baseCommand: [phyluce_align_parallel_sate]
label: phyluce_phyluce_align_parallel_sate
doc: "Run SATe alignments in parallel on a directory of FASTA files.\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: input
    type: Directory
    doc: "The input directory containing fasta files."
    inputBinding:
      position: 1
      prefix: --input
  - id: output
    type: string
    doc: "The output directory to hold alignments (the folder is created before the run)."
    inputBinding:
      position: 2
      prefix: --output
  - id: sate_conf
    type: File
    doc: "The path to the SATe config file."
    inputBinding:
      position: 3
      prefix: --sate-conf
  - id: cores
    type: ['null', int]
    doc: "The number of compute cores to use."
    inputBinding:
      position: 4
      prefix: --cores
outputs:
  - id: output_dir
    type: Directory
    doc: "Directory holding the SATe alignments."
    outputBinding:
      glob: "$(inputs.output)"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - "${ return {class: 'Directory', basename: inputs.output, listing: [], writable: true}; }"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
