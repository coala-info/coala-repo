cwlVersion: v1.2
class: CommandLineTool
baseCommand: extract-sv-reads
label: extract-sv-reads
doc: "Extracts split and discordant reads from BAM/CRAM/SAM files for structural variant
  analysis.\n\nTool homepage: https://github.com/hall-lab/extract_sv_reads"
inputs:
  - id: input_file
    type: File
    doc: input BAM/CRAM/SAM
    inputBinding:
      position: 1
  - id: exclude_dups
    type:
      - 'null'
      - boolean
    doc: exclude duplicate reads from output
    inputBinding:
      position: 102
      prefix: --exclude-dups
  - id: input
    type:
      - 'null'
      - File
    doc: input BAM/CRAM/SAM. Use '-' for stdin if using positional arguments
    inputBinding:
      position: 102
      prefix: --input
  - id: max_unmapped_bases
    type:
      - 'null'
      - int
    doc: maximum number of unaligned bases between two alignments to be included
      in the splitter file
    inputBinding:
      position: 102
      prefix: --max-unmapped-bases
  - id: min_indel_size
    type:
      - 'null'
      - int
    doc: minimum structural variant feature size for split alignments to be 
      included in the splitter file
    inputBinding:
      position: 102
      prefix: --min-indel-size
  - id: min_non_overlap
    type:
      - 'null'
      - int
    doc: minimum number of non-overlapping base pairs between two alignments for
      a read to be included in the splitter file
    inputBinding:
      position: 102
      prefix: --min-non-overlap
  - id: reduce_output_bams
    type:
      - 'null'
      - boolean
    doc: remove sequences and qualities from output bams
    inputBinding:
      position: 102
      prefix: --reduce-output-bams
  - id: reference
    type:
      - 'null'
      - File
    doc: reference sequence used to encode CRAM file, recommended if reading 
      CRAM
    inputBinding:
      position: 102
      prefix: --reference
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use
    inputBinding:
      position: 102
      prefix: --threads
  - id: with_nm
    type:
      - 'null'
      - boolean
    doc: ensure NM tag is present in output if reading CRAM file
    inputBinding:
      position: 102
      prefix: --with-nm
outputs:
  - id: splitter_file_pos
    type: File
    doc: output split reads to this file in BAM format
    outputBinding:
      glob: '*.out'
  - id: discordant_file_pos
    type: File
    doc: output discordant reads to this file in BAM format
    outputBinding:
      glob: '*.out'
  - id: splitter
    type: File
    doc: output split reads to this file in BAM format
    outputBinding:
      glob: $(inputs.splitter)
  - id: discordant
    type: File
    doc: output discordant reads to this file in BAM format
    outputBinding:
      glob: $(inputs.discordant)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/extract-sv-reads:1.3.0--pl5321h9948957_6
