cwlVersion: v1.2
class: CommandLineTool
baseCommand: fgbio
label: fgbio_CollectErccMetrics
doc: "Collects metrics for ERCC spike-ins for RNA-Seq experiments.\n\nCurrently calculates\
  \ per-transcript ERCC metrics and summarizes dose response, but does not calculate\
  \ fold-change\nresponse.\n\nThe input BAM should contain reads mapped to a reference\
  \ containing the ERCC transcripts. The reference may have\nadditional contigs, for\
  \ example, when concatenating the sample's reference genome and the ERCC transcripts.\
  \ The BAM\nshould have sequence lines in the header matching the ERCC ids (ex. ERCC-00130\
  \ or ERCC-00004).\n\nThe standard ERCC transcripts, including their unique IDs and\
  \ concentrations, are taken from here\n(https://assets.thermofisher.com/TFS-Assets/LSG/manuals/cms_095046.txt).\
  \ The second column lists the ERCC transcript\nidentifier which should be present\
  \ as a sequence line in the BAM header, while columns four and five give the\nconcentration\
  \ of the transcript for mixtures #1 and #2.\n\nThe choice of mixture to use can\
  \ be specified with the '--mixture-name' option (either 'Mix1' or 'Mix2'), or with\
  \ a\nfile containing a custom list of transcripts and concentrations using the '--custom-mixture'\
  \ option as follows. The\ncustom mixture file should be tab-delimited file containing\
  \ the following columns:\n\n  1. ERCC ID - each ERCC ID should match a contig/reference-sequence\
  \ name in the input SAM/BAM header.\n  2. Concentration - the concentration (in\
  \ 'attomoles/ul'). The custom mixture file should contain a header line with\n \
  \    names for each column, though the actual values will be ignored.\n\nThree outputs\
  \ will be produced:\n\n  1. <output>.ercc_summary_metrics.txt - summary statistics\
  \ for total # of reads mapping to the ERCC transcripts and\n     dose response metrics.\n\
  \  2. <output>.ercc_detailed_metrics.txt - gives a per-ERCC-transcript expected\
  \ concentration and observed fragment\n     count.\n  3. <output>.ercc_metrics.pdf\
  \ - plots the expected concentration versus the observed fragment count.\n\nSecondary\
  \ andsupplementary reads will be ignored. A read pair mapping to an ERCC transcript\
  \ is counted only if both\nends of the pair map to the same ERCC transcript. A minimum\
  \ mapping quality can be required for reads to be counted as\nmapped to an ERCC\
  \ transcript.\n\nNote: the help names the plot '<output>.ercc_metrics.pdf', but\
  \ fgbio 3.1.1 writes '<output>.ercc_plot.pdf'; the output glob uses the real name.\n\
  \nTool homepage: https://github.com/fulcrumgenomics/fgbio"
inputs:
  - id: async_io
    type:
      - 'null'
      - boolean
    doc: Use asynchronous I/O where possible, e.g. for SAM and BAM files.
    inputBinding:
      position: 1
      prefix: --async-io
      separate: false
      valueFrom: $("=" + self)
  - id: compression
    type:
      - 'null'
      - int
    doc: Default GZIP compression level, BAM compression level.
    inputBinding:
      position: 1
      prefix: --compression
  - id: cram_ref_fasta
    type:
      - 'null'
      - File
    doc: Reference FASTA for CRAM encoding/decoding.
    inputBinding:
      position: 1
      prefix: --cram-ref-fasta
  - id: custom_mixture
    type:
      - 'null'
      - File
    doc: 'Tab-delimited file containing ERCC IDs and expected concentrations. Cannot
      be used in conjunction with argument(s): mixtureName (m)'
    inputBinding:
      position: 101
      prefix: --custom-mixture
  - id: input_bam
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
    type: File
    doc: Input SAM or BAM file of aligned reads in coordinate order.
    inputBinding:
      position: 101
      prefix: --input
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Minimum severity log-level to emit. Options: Debug, Info, Warning, Error,
      Fatal.'
    inputBinding:
      position: 1
      prefix: --log-level
  - id: min_transcript_count
    type:
      - 'null'
      - int
    doc: 'Minimum # of counts required to include an ERCC transcript. [Default: 3].'
    inputBinding:
      position: 101
      prefix: --min-transcript-count
  - id: minimum_mapping_quality
    type:
      - 'null'
      - int
    doc: 'The minimum mapping quality [Default: 10].'
    inputBinding:
      position: 101
      prefix: --minimum-mapping-quality
  - id: mixture_name
    type:
      - 'null'
      - string
    doc: 'The name of the standard ERCC mixture. Options: Mix1, Mix2. Cannot be used
      in conjunction with argument(s): customMixture'
    inputBinding:
      position: 101
      prefix: --mixture-name
  - id: output_prefix
    type: string
    doc: Output prefix.
    inputBinding:
      position: 101
      prefix: --output
  - id: sam_validation_stringency
    type:
      - 'null'
      - string
    doc: 'Validation stringency for SAM/BAM reading. Options: STRICT, LENIENT, SILENT.'
    inputBinding:
      position: 1
      prefix: --sam-validation-stringency
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: Directory to use for temporary files.
    inputBinding:
      position: 1
      prefix: --tmp-dir
arguments:
  - position: 50
    valueFrom: CollectErccMetrics
outputs:
  - id: summary_metrics
    type: File
    doc: 'Summary statistics: total reads mapping to the ERCC transcripts and dose
      response metrics.'
    outputBinding:
      glob: $(inputs.output_prefix).ercc_summary_metrics.txt
  - id: detailed_metrics
    type: File
    doc: Per-ERCC-transcript expected concentration and observed fragment count.
    outputBinding:
      glob: $(inputs.output_prefix).ercc_detailed_metrics.txt
  - id: metrics_pdf
    type:
      - 'null'
      - File
    doc: Plot of expected concentration versus observed fragment count.
    outputBinding:
      glob: $(inputs.output_prefix).ercc_plot.pdf
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
requirements:
  - class: InlineJavascriptRequirement
