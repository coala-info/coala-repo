cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyluce_probe_get_clusters_from_bed
label: phyluce_phyluce_probe_get_clusters_from_bed
doc: "Given an input directory of BED files, find clusters of overlapping entries\
  \ and write one JSON file per BED file\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: bed
    type: Directory
    doc: The BED directory you want to search for clusters
    inputBinding:
      prefix: --bed
  - id: outdir
    type: string
    doc: The output directory to store results
    inputBinding:
      prefix: --outdir
  - id: files
    type:
      - 'null'
      - type: array
        items: string
    doc: Specific files in the directory you want to process (file names inside the
      BED directory)
    inputBinding:
      prefix: --files
      valueFrom: $(self.map(function(f) { return inputs.bed.path + "/" + f; }))
outputs:
  - id: clusters
    type: Directory
    doc: The directory of JSON cluster files.
    outputBinding:
      glob: $(inputs.outdir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
