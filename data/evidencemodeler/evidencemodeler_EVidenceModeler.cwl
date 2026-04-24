cwlVersion: v1.2
class: CommandLineTool
baseCommand: EVidenceModeler
label: evidencemodeler_EVidenceModeler
doc: "EvidenceModeler (EVM) automates the process of combining gene predictions and
  protein/transcript alignments into a single set of high-quality gene models.\n\n\
  Tool homepage: https://github.com/EVidenceModeler/EVidenceModeler"
inputs:
  - id: cpu
    type:
      - 'null'
      - int
    doc: number of parallel computes
    inputBinding:
      position: 101
      prefix: --CPU
  - id: debug
    type:
      - 'null'
      - boolean
    doc: debug mode, writes lots of extra files.
    inputBinding:
      position: 101
      prefix: --debug
  - id: exec_dir
    type:
      - 'null'
      - Directory
    doc: directory that EVM cd's to before running.
    inputBinding:
      position: 101
      prefix: --exec_dir
  - id: forward_strand_only
    type:
      - 'null'
      - boolean
    doc: runs only on the forward strand
    inputBinding:
      position: 101
      prefix: --forwardStrandOnly
  - id: gene_predictions
    type: File
    doc: gene predictions gff3 file
    inputBinding:
      position: 101
      prefix: --gene_predictions
  - id: genome
    type: File
    doc: genome sequence in fasta format
    inputBinding:
      position: 101
      prefix: --genome
  - id: min_intron_length
    type:
      - 'null'
      - int
    doc: minimum length for an intron
    inputBinding:
      position: 101
      prefix: --min_intron_length
  - id: overlap_size
    type: string
    doc: length of sequence overlap between segmented sequences
    inputBinding:
      position: 101
      prefix: --overlapSize
  - id: protein_alignments
    type:
      - 'null'
      - File
    doc: protein alignments gff3 file
    inputBinding:
      position: 101
      prefix: --protein_alignments
  - id: re_search_intergenic
    type:
      - 'null'
      - int
    doc: when set, reexamines intergenic regions of minimum length (can add FPs)
    inputBinding:
      position: 101
      prefix: --re_search_intergenic
  - id: repeats
    type:
      - 'null'
      - File
    doc: gff3 file with repeats masked from genome file
    inputBinding:
      position: 101
      prefix: --repeats
  - id: report_elm
    type:
      - 'null'
      - boolean
    doc: report the eliminated EVM preds too.
    inputBinding:
      position: 101
      prefix: --report_ELM
  - id: reverse_strand_only
    type:
      - 'null'
      - boolean
    doc: runs only on the reverse strand
    inputBinding:
      position: 101
      prefix: --reverseStrandOnly
  - id: sample_id
    type: string
    doc: sample_id (for naming outputs)
    inputBinding:
      position: 101
      prefix: --sample_id
  - id: search_long_introns
    type:
      - 'null'
      - int
    doc: when set, reexamines long introns (can find nested genes, but also can 
      result in FPs)
    inputBinding:
      position: 101
      prefix: --search_long_introns
  - id: segment_size
    type: string
    doc: length of a single sequence for running EVM
    inputBinding:
      position: 101
      prefix: --segmentSize
  - id: stop_codons
    type:
      - 'null'
      - string
    doc: list of stop codons
    inputBinding:
      position: 101
      prefix: --stop_codons
  - id: terminal_exons
    type:
      - 'null'
      - File
    doc: supplementary file of additional terminal exons to consider (from PASA 
      long-orfs)
    inputBinding:
      position: 101
      prefix: --terminalExons
  - id: terminal_intergenic_re_search
    type:
      - 'null'
      - int
    doc: reexamines genomic regions outside of the span of all predicted genes
    inputBinding:
      position: 101
      prefix: --terminal_intergenic_re_search
  - id: transcript_alignments
    type:
      - 'null'
      - File
    doc: transcript alignments gff3 file
    inputBinding:
      position: 101
      prefix: --transcript_alignments
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose flag
    inputBinding:
      position: 101
      prefix: -S
  - id: weights
    type: File
    doc: weights for evidence types file. See documentation for formatting.
    inputBinding:
      position: 101
      prefix: --weights
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/evidencemodeler:2.1.0--h9948957_5
stdout: evidencemodeler_EVidenceModeler.out
