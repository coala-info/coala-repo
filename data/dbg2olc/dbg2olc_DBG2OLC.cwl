cwlVersion: v1.2
class: CommandLineTool
baseCommand: DBG2OLC
label: dbg2olc_DBG2OLC
doc: "DBG2OLC: hybrid assembly of long reads (third-gen) using de Bruijn graph contigs from short reads.\n\nTool
  homepage: https://github.com/yechengxi/DBG2OLC"
inputs:
  - id: contigs_file
    type: File
    doc: contig file to be used.
    inputBinding:
      position: 1
      prefix: Contigs
  - id: reads_files
    type:
      type: array
      items: File
      inputBinding:
        prefix: f
    doc: Input reads files (e.g., reads_file1.fq/fa)
    inputBinding:
      position: 2
  - id: adaptive_threshold
    type:
      - 'null'
      - float
    doc: '[Specific for third-gen sequencing] adaptive k-mer threshold for each solid
      contig. (suggest 0.001-0.02)'
    inputBinding:
      position: 103
      prefix: AdaptiveTh
  - id: k
    type:
      - 'null'
      - int
    doc: k-mer size.
    inputBinding:
      position: 103
      prefix: k
  - id: kmer_cov_threshold
    type:
      - 'null'
      - int
    doc: k-mer matching threshold for each solid contig. (suggest 2-10)
    inputBinding:
      position: 103
      prefix: KmerCovTh
  - id: ld
    type:
      - 'null'
      - int
    doc: load compressed reads information. You can set to 1 if you have run the
      algorithm for one round and just want to fine tune the following 
      parameters.
    inputBinding:
      position: 103
      prefix: LD
  - id: min_len
    type:
      - 'null'
      - int
    doc: min read length for a read to be used.
    inputBinding:
      position: 103
      prefix: MinLen
  - id: min_overlap
    type:
      - 'null'
      - int
    doc: min matching k-mers for each two reads. (suggest 10-150)
    inputBinding:
      position: 103
      prefix: MinOverlap
  - id: path_cov_threshold
    type:
      - 'null'
      - int
    doc: '[Specific for Illumina sequencing] occurence threshold for a compressed
      read. (suggest 1-3)'
    inputBinding:
      position: 103
      prefix: PathCovTh
  - id: remove_chimera
    type:
      - 'null'
      - int
    doc: Set to 1 to remove chimeric reads (documented in the DBG2OLC README)
    inputBinding:
      position: 103
      prefix: RemoveChimera
outputs:
  - id: backbone
    type: File
    doc: Raw backbone assembly (backbone_raw.fasta), to be polished by Sparc
    outputBinding:
      glob: backbone_raw.fasta
  - id: consensus_info
    type: File
    doc: Read layout for the consensus step (DBG2OLC_Consensus_info.txt)
    outputBinding:
      glob: DBG2OLC_Consensus_info.txt
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dbg2olc:20200723--h077b44d_4
stdout: dbg2olc_DBG2OLC.out
