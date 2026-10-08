cwlVersion: v1.2
class: CommandLineTool
baseCommand: normalisation.py
label: frogs_normalisation
doc: "Normalisation in BIOM by random sampling.\n\nTool homepage: https://github.com/geraldinepascal/FROGS"
inputs:
  - id: debug
    type: ['null', boolean]
    doc: "Keep temporary files to debug program. [Default: False]"
    inputBinding:
      position: 1
      prefix: --debug
  - id: num_reads
    type: ['null', int]
    doc: "Number of sampled sequences by sample."
    inputBinding:
      position: 2
      prefix: --num-reads
  - id: sampling_by_min
    type: ['null', boolean]
    doc: "Sampling by the number of sequences of the smallest sample. [Default: False]"
    inputBinding:
      position: 3
      prefix: --sampling-by-min
  - id: delete_samples
    type: ['null', boolean]
    doc: "Delete samples that have a number of sequences below the selected filter. [Default: False]"
    inputBinding:
      position: 4
      prefix: --delete-samples
  - id: input_biom
    type: File
    doc: "Abundances file to normalise (format: BIOM)."
    inputBinding:
      position: 5
      prefix: --input-biom
  - id: input_fasta
    type: File
    doc: "Sequences file to normalise (format: FASTA)."
    inputBinding:
      position: 6
      prefix: --input-fasta
  - id: output_biom_path
    type: ['null', string]
    doc: "Normalised abundances (format: BIOM). [Default: normalisation_abundance.biom]"
    inputBinding:
      position: 7
      prefix: --output-biom
  - id: output_fasta_path
    type: ['null', string]
    doc: "Normalised sequences (format: FASTA). [Default: normalisation.fasta]"
    inputBinding:
      position: 8
      prefix: --output-fasta
  - id: html_path
    type: ['null', string]
    doc: "The HTML file containing the graphs. [Default: normalisation.html]"
    inputBinding:
      position: 9
      prefix: --html
  - id: log_file_path
    type: ['null', string]
    doc: "The list of commands executed. [Default: stdout]"
    inputBinding:
      position: 10
      prefix: --log-file
outputs:
  - id: output_biom
    type: ['null', File]
    doc: "Normalised abundances (format: BIOM). [Default: normalisation_abundance.biom]"
    outputBinding:
      glob: '${ return inputs.output_biom_path ? inputs.output_biom_path : ''normalisation_abundance.biom''; }'
  - id: output_fasta
    type: ['null', File]
    doc: "Normalised sequences (format: FASTA). [Default: normalisation.fasta]"
    outputBinding:
      glob: '${ return inputs.output_fasta_path ? inputs.output_fasta_path : ''normalisation.fasta''; }'
  - id: html
    type: ['null', File]
    doc: "The HTML file containing the graphs. [Default: normalisation.html]"
    outputBinding:
      glob: '${ return inputs.html_path ? inputs.html_path : ''normalisation.html''; }'
  - id: log_file
    type: ['null', File]
    doc: "The list of commands executed. [Default: stdout]"
    outputBinding:
      glob: '${ return inputs.log_file_path ? inputs.log_file_path : ''normalisation_stdout.txt''; }'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
stdout: normalisation_stdout.txt
