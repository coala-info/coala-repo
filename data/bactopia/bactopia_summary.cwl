cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bactopia-summary
label: bactopia_summary
doc: "Generate a summary table from the Bactopia results.\n\nTool homepage: https://github.com/bactopia/bactopia"
inputs:
  - id: bactopia_path
    type: Directory
    doc: Directory where Bactopia results are stored
    inputBinding:
      position: 1
      prefix: --bactopia-path
  - id: gold_coverage
    type:
      - 'null'
      - int
    doc: 'Minimum amount of coverage required for Gold status [default: 100]'
    inputBinding:
      position: 1
      prefix: --gold-coverage
  - id: gold_quality
    type:
      - 'null'
      - int
    doc: 'Minimum per-read mean quality score required for Gold status [default: 30]'
    inputBinding:
      position: 1
      prefix: --gold-quality
  - id: gold_read_length
    type:
      - 'null'
      - int
    doc: 'Minimum mean read length required for Gold status [default: 95]'
    inputBinding:
      position: 1
      prefix: --gold-read-length
  - id: gold_contigs
    type:
      - 'null'
      - int
    doc: 'Maximum contig count required for Gold status [default: 100]'
    inputBinding:
      position: 1
      prefix: --gold-contigs
  - id: silver_coverage
    type:
      - 'null'
      - int
    doc: 'Minimum amount of coverage required for Silver status [default: 50]'
    inputBinding:
      position: 1
      prefix: --silver-coverage
  - id: silver_quality
    type:
      - 'null'
      - int
    doc: 'Minimum per-read mean quality score required for Silver status [default:
      20]'
    inputBinding:
      position: 1
      prefix: --silver-quality
  - id: silver_read_length
    type:
      - 'null'
      - int
    doc: 'Minimum mean read length required for Silver status [default: 75]'
    inputBinding:
      position: 1
      prefix: --silver-read-length
  - id: silver_contigs
    type:
      - 'null'
      - int
    doc: 'Maximum contig count required for Silver status [default: 200]'
    inputBinding:
      position: 1
      prefix: --silver-contigs
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: 'Minimum amount of coverage required to pass [default: 20]'
    inputBinding:
      position: 1
      prefix: --min-coverage
  - id: min_quality
    type:
      - 'null'
      - int
    doc: 'Minimum per-read mean quality score required to pass [default: 12]'
    inputBinding:
      position: 1
      prefix: --min-quality
  - id: min_read_length
    type:
      - 'null'
      - int
    doc: 'Minimum mean read length required to pass [default: 49]'
    inputBinding:
      position: 1
      prefix: --min-read-length
  - id: max_contigs
    type:
      - 'null'
      - int
    doc: 'Maximum contig count required to pass [default: 500]'
    inputBinding:
      position: 1
      prefix: --max-contigs
  - id: min_assembled_size
    type:
      - 'null'
      - int
    doc: Minimum assembled genome size
    inputBinding:
      position: 1
      prefix: --min-assembled-size
  - id: max_assembled_size
    type:
      - 'null'
      - int
    doc: Maximum assembled genome size
    inputBinding:
      position: 1
      prefix: --max-assembled-size
  - id: outdir
    type: string
    doc: Directory to write output
    inputBinding:
      position: 1
      prefix: --outdir
    default: bactopia-summary
  - id: prefix
    type:
      - 'null'
      - string
    doc: 'Prefix to use for output files [default: bactopia]'
    inputBinding:
      position: 1
      prefix: --prefix
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existing reports
    inputBinding:
      position: 1
      prefix: --force
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase the verbosity of output
    inputBinding:
      position: 1
      prefix: --verbose
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Only critical errors will be printed
    inputBinding:
      position: 1
      prefix: --silent
outputs:
  - id: output_dir
    type: Directory
    doc: Directory with the summary report tables
    outputBinding:
      glob: $(inputs.outdir)
  - id: reports
    type: File[]
    doc: Summary, exclusion and report tables
    outputBinding:
      glob: $(inputs.outdir)/*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bactopia:3.2.0--hdfd78af_0
