cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - koverage
  - config
label: koverage_config
doc: "Copy the system default config file\n\nTool homepage: https://github.com/beardymcjohnface/Koverage"
inputs:
  - id: snake_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional arguments for Snakemake
    inputBinding:
      position: 1
  - id: bin_width
    type:
      - 'null'
      - int
    doc: Bin width for estimating read depth variance
    default: 100
    inputBinding:
      position: 102
      prefix: --bin-width
  - id: conda_prefix
    type:
      - 'null'
      - Directory
    doc: Custom conda env directory
    inputBinding:
      position: 102
      prefix: --conda-prefix
  - id: configfile
    type:
      - 'null'
      - string
    doc: Custom config file
    default: (outputDir)/koverage.config.yaml
    inputBinding:
      position: 102
      prefix: --configfile
  - id: kmer_max
    type:
      - 'null'
      - int
    doc: Max kmers to sample per contig
    default: 5000
    inputBinding:
      position: 102
      prefix: --kmer-max
  - id: kmer_min
    type:
      - 'null'
      - int
    doc: Min kmers to try to sample per contig
    default: 50
    inputBinding:
      position: 102
      prefix: --kmer-min
  - id: kmer_sample
    type:
      - 'null'
      - int
    doc: Sample every [INT]th kmer
    default: 100
    inputBinding:
      position: 102
      prefix: --kmer-sample
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: Size of kmers to use
    default: 25
    inputBinding:
      position: 102
      prefix: --kmer-size
  - id: minimap
    type:
      - 'null'
      - string
    doc: Minimap preset
    default: sr
    inputBinding:
      position: 102
      prefix: --minimap
  - id: no_report
    type:
      - 'null'
      - boolean
    doc: Generate HTML summary report of coverage
    inputBinding:
      position: 102
      prefix: --no-report
  - id: no_use_conda
    type:
      - 'null'
      - boolean
    doc: Use conda for Snakemake rules
    inputBinding:
      position: 102
      prefix: --no-use-conda
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory
    default: koverage.out
    inputBinding:
      position: 102
      prefix: --output
  - id: pafs
    type:
      - 'null'
      - boolean
    doc: Save the (compressed) PAF files
    inputBinding:
      position: 102
      prefix: --pafs
  - id: report
    type:
      - 'null'
      - boolean
    doc: Generate HTML summary report of coverage
    inputBinding:
      position: 102
      prefix: --report
  - id: report_max_ctg
    type:
      - 'null'
      - int
    doc: Only include the top N contigs by coverage in the summary HMTL report 
      (use -1 for all contigs)
    default: 1000
    inputBinding:
      position: 102
      prefix: --report-max-ctg
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 8
    inputBinding:
      position: 102
      prefix: --threads
  - id: use_conda
    type:
      - 'null'
      - boolean
    doc: Use conda for Snakemake rules
    default: true
    inputBinding:
      position: 102
      prefix: --use-conda
  - id: workflow_profile
    type:
      - 'null'
      - string
    doc: Custom config file
    default: (outputDir)/koverage.profile/
    inputBinding:
      position: 102
      prefix: --workflow-profile
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/koverage:0.1.11--pyhdfd78af_0
stdout: koverage_config.out
