cwlVersion: v1.2
class: CommandLineTool
baseCommand: [phyluce_align_get_taxon_locus_counts_in_alignments]
label: phyluce_phyluce_align_get_taxon_locus_counts_in_alignments
doc: "Given an input directory of alignments, determine the number of alignments per taxon.\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: alignments
    type: Directory
    doc: "The input directory of alignment files."
    inputBinding:
      position: 1
      prefix: --alignments
  - id: input_format
    type: ['null', string]
    doc: "The input alignment format. One of: fasta, nexus, phylip, clustal, emboss, stockholm (default: nexus)."
    inputBinding:
      position: 2
      prefix: --input-format
outputs:
  - id: taxon_counts
    type: stdout
    doc: "CSV table (taxon,count) of alignments with data per taxon."
stdout: phyluce_align_get_taxon_locus_counts_in_alignments.stdout.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
