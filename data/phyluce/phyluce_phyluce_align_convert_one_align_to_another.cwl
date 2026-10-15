cwlVersion: v1.2
class: CommandLineTool
baseCommand: [phyluce_align_convert_one_align_to_another]
label: phyluce_phyluce_align_convert_one_align_to_another
doc: "Convert alignments from one format to another.\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: alignments
    type: Directory
    doc: "The directory containing the alignments to convert."
    inputBinding:
      position: 1
      prefix: --alignments
  - id: output
    type: string
    doc: "An output directory to hold the converted alignments."
    inputBinding:
      position: 2
      prefix: --output
  - id: input_format
    type: ['null', string]
    doc: "The input alignment format. One of: fasta, nexus, phylip, phylip-relaxed, phylip-sequential, clustal, emboss, stockholm (default: fasta)."
    inputBinding:
      position: 3
      prefix: --input-format
  - id: output_format
    type: ['null', string]
    doc: "The output alignment format. One of: fasta, nexus, phylip, phylip-relaxed, phylip-sequential, clustal, emboss, stockholm (default: fasta)."
    inputBinding:
      position: 4
      prefix: --output-format
  - id: cores
    type: ['null', int]
    doc: "The number of compute cores to use."
    inputBinding:
      position: 5
      prefix: --cores
  - id: shorten_names
    type: ['null', boolean]
    doc: "Convert names to a 6 or 7 character representation."
    inputBinding:
      position: 6
      prefix: --shorten-names
  - id: name_conf
    type: ['null', File]
    doc: "A config-formatted file containing full-name:shortname mappings."
    inputBinding:
      position: 7
      prefix: --name-conf
  - id: verbosity
    type: ['null', string]
    doc: "The logging level to use (INFO, WARN, CRITICAL)."
    inputBinding:
      position: 8
      prefix: --verbosity
  - id: log_path
    type: ['null', string]
    doc: "The path to an existing directory to hold logs."
    inputBinding:
      position: 9
      prefix: --log-path
outputs:
  - id: output_dir
    type: Directory
    doc: "Directory of converted alignments."
    outputBinding:
      glob: "$(inputs.output)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
