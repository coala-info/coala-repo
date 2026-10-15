cwlVersion: v1.2
class: CommandLineTool
baseCommand: [phyluce_align_get_ry_recoded_alignments]
label: phyluce_phyluce_align_get_ry_recoded_alignments
doc: "Recode alignments to R and Y (purine and pyrimidine) characters.\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: alignments
    type: Directory
    doc: "The input directory containing alignment files to filter."
    inputBinding:
      position: 1
      prefix: --alignments
  - id: output
    type: string
    doc: "The output directory to hold the converted alignments."
    inputBinding:
      position: 2
      prefix: --output
  - id: input_format
    type: ['null', string]
    doc: "The input alignment format. One of: fasta, nexus, phylip, phylip-relaxed, clustal, emboss, stockholm (default: nexus)."
    inputBinding:
      position: 3
      prefix: --input-format
  - id: output_format
    type: ['null', string]
    doc: "The output alignment format. One of: fasta, nexus, phylip, phylip-relaxed, clustal, emboss, stockholm (default: nexus)."
    inputBinding:
      position: 4
      prefix: --output-format
  - id: verbosity
    type: ['null', string]
    doc: "The logging level to use (INFO, WARN, CRITICAL)."
    inputBinding:
      position: 5
      prefix: --verbosity
  - id: log_path
    type: ['null', string]
    doc: "The path to an existing directory to hold logs."
    inputBinding:
      position: 6
      prefix: --log-path
  - id: cores
    type: ['null', int]
    doc: "Process alignments in parallel using --cores for alignment. This is the number of PHYSICAL CPUs."
    inputBinding:
      position: 7
      prefix: --cores
  - id: binary
    type: ['null', boolean]
    doc: "Output alignments in binary encoding (A or G) = 1 and (C or T) = 0."
    inputBinding:
      position: 8
      prefix: --binary
outputs:
  - id: output_dir
    type: Directory
    doc: "Directory of RY-recoded alignments."
    outputBinding:
      glob: "$(inputs.output)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
