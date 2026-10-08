cwlVersion: v1.2
class: CommandLineTool
baseCommand: reads_processing.py
label: frogs_reads_processing
doc: "Pre-process reads and denoise or cluster them. Run as reads_processing.py <illumina|longreads|454> [options].\n\nTool homepage: https://github.com/geraldinepascal/FROGS"
inputs:
  - id: sequencer
    type: {type: enum, symbols: [illumina, longreads, '454']}
    doc: "Sequencing technology sub-command: illumina, longreads or 454."
    inputBinding:
      position: 1
  - id: nb_cpus
    type: ['null', int]
    doc: "The maximum number of CPUs used. [Default: 1]"
    inputBinding:
      position: 2
      prefix: --nb-cpus
  - id: debug
    type: ['null', boolean]
    doc: "Keep temporary files to debug program. [Default: False]"
    inputBinding:
      position: 3
      prefix: --debug
  - id: R1_size
    type: ['null', int]
    doc: "The read1 size."
    inputBinding:
      position: 4
      prefix: --R1-size
  - id: R2_size
    type: ['null', int]
    doc: "The read2 size."
    inputBinding:
      position: 5
      prefix: --R2-size
  - id: already_contiged
    type: ['null', boolean]
    doc: "The archive contains 1 file by sample : Reads 1 and Reads 2 are already contiged by pair. [Default: False]"
    inputBinding:
      position: 6
      prefix: --already-contiged
  - id: merge_software
    type: ['null', {type: enum, symbols: [vsearch, flash, pear]}]
    doc: "Software used to merge paired reads"
    inputBinding:
      position: 7
      prefix: --merge-software
  - id: quality_scale
    type: ['null', {type: enum, symbols: ['33', '64']}]
    doc: "The phred base quality scale, either 33 or 64 if using Vsearch as read pair merge software [Default: 33]"
    inputBinding:
      position: 8
      prefix: --quality-scale
  - id: expected_amplicon_size
    type: ['null', int]
    doc: "The expected size for the majority of the amplicons (with primers), if using Flash as read pair merge software."
    inputBinding:
      position: 9
      prefix: --expected-amplicon-size
  - id: keep_unmerged
    type: ['null', boolean]
    doc: "In case of uncontiged paired reads, keep unmerged, and artificially combined them with 100 Ns. [Default: False]"
    inputBinding:
      position: 10
      prefix: --keep-unmerged
  - id: five_prim_primer
    type: ['null', string]
    doc: "The 5' primer sequence (wildcards are accepted)."
    inputBinding:
      position: 11
      prefix: --five-prim-primer
  - id: three_prim_primer
    type: ['null', string]
    doc: "The 3' primer sequence (wildcards are accepted)."
    inputBinding:
      position: 12
      prefix: --three-prim-primer
  - id: without_primers
    type: ['null', boolean]
    doc: "Use this option when you use custom sequencing primers and these primers are the PCR primers. In this case the reads do not contain the PCR primers. [Default: False]"
    inputBinding:
      position: 13
      prefix: --without-primers
  - id: mismatch_rate
    type: ['null', float]
    doc: "Maximum mismatch rate in overlap region. [Default: 0.1; must be expressed as decimal, between 0 and 1]"
    inputBinding:
      position: 14
      prefix: --mismatch-rate
  - id: min_amplicon_size
    type: ['null', int]
    doc: "The minimum size for the amplicons (with primers)."
    inputBinding:
      position: 15
      prefix: --min-amplicon-size
  - id: max_amplicon_size
    type: ['null', int]
    doc: "The maximum size for the amplicons (with primers)."
    inputBinding:
      position: 16
      prefix: --max-amplicon-size
  - id: process
    type: ['null', {type: enum, symbols: [swarm, dada2, preprocess-only]}]
    doc: "Choose between performing only dereplication and using swarm or dada2 to build ASVs (dada2 is not available for 454) [Default: swarm]"
    inputBinding:
      position: 17
      prefix: --process
  - id: pre_clustering
    type: ['null', boolean]
    doc: "denoise data by clustering read with distance=1 before perform real clustering. It is mutually exclusive with --fastidious. [Default: False]"
    inputBinding:
      position: 18
      prefix: --pre-clustering
  - id: distance
    type: ['null', int]
    doc: "Maximum distance between sequences in each aggregation step. RECOMMENDED : d=1 in combination with --fastidious option [Default: 1]"
    inputBinding:
      position: 19
      prefix: --distance
  - id: fastidious
    type: ['null', boolean]
    doc: "use the fastidious option of swarm to refine cluster. RECOMMENDED in combination with a distance equal to 1 (-d). it is only usable with d=1 and mutually exclusive with --pre-clustering. [Default: False]"
    inputBinding:
      position: 20
      prefix: --fastidious
  - id: output_compo_path
    type: ['null', string]
    doc: "This output file will contain the composition of each cluster (format: TSV). One Line is a cluster ; each column is a sequence ID. [Default: clustering_swarms_composition.tsv]"
    inputBinding:
      position: 21
      prefix: --output-compo
  - id: sample_inference
    type: ['null', {type: enum, symbols: [pseudo-pooling, independent, pooling]}]
    doc: "Independent, pseudo-pooling of full pooling for dada2 samples processing. [Default: pseudo-pooling]"
    inputBinding:
      position: 22
      prefix: --sample-inference
  - id: samples_names
    type: ['null', {type: array, items: string}]
    doc: "The sample name for each R1/R2-files."
    inputBinding:
      position: 23
      prefix: --samples-names
  - id: input_archive
    type: ['null', File]
    doc: "The tar file containing R1 file and R2 file for each sample."
    inputBinding:
      position: 24
      prefix: --input-archive
  - id: input_R1
    type: ['null', {type: array, items: File}]
    doc: "The R1 sequence file for each sample (format: fastq)."
    inputBinding:
      position: 25
      prefix: --input-R1
  - id: input_R2
    type: ['null', {type: array, items: File}]
    doc: "The R2 sequence file for each sample (format: fastq)."
    inputBinding:
      position: 26
      prefix: --input-R2
  - id: output_biom_path
    type: ['null', string]
    doc: "This output file will contain the abundance by sample for each cluster or ASV (format: BIOM). [Default: reads_processing_abundance.biom]"
    inputBinding:
      position: 27
      prefix: --output-biom
  - id: output_fasta_path
    type: ['null', string]
    doc: "This output file will contain the sequence for each cluster or ASV (format: FASTA). [Default: sequences.fasta]"
    inputBinding:
      position: 28
      prefix: --output-fasta
  - id: html_path
    type: ['null', string]
    doc: "The HTML file containing the graphs. [Default: reads_processing.html]"
    inputBinding:
      position: 29
      prefix: --html
  - id: log_file_path
    type: ['null', string]
    doc: "This output file will contain several information on executed commands."
    inputBinding:
      position: 30
      prefix: --log-file
