cwlVersion: v1.2
class: CommandLineTool
baseCommand: telr
label: telr
doc: "Program for detecting non-reference TEs in long read data\n\nTool homepage:
  https://github.com/bergmanlab/telr"
inputs:
  - id: af_flank_interval
    type:
      - 'null'
      - int
    doc: 5' and 3'flanking sequence interval size used for allele frequency 
      estimation
    inputBinding:
      position: 101
      prefix: --af_flank_interval
  - id: af_flank_offset
    type:
      - 'null'
      - int
    doc: 5' and 3' flanking sequence offset size used for allele frequency 
      estimation
    inputBinding:
      position: 101
      prefix: --af_flank_offset
  - id: af_te_interval
    type:
      - 'null'
      - int
    doc: 5' and 3' te sequence interval size used for allele frequency 
      estimation
    inputBinding:
      position: 101
      prefix: --af_te_interval
  - id: af_te_offset
    type:
      - 'null'
      - int
    doc: 5' and 3' te sequence offset size used for allele frequency estimation
    inputBinding:
      position: 101
      prefix: --af_te_offset
  - id: aligner
    type:
      - 'null'
      - string
    doc: choose method for read alignment, please provide 'nglmr' or 'minimap2'
    inputBinding:
      position: 101
      prefix: --aligner
  - id: assembler
    type:
      - 'null'
      - string
    doc: Choose the method to be used for local contig assembly step, please 
      provide 'wtdbg2' or 'flye'
    inputBinding:
      position: 101
      prefix: --assembler
  - id: different_contig_name
    type:
      - 'null'
      - boolean
    doc: 'If provided then TELR does not require the contig name to match before and
      after annotation liftover (default: require contig name to be the same before
      and after liftover)'
    inputBinding:
      position: 101
      prefix: --different_contig_name
  - id: flank_len
    type:
      - 'null'
      - int
    doc: flanking sequence length
    inputBinding:
      position: 101
      prefix: --flank_len
  - id: gap
    type:
      - 'null'
      - int
    doc: max gap size for flanking sequence alignment
    inputBinding:
      position: 101
      prefix: --gap
  - id: keep_files
    type:
      - 'null'
      - boolean
    doc: 'If provided then all intermediate files will be kept (default: remove intermediate
      files)'
    inputBinding:
      position: 101
      prefix: --keep_files
  - id: library
    type: File
    doc: TE consensus sequences in fasta format
    inputBinding:
      position: 101
      prefix: --library
  - id: minimap2_family
    type:
      - 'null'
      - boolean
    doc: 'If provided then minimap2 will be used to annotate TE families in the assembled
      contigs (default: use repeatmasker for contig TE annotation)'
    inputBinding:
      position: 101
      prefix: --minimap2_family
  - id: overlap
    type:
      - 'null'
      - int
    doc: max overlap size for flanking sequence alignment
    inputBinding:
      position: 101
      prefix: --overlap
  - id: polish_iterations
    type:
      - 'null'
      - int
    doc: iterations of contig polishing
    inputBinding:
      position: 101
      prefix: --polish_iterations
  - id: polisher
    type:
      - 'null'
      - string
    doc: Choose the method to be used for local contig polishing step, please 
      provide 'wtdbg2' or 'flye'
    inputBinding:
      position: 101
      prefix: --polisher
  - id: presets
    type:
      - 'null'
      - string
    doc: parameter presets for different sequencing technologies, please provide
      'pacbio' or 'ont'
    inputBinding:
      position: 101
      prefix: --presets
  - id: reads
    type: File
    doc: reads in fasta/fastq format or read alignments in bam format
    inputBinding:
      position: 101
      prefix: --reads
  - id: reference
    type: File
    doc: reference genome in fasta format
    inputBinding:
      position: 101
      prefix: --reference
  - id: thread
    type:
      - 'null'
      - string
    doc: max cpu threads to use
    inputBinding:
      position: 101
      prefix: --thread
outputs:
  - id: out
    type:
      - 'null'
      - Directory
    doc: directory to output data
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/telr:1.1--pyhdfd78af_0
