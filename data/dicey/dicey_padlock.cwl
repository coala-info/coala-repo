cwlVersion: v1.2
class: CommandLineTool
baseCommand: dicey_padlock
label: dicey_padlock
doc: "Probes for one gene, one transcript, a set of genes, or custom FASTA input.\n\
  \nTool homepage: https://github.com/gear-genomics/dicey"
inputs:
  - id: gene_id
    type:
      - 'null'
      - string
    doc: ENSG gene ID for one gene
    inputBinding:
      position: 1
  - id: gene_list_file
    type:
      - 'null'
      - File
    doc: File containing a list of gene IDs for a set of genes
    inputBinding:
      position: 2
  - id: sequences_fasta
    type:
      - 'null'
      - File
    doc: FASTA file with custom sequences
    inputBinding:
      position: 3
  - id: transcript_id
    type:
      - 'null'
      - string
    doc: ENST transcript ID for one transcript
    inputBinding:
      position: 4
  - id: allow_overlapping_probes
    type:
      - 'null'
      - boolean
    doc: allow overlapping probes
    inputBinding:
      position: 105
      prefix: --overlapping
  - id: anchor_sequence
    type:
      - 'null'
      - string
    doc: anchor sequence
    default: TGCGTCTATTTAGTGGAGCC
    inputBinding:
      position: 105
      prefix: --anchor
  - id: annealing_oligos_concentration
    type:
      - 'null'
      - int
    doc: concentration of annealing(!) Oligos in nMol
    default: 50
    inputBinding:
      position: 105
  - id: apply_distance_to_probe
    type:
      - 'null'
      - boolean
    doc: apply distance to entire probe, i.e., only one arm needs to be unique
    inputBinding:
      position: 105
      prefix: --probe
  - id: barcodes_file
    type: File
    doc: FASTA barcode file
    inputBinding:
      position: 105
      prefix: --barcodes
  - id: config_dir
    type:
      - 'null'
      - Directory
    doc: primer3 config directory
    default: ./src/primer3_config/
    inputBinding:
      position: 105
      prefix: --config
  - id: divalent_ions
    type:
      - 'null'
      - float
    doc: concentration of divalent ions in mMol
    default: 1.5
    inputBinding:
      position: 105
  - id: enttemp
    type:
      - 'null'
      - int
    doc: temperature for entropie and entalpie calculation in Celsius
    default: 37
    inputBinding:
      position: 105
  - id: gc_max
    type:
      - 'null'
      - float
    doc: maximum arm GC fraction
    default: 0.6
    inputBinding:
      position: 105
  - id: gc_min
    type:
      - 'null'
      - float
    doc: minimum arm GC fraction
    default: 0.4
    inputBinding:
      position: 105
  - id: gtf_attribute
    type:
      - 'null'
      - string
    doc: gtf/gff3 attribute
    default: gene_id
    inputBinding:
      position: 105
      prefix: --attribute
  - id: gtf_feature
    type:
      - 'null'
      - string
    doc: gtf/gff3 feature
    default: exon
    inputBinding:
      position: 105
      prefix: --feature
  - id: json_file
    type:
      - 'null'
      - File
    doc: gzipped JSON file [optional]
    inputBinding:
      position: 105
      prefix: --json
  - id: monovalent_ions
    type:
      - 'null'
      - int
    doc: concentration of monovalent ions in mMol
    default: 50
    inputBinding:
      position: 105
  - id: neighborhood_distance
    type:
      - 'null'
      - int
    doc: neighborhood distance
    default: 1
    inputBinding:
      position: 105
      prefix: --distance
  - id: probe_arm_length
    type:
      - 'null'
      - int
    doc: probe arm length
    default: 20
    inputBinding:
      position: 105
      prefix: --armlen
  - id: ref_genome
    type: File
    doc: genome file
    inputBinding:
      position: 105
      prefix: --genome
  - id: ref_gtf
    type: File
    doc: gtf/gff3 file
    inputBinding:
      position: 105
      prefix: --gtf
  - id: source_absent
    type:
      - 'null'
      - boolean
    doc: source sequence is absent in reference genome [only relevant for FASTA 
      input]
    inputBinding:
      position: 105
      prefix: --absent
  - id: spacer_left
    type:
      - 'null'
      - string
    doc: spacer left
    default: TCCTC
    inputBinding:
      position: 105
      prefix: --spacerleft
  - id: spacer_right
    type:
      - 'null'
      - string
    doc: spacer right
    default: TCTTT
    inputBinding:
      position: 105
      prefix: --spacerright
  - id: tm_difference
    type:
      - 'null'
      - int
    doc: Tm difference between arms
    default: 2
    inputBinding:
      position: 105
      prefix: --tmdiff
  - id: total_dnps_concentration
    type:
      - 'null'
      - float
    doc: the sum of all dNTPs in mMol
    default: 0.6
    inputBinding:
      position: 105
  - id: use_hamming
    type:
      - 'null'
      - boolean
    doc: use hamming neighborhood instead of edit distance
    inputBinding:
      position: 105
      prefix: --hamming
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dicey:0.3.4--h4d20210_0
