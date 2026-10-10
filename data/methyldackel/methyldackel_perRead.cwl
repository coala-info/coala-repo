cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - MethylDackel
  - perRead
label: methyldackel_perRead
doc: "Compute the average CpG methylation level of each read.\n\nTool homepage: https://github.com/dpryan79/MethylDackel"
inputs:
  - id: ref
    type: File
    secondaryFiles:
      - .fai
    doc: "Reference genome in fasta format, indexed with samtools faidx."
    inputBinding:
      position: 100
  - id: alignments
    type: File
    secondaryFiles:
      - .bai
    doc: "An input BAM or CRAM file. This MUST be sorted and should be indexed."
    inputBinding:
      position: 101
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: "Minimum MAPQ threshold to include an alignment (default 10)"
    inputBinding:
      position: 10
      prefix: -q
  - id: min_phred
    type:
      - 'null'
      - int
    doc: "Minimum Phred threshold to include a base (default 5). This must be >0."
    inputBinding:
      position: 10
      prefix: -p
  - id: region
    type:
      - 'null'
      - string
    doc: "Region string in which to extract methylation"
    inputBinding:
      position: 10
      prefix: -r
  - id: bed
    type:
      - 'null'
      - File
    doc: "A BED file listing regions for inclusion."
    inputBinding:
      position: 10
      prefix: -l
  - id: keep_strand
    type:
      - 'null'
      - boolean
    doc: "If a BED file is specified, use the strand column (column 6) so that only metrics from the given strand are output."
    inputBinding:
      position: 10
      prefix: --keepStrand
  - id: ignore_flags
    type:
      - 'null'
      - int
    doc: "Alignments are ignored when their flags overlap this value (by default all reads are output). The default is 0."
    inputBinding:
      position: 10
      prefix: --ignoreFlags
  - id: require_flags
    type:
      - 'null'
      - int
    doc: "Require each alignment to have all bits in this value present, or else the alignment is ignored (like samtools -f). The default is 0."
    inputBinding:
      position: 10
      prefix: --requireFlags
  - id: ignore_nh
    type:
      - 'null'
      - boolean
    doc: "Ignore NH auxiliary tags. By default, if an NH tag is present and its value is >1 then an entry is ignored as a multimapper."
    inputBinding:
      position: 10
      prefix: --ignoreNH
  - id: threads
    type:
      - 'null'
      - int
    doc: "The number of threads to use, the default 1"
    inputBinding:
      position: 10
      prefix: -@
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: "The size of the genome processed by a single thread at a time. The default is 1000000 bases. This value MUST be at least 1."
    inputBinding:
      position: 10
      prefix: --chunkSize
  - id: output_file
    type: string
    doc: "Output file name"
    inputBinding:
      position: 50
      prefix: -o
outputs:
  - id: per_read
    type: File
    doc: "Per-read CpG methylation summary (read name, chromosome, position, CpG methylation %, informative bases)."
    outputBinding:
      glob: $(inputs.output_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methyldackel:0.6.1--h577a1d6_9
