cwlVersion: v1.2
class: CommandLineTool
baseCommand: tatajuba
label: tatajuba
doc: "Compare histograms of homopolymeric tract lengths, within context.\n\nTool homepage:
  https://github.com/quadram-institute-bioscience/tatajuba"
inputs:
  - id: fastq_files
    type:
      type: array
      items: File
    doc: fastq file with reads (weirdly, fasta also possible as long as contains
      all reads and not only contigs)
    inputBinding:
      position: 1
  - id: generate_vcf
    type:
      - 'null'
      - boolean
    doc: generate VCF files for each sample, around the HT regions 
      (EXPERIMENTAL) (default=not to save)
    inputBinding:
      position: 102
      prefix: --vcf
  - id: genome_fasta
    type:
      - 'null'
      - File
    doc: reference genome file in fasta format, if absent from GFF3
    inputBinding:
      position: 102
      prefix: --fasta
  - id: genome_gff
    type: File
    doc: reference genome file in GFF3, preferencially with sequence
    inputBinding:
      position: 102
      prefix: --gff
  - id: keep_bias
    type:
      - 'null'
      - boolean
    doc: keep biased tracts, i.e. present only in reverse or only in forward 
      strains (default=remove)
    inputBinding:
      position: 102
      prefix: --keep_bias
  - id: kmer
    type:
      - 'null'
      - int
    doc: kmer size flanking each side of homopolymer
    inputBinding:
      position: 102
      prefix: --kmer
  - id: levenshtein_distance
    type:
      - 'null'
      - int
    doc: levenshtein distance between flanking regions to merge them into one 
      context (after ref genome mapping)
    inputBinding:
      position: 102
      prefix: --leven
  - id: max_flanking_kmer_distance
    type:
      - 'null'
      - int
    doc: maximum distance between kmers of a flanking region to merge them into 
      one context
    inputBinding:
      position: 102
      prefix: --maxdist
  - id: min_homopolymer_tract_length
    type:
      - 'null'
      - int
    doc: minimum homopolymer tract length to be compared
    inputBinding:
      position: 102
      prefix: --minsize
  - id: min_reads
    type:
      - 'null'
      - int
    doc: minimum number of reads for tract+context to be considered
    inputBinding:
      position: 102
      prefix: --minreads
  - id: nthreads
    type:
      - 'null'
      - int
    doc: suggested number of threads (default is to let system decide; I may not
      honour your suggestion btw)
    inputBinding:
      position: 102
      prefix: --nthreads
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: output directory, or 'random' for generating random dir name
    inputBinding:
      position: 102
      prefix: --outdir
  - id: paired_end
    type:
      - 'null'
      - boolean
    doc: paired end (pairs of) files
    inputBinding:
      position: 102
      prefix: --paired
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tatajuba:1.0.4--h577a1d6_4
stdout: tatajuba.out
