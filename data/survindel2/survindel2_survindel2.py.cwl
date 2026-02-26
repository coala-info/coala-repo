cwlVersion: v1.2
class: CommandLineTool
baseCommand: survindel2.py
label: survindel2_survindel2.py
doc: "SurVIndel2, a CNV caller.\n\nTool homepage: https://github.com/kensung-lab/SurVIndel2"
inputs:
  - id: bam_file
    type: File
    doc: Input bam file.
    inputBinding:
      position: 1
  - id: workdir
    type: Directory
    doc: Working directory for Surveyor to use.
    inputBinding:
      position: 2
  - id: reference
    type: File
    doc: Reference genome in FASTA format.
    inputBinding:
      position: 3
  - id: log
    type:
      - 'null'
      - boolean
    doc: "Activate in-depth logging (can be very large and\n                     \
      \   cryptic)."
    inputBinding:
      position: 104
      prefix: --log
  - id: match_score
    type:
      - 'null'
      - int
    doc: "Match score used by the aligner that produced tha\n                    \
      \    BAM/CRAM file (TODO: auto-determine)."
    inputBinding:
      position: 104
      prefix: --match_score
  - id: max_clipped_pos_dist
    type:
      - 'null'
      - int
    doc: Max clipped position distance.
    inputBinding:
      position: 104
      prefix: --max_clipped_pos_dist
  - id: max_seq_error
    type:
      - 'null'
      - float
    doc: Max sequencing error admissible on the platform used.
    inputBinding:
      position: 104
      prefix: --max_seq_error
  - id: min_clip_len
    type:
      - 'null'
      - int
    doc: Min length for a clip to be used.
    inputBinding:
      position: 104
      prefix: --min_clip_len
  - id: min_diff_hsr
    type:
      - 'null'
      - int
    doc: "Minimum number of differences with the reference\n                     \
      \   (considered as number of insertions, deletions and\n                   \
      \     mismatches) for a read to be considered a hidden split\n             \
      \           read."
    inputBinding:
      position: 104
      prefix: --min-diff-hsr
  - id: min_size_for_depth_filtering
    type:
      - 'null'
      - int
    doc: Minimum size for depth filtering.
    inputBinding:
      position: 104
      prefix: --min_size_for_depth_filtering
  - id: min_sv_size
    type:
      - 'null'
      - int
    doc: Min SV size.
    inputBinding:
      position: 104
      prefix: --min_sv_size
  - id: samplename
    type:
      - 'null'
      - string
    doc: "Name of the sample to be used in the VCF output.If not\n               \
      \         provided, the basename of the bam/cram file will be\n            \
      \            used,up until the first '.'\n"
    inputBinding:
      position: 104
      prefix: --samplename
  - id: sampling_regions
    type:
      - 'null'
      - File
    doc: "File in BED format containing a list of regions to be\n                \
      \        used to estimatestatistics such as depth."
    inputBinding:
      position: 104
      prefix: --sampling-regions
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed for random sampling of genomic positions.
    inputBinding:
      position: 104
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to be used.
    inputBinding:
      position: 104
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/survindel2:1.1.4--h503566f_0
stdout: survindel2_survindel2.py.out
