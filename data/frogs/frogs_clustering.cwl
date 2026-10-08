cwlVersion: v1.2
class: CommandLineTool
baseCommand: clustering.py
label: frogs_clustering
doc: "Single-linkage clustering on sequences.\n\nTool homepage: https://github.com/geraldinepascal/FROGS"
inputs:
  - id: nb_cpus
    type: ['null', int]
    doc: "The maximum number of CPUs used. [Default: 1]"
    inputBinding:
      position: 1
      prefix: --nb-cpus
  - id: debug
    type: ['null', boolean]
    doc: "Keep temporary files to debug program."
    inputBinding:
      position: 2
      prefix: --debug
  - id: distance
    type: ['null', int]
    doc: "Maximum distance between sequences in each aggregation step. RECOMMENDED : d=1 in combination with --fastidious option [Default: 1]"
    inputBinding:
      position: 3
      prefix: --distance
  - id: fastidious
    type: ['null', boolean]
    doc: "use the fastidious option of swarm to refine ASV. RECOMMENDED in combination with a distance equal to 1 (-d). it is only usable with d=1 and mutually exclusive with --denoising."
    inputBinding:
      position: 4
      prefix: --fastidious
  - id: denoising
    type: ['null', boolean]
    doc: "denoise data by clustering read with distance=1 before perform real clustering. It is mutually exclusive with --fastidious."
    inputBinding:
      position: 5
      prefix: --denoising
  - id: input_fasta
    type: File
    doc: "The sequences file (format: FASTA)."
    inputBinding:
      position: 6
      prefix: --input-fasta
  - id: input_count
    type: File
    doc: "The count file for 'fasta-file' (format: TSV). It contains the count by sample for each sequence."
    inputBinding:
      position: 7
      prefix: --input-count
  - id: output_biom_path
    type: ['null', string]
    doc: "This output file will contain the abondance by sample for each cluster (format: BIOM). [Default: clustering_abundance.biom]"
    inputBinding:
      position: 8
      prefix: --output-biom
  - id: output_fasta_path
    type: ['null', string]
    doc: "This output file will contain the seed sequence for each cluster (format: FASTA). [Default: clustering_seeds.fasta]"
    inputBinding:
      position: 9
      prefix: --output-fasta
  - id: output_compo_path
    type: ['null', string]
    doc: "This output file will contain the composition of each cluster (format: TSV). One Line is a cluster ; each column is a sequence ID. [Default: clustering_swarms_composition.tsv]"
    inputBinding:
      position: 10
      prefix: --output-compo
  - id: log_file_path
    type: ['null', string]
    doc: "This output file will contain several information on executed commands."
    inputBinding:
      position: 11
      prefix: --log-file
outputs:
  - id: output_biom
    type: ['null', File]
    doc: "This output file will contain the abondance by sample for each cluster (format: BIOM). [Default: clustering_abundance.biom]"
    outputBinding:
      glob: '${ return inputs.output_biom_path ? inputs.output_biom_path : ''clustering_abundance.biom''; }'
  - id: output_fasta
    type: ['null', File]
    doc: "This output file will contain the seed sequence for each cluster (format: FASTA). [Default: clustering_seeds.fasta]"
    outputBinding:
      glob: '${ return inputs.output_fasta_path ? inputs.output_fasta_path : ''clustering_seeds.fasta''; }'
  - id: output_compo
    type: ['null', File]
    doc: "This output file will contain the composition of each cluster (format: TSV). One Line is a cluster ; each column is a sequence ID. [Default: clustering_swarms_composition.tsv]"
    outputBinding:
      glob: '${ return inputs.output_compo_path ? inputs.output_compo_path : ''clustering_swarms_composition.tsv''; }'
  - id: log_file
    type: ['null', File]
    doc: "This output file will contain several information on executed commands."
    outputBinding:
      glob: '${ return inputs.log_file_path ? inputs.log_file_path : ''clustering_stdout.txt''; }'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
stdout: clustering_stdout.txt
