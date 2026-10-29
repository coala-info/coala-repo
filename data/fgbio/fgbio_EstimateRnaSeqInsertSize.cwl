cwlVersion: v1.2
class: CommandLineTool
baseCommand: fgbio
label: fgbio_EstimateRnaSeqInsertSize
doc: "Computes the insert size for RNA-Seq experiments.\n\nComputes the insert size\
  \ by counting the # of bases sequenced in transcript space. The insert size is defined\
  \ as the\ndistance between the first bases sequenced of each pair respectively (5'\
  \ sequencing ends).\n\nThis tool skips reads that overlap multiple genes, reads\
  \ that aren't fully enclosed in a gene, and reads where the\ninsert size would disagree\
  \ across transcripts from the same gene. Also skips reads that are unpaired, failed\
  \ QC,\nsecondary, supplementary, pairs without both ends mapped, duplicates, and\
  \ pairs whose reads map to different\nchromosomes. Finally, skips transcripts where\
  \ too few mapped read bases overlap exonic sequence.\n\nThis tool requires each\
  \ mapped pair to have the mate cigar ('MC') tag. Use 'SetMateInformation' to add\
  \ the mate cigar.\n\nThe output metric file will have the extension '.rna_seq_insert_size.txt'\
  \ and the output histogram file will have the\nextension '.rna_seq_insert_size_histogram.txt'.\
  \ The histogram file gives for each orientation ('FR', 'RF', 'tandem'),\nthe number\
  \ of read pairs that had the given insert size.\n\nNote: the help names the outputs\
  \ '.rna_seq_insert_size.txt', but fgbio 3.1.1 actually writes '<prefix>.rnaseq_insert_size.txt'\
  \ and '<prefix>.rnaseq_insert_size_histogram.txt'; the output globs use the real\
  \ names.\n\nTool homepage: https://github.com/fulcrumgenomics/fgbio"
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
  - id: deviations
    type:
      - 'null'
      - double
    doc: 'Generate mean and standard deviation by filtering to ''median + deviations*median_absolute_deviation''.
      This is done because insert size data typically includes enough anomalous values
      from chimeras and other artifacts to make the mean and sd grossly misleading
      regarding the real distribution. " [Default: 10.0].'
    inputBinding:
      position: 101
      prefix: --deviations
  - id: include_duplicates
    type:
      - 'null'
      - boolean
    doc: 'Include duplicates [Default: false].'
    inputBinding:
      position: 101
      prefix: --include-duplicates
      separate: false
      valueFrom: $("=" + self)
  - id: input_bam
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
    type: File
    doc: Input BAM file.
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
  - id: minimum_mapping_quality
    type:
      - 'null'
      - int
    doc: 'Ignore reads with mapping quality less than this value. [Default: 30].'
    inputBinding:
      position: 101
      prefix: --minimum-mapping-quality
  - id: minimum_overlap
    type:
      - 'null'
      - double
    doc: 'The minimum fraction of read bases that must overlap exonic sequence in
      a transcript [Default: 0.95].'
    inputBinding:
      position: 101
      prefix: --minimum-overlap
  - id: output_prefix
    type: string
    doc: Output prefix file. The file will have the extension '.rna_seq_insert_size.txt'
      if not given
    inputBinding:
      position: 101
      prefix: --prefix
  - id: ref_flat
    type: File
    doc: Input gene annotations in RefFlat (http://genome.ucsc.edu/goldenPath/gbdDescriptionsOld.html#RefFlat)
      form
    inputBinding:
      position: 101
      prefix: --ref-flat
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
    valueFrom: EstimateRnaSeqInsertSize
outputs:
  - id: metrics
    type: File
    doc: Insert size metrics.
    outputBinding:
      glob: $(inputs.output_prefix).rnaseq_insert_size.txt
  - id: histogram
    type: File
    doc: Insert size histogram per orientation.
    outputBinding:
      glob: $(inputs.output_prefix).rnaseq_insert_size_histogram.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
requirements:
  - class: InlineJavascriptRequirement
