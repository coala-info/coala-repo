cwlVersion: v1.2
class: CommandLineTool
baseCommand: wellington_footprints.py
label: pydnase_wellington_footprints.py
doc: "Footprint the DHSs in a DNase-seq or ATAC-seq experiment using the Wellington Algorithm.\n\nTool homepage: https://github.com/jpiper/pyDNase"
inputs:
  - id: regions
    type: File
    doc: "BED file of the regions you want to footprint"
    inputBinding:
      position: 1
  - id: reads
    type: File
    doc: "The BAM file containing the DNase-seq reads"
    secondaryFiles:
      - pattern: .bai
        required: true
    inputBinding:
      position: 2
  - id: outputdir
    type: string
    doc: "A writeable directory to write the results to"
    inputBinding:
      position: 3
  - id: bonferroni
    type:
      - 'null'
      - boolean
    doc: "Performs a bonferroni correction (default: False)."
    inputBinding:
      position: 10
      prefix: --bonferroni
  - id: shoulder_sizes
    type:
      - 'null'
      - string
    doc: "Range of shoulder sizes to try in format \"from,to,step\" (default: 35,36,1)."
    inputBinding:
      position: 11
      prefix: --shoulder-sizes
  - id: footprint_sizes
    type:
      - 'null'
      - string
    doc: "Range of footprint sizes to try in format \"from,to,step\" (default: 11,26,2)."
    inputBinding:
      position: 12
      prefix: --footprint-sizes
  - id: one_dimension
    type:
      - 'null'
      - boolean
    doc: "Use Wellington 1D instead of Wellington (default: False)."
    inputBinding:
      position: 13
      prefix: --one_dimension
  - id: fdr_cutoff
    type:
      - 'null'
      - float
    doc: "Write footprints using the FDR selection method at a specific FDR (default: 0.01)."
    inputBinding:
      position: 14
      prefix: --FDR_cutoff
  - id: fdr_iterations
    type:
      - 'null'
      - int
    doc: "How many randomisations to use when performing FDR calculations (default: 100)."
    inputBinding:
      position: 15
      prefix: --FDR_iterations
  - id: fdr_limit
    type:
      - 'null'
      - int
    doc: "Minimum p-value to be considered significant for FDR calculation (default: -20)."
    inputBinding:
      position: 16
      prefix: --FDR_limit
  - id: pv_cutoffs
    type:
      - 'null'
      - int[]
    doc: "Select footprints using a range of pvalue cutoffs (default: -10 -20 -30 -40 -50 -75 -100 -300 -500 -700)."
    inputBinding:
      position: 17
      prefix: --pv_cutoffs
  - id: dont_merge_footprints
    type:
      - 'null'
      - boolean
    doc: "Disables merging of overlapping footprints (Default: False)."
    inputBinding:
      position: 18
      prefix: --dont-merge-footprints
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: "The prefix for results files (default: <reads.regions>)."
    inputBinding:
      position: 19
      prefix: --output_prefix
  - id: processes
    type:
      - 'null'
      - int
    doc: "Number of processes to use, use 0 to use all cores (default: 1)."
    inputBinding:
      position: 20
      prefix: -p
  - id: atac
    type:
      - 'null'
      - boolean
    doc: "ATAC-seq mode (default: False)."
    inputBinding:
      position: 20
      prefix: -A
outputs:
  - id: results_dir
    type: Directory
    doc: "Directory with the footprint results."
    outputBinding:
      glob: $(inputs.outputdir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.outputdir)
        entry: "$({class: 'Directory', basename: inputs.outputdir, listing: []})"
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pydnase:0.3.0--py35_0