outputs:
  - id: output_compo
    type: ['null', File]
    doc: "This output file will contain the composition of each cluster (format: TSV). One Line is a cluster ; each column is a sequence ID. [Default: clustering_swarms_composition.tsv]"
    outputBinding:
      glob: '${ return inputs.output_compo_path ? inputs.output_compo_path : ''clustering_swarms_composition.tsv''; }'
  - id: output_biom
    type: ['null', File]
    doc: "This output file will contain the abundance by sample for each cluster or ASV (format: BIOM). [Default: reads_processing_abundance.biom]"
    outputBinding:
      glob: '${ return inputs.output_biom_path ? inputs.output_biom_path : ''reads_processing_abundance.biom''; }'
  - id: output_fasta
    type: ['null', File]
    doc: "This output file will contain the sequence for each cluster or ASV (format: FASTA). [Default: sequences.fasta]"
    outputBinding:
      glob: '${ return inputs.output_fasta_path ? inputs.output_fasta_path : ''sequences.fasta''; }'
  - id: html
    type: ['null', File]
    doc: "The HTML file containing the graphs. [Default: reads_processing.html]"
    outputBinding:
      glob: '${ return inputs.html_path ? inputs.html_path : ''reads_processing.html''; }'
  - id: log_file
    type: ['null', File]
    doc: "This output file will contain several information on executed commands."
    outputBinding:
      glob: '${ return inputs.log_file_path ? inputs.log_file_path : ''reads_processing_stdout.txt''; }'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
stdout: reads_processing_stdout.txt
