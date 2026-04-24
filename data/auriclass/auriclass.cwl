cwlVersion: v1.2
class: CommandLineTool
baseCommand: auriclass
label: auriclass
doc: "AuriClass predicts Candida auris clade from Illumina WGS data\n\nTool homepage:
  https://rivm-bioinformatics.github.io/auriclass/"
inputs:
  - id: read_file_paths
    type:
      type: array
      items: File
    doc: Paths to read files
    inputBinding:
      position: 1
  - id: clade_config_path
    type:
      - 'null'
      - File
    doc: Path to clade config
    inputBinding:
      position: 102
      prefix: --clade_config_path
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Very verbose output
    inputBinding:
      position: 102
      prefix: --debug
  - id: expected_genome_size
    type:
      - 'null'
      - type: array
        items: int
    doc: Expected genome size range. Defaults 11.4-14.6 Mb are based on 150 NCBI
      genomes and take mash genome size overestimation into account.
      - 11400000
      - 14900000
    inputBinding:
      position: 102
      prefix: --expected_genome_size
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: Input files are fasta files
    inputBinding:
      position: 102
      prefix: --fasta
  - id: fastq
    type:
      - 'null'
      - boolean
    doc: Input files are fastq files
    inputBinding:
      position: 102
      prefix: --fastq
  - id: high_dist_threshold
    type:
      - 'null'
      - float
    doc: If the minimal distance from a reference sample is above this 
      threshold, a warning is emitted. See the docs for more info.
    inputBinding:
      position: 102
      prefix: --high_dist_threshold
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: Kmer size
    inputBinding:
      position: 102
      prefix: --kmer_size
  - id: log_file_path
    type:
      - 'null'
      - File
    doc: Path to log file
    inputBinding:
      position: 102
      prefix: --log_file_path
  - id: minimal_kmer_coverage
    type:
      - 'null'
      - int
    doc: Minimal kmer coverage
    inputBinding:
      position: 102
      prefix: --minimal_kmer_coverage
  - id: name
    type:
      - 'null'
      - string
    doc: Name of isolate
    inputBinding:
      position: 102
      prefix: --name
  - id: no_qc
    type:
      - 'null'
      - boolean
    doc: Skip extended QC
    inputBinding:
      position: 102
      prefix: --no_qc
  - id: non_candida_threshold
    type:
      - 'null'
      - float
    doc: If the minimal distance from a reference sample is above this 
      threshold, the sample might not be a Candida sp.
    inputBinding:
      position: 102
      prefix: --non_candida_threshold
  - id: reference_sketch_path
    type:
      - 'null'
      - File
    doc: Path to reference sketch
    inputBinding:
      position: 102
      prefix: --reference_sketch_path
  - id: sketch_size
    type:
      - 'null'
      - int
    doc: Sketch size
    inputBinding:
      position: 102
      prefix: --sketch_size
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_report_path
    type:
      - 'null'
      - File
    doc: Path to output report
    outputBinding:
      glob: $(inputs.output_report_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/auriclass:0.5.4--pyhdfd78af_0
