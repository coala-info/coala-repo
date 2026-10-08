cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fanc
  - loops
label: fanc_loops
doc: "Call loops in a Hic object using the FAN-C implementation of HICCUPS (Rao, Huntley et al. 2014).\n\nTool homepage: https://github.com/vaquerizaslab/fanc"
inputs:
  - id: input
    type: File
    doc: "Input Hic file, or an existing FAN-C loops object to filter."
    inputBinding:
      position: 1
  - id: output
    type:
      - 'null'
      - string
    doc: "Output FAN-C loops (peaks) file. Can be left empty when the input is a loops object and only a BEDPE export (-b) is wanted."
    inputBinding:
      position: 2
  - id: chromosomes
    type:
      - 'null'
      - type: array
        items: string
    doc: "Chromosomes to be investigated."
    inputBinding:
      position: 20
      prefix: --chromosomes
  - id: peak_size
    type:
      - 'null'
      - int
    doc: "Size of the expected peak in pixels. If not set, will be estimated to correspond to ~ 25kb."
    inputBinding:
      position: 20
      prefix: --peak-size
  - id: neighborhood_width
    type:
      - 'null'
      - int
    doc: "Width of the investigated area surrounding pixels. If not set, will be estimated at p+3"
    inputBinding:
      position: 20
      prefix: --neighborhood-width
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads for parallel processing. Default: 1 - it is advised to set this as high as possible, since loop calling is very computationally expensive!"
    inputBinding:
      position: 20
      prefix: --threads
  - id: min_distance
    type:
      - 'null'
      - int
    doc: "Minimum distance in bins for two loci to be considered as loops. Default: peak size. Set this value higher to exclude loops close to the diagonal."
    inputBinding:
      position: 20
      prefix: --min-distance
  - id: mappability
    type:
      - 'null'
      - float
    doc: "Global mappability filter for all neighborhoods.Minimum mappable fraction of a pixel neighborhood to consider pixel as loop. Can be overridden by filters for local neighborhoods."
    inputBinding:
      position: 20
      prefix: --mappability
  - id: mappability_donut
    type:
      - 'null'
      - float
    doc: "Mappability filter for donut neighborhood. Value between 0 and 1."
    inputBinding:
      position: 20
      prefix: --mappability-donut
  - id: mappability_horizontal
    type:
      - 'null'
      - float
    doc: "Mappability filter for horizontal neighborhood. Value between 0 and 1."
    inputBinding:
      position: 20
      prefix: --mappability-horizontal
  - id: mappability_vertical
    type:
      - 'null'
      - float
    doc: "Mappability filter for vertical neighborhood. Value between 0 and 1."
    inputBinding:
      position: 20
      prefix: --mappability-vertical
  - id: mappability_lower_left
    type:
      - 'null'
      - float
    doc: "Mappability filter for lower-left neighborhood. Value between 0 and 1."
    inputBinding:
      position: 20
      prefix: --mappability-lower-left
  - id: fdr
    type:
      - 'null'
      - float
    doc: "Global FDR filter all neighborhoods. Individual neighborhood filters can override this global setting. Value between 0 and 1."
    inputBinding:
      position: 20
      prefix: --fdr
  - id: fdr_donut
    type:
      - 'null'
      - float
    doc: "FDR filter for donut neighborhood. Value between 0 and 1."
    inputBinding:
      position: 20
      prefix: --fdr-donut
  - id: fdr_horizontal
    type:
      - 'null'
      - float
    doc: "FDR filter for horizontal neighborhood. Value between 0 and 1."
    inputBinding:
      position: 20
      prefix: --fdr-horizontal
  - id: fdr_vertical
    type:
      - 'null'
      - float
    doc: "FDR filter for vertical neighborhood. Value between 0 and 1."
    inputBinding:
      position: 20
      prefix: --fdr-vertical
  - id: fdr_lower_left
    type:
      - 'null'
      - float
    doc: "FDR filter for lower-left neighborhood. Value between 0 and 1."
    inputBinding:
      position: 20
      prefix: --fdr-lower-left
  - id: enrichment
    type:
      - 'null'
      - float
    doc: "Global observed/expected filter all neighborhoods. Individual neighborhood filters can override this global setting."
    inputBinding:
      position: 20
      prefix: --enrichment
  - id: enrichment_donut
    type:
      - 'null'
      - float
    doc: "Observed/expected enrichment filter for donut neighborhood."
    inputBinding:
      position: 20
      prefix: --enrichment-donut
  - id: enrichment_horizontal
    type:
      - 'null'
      - float
    doc: "Observed/expected enrichment filter for horizontal neighborhood."
    inputBinding:
      position: 20
      prefix: --enrichment-horizontal
  - id: enrichment_vertical
    type:
      - 'null'
      - float
    doc: "Observed/expected enrichment filter for vertical neighborhood."
    inputBinding:
      position: 20
      prefix: --enrichment-vertical
  - id: enrichment_lower_left
    type:
      - 'null'
      - float
    doc: "Observed/expected enrichment filter for lower-left neighborhood."
    inputBinding:
      position: 20
      prefix: --enrichment-lower-left
  - id: observed
    type:
      - 'null'
      - int
    doc: "Minimum observed value (integer, uncorrected). Default: 1"
    inputBinding:
      position: 20
      prefix: --observed
  - id: rh_filter
    type:
      - 'null'
      - boolean
    doc: "Filter peaks as in Rao, Huntley et al. (2014), Cell. It only retains peaks that are at least 2-fold enriched over either the donut or lower-left neighborhood, at least 1.5-fold enriched over the horizontal and vertical neighborhoods, at least 1.75-fold enriched over both the donut and lower-left neighborhood, and have an FDR <= 0.1 in every neighborhood"
    inputBinding:
      position: 20
      prefix: --rh-filter
  - id: batch_size
    type:
      - 'null'
      - int
    doc: "Width of submatrix examined per process. Default: 200"
    inputBinding:
      position: 20
      prefix: --batch-size
  - id: merge_pixels
    type:
      - 'null'
      - boolean
    doc: "Merge individual pixels into peaks after filtering."
    inputBinding:
      position: 20
      prefix: --merge-pixels
  - id: merge_distance
    type:
      - 'null'
      - int
    doc: "Maximum distance in base pairs at which to merge two pixels. Default 20000"
    inputBinding:
      position: 20
      prefix: --merge-distance
  - id: remove_singlets
    type:
      - 'null'
      - boolean
    doc: "Remove isolated pixels after merging step."
    inputBinding:
      position: 20
      prefix: --remove-singlets
  - id: fdr_sum
    type:
      - 'null'
      - float
    doc: "FDR sum filter for merged peaks. Merged peaks where the sum of donut FDR values of all constituent pixels is larger than the specified cutoff are filtered."
    inputBinding:
      position: 20
      prefix: --fdr-sum
  - id: bedpe
    type:
      - 'null'
      - string
    doc: "BEDPE output file. When set, merged loops will be written to this file after all filtering steps have completed."
    inputBinding:
      position: 20
      prefix: --bedpe
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: "If the specified output file exists, it will be overwritten without warning."
    inputBinding:
      position: 20
      prefix: --force-overwrite
  - id: work_in_tmp
    type:
      - 'null'
      - boolean
    doc: "Work in temporary directory"
    inputBinding:
      position: 20
      prefix: --work-in-tmp
outputs:
  - id: loops
    type:
      - 'null'
      - File
    doc: "FAN-C loops object."
    outputBinding:
      glob: "$(inputs.output ? inputs.output : [])"
  - id: bedpe_file
    type:
      - 'null'
      - File
    doc: "Merged loops (BEDPE)."
    outputBinding:
      glob: $(inputs.bedpe)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
