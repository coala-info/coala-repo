cwlVersion: v1.2
class: CommandLineTool
baseCommand: fgbio
label: fgbio_DownsampleAndNormalizeBam
doc: "Downsamples a BAM in a biased way to a uniform coverage across regions.\n\n\
  Attempts to downsample a BAM such that every base in the genome (or in the target\
  \ 'regions' if provided) is covered by at least 'coverage' reads. When computing\
  \ coverage:\n\n  * Reads marked as secondary, duplicate or unmapped are not used\n\
  \  * A base can receive coverage from only one read with the same queryname (i.e.\
  \ mate overlaps are not counted)\n  * Coverage is counted if a read spans a base,\
  \ even if that base is deleted in the read\n\nReads are first sorted into a random\
  \ order (by hashing read names). Reads are then consumed one template at a time,\
  \ and if any read adds coverage to base that is under the target coverage, all reads\
  \ (including secondary, unmapped, etc.) for that template are emitted into the output.\n\
  \nGiven the procedure used for downsampling, it is likely the output BAM will have\
  \ coverage up to 2X the requested coverage at regions in the input BAM that are\
  \ i) well covered and ii) are close to regions that are poorly covered.\n\nTool\
  \ homepage: https://github.com/fulcrumgenomics/fgbio"
inputs:
  - id: async_io
    type:
      - 'null'
      - boolean
    doc: Use asynchronous I/O where possible, e.g. for SAM and BAM files.
    inputBinding:
      position: 1
      prefix: --async-io
  - id: compression
    type:
      - 'null'
      - int
    doc: Default GZIP compression level, BAM compression level.
    inputBinding:
      position: 1
      prefix: --compression
  - id: coverage
    type: int
    doc: Desired minimum coverage.
    inputBinding:
      position: 101
      prefix: --coverage
  - id: cram_ref_fasta
    type:
      - 'null'
      - File
    doc: Reference FASTA for CRAM encoding/decoding.
    inputBinding:
      position: 1
      prefix: --cram-ref-fasta
  - id: input_bam
    type: File
    doc: Input SAM or BAM file.
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
  - id: max_in_memory
    type:
      - 'null'
      - int
    doc: Maximum records to be held in memory while sorting.
    inputBinding:
      position: 101
      prefix: --max-in-memory
  - id: min_map_q
    type:
      - 'null'
      - int
    doc: Minimum mapping quality to count a read as covering.
    inputBinding:
      position: 101
      prefix: --min-map-q
  - id: output_bam
    type: string
    doc: Output SAM or BAM file.
    inputBinding:
      position: 101
      prefix: --output
  - id: regions
    type:
      - 'null'
      - File
    doc: Optional set of regions for coverage targeting.
    inputBinding:
      position: 101
      prefix: --regions
  - id: sam_validation_stringency
    type:
      - 'null'
      - string
    doc: 'Validation stringency for SAM/BAM reading. Options: STRICT, LENIENT, SILENT.'
    inputBinding:
      position: 1
      prefix: --sam-validation-stringency
  - id: seed
    type:
      - 'null'
      - int
    doc: Random seed to use when randomizing order of reads/templates.
    inputBinding:
      position: 101
      prefix: --seed
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
    valueFrom: DownsampleAndNormalizeBam
outputs:
  - id: output_bam_out
    type: File
    doc: Output SAM or BAM file.
    outputBinding:
      glob: $(inputs.output_bam)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
