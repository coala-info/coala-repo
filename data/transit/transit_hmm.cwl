cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - transit
  - hmm
label: transit_hmm
doc: "Hidden Markov Model that classifies each TA site and gene as essential, non-essential, growth-defect or growth-advantage.\n\nTool homepage: http://github.com/mad-lab/transit"
inputs:
  - id: wig_files
    type: File[]
    doc: "Comma-separated .wig files"
    inputBinding:
      position: 1
      itemSeparator: ','
  - id: annotation_file
    type: File
    doc: "Annotation .prot_table or GFF3 file"
    inputBinding:
      position: 2
  - id: output_base_filename
    type: string
    doc: "Output BASE filename (will create 2 output files: BASE.sites.txt and BASE.genes.txt)"
    inputBinding:
      position: 3
  - id: replicates_handling
    type: ['null', string]
    doc: "How to handle replicates. Sum, Mean. Default: Mean"
    inputBinding:
      position: 20
      prefix: -r
  - id: normalization_method
    type: ['null', string]
    doc: "Normalization method. Default: TTR"
    inputBinding:
      position: 20
      prefix: -n
  - id: loess_correction
    type: ['null', boolean]
    doc: "Perform LOESS Correction; Helps remove possible genomic position bias. Default: Turned Off."
    inputBinding:
      position: 20
      prefix: -l
  - id: ignore_n_terminus_percentage
    type: ['null', float]
    doc: "Ignore TAs occuring within given percentage (as integer) of the N terminus. Default: 0"
    inputBinding:
      position: 20
      prefix: -iN
  - id: ignore_c_terminus_percentage
    type: ['null', float]
    doc: "Ignore TAs occuring within given percentage (as integer) of the C terminus. Default: 0"
    inputBinding:
      position: 20
      prefix: -iC
outputs:
  - id: sites_file
    type: File
    doc: "Per-site output file (BASE.sites.txt)"
    outputBinding:
      glob: $(inputs.output_base_filename).sites.txt
  - id: genes_file
    type: File
    doc: "Per-gene output file (BASE.genes.txt)"
    outputBinding:
      glob: $(inputs.output_base_filename).genes.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
