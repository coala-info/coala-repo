cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - anglerfish
  - explore
label: anglerfish_explore
doc: "This is an advanced samplesheet-free version of anglerfish.\n\nTool homepage:
  https://github.com/remiolsen/anglerfish"
inputs:
  - id: fastq
    type: File
    doc: Fastq file to align
    inputBinding:
      position: 101
      prefix: --fastq
  - id: good_hit_threshold
    type:
      - 'null'
      - float
    doc: Fraction of adaptor bases immediately before and immediately after index
      insert required to match perfectly for a hit to be considered a good hit
    default: 0.9
    inputBinding:
      position: 101
      prefix: --good_hit_threshold
  - id: insert_thres_high
    type:
      - 'null'
      - int
    doc: Upper threshold for index(+UMI) insert length, with value included.
    default: 30
    inputBinding:
      position: 101
      prefix: --insert_thres_high
  - id: insert_thres_low
    type:
      - 'null'
      - int
    doc: Lower threshold for index(+UMI) insert length, with value included.
    default: 4
    inputBinding:
      position: 101
      prefix: --insert_thres_low
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: Kmer length for entropy calculation.
    default: 2
    inputBinding:
      position: 101
      prefix: --kmer_length
  - id: min_hits_per_adaptor
    type:
      - 'null'
      - int
    doc: Minimum number of good hits for an adaptor to be included in the analysis.
    default: 50
    inputBinding:
      position: 101
      prefix: --min_hits_per_adaptor
  - id: minimap_b
    type:
      - 'null'
      - int
    doc: Minimap2 -B parameter, mismatch penalty.
    default: 4
    inputBinding:
      position: 101
      prefix: --minimap_b
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads specified to minimap2
    default: 4
    inputBinding:
      position: 101
      prefix: --threads
  - id: umi_threshold
    type:
      - 'null'
      - float
    doc: Minimum number of bases in insert to perform entropy calculation.
    default: 11.0
    inputBinding:
      position: 101
      prefix: --umi_threshold
  - id: use_existing
    type:
      - 'null'
      - boolean
    doc: Use existing alignments if found in the specified output directory.
    inputBinding:
      position: 101
      prefix: --use-existing
outputs:
  - id: outdir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/anglerfish:0.7.0--pyhdfd78af_0
