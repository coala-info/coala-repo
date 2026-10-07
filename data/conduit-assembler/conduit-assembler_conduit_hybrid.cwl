cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - conduit
  - hybrid
label: conduit-assembler_conduit_hybrid
doc: "CONsensus Decomposition Utility In Transcriptome-assembly: hybrid mode corrects nanopore scaffold reads, separated by gene cluster, with Illumina reads.\n\nTool homepage: https://github.com/NatPRoach/conduit"
inputs:
  - id: clusters_directory
    type: Directory
    doc: "Directory containing the .fasta/.fa or .fastq/.fq files of reads separated by gene cluster"
    inputBinding:
      position: 2
      valueFrom: $(self.path + '/')
  - id: mate1
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files with #1 mates, paired with files in mate2 (gzip or bzip2 allowed)"
    inputBinding:
      position: 3
      prefix: '-1'
      itemSeparator: ","
  - id: mate2
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files with #2 mates, paired with files in mate1 (gzip or bzip2 allowed)"
    inputBinding:
      position: 3
      prefix: '-2'
      itemSeparator: ","
  - id: unpaired
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files with unpaired reads (gzip or bzip2 allowed)"
    inputBinding:
      position: 3
      prefix: -U
      itemSeparator: ","
  - id: interleaved
    type:
      - 'null'
      - File
    doc: "File with interleaved paired-end FASTQ/FASTA reads"
    inputBinding:
      position: 3
      prefix: --interleaved
  - id: bam
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files of unaligned BAM sorted by read name"
    inputBinding:
      position: 3
      prefix: -b
      itemSeparator: ","
  - id: drna
    type:
      - 'null'
      - boolean
    doc: "Scaffold reads are stranded forward relative to coding strand, enforces --UtoT (default)"
    inputBinding:
      position: 1
      prefix: --drna
  - id: cdna_rev_stranded
    type:
      - 'null'
      - boolean
    doc: "Scaffold reads are stranded reverse complemented relative to coding strand"
    inputBinding:
      position: 1
      prefix: --cdna-rev-stranded
  - id: cdna
    type:
      - 'null'
      - boolean
    doc: "Scaffold reads are NOT stranded"
    inputBinding:
      position: 1
      prefix: --cdna
  - id: sfq
    type:
      - 'null'
      - boolean
    doc: "Scaffold reads are in FASTQ format, enforces --UtoT (default)"
    inputBinding:
      position: 1
      prefix: --sfq
  - id: sfa
    type:
      - 'null'
      - boolean
    doc: "Scaffold reads are in FASTA format"
    inputBinding:
      position: 1
      prefix: --sfa
  - id: u_to_t
    type:
      - 'null'
      - boolean
    doc: "Scaffold reads contain Us instead of Ts; converts U nucleotides to Ts (default)"
    inputBinding:
      position: 1
      prefix: --UtoT
  - id: no_u_to_t
    type:
      - 'null'
      - boolean
    doc: "Scaffold reads do not contain Us and do not need to be converted"
    inputBinding:
      position: 1
      prefix: --noUtoT
  - id: unstranded
    type:
      - 'null'
      - boolean
    doc: "Illumina reads are unstranded"
    inputBinding:
      position: 1
      prefix: --unstranded
  - id: fwd_stranded
    type:
      - 'null'
      - boolean
    doc: "Illumina reads are stranded s.t. the first mate originates from the RNA strand"
    inputBinding:
      position: 1
      prefix: --fwd-stranded
  - id: rev_stranded
    type:
      - 'null'
      - boolean
    doc: "Illumina reads are stranded s.t. the first mate is the reverse complement of the RNA strand (default)"
    inputBinding:
      position: 1
      prefix: --rev-stranded
  - id: ifq
    type:
      - 'null'
      - boolean
    doc: "Illumina reads are in FASTQ format (default)"
    inputBinding:
      position: 1
      prefix: --ifq
  - id: ifa
    type:
      - 'null'
      - boolean
    doc: "Illumina reads are in FASTA format"
    inputBinding:
      position: 1
      prefix: --ifa
  - id: score_matrix
    type:
      - 'null'
      - File
    doc: "Alternative scoring matrix to use in partial order alignment"
    inputBinding:
      position: 1
      prefix: --score-matrix
  - id: isoform_delta
    type:
      - 'null'
      - int
    doc: "Maximum indel size to be corrected, beyond this size a new isoform is declared; 2 to 255 (default 35)"
    inputBinding:
      position: 1
      prefix: --isoform-delta
  - id: ends_delta
    type:
      - 'null'
      - int
    doc: "Maximum size at the ends of isoforms to correct before splitting; 2 to 255 (default 35)"
    inputBinding:
      position: 1
      prefix: --ends-delta
  - id: max_iterations
    type:
      - 'null'
      - int
    doc: "Maximum number of iterations to align to and correct scaffolds; 0 performs no graph based Illumina correction (default 5)"
    inputBinding:
      position: 1
      prefix: --max-iterations
  - id: illumina_weight
    type:
      - 'null'
      - int
    doc: "Weight of Illumina reads relative to nanopore reads when generating consensus (default 10)"
    inputBinding:
      position: 1
      prefix: --illumina-weight
  - id: final_polish
    type:
      - 'null'
      - boolean
    doc: "Include a final correction of individual isoforms, not in a splice graph (default)"
    inputBinding:
      position: 1
      prefix: --final-polish
  - id: no_final_polish
    type:
      - 'null'
      - boolean
    doc: "Do not do a final correction of individual isoforms"
    inputBinding:
      position: 1
      prefix: --no-final-polish
  - id: stringent
    type:
      - 'null'
      - boolean
    doc: "Enforce that every base / edge in each final isoform is supported by an Illumina read (default)"
    inputBinding:
      position: 1
      prefix: --stringent
  - id: no_stringent
    type:
      - 'null'
      - boolean
    doc: "Do not enforce Illumina support of every base / edge in each final isoform"
    inputBinding:
      position: 1
      prefix: --no-stringent
  - id: stringent_tolerance
    type:
      - 'null'
      - int
    doc: "Number of bases at each isoform end that need no Illumina support in --stringent mode (default 100)"
    inputBinding:
      position: 1
      prefix: --stringent-tolerance
  - id: output_dir
    type: string
    doc: "Path where corrected clusters will be written (default conduit/)"
    default: conduit
    inputBinding:
      position: 1
      prefix: --output-dir
  - id: no_intermediates
    type:
      - 'null'
      - boolean
    doc: "Do not save FASTA files of intermediate rounds of polishing (default)"
    inputBinding:
      position: 1
      prefix: --no-intermediates
  - id: save_intermediates
    type:
      - 'null'
      - boolean
    doc: "Save the FASTA files generated for intermediate rounds of polishing"
    inputBinding:
      position: 1
      prefix: --save-intermediates
  - id: end_to_end
    type:
      - 'null'
      - boolean
    doc: "Align Illumina reads to ONT scaffolds in end-to-end alignment mode (default)"
    inputBinding:
      position: 1
      prefix: --end-to-end
  - id: local
    type:
      - 'null'
      - boolean
    doc: "Align Illumina reads to ONT scaffolds in local alignment mode"
    inputBinding:
      position: 1
      prefix: --local
  - id: bowtie2_max_alignments
    type:
      - 'null'
      - int
    doc: "Maximum number of alignments per Illumina read used in the final polishing step (default 50)"
    inputBinding:
      position: 1
      prefix: --bowtie2-max-alignments
  - id: samtools_thread_memory
    type:
      - 'null'
      - string
    doc: "Memory per SAMtools thread, in bytes or with a K, M or G suffix (default 768M)"
    inputBinding:
      position: 1
      prefix: --samtools-thread-memory
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: "Path where temporary files will be created (default conduit-tmp/)"
    inputBinding:
      position: 1
      prefix: --tmp-dir
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads to run in parallel (default 4)"
    inputBinding:
      position: 1
      prefix: --threads
outputs:
  - id: output_directory
    type: Directory
    doc: "Directory with the corrected clusters"
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/conduit-assembler:0.1.2--h14cfee4_1
