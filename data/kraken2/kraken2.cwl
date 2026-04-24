cwlVersion: v1.2
class: CommandLineTool
baseCommand: kraken2
label: kraken2
doc: "Classify sequences using the Kraken 2 algorithm.\n\nTool homepage: http://ccb.jhu.edu/software/kraken/"
inputs:
  - id: filenames
    type:
      type: array
      items: File
    doc: Input filename(s)
    inputBinding:
      position: 1
  - id: bzip2_compressed
    type:
      - 'null'
      - boolean
    doc: Input files are compressed with bzip2
    inputBinding:
      position: 102
      prefix: --bzip2-compressed
  - id: confidence
    type:
      - 'null'
      - float
    doc: 'Confidence score threshold (default: 0.0); must be in [0, 1].'
    inputBinding:
      position: 102
      prefix: --confidence
  - id: db_name
    type:
      - 'null'
      - string
    doc: Name for Kraken 2 DB
    inputBinding:
      position: 102
      prefix: --db
  - id: gzip_compressed
    type:
      - 'null'
      - boolean
    doc: Input files are compressed with gzip
    inputBinding:
      position: 102
      prefix: --gzip-compressed
  - id: memory_mapping
    type:
      - 'null'
      - boolean
    doc: Avoids loading database into RAM
    inputBinding:
      position: 102
      prefix: --memory-mapping
  - id: minimum_base_quality
    type:
      - 'null'
      - int
    doc: 'Minimum base quality used in classification (def: 0, only effective with
      FASTQ input).'
    inputBinding:
      position: 102
      prefix: --minimum-base-quality
  - id: minimum_hit_groups
    type:
      - 'null'
      - int
    doc: Minimum number of hit groups (overlapping k-mers sharing the same 
      minimizer) needed to make a call
    inputBinding:
      position: 102
      prefix: --minimum-hit-groups
  - id: paired
    type:
      - 'null'
      - boolean
    doc: The filenames provided have paired-end reads
    inputBinding:
      position: 102
      prefix: --paired
  - id: quick
    type:
      - 'null'
      - boolean
    doc: Quick operation (use first hit or hits)
    inputBinding:
      position: 102
      prefix: --quick
  - id: report_minimizer_data
    type:
      - 'null'
      - boolean
    doc: With --report, report minimizer and distinct minimizer count 
      information in addition to normal Kraken report
    inputBinding:
      position: 102
      prefix: --report-minimizer-data
  - id: report_zero_counts
    type:
      - 'null'
      - boolean
    doc: With --report, report counts for ALL taxa, even if counts are zero
    inputBinding:
      position: 102
      prefix: --report-zero-counts
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 102
      prefix: --threads
  - id: use_mpa_style
    type:
      - 'null'
      - boolean
    doc: With --report, format report output like Kraken 1's kraken-mpa-report
    inputBinding:
      position: 102
      prefix: --use-mpa-style
  - id: use_names
    type:
      - 'null'
      - boolean
    doc: Print scientific names instead of just taxids
    inputBinding:
      position: 102
      prefix: --use-names
outputs:
  - id: unclassified_out
    type:
      - 'null'
      - File
    doc: Print unclassified sequences to filename
    outputBinding:
      glob: $(inputs.unclassified_out)
  - id: classified_out
    type:
      - 'null'
      - File
    doc: Print classified sequences to filename
    outputBinding:
      glob: $(inputs.classified_out)
  - id: output_file
    type:
      - 'null'
      - File
    doc: 'Print output to filename (default: stdout); "-" will suppress normal output'
    outputBinding:
      glob: $(inputs.output_file)
  - id: report_file
    type:
      - 'null'
      - File
    doc: Print a report with aggregrate counts/clade to file
    outputBinding:
      glob: $(inputs.report_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kraken2:2.17.1--pl5321h077b44d_0
