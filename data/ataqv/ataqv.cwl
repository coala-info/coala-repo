cwlVersion: v1.2
class: CommandLineTool
baseCommand: ataqv
label: ataqv
doc: "QC metrics for ATAC-seq data\n\nTool homepage: https://parkerlab.github.io/ataqv/"
inputs:
  - id: organism
    type: string
    doc: The subject of the experiment, which determines the list of autosomes
    inputBinding:
      position: 1
  - id: alignment_file
    type: File
    doc: A BAM file with duplicate reads marked.
    inputBinding:
      position: 2
  - id: autosomal_reference_file
    type:
      - 'null'
      - File
    doc: A file containing autosomal reference names, one per line. The names 
      must match the reference names in the alignment file exactly, or the 
      metrics based on counts of autosomal alignments will be wrong.
    inputBinding:
      position: 103
      prefix: --autosomal-reference-file
  - id: description
    type:
      - 'null'
      - string
    doc: A short description of the experiment.
    inputBinding:
      position: 103
      prefix: --description
  - id: excluded_region_file
    type:
      - 'null'
      - type: array
        items: File
    doc: A BED file containing excluded regions. Peaks or TSS overlapping these 
      will be ignored.
    inputBinding:
      position: 103
      prefix: --excluded-region-file
  - id: ignore_read_groups
    type:
      - 'null'
      - boolean
    doc: Even if read groups are present in the BAM file, ignore them and 
      combine metrics for all reads under a single sample and library named with
      the --name option. This also implies that a single peak file will be used 
      for all reads; see the --peak option.
    inputBinding:
      position: 103
      prefix: --ignore-read-groups
  - id: less_redundant
    type:
      - 'null'
      - boolean
    doc: If given, output a subset of metrics that should be less redundant. If 
      this flag is used, the same flag should be passed to mkarv when making the
      viewer.
    inputBinding:
      position: 103
      prefix: --less-redundant
  - id: library_description
    type:
      - 'null'
      - string
    doc: Use this description for all libraries in the BAM file, instead of 
      using the DS field from each read group.
    inputBinding:
      position: 103
      prefix: --library-description
  - id: log_problematic_reads
    type:
      - 'null'
      - boolean
    doc: If given, problematic reads will be logged to a file per read group, 
      with names derived from the read group IDs, with ".problems" appended. If 
      no read groups are found, the reads will be written to one file named 
      after the BAM file.
    inputBinding:
      position: 103
      prefix: --log-problematic-reads
  - id: mitochondrial_reference_name
    type:
      - 'null'
      - string
    doc: If the reference name for mitochondrial DNA in your alignment file is 
      not "chrM",. use this option to supply the correct name. Again, if this 
      name is wrong, all the measurements involving mitochondrial alignments 
      will be wrong.
    inputBinding:
      position: 103
      prefix: --mitochondrial-reference-name
  - id: name
    type:
      - 'null'
      - string
    doc: A label to be used for the metrics when there are no read groups. If 
      there are read groups, each will have its metrics named using its ID 
      field. With no read groups and no --name given, your metrics will be named
      after the alignment file.
    inputBinding:
      position: 103
      prefix: --name
  - id: nucleus_barcode_tag
    type:
      - 'null'
      - string
    doc: Data is single-nucleus, with the barcode stored in this BAM tag. In 
      this case, metrics will be collected per barcode.
    inputBinding:
      position: 103
      prefix: --nucleus-barcode-tag
  - id: peak_file
    type:
      - 'null'
      - File
    doc: A BED file of peaks called for alignments in the BAM file. Specify 
      "auto" to use the BAM file name with ".peaks" appended, or if the BAM file
      contains read groups, to assume each read group has a peak file whose name
      is the read group ID with ".peaks" appended. If you specify a single 
      filename instead of "auto" with read groups, the same peaks will be used 
      for all reads -- be sure this is what you want.
    inputBinding:
      position: 103
      prefix: --peak-file
  - id: threads
    type:
      - 'null'
      - int
    doc: the maximum number of threads to use (right now, only for calculating 
      TSS enrichment).
    inputBinding:
      position: 103
      prefix: --threads
  - id: tss_extension
    type:
      - 'null'
      - string
    doc: If a TSS enrichment score is requested, it will be calculated for a 
      region of "size" bases to either side of transcription start sites.
    default: 1000bp
    inputBinding:
      position: 103
      prefix: --tss-extension
  - id: tss_file
    type:
      - 'null'
      - File
    doc: A BED file of transcription start sites for the experiment organism. If
      supplied, a TSS enrichment score will be calculated according to the 
      ENCODE data standards. This calculation requires that the BAM file of 
      alignments be indexed.
    inputBinding:
      position: 103
      prefix: --tss-file
  - id: url
    type:
      - 'null'
      - string
    doc: A URL for more detail on the experiment (perhaps using a DOI).
    inputBinding:
      position: 103
      prefix: --url
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: show more details and progress updates.
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: metrics_file
    type:
      - 'null'
      - File
    doc: The JSON file to which metrics will be written. The default filename 
      will be based on the BAM file, with the suffix ".ataqv.json".
    outputBinding:
      glob: $(inputs.metrics_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ataqv:1.3.1--py310h50a2689_5
