cwlVersion: v1.2
class: CommandLineTool
baseCommand: trim_adapters
label: atactk_trim_adapters
doc: "Trim adapters from paired-end HTS reads.\n\nTool homepage: http://theparkerlab.org/"
inputs:
  - id: forward
    type: File
    doc: The (optionally gzipped) FASTQ file containing the forward reads.
    inputBinding:
      position: 1
  - id: reverse
    type: File
    doc: The (optionally gzipped) FASTQ file containing the reverse reads.
    inputBinding:
      position: 2
  - id: fudge
    type:
      - 'null'
      - int
    doc: An arbitrary number of extra bases to trim from the ends of reads 
      because the original pyadapter_trim.py script did so.
    default: 1
    inputBinding:
      position: 103
      prefix: --fudge
  - id: max_edit_distance
    type:
      - 'null'
      - int
    doc: The maximum edit distance permitted when aligning the paired reads
    default: 1
    inputBinding:
      position: 103
      prefix: --max-edit-distance
  - id: rc_length
    type:
      - 'null'
      - int
    doc: Use the reverse complement of this number of bases from the beginning 
      of the reverse read to align the reads
    default: 20
    inputBinding:
      position: 103
      prefix: --rc-length
  - id: trim_from_start
    type:
      - 'null'
      - int
    doc: Trim this number of bases from the start of each sequence
    default: 0
    inputBinding:
      position: 103
      prefix: --trim-from-start
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Report on the handling of each FASTQ record.
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/atactk:0.1.9--pyh3252c3a_0
stdout: atactk_trim_adapters.out
