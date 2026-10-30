cwlVersion: v1.2
class: CommandLineTool
baseCommand: annotate_cluster.pl
label: get_homologues_annotate_cluster.pl
doc: "Aligns the longest sequence of a cluster FASTA file (or an external reference sequence) to the rest of the cluster with BLAST and prints an annotated alignment (MVIEW), optionally with Pfam domains, SNPs and private variants of a group of taxa.\n\nTool homepage: https://github.com/eead-csic-compbio/get_homologues"
inputs:
  - id: cluster_fasta
    type: File
    doc: input cluster FASTA file (expects nucleotides, aligns longest seq to rest of cluster)
    inputBinding:
      position: 1
      prefix: -f
  - id: output_fasta
    type: string
    doc: output FASTA file for the alignment (the tool prints it to standard output by default)
    default: annotated_cluster.fna
    inputBinding:
      position: 1
      prefix: -o
  - id: peptides
    type:
      - 'null'
      - boolean
    doc: sequences are peptides (optional, uses BLASTP instead of BLASTN)
    inputBinding:
      position: 1
      prefix: -P
  - id: reference_fasta
    type:
      - 'null'
      - File
    doc: reference sequence FASTA (optional, aligns cluster sequences to this external seq)
    inputBinding:
      position: 1
      prefix: -r
  - id: match_pfam_domains
    type:
      - 'null'
      - boolean
    doc: match Pfam domains (optional, annotates longest seq, nucleotides on 6 frames)
    inputBinding:
      position: 1
      prefix: -D
  - id: print_unaligned
    type:
      - 'null'
      - boolean
    doc: print unaligned sequences (optional, flips seqs, handy for multiple alignments, skips option below)
    inputBinding:
      position: 1
      prefix: -u
  - id: blunt_borders
    type:
      - 'null'
      - boolean
    doc: blunt alignment borders (optional, also annotates SNPs/missense mutations and parsimony-informative sites)
    inputBinding:
      position: 1
      prefix: -b
  - id: group_a_taxa_file
    type:
      - 'null'
      - File
    doc: file with taxon names of group A (optional, identifies private variants of group A vs 'rest')
    inputBinding:
      position: 1
      prefix: -A
  - id: group_b_taxa_file
    type:
      - 'null'
      - File
    doc: file with taxon names of group B (optional, requires -A, group B is used as 'rest')
    inputBinding:
      position: 1
      prefix: -B
  - id: collapse_overlap
    type:
      - 'null'
      - int
    doc: collapse overlapping fragments (optional, example -c 40 for overlaps >= 40 residues, requires -o, useful to merge fragmented de-novo transcripts)
    inputBinding:
      position: 1
      prefix: -c
outputs:
  - id: output_alignment
    type: File
    doc: Output FASTA file with the annotated alignment.
    outputBinding:
      glob: $(inputs.output_fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/get_homologues:3.8.1--hdfd78af_0
