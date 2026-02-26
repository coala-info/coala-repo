cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - minimod
  - freq
label: minimod_freq
doc: "Calculate modification frequencies from reads aligned to a reference\n\nTool
  homepage: https://github.com/warp9seq/minimod"
inputs:
  - id: reference_fasta
    type: File
    doc: Reference FASTA file
    inputBinding:
      position: 1
  - id: reads_bam
    type: File
    doc: Aligned reads in BAM format
    inputBinding:
      position: 2
  - id: batch_size
    type:
      - 'null'
      - int
    doc: max number of reads loaded at once
    default: 512
    inputBinding:
      position: 103
      prefix: -K
  - id: bed_methyl_format
    type:
      - 'null'
      - boolean
    doc: output in bedMethyl format
    inputBinding:
      position: 103
      prefix: -b
  - id: debug_break
    type:
      - 'null'
      - int
    doc: break after processing the specified no. of batches
    inputBinding:
      position: 103
      prefix: --debug-break
  - id: haplotypes
    type:
      - 'null'
      - boolean
    doc: enable haplotype mode
    inputBinding:
      position: 103
      prefix: --haplotypes
  - id: insertions
    type:
      - 'null'
      - boolean
    doc: enable modifications in insertions
    inputBinding:
      position: 103
      prefix: --insertions
  - id: max_bases
    type:
      - 'null'
      - string
    doc: max number of bases loaded at once
    default: 20.0M
    inputBinding:
      position: 103
      prefix: -B
  - id: min_modification_threshold
    type:
      - 'null'
      - float
    doc: min modification threshold(s). Comma separated values for each 
      modification code given in -c
    default: 0.8
    inputBinding:
      position: 103
      prefix: -m
  - id: modification_codes
    type:
      - 'null'
      - string
    doc: modification code(s) (eg. m, h or mh or as ChEBI)
    default: m
    inputBinding:
      position: 103
      prefix: -c
  - id: print_progress
    type:
      - 'null'
      - int
    doc: 'print progress every INT seconds (0: per batch)'
    default: 0
    inputBinding:
      position: 103
      prefix: -p
  - id: threads
    type:
      - 'null'
      - int
    doc: number of processing threads
    default: 8
    inputBinding:
      position: 103
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - int
    doc: verbosity level
    default: 4
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minimod:0.4.0--h577a1d6_0
