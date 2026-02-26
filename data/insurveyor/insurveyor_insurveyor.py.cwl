cwlVersion: v1.2
class: CommandLineTool
baseCommand: insurveyor.py
label: insurveyor_insurveyor.py
doc: "INSurVeyor, an insertion caller [1.1.2].\n\nTool homepage: https://github.com/kensung-lab/INSurVeyor"
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
  - id: max_clipped_pos_dist
    type:
      - 'null'
      - int
    doc: Max distance (in bp) for two clips to be considered representing the 
      same breakpoint.
    inputBinding:
      position: 104
      prefix: --max-clipped-pos-dist
  - id: max_seq_error
    type:
      - 'null'
      - float
    doc: Max sequencing error admissible on the platform used.
    inputBinding:
      position: 104
      prefix: --max-seq-error
  - id: max_trans_size
    type:
      - 'null'
      - int
    doc: Maximum size of the transpositions which INSurVeyor will predict.
    inputBinding:
      position: 104
      prefix: --max-trans-size
  - id: min_clip_len
    type:
      - 'null'
      - int
    doc: Minimum clip len to consider.
    inputBinding:
      position: 104
      prefix: --min-clip-len
  - id: min_insertion_size
    type:
      - 'null'
      - int
    doc: Minimum size of the insertion to be called.Smaller insertions will be 
      reported anyway but markedas SMALL in the FILTER field.
    inputBinding:
      position: 104
      prefix: --min-insertion-size
  - id: min_stable_mapq
    type:
      - 'null'
      - int
    doc: Minimum MAPQ for a stable read.
    inputBinding:
      position: 104
      prefix: --min-stable-mapq
  - id: per_contig_stats
    type:
      - 'null'
      - boolean
    doc: Statistics are computed separately for each contig (experimental).
    inputBinding:
      position: 104
      prefix: --per-contig-stats
  - id: sample_clipped_pairs
    type:
      - 'null'
      - boolean
    doc: When estimating the insert size distribution by sampling pairs, do not 
      discard pairs where one or both of the reads are clipped.
    inputBinding:
      position: 104
      prefix: --sample-clipped-pairs
  - id: samplename
    type:
      - 'null'
      - string
    doc: Name of the sample to be used in the VCF output.If not provided, the 
      basename of the bam/cram file will be used,up until the first '.'
    inputBinding:
      position: 104
      prefix: --samplename
  - id: sampling_regions
    type:
      - 'null'
      - File
    doc: File in BED format containing a list of regions to be used to 
      estimatestatistics such as depth.
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
  - id: use_csi
    type:
      - 'null'
      - boolean
    doc: Use CSI indices instead of BAI for intermediate bam files.
    inputBinding:
      position: 104
      prefix: --use-csi
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/insurveyor:1.1.3--h077b44d_2
stdout: insurveyor_insurveyor.py.out
