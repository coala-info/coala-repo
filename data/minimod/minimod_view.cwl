cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - minimod
  - view
label: minimod_view
doc: "View modifications in reads using a reference genome and BAM file\n\nTool homepage:
  https://github.com/warp9seq/minimod"
inputs:
  - id: reference_fasta
    type: File
    doc: Reference genome FASTA file
    inputBinding:
      position: 1
  - id: reads_bam
    type: File
    doc: Input reads BAM file
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
  - id: profile_cpu
    type:
      - 'null'
      - string
    doc: process section by section (yes|no)
    inputBinding:
      position: 103
      prefix: --profile-cpu
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
