cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cooltools
  - genome
  - digest
label: cooltools_genome_digest
doc: "Digest a genome FASTA in silico with a restriction enzyme and print the restriction
  fragment table (chrom, start, end).\n\nTool homepage: https://github.com/mirnylab/cooltools"
inputs:
  - id: chromsizes_path
    type: File
    doc: Chromosome sizes file; every chromosome in it must be in the FASTA.
    inputBinding:
      position: 1
  - id: fasta_path
    type: File
    doc: Genome FASTA file (needs its .fai index beside it).
    secondaryFiles:
      - .fai
    inputBinding:
      position: 2
  - id: enzyme_name
    type: string
    doc: Restriction enzyme name as known to Biopython (e.g. DpnII, HindIII).
    inputBinding:
      position: 3
  - id: output_name
    type:
      - 'null'
      - string
    doc: Name of the file that captures the fragment table printed to standard
      output.
    default: fragments.tsv
outputs:
  - id: fragments
    type: stdout
    doc: Restriction fragment table in TSV format.
stdout: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cooltools:0.7.1--py311h93dcfea_3
