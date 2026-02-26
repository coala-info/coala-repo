cwlVersion: v1.2
class: CommandLineTool
baseCommand: fuma
label: fuma
doc: "fuma\n\nTool homepage: https://github.com/yhoogstrate/fuma/"
inputs:
  - id: acceptor_donor_order_specific_matching
    type:
      - 'null'
      - boolean
    doc: 'Consider fusion genes distinct when the donor and acceptor sites are swapped:
      (A,B) != (B,A)'
    inputBinding:
      position: 101
      prefix: --acceptor-donor-order-specific-matching
  - id: add_gene_annotation
    type:
      - 'null'
      - type: array
        items: File
    doc: annotation_alias:filename * file in BED format
    inputBinding:
      position: 101
      prefix: --add-gene-annotation
  - id: add_sample
    type:
      type: array
      items: string
    doc: 'sample_alias:format:filename (available formats: fuma --formats)'
    inputBinding:
      position: 101
      prefix: --add-sample
  - id: format
    type:
      - 'null'
      - string
    doc: Output-format
    inputBinding:
      position: 101
      prefix: --format
  - id: formats
    type:
      - 'null'
      - boolean
    doc: show accepted dataset formats
    inputBinding:
      position: 101
      prefix: --formats
  - id: link_sample_to_annotation
    type:
      - 'null'
      - type: array
        items: string
    doc: sample_alias:annotation_alias
    inputBinding:
      position: 101
      prefix: --link-sample-to-annotation
  - id: long_gene_size
    type:
      - 'null'
      - int
    doc: Gene-name based matching is more sensitive to long genes. This is the 
      gene size used to mark fusion genes spanning a 'long gene' as reported the
      output. Use 0 to disable this feature.
    inputBinding:
      position: 101
      prefix: --long-gene-size
  - id: matching_method
    type:
      - 'null'
      - string
    doc: The used method to match two gene sets. Overlap matches when two gene 
      set have one or more genes overlapping. Subset matches when one gene set 
      is a subset of the other. EGM is exact gene matching; all genes in both 
      sets need to be identical to match.
    inputBinding:
      position: 101
      prefix: --matching-method
  - id: no_acceptor_donor_order_specific_matching
    type:
      - 'null'
      - boolean
    doc: 'Consider fusion genes identical when the donor and acceptor sites are swapped:
      (A,B) == (B,A); default'
    inputBinding:
      position: 101
      prefix: --no-acceptor-donor-order-specific-matching
  - id: no_strand_specific_matching
    type:
      - 'null'
      - boolean
    doc: 'Consider fusion genes identical when the breakpoints have different strands:
      (A<-,B<-) == (->A,B<-)'
    inputBinding:
      position: 101
      prefix: --no-strand-specific-matching
  - id: strand_specific_matching
    type:
      - 'null'
      - boolean
    doc: 'Consider fusion genes distinct when the breakpoints have different strands:
      (A<-,B<-) != (->A,B<-); default'
    inputBinding:
      position: 101
      prefix: --strand-specific-matching
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: increase output verbosity
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: output filename; '-' for stdout
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fuma:4.0.0--pyhb7b1952_0
