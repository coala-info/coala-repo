cwlVersion: v1.2
class: CommandLineTool
baseCommand: [phyluce_align_get_informative_sites]
label: phyluce_phyluce_align_get_informative_sites
doc: "Count the number of informative sites in a given set of alignment.\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: alignments
    type: Directory
    doc: "The directory containing the alignment files."
    inputBinding:
      position: 1
      prefix: --alignments
  - id: output
    type: ['null', string]
    doc: "The output filename (the table is printed to standard output when not given)."
    inputBinding:
      position: 2
      prefix: --output
  - id: input_format
    type: ['null', string]
    doc: "The input alignment format. One of: fasta, nexus, phylip, clustal, emboss, stockholm (default: nexus)."
    inputBinding:
      position: 3
      prefix: --input-format
  - id: cores
    type: ['null', int]
    doc: "The number of cores to use."
    inputBinding:
      position: 4
      prefix: --cores
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
outputs:
  - id: output_csv
    type: ['null', File]
    doc: "CSV table of informative sites by locus."
    outputBinding:
      glob: "$(inputs.output)"
  - id: report
    type: stdout
    doc: "Table of informative sites by locus when --output is not given."
stdout: phyluce_align_get_informative_sites.stdout.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
