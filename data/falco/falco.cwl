cwlVersion: v1.2
class: CommandLineTool
baseCommand: falco
label: falco
doc: "A high throughput sequence QC analysis tool\n\nTool homepage: https://github.com/smithlabcode/falco"
inputs:
  - id: seqfiles
    type:
      type: array
      items: File
    doc: Sequence files to be analyzed
    inputBinding:
      position: 1
  - id: adapters
    type:
      - 'null'
      - File
    doc: Specifies a non-default file which contains the list of adapter 
      sequences which will be explicity searched against the library.
    inputBinding:
      position: 102
      prefix: --adapters
  - id: add_call
    type:
      - 'null'
      - boolean
    doc: '[Falco only] add the command call call to FastQC data output and FastQC
      report HTML.'
    inputBinding:
      position: 102
      prefix: -add-call
  - id: allow_empty_input
    type:
      - 'null'
      - boolean
    doc: '[Falco only] allow empty input files and generate empty output files without
      en error state.'
    inputBinding:
      position: 102
      prefix: -allow-empty-input
  - id: bisulfite
    type:
      - 'null'
      - boolean
    doc: '[Falco only] reads are whole genome bisulfite sequencing.'
    inputBinding:
      position: 102
      prefix: -bisulfite
  - id: casava
    type:
      - 'null'
      - boolean
    doc: '[IGNORED BY FALCO] Files come from raw casava output.'
    inputBinding:
      position: 102
      prefix: --casava
  - id: contaminants
    type:
      - 'null'
      - File
    doc: Specifies a non-default file which contains the list of contaminants to
      screen overrepresented sequences against.
    inputBinding:
      position: 102
      prefix: --contaminants
  - id: dir
    type:
      - 'null'
      - Directory
    doc: '[IGNORED: FALCO DOES NOT CREATE TMP FILES] Selects a directory to be used
      for temporary files.'
    inputBinding:
      position: 102
      prefix: --dir
  - id: extract
    type:
      - 'null'
      - boolean
    doc: '[ALWAYS ON IN FALCO] If set then the zipped output file will be uncompressed
      in the same directory after it has been created.'
    inputBinding:
      position: 102
      prefix: --extract
  - id: format
    type:
      - 'null'
      - string
    doc: Bypasses the normal sequence file format detection and forces the 
      program to use the specified format (bam, sam, fastq, etc.).
    inputBinding:
      position: 102
      prefix: --format
  - id: java
    type:
      - 'null'
      - File
    doc: '[IGNORED BY FALCO] Provides the full path to the java binary you want to
      use to launch fastqc.'
    inputBinding:
      position: 102
      prefix: --java
  - id: kmers
    type:
      - 'null'
      - int
    doc: '[IGNORED BY FALCO AND ALWAYS SET TO 7] Specifies the length of Kmer to look
      for.'
    inputBinding:
      position: 102
      prefix: --kmers
  - id: limits
    type:
      - 'null'
      - File
    doc: Specifies a non-default file which contains a set of criteria which 
      will be used to determine the warn/error limits.
    inputBinding:
      position: 102
      prefix: --limits
  - id: min_length
    type:
      - 'null'
      - int
    doc: '[NOT YET IMPLEMENTED IN FALCO] Sets an artificial lower limit on the length
      of the sequence to be shown in the report.'
    inputBinding:
      position: 102
      prefix: --min_length
  - id: nano
    type:
      - 'null'
      - boolean
    doc: '[IGNORED BY FALCO] Files come from nanopore sequences and are in fast5 format.'
    inputBinding:
      position: 102
      prefix: --nano
  - id: noextract
    type:
      - 'null'
      - boolean
    doc: '[IGNORED BY FALCO] Do not uncompress the output file after creating it.'
    inputBinding:
      position: 102
      prefix: --noextract
  - id: nofilter
    type:
      - 'null'
      - boolean
    doc: "[IGNORED BY FALCO] If running with --casava then don't remove read flagged
      by casava as poor quality."
    inputBinding:
      position: 102
      prefix: --nofilter
  - id: nogroup
    type:
      - 'null'
      - boolean
    doc: Disable grouping of bases for reads >50bp.
    inputBinding:
      position: 102
      prefix: --nogroup
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Supress all progress messages on stdout and only report errors.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: reverse_complement
    type:
      - 'null'
      - boolean
    doc: '[Falco only] The input is a reverse-complement. All modules will be tested
      by swapping A/T and C/G.'
    inputBinding:
      position: 102
      prefix: -reverse-complement
  - id: skip_data
    type:
      - 'null'
      - boolean
    doc: '[Falco only] Do not create FastQC data text file.'
    inputBinding:
      position: 102
      prefix: -skip-data
  - id: skip_report
    type:
      - 'null'
      - boolean
    doc: '[Falco only] Do not create FastQC report HTML file.'
    inputBinding:
      position: 102
      prefix: -skip-report
  - id: skip_summary
    type:
      - 'null'
      - boolean
    doc: '[Falco only] Do not create FastQC summary file'
    inputBinding:
      position: 102
      prefix: -skip-summary
  - id: subsample
    type:
      - 'null'
      - int
    doc: '[Falco only] makes falco faster by only processing reads that are multiple
      of this value.'
    inputBinding:
      position: 102
      prefix: -subsample
  - id: threads
    type:
      - 'null'
      - int
    doc: '[NOT YET IMPLEMENTED IN FALCO] Specifies the number of files which can be
      processed simultaneously.'
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Create all output files in the specified output directory.
    outputBinding:
      glob: $(inputs.outdir)
  - id: data_filename
    type:
      - 'null'
      - File
    doc: '[Falco only] Specify filename for FastQC data output (TXT).'
    outputBinding:
      glob: $(inputs.data_filename)
  - id: report_filename
    type:
      - 'null'
      - File
    doc: '[Falco only] Specify filename for FastQC report output (HTML).'
    outputBinding:
      glob: $(inputs.report_filename)
  - id: summary_filename
    type:
      - 'null'
      - File
    doc: '[Falco only] Specify filename for the short summary output (TXT).'
    outputBinding:
      glob: $(inputs.summary_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/falco:1.2.5--h077b44d_0
