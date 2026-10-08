cwlVersion: v1.2
class: CommandLineTool
baseCommand: remove_chimera.py
label: frogs_remove_chimera
doc: "Removes PCR chimera.\n\nTool homepage: https://github.com/geraldinepascal/FROGS"
inputs:
  - id: debug
    type: ['null', boolean]
    doc: "Keep temporary files to debug program. [Default: False]"
    inputBinding:
      position: 1
      prefix: --debug
  - id: nb_cpus
    type: ['null', int]
    doc: "The maximum number of CPUs used. [Default: 1]"
    inputBinding:
      position: 2
      prefix: --nb-cpus
  - id: long_reads
    type: ['null', boolean]
    doc: "If original sequences were long reads, use chimera_denovo algorithm to detect chimera, else, i.e for short reads, use uchime_denovo [Default: False]"
    inputBinding:
      position: 3
      prefix: --long-reads
  - id: input_fasta
    type: File
    doc: "The cluster sequences (format: FASTA)."
    inputBinding:
      position: 4
      prefix: --input-fasta
  - id: input_biom
    type: File
    doc: "The abundance file for clusters by sample (format: BIOM)."
    inputBinding:
      position: 5
      prefix: --input-biom
  - id: output_fasta_path
    type: ['null', string]
    doc: "sequences file without chimera (format: FASTA). [Default: remove_chimera.fasta]"
    inputBinding:
      position: 6
      prefix: --output-fasta
  - id: output_biom_path
    type: ['null', string]
    doc: "Abundance file without chimera (format: BIOM). [Default: remove_chimera_abundance.biom]"
    inputBinding:
      position: 7
      prefix: --output-biom
  - id: html_path
    type: ['null', string]
    doc: "The HTML file containing the graphs. [Default: remove_chimera.html]"
    inputBinding:
      position: 8
      prefix: --html
  - id: log_file_path
    type: ['null', string]
    doc: "This output file will contain several informations on executed commands. [Default: stdout]"
    inputBinding:
      position: 9
      prefix: --log-file
outputs:
  - id: output_fasta
    type: ['null', File]
    doc: "sequences file without chimera (format: FASTA). [Default: remove_chimera.fasta]"
    outputBinding:
      glob: '${ return inputs.output_fasta_path ? inputs.output_fasta_path : ''remove_chimera.fasta''; }'
  - id: output_biom
    type: ['null', File]
    doc: "Abundance file without chimera (format: BIOM). [Default: remove_chimera_abundance.biom]"
    outputBinding:
      glob: '${ return inputs.output_biom_path ? inputs.output_biom_path : ''remove_chimera_abundance.biom''; }'
  - id: html
    type: ['null', File]
    doc: "The HTML file containing the graphs. [Default: remove_chimera.html]"
    outputBinding:
      glob: '${ return inputs.html_path ? inputs.html_path : ''remove_chimera.html''; }'
  - id: log_file
    type: ['null', File]
    doc: "This output file will contain several informations on executed commands. [Default: stdout]"
    outputBinding:
      glob: '${ return inputs.log_file_path ? inputs.log_file_path : ''remove_chimera_stdout.txt''; }'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
stdout: remove_chimera_stdout.txt
