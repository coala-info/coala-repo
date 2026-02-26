cwlVersion: v1.2
class: CommandLineTool
baseCommand: peaks2utr
label: peaks2utr
doc: "Use MACS to build forward and reverse peaks files for given .bam file. Iterate
  peaks through set of criteria to determine UTR viability, before annotating in .gff
  file.\n\nTool homepage: https://github.com/haessar/peaks2utr"
inputs:
  - id: gff_in
    type: File
    doc: input 'canonical' annotations file in gff or gtf format
    inputBinding:
      position: 1
  - id: bam_in
    type: File
    doc: input reads file in bam format
    inputBinding:
      position: 2
  - id: do_pseudo
    type:
      - 'null'
      - boolean
    doc: annotate 3' UTR also for pseudogenic transcripts.
    inputBinding:
      position: 103
      prefix: --do-pseudo
  - id: extend_utr
    type:
      - 'null'
      - boolean
    doc: extend previously existing 3' UTR annotations where possible
    inputBinding:
      position: 103
      prefix: --extend-utr
  - id: five_prime_ext
    type:
      - 'null'
      - int
    doc: a peak within this many bases of a gene's 5'-end should be assumed to 
      belong to it.
    default: 0
    inputBinding:
      position: 103
      prefix: --five-prime-ext
  - id: force
    type:
      - 'null'
      - boolean
    doc: overwrite outputs if they exist
    inputBinding:
      position: 103
      prefix: --force
  - id: gtf
    type:
      - 'null'
      - boolean
    doc: output in GTF format (rather than default GFF3)
    inputBinding:
      position: 103
      prefix: --gtf
  - id: keep_cache
    type:
      - 'null'
      - boolean
    doc: keep cached files on run completion
    inputBinding:
      position: 103
      prefix: --keep-cache
  - id: max_distance
    type:
      - 'null'
      - int
    doc: maximum distance in bases that UTR can be from a transcript.
    default: 200
    inputBinding:
      position: 103
      prefix: --max-distance
  - id: min_pileups
    type:
      - 'null'
      - int
    doc: minimum number of piled-up mapped reads for UTR cut-off.
    default: 10
    inputBinding:
      position: 103
      prefix: --min-pileups
  - id: min_poly_tail
    type:
      - 'null'
      - int
    doc: minimum length of poly-A/T tail considered in soft-clipped reads.
    default: 10
    inputBinding:
      position: 103
      prefix: --min-poly-tail
  - id: no_strand_overlap
    type:
      - 'null'
      - boolean
    doc: Prevent overlapping of new UTR feature with any feature on other strand
      (truncating if necessary).
    inputBinding:
      position: 103
      prefix: --no-strand-overlap
  - id: override_utr
    type:
      - 'null'
      - boolean
    doc: ignore already annotated 3' UTRs in criteria
    inputBinding:
      position: 103
      prefix: --override-utr
  - id: processors
    type:
      - 'null'
      - int
    doc: how many processor cores to use.
    default: 1
    inputBinding:
      position: 103
      prefix: --processors
  - id: skip_soft_clip
    type:
      - 'null'
      - boolean
    doc: skip the resource-intensive logic to pileup soft-clipped read edges
    inputBinding:
      position: 103
      prefix: --skip-soft-clip
  - id: skip_validation
    type:
      - 'null'
      - boolean
    doc: skip validation of input files
    inputBinding:
      position: 103
      prefix: --skip-validation
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: output filename. Defaults to <GFF_IN basename>.new.<ext>
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/peaks2utr:1.4.1--pyhdfd78af_0
