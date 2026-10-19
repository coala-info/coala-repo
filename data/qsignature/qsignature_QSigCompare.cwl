cwlVersion: v1.2
class: CommandLineTool
baseCommand: [qsignature, org.qcmg.sig.QSigCompare]
label: qsignature_QSigCompare
doc: "Compare qsignature VCF files in a directory and report the pairwise similarity as XML.\n\nTool homepage: https://github.com/AdamaJava/adamajava/tree/master/qsignature"
inputs:
  - id: input
    type: Directory
    doc: "Input directory with qsignature VCF files."
    inputBinding:
      position: 1
      prefix: -i
  - id: outdir
    type:
      - 'null'
      - string
    doc: "Specifies the output directory."
    inputBinding:
      position: 1
      prefix: -d
  - id: output
    type: string
    doc: "Specifies the output file."
    inputBinding:
      position: 1
      prefix: --output
  - id: log
    type: string
    doc: "Full path to file where log output will be directed."
    inputBinding:
      position: 1
      prefix: --log
  - id: loglevel
    type:
      - 'null'
      - string
    doc: "Logging level required, e.g. INFO, DEBUG."
    inputBinding:
      position: 1
      prefix: --loglevel
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: "Minimum coverage to be used in the comparison."
    inputBinding:
      position: 1
      prefix: --minCoverage
  - id: cutoff
    type:
      - 'null'
      - float
    doc: "Cutoff value to be used in the comparison."
    inputBinding:
      position: 1
      prefix: --cutoff
  - id: no_of_threads
    type:
      - 'null'
      - int
    doc: "Number of threads to be used when retrieving positions from bam files."
    inputBinding:
      position: 1
      prefix: --noOfThreads
  - id: sequential
    type:
      - 'null'
      - boolean
    doc: "Specifies that bam access should be sequential rather than indexed."
    inputBinding:
      position: 1
      prefix: --sequential
  - id: search_suffix
    type:
      - 'null'
      - string
    doc: "Search suffix."
    inputBinding:
      position: 1
      prefix: --searchSuffix
  - id: additional_search_string
    type:
      - 'null'
      - string
    doc: "Additional search string."
    inputBinding:
      position: 1
      prefix: --additionalSearchString
  - id: snp_chip_search_suffix
    type:
      - 'null'
      - string
    doc: "Snp chip search suffix."
    inputBinding:
      position: 1
      prefix: --snpChipSearchSuffix
  - id: exclude_vcfs_file
    type:
      - 'null'
      - File
    doc: "File listing VCFs to exclude."
    inputBinding:
      position: 1
      prefix: --excludeVcfsFile
  - id: email
    type:
      - 'null'
      - string
    doc: "Email address."
    inputBinding:
      position: 1
      prefix: --email
  - id: email_subject
    type:
      - 'null'
      - string
    doc: "Email subject."
    inputBinding:
      position: 1
      prefix: --emailSubject
outputs:
  - id: compare_xml
    type: File
    doc: "Comparison result XML"
    outputBinding:
      glob: $(inputs.output)
  - id: log_file
    type: File
    doc: "Log file"
    outputBinding:
      glob: $(inputs.log)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qsignature:0.1pre--3
