cwlVersion: v1.2
class: CommandLineTool
baseCommand: secapr find_target_contigs
label: secapr_find_target_contigs
doc: "Extract the contigs that match the reference database\n\nTool homepage: https://github.com/AntonelliLab/seqcap_processor"
inputs:
  - id: contigs
    type: Directory
    doc: The directory containing the assembled contigs in fasta format. 
      Alternatively you can provide a directory with subfolders containing 
      results of various assembly runs (e.g. based on different kmer values). In
      the latter case it is recommended to use the --keep_paralogs flag, to 
      avoid the majority of loci being discarded as paralogous.
    inputBinding:
      position: 101
      prefix: --contigs
  - id: keep_paralogs
    type:
      - 'null'
      - boolean
    doc: Keep contigs for loci that are flagged as potentially paralogous 
      (multiple contigs matching same locus). The longest contig will be 
      selected for these loci.
    inputBinding:
      position: 101
      prefix: --keep_paralogs
  - id: min_identity
    type:
      - 'null'
      - int
    doc: The minimum percent identity required for a match
    default: 90
    inputBinding:
      position: 101
      prefix: --min_identity
  - id: reference
    type: File
    doc: The fasta-file containing the reference sequences (one sequence per 
      targeted locus).
    inputBinding:
      position: 101
      prefix: --reference
  - id: remove_multilocus_contigs
    type:
      - 'null'
      - boolean
    doc: Drop those contigs that match multiple exons.
    inputBinding:
      position: 101
      prefix: --remove_multilocus_contigs
  - id: seed_length
    type:
      - 'null'
      - int
    doc: Length of initial seed sequence for finding BLAST matches. The seed has
      to be a perfect match between a given contig and a reference locus
    default: 11
    inputBinding:
      position: 101
      prefix: --seed_length
  - id: target_length
    type:
      - 'null'
      - int
    doc: The required length of the matching sequence stretch between contigs 
      and target sequences. This does not have to be a perfect match but can be 
      adjusted with the --min_identity flag
    default: 50
    inputBinding:
      position: 101
      prefix: --target_length
outputs:
  - id: output
    type: Directory
    doc: The directory in which to store the extracted target contigs and lastz 
      results.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/secapr:2.2.8--pyh5e36f6f_0
