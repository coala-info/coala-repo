cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - chira_merge.py
label: chira_merge
doc: "Chimeric Read Annotator: merge alignments and convert coordinates\n\nTool homepage: https://github.com/pavanvidem/chira/"
inputs:
  - id: block_based
    type:
      - 'null'
      - boolean
    doc: "Merge alignments with blockbuster (block based) instead of overlap based merging"
    inputBinding:
      position: 1
      prefix: --block_based
  - id: bed
    type: File
    doc: "Input BED file with alignments"
    inputBinding:
      position: 1
      prefix: --bed
  - id: outdir
    type: string
    doc: "Output directory path for the whole analysis"
    default: "chira_merge_out"
    inputBinding:
      position: 1
      prefix: --outdir
  - id: gtf
    type:
      - 'null'
      - File
    doc: "Annotation GTF file"
    inputBinding:
      position: 1
      prefix: --gtf
  - id: alignment_overlap
    type:
      - 'null'
      - float
    doc: "Minimum percentage overlap among BED entries in order to merge. [0-1.0] (default: 0.7)"
    inputBinding:
      position: 1
      prefix: --alignment_overlap
  - id: segment_overlap
    type:
      - 'null'
      - float
    doc: "Matching read positions with greater than this % overlap are merged into a segment (default: 0.7)"
    inputBinding:
      position: 1
      prefix: --segment_overlap
  - id: length_threshold
    type:
      - 'null'
      - float
    doc: "Minimum length of the alignments to consider as a fraction of longest alignment. [0.8-1.0] (default: 0.9)"
    inputBinding:
      position: 1
      prefix: --length_threshold
  - id: distance
    type:
      - 'null'
      - int
    doc: "Blockbuster parameter distance (default: 30)"
    inputBinding:
      position: 1
      prefix: --distance
  - id: min_cluster_height
    type:
      - 'null'
      - int
    doc: "Blockbuster parameter minClusterHeight (default: 10)"
    inputBinding:
      position: 1
      prefix: --min_cluster_height
  - id: min_block_height
    type:
      - 'null'
      - int
    doc: "Blockbuster parameter minBlockHeight (default: 10)"
    inputBinding:
      position: 1
      prefix: --min_block_height
  - id: scale
    type:
      - 'null'
      - float
    doc: "Blockbuster parameter scale (default: 0.1)"
    inputBinding:
      position: 1
      prefix: --scale
  - id: chimeric_overlap
    type:
      - 'null'
      - int
    doc: "Maximum number of bases allowed between the chimeric segments of a read (default: 2)"
    inputBinding:
      position: 1
      prefix: --chimeric_overlap
  - id: ref_fasta1
    type:
      - 'null'
      - File
    doc: "First priority fasta file"
    inputBinding:
      position: 1
      prefix: --ref_fasta1
  - id: ref_fasta2
    type:
      - 'null'
      - File
    doc: "Second priority fasta file"
    inputBinding:
      position: 1
      prefix: --ref_fasta2
  - id: chimeric_only
    type:
      - 'null'
      - boolean
    doc: "Consider chimeric reads only for merging"
    inputBinding:
      position: 1
      prefix: --chimeric_only
  - id: min_locus_size
    type:
      - 'null'
      - int
    doc: "Minimum number of alignments required per merged locus (default: 1)"
    inputBinding:
      position: 1
      prefix: --min_locus_size
outputs:
  - id: segments_bed
    type: File
    doc: "Aligned read segments (segments.bed)"
    outputBinding:
      glob: $(inputs.outdir)/segments.bed
  - id: merged_bed
    type: File
    doc: "Merged alignments (merged.bed)"
    outputBinding:
      glob: $(inputs.outdir)/merged.bed
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - "${ return {class: 'Directory', basename: inputs.outdir, listing: [], writable: true}; }"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chira:1.4.3--hdfd78af_2
