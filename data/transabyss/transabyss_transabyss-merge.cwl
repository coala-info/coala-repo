cwlVersion: v1.2
class: CommandLineTool
baseCommand: transabyss-merge
label: transabyss_transabyss-merge
doc: "Merge Trans-ABySS assemblies.\n\nTool homepage: http://www.bcgsc.ca/platform/bioinfo/software/trans-abyss"
inputs:
  - id: assemblies
    type:
      type: array
      items: File
    doc: assembly FASTA file(s)
    inputBinding:
      position: 100
  - id: mink
    type: int
    doc: smallest k-mer size
    inputBinding:
      prefix: --mink
  - id: maxk
    type: int
    doc: largest k-mer size
    inputBinding:
      prefix: --maxk
  - id: prefixes
    type:
      - 'null'
      - type: array
        items: string
    doc: prefixes for the contigs from each assembly
    inputBinding:
      prefix: --prefixes
  - id: ss
    type:
      - 'null'
      - boolean
    doc: assemblies are strand-specific
    inputBinding:
      prefix: --SS
  - id: force
    type:
      - 'null'
      - boolean
    doc: force overwriting
    inputBinding:
      prefix: --force
  - id: out
    type: string
    default: transabyss-merged.fa
    doc: output file
    inputBinding:
      prefix: --out
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      prefix: --threads
  - id: length
    type:
      - 'null'
      - int
    doc: shortest sequence to report
    inputBinding:
      prefix: --length
  - id: no_cleanup
    type:
      - 'null'
      - boolean
    doc: do not remove intermediate files at completion
    inputBinding:
      prefix: --no-cleanup
  - id: abyssmap
    type:
      - 'null'
      - boolean
    doc: use abyss-map to merge all FASTA files at once (faster than BLAT but less sensitive and more memory intensive)
    inputBinding:
      prefix: --abyssmap
  - id: abyssmap_itr
    type:
      - 'null'
      - boolean
    doc: use abyss-map to merge one additional FASTA at a time, utilizing less memory.
    inputBinding:
      prefix: --abyssmap-itr
  - id: indel
    type:
      - 'null'
      - int
    doc: indel size tolerance
    inputBinding:
      prefix: --indel
  - id: pid
    type:
      - 'null'
      - float
    doc: minimum percent sequence identity of redundant sequences
    inputBinding:
      prefix: --pid
outputs:
  - id: merged_fasta
    type: File
    doc: Merged assembly FASTA.
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transabyss:2.0.1--py27_4
