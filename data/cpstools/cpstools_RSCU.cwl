cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cpstools
  - RSCU
label: cpstools_RSCU
requirements:
  - class: InlineJavascriptRequirement
  - class: LoadListingRequirement
    loadListing: shallow_listing
doc: "Calculate RSCU values for CDS sequences.\n\nTool homepage: https://github.com/Xwb7533/CPStools"
inputs:
  - id: filter_length
    type:
      - 'null'
      - int
    doc: CDS filter length
    inputBinding:
      position: 101
      prefix: --filter_length
  - id: work_dir
    type: Directory
    doc: Input directory of genbank files
    inputBinding:
      position: 101
      prefix: --work_dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: rscu_dirs
    type: Directory[]
    doc: One result folder per GenBank file (RSCU_results.txt and filtered sequences)
    outputBinding:
      glob: |-
        ${ return inputs.work_dir.listing.filter(function(f) { return f.class == 'File' && /(gb|gbk)$/.test(f.basename); }).map(function(f) { return f.nameroot; }); }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cpstools:3.0--pyhdfd78af_0
stdout: cpstools_RSCU.out
