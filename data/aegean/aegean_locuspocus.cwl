cwlVersion: v1.2
class: CommandLineTool
baseCommand: locuspocus
label: aegean_locuspocus
doc: "calculate locus coordinates for the given gene annotation\n\nTool homepage:
  https://github.com/BrendelGroup/AEGeAn"
inputs:
  - id: gff3_input
    type:
      type: array
      items: File
    doc: GFF3 file(s) as input
    inputBinding:
      position: 1
  - id: cds
    type:
      - 'null'
      - boolean
    doc: use CDS rather than UTRs for determining gene overlap; implies 'refine'
      mode
    inputBinding:
      position: 102
      prefix: --cds
  - id: debug
    type:
      - 'null'
      - boolean
    doc: print detailed debugging messages to terminal (standard error)
    inputBinding:
      position: 102
      prefix: --debug
  - id: delta
    type:
      - 'null'
      - int
    doc: when parsing interval loci, use the following delta to extend gene loci
      and include potential regulatory regions
    inputBinding:
      position: 102
      prefix: --delta
  - id: endsonly
    type:
      - 'null'
      - boolean
    doc: report only incomplete iLocus fragments at the unannotated ends of 
      sequences (complement of --skipends)
    inputBinding:
      position: 102
      prefix: --endsonly
  - id: filter
    type:
      - 'null'
      - string
    doc: comma-separated list of feature types to use in constructing loci/iLoci
    inputBinding:
      position: 102
      prefix: --filter
  - id: minoverlap
    type:
      - 'null'
      - int
    doc: the minimum number of nucleotides two genes must overlap to be grouped 
      in the same iLocus
    inputBinding:
      position: 102
      prefix: --minoverlap
  - id: namefmt
    type:
      - 'null'
      - string
    doc: provide a printf-style format string to override the default ID format 
      for newly created loci
    inputBinding:
      position: 102
      prefix: --namefmt
  - id: parent
    type:
      - 'null'
      - type: array
        items: string
    doc: if a feature of type $CT exists without a parent, create a parent for 
      this feature with type $PT; e.g., mRNA:gene
    inputBinding:
      position: 102
      prefix: --parent
  - id: pseudo
    type:
      - 'null'
      - boolean
    doc: correct erroneously labeled pseudogenes
    inputBinding:
      position: 102
      prefix: --pseudo
  - id: refine
    type:
      - 'null'
      - boolean
    doc: by default genes are grouped in the same iLocus if they have any 
      overlap; 'refine' mode allows for a more nuanced handling of overlapping 
      genes
    inputBinding:
      position: 102
      prefix: --refine
  - id: retainids
    type:
      - 'null'
      - boolean
    doc: retain original feature IDs from input files
    inputBinding:
      position: 102
      prefix: --retainids
  - id: skipends
    type:
      - 'null'
      - boolean
    doc: when enumerating interval loci, exclude unannotated (and presumably 
      incomplete) iLoci at either end of the sequence
    inputBinding:
      position: 102
      prefix: --skipends
  - id: skipiiloci
    type:
      - 'null'
      - boolean
    doc: do not report intergenic iLoci
    inputBinding:
      position: 102
      prefix: --skipiiloci
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: include all locus subfeatures (genes, RNAs, etc) in the GFF3 output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: ilens
    type:
      - 'null'
      - File
    doc: create a file with the lengths of each intergenic iLocus
    outputBinding:
      glob: $(inputs.ilens)
  - id: genemap
    type:
      - 'null'
      - File
    doc: print a mapping from each gene annotation to its corresponding locus to
      the given file
    outputBinding:
      glob: $(inputs.genemap)
  - id: outfile
    type:
      - 'null'
      - File
    doc: name of file to which results will be written
    outputBinding:
      glob: $(inputs.outfile)
  - id: transmap
    type:
      - 'null'
      - File
    doc: print a mapping from each transcript annotation to its corresponding 
      locus to the given file
    outputBinding:
      glob: $(inputs.transmap)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/aegean:0.16.0--h71bfec9_5
