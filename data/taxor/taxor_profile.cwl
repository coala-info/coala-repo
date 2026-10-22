cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taxor
  - profile
label: taxor_profile
doc: "Taxonomic profiling of a sample by giving read matching results of Taxor search\n\nTool homepage: https://github.com/JensUweUlrich/Taxor"
inputs:
  - id: search_file
    type: File
    doc: 'Taxor search file containing results of read querying against the HIXF index'
    inputBinding:
      position: 101
      prefix: --search-file
  - id: cami_report_file
    type: string
    doc: 'Output file reporting genomic abundances in CAMI profiling format'
    inputBinding:
      position: 102
      prefix: --cami-report-file
  - id: seq_abundance_file
    type:
      - 'null'
      - string
    doc: 'Output file reporting sequence abundance in CAMI profiling format (including unclassified reads)'
    inputBinding:
      position: 102
      prefix: --seq-abundance-file
  - id: binning_file
    type:
      - 'null'
      - string
    doc: 'Output file reporting read to taxa assignments in CAMI binning format'
    inputBinding:
      position: 102
      prefix: --binning-file
  - id: sample_id
    type:
      - 'null'
      - string
    doc: 'Identifier of the analyzed sample'
    inputBinding:
      position: 101
      prefix: --sample-id
  - id: min_abundance
    type:
      - 'null'
      - float
    doc: 'Minimum abundance to report (default 0.001, range 0-1)'
    inputBinding:
      position: 101
      prefix: --min-abundance
  - id: em_steps
    type:
      - 'null'
      - int
    doc: 'The number of steps for the expectation maximization (EM) algorithm (default 100, range 1-1000)'
    inputBinding:
      position: 101
      prefix: --em-steps
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: cami_report
    type:
      - 'null'
      - File
    doc: Genomic abundance profile in CAMI format
    outputBinding:
      glob: $(inputs.cami_report_file)
  - id: seq_abundance
    type:
      - 'null'
      - File
    doc: Sequence abundance profile in CAMI format
    outputBinding:
      glob: $(inputs.seq_abundance_file)
  - id: binning
    type:
      - 'null'
      - File
    doc: Read to taxa assignments in CAMI binning format
    outputBinding:
      glob: $(inputs.binning_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxor:0.2.1--h4e8ebbd_0
stdout: taxor_profile.out
