cwlVersion: v1.2
class: CommandLineTool
baseCommand: gmove
label: gmove
doc: "Gene modelling using various evidence.\n\nTool homepage: https://github.com/institut-de-genomique/Gmove"
inputs:
  - id: abinitio
    type:
      - 'null'
      - File
    doc: ab initio file in gff (expect tag 'CDS' or 'UTR' in column 3)
    inputBinding:
      position: 101
      prefix: --abinitio
  - id: annot
    type:
      - 'null'
      - File
    doc: annotation file in gff (expect tag 'CDS' or 'UTR' in column 3)
    inputBinding:
      position: 101
      prefix: --annot
  - id: exclude_introns
    type:
      - 'null'
      - File
    doc: "tabular file that contains introns to remove\n                         \
      \ [FORMAT 4 columns: seqname start end strand]\n                          [separator
      is tabulation AND strand is '+' or '-' only]"
    inputBinding:
      position: 101
      prefix: --exclude_introns
  - id: exon_boundary_region_size
    type:
      - 'null'
      - int
    doc: number of nucleotides around exons boundaries where to find start and 
      stop codons, default is 30.
    inputBinding:
      position: 101
      prefix: -b
  - id: genetic_code
    type:
      - 'null'
      - int
    doc: genetic code (1, 6 or 23), default is 1.
    inputBinding:
      position: 101
      prefix: -y
  - id: gtf_format
    type:
      - 'null'
      - boolean
    doc: gtf format annotation file - default is gff3
    inputBinding:
      position: 101
      prefix: -t
  - id: long_reads
    type:
      - 'null'
      - File
    doc: rna file in gff from long reads sequencing (expect tag 'exon' or 'HSP' 
      in column 3)
    inputBinding:
      position: 101
      prefix: --longReads
  - id: max_intron_size
    type:
      - 'null'
      - int
    doc: maximal size of introns, default is 50.000 nucleotides.
    inputBinding:
      position: 101
      prefix: -m
  - id: max_paths
    type:
      - 'null'
      - int
    doc: maximal number of paths inside a connected component, default is 
      10,000.
    inputBinding:
      position: 101
      prefix: -P
  - id: min_cds_size
    type:
      - 'null'
      - int
    doc: min size CDS, by default 100
    inputBinding:
      position: 101
      prefix: --cds
  - id: min_exon_size
    type:
      - 'null'
      - int
    doc: minimal size of exons, default is 9 nucleotides.
    inputBinding:
      position: 101
      prefix: -e
  - id: min_intron_size
    type:
      - 'null'
      - int
    doc: minimal size of introns, default is 9 nucleotides.
    inputBinding:
      position: 101
      prefix: -i
  - id: no_single_exon_models
    type:
      - 'null'
      - boolean
    doc: do not output single exon models.
    inputBinding:
      position: 101
      prefix: -S
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: output folder, by default ./out
    inputBinding:
      position: 101
      prefix: -o
  - id: prot
    type:
      - 'null'
      - File
    doc: prot file in gff (expect tag 'exon' or 'HSP' in column 3)
    inputBinding:
      position: 101
      prefix: --prot
  - id: ratio_cds_utr
    type:
      - 'null'
      - boolean
    doc: ratio CDS/UTR min 80% de CDS
    inputBinding:
      position: 101
      prefix: --ratio
  - id: raw_output
    type:
      - 'null'
      - boolean
    doc: output raw data
    inputBinding:
      position: 101
      prefix: --raw
  - id: reference_sequence
    type: File
    doc: fasta file which contains genome sequence(s).
    inputBinding:
      position: 101
      prefix: -f
  - id: rna
    type:
      - 'null'
      - File
    doc: rna file in gff (expect tag 'exon' or 'HSP' in column 3)
    inputBinding:
      position: 101
      prefix: --rna
  - id: score_highest
    type:
      - 'null'
      - boolean
    doc: Keep the model with the highest score per connected component, 
      otherwise keep model with the longest CDS
    inputBinding:
      position: 101
      prefix: --score
  - id: splice_site_region_size
    type:
      - 'null'
      - int
    doc: size of regions where to find splice site around covtigs boundaries, 
      default is 0.
    inputBinding:
      position: 101
      prefix: -x
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gmove:1.3--h9948957_0
stdout: gmove.out
