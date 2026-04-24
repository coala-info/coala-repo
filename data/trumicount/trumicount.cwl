cwlVersion: v1.2
class: CommandLineTool
baseCommand: trumicount
label: trumicount
doc: "This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
  A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.\n\
  \nTool homepage: https://cibiv.github.io/trumicount/"
inputs:
  - id: combine_strand_umis
    type:
      - 'null'
      - boolean
    doc: combine UMIs strand pairs (implies --filter-strand-umis)
    inputBinding:
      position: 101
      prefix: --combine-strand-umis
  - id: cores
    type:
      - 'null'
      - int
    doc: spread group-wise model fitting over CORES cpus
    inputBinding:
      position: 101
      prefix: --cores
  - id: digits
    type:
      - 'null'
      - int
    doc: number of digits to output
    inputBinding:
      position: 101
      prefix: --digits
  - id: filter_strand_umis
    type:
      - 'null'
      - boolean
    doc: filtes UMIs where only one strands was observed
    inputBinding:
      position: 101
      prefix: --filter-strand-umis
  - id: genewise_min_umis
    type:
      - 'null'
      - int
    doc: obsolete name for --groupwise-min-umis
    inputBinding:
      position: 101
      prefix: --genewise-min-umis
  - id: group_per
    type:
      - 'null'
      - string
    doc: counts UMIs per distinct key(s), can be "cell" and/or "gene", "cell" 
      implies --umitools-option --per-cell
    inputBinding:
      position: 101
      prefix: --group-per
  - id: groupwise_min_umis
    type:
      - 'null'
      - int
    doc: use global estimates for groups with fewer than MINUMIS (strand) UMIs
    inputBinding:
      position: 101
      prefix: --groupwise-min-umis
  - id: include_filter_statistics
    type:
      - 'null'
      - boolean
    doc: add filtered and unfiltered read and UMI counts to count table
    inputBinding:
      position: 101
      prefix: --include-filter-statistics
  - id: input_bam
    type:
      - 'null'
      - File
    doc: read UMIs from FILE (uses `umi_tools group`)
    inputBinding:
      position: 101
      prefix: --input-bam
  - id: input_umis
    type:
      - 'null'
      - File
    doc: read UMIs from FILE (previously produced by --output-umis)
    inputBinding:
      position: 101
      prefix: --input-umis
  - id: input_umitools_group_out
    type:
      - 'null'
      - File
    doc: read UMIs from FILE produced by `umi_tools group`
    inputBinding:
      position: 101
      prefix: --input-umitools-group-out
  - id: mapping_quality
    type:
      - 'null'
      - int
    doc: ignored read with mapping quality below MAPQ (passed to umi_tools)
    inputBinding:
      position: 101
      prefix: --mapping-quality
  - id: molecules
    type:
      - 'null'
      - int
    doc: assume UMIs are initially represented by MOLECULES copies (strands)
    inputBinding:
      position: 101
      prefix: --molecules
  - id: paired
    type:
      - 'null'
      - boolean
    doc: assume BAM file contains paired reads (passed to umi_tools)
    inputBinding:
      position: 101
      prefix: --paired
  - id: plot_hist_bin
    type:
      - 'null'
      - float
    doc: make read count histogram bins PLOTXBIN wide
    inputBinding:
      position: 101
      prefix: --plot-hist-bin
  - id: plot_hist_xmax
    type:
      - 'null'
      - float
    doc: limit read count histogram plot to at most PLOTXMAX reads per UMI
    inputBinding:
      position: 101
      prefix: --plot-hist-xmax
  - id: plot_skip_phantoms
    type:
      - 'null'
      - boolean
    doc: do not show phantom UMIs in histogram plot
    inputBinding:
      position: 101
      prefix: --plot-skip-phantoms
  - id: plot_var_bins
    type:
      - 'null'
      - int
    doc: plot PLOTVARBINS separate emprirical variances
    inputBinding:
      position: 101
      prefix: --plot-var-bins
  - id: plot_var_logy
    type:
      - 'null'
      - boolean
    doc: use log scale for the variance (y) axis
    inputBinding:
      position: 101
      prefix: --plot-var-logy
  - id: skip_groupwise_fits
    type:
      - 'null'
      - boolean
    doc: skip group-wise model fitting, stop after plotting the global fit
    inputBinding:
      position: 101
      prefix: --skip-groupwise-fits
  - id: threshold
    type:
      - 'null'
      - int
    doc: remove UMIs with fewer than THRESHOLD reads
    inputBinding:
      position: 101
      prefix: --threshold
  - id: threshold_quantile
    type:
      - 'null'
      - float
    doc: use quantile Q of the raw read-count distribution for THRESHOLD
    inputBinding:
      position: 101
      prefix: --threshold-quantile
  - id: umi_sep
    type:
      - 'null'
      - string
    doc: assume UMISEP separates read name and UMI (passed to umi_tools)
    inputBinding:
      position: 101
      prefix: --umi-sep
  - id: umipair_sep
    type:
      - 'null'
      - string
    doc: assume UMIPAIRSEP separates read1 and read2 UMI (see Strand UMIs)
    inputBinding:
      position: 101
      prefix: --umipair-sep
  - id: umitools
    type:
      - 'null'
      - string
    doc: use executable UMITOOLS to run `umi_tools group`
    inputBinding:
      position: 101
      prefix: --umitools
  - id: umitools_option
    type:
      - 'null'
      - type: array
        items: string
    doc: pass UMITOOLSOPT to `umi_tools group` (see `umi_tools group --help`)
    inputBinding:
      position: 101
      prefix: --umitools-option
  - id: variance_estimator
    type:
      - 'null'
      - string
    doc: use VAREST to estimate variances, can be "lsq" or "mle"
    inputBinding:
      position: 101
      prefix: --variance-estimator
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: enable verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_counts
    type:
      - 'null'
      - File
    doc: write bias-corrected per-group counts and models to FILE
    outputBinding:
      glob: $(inputs.output_counts)
  - id: output_umis
    type:
      - 'null'
      - File
    doc: write UMIs reported by `umi_tools group` to FILE
    outputBinding:
      glob: $(inputs.output_umis)
  - id: output_final_umis
    type:
      - 'null'
      - File
    doc: write strand-combined and filtered UMIs to FILE
    outputBinding:
      glob: $(inputs.output_final_umis)
  - id: output_readdist
    type:
      - 'null'
      - File
    doc: write global reads/UMI distribution (before and after filtering) to 
      FILE
    outputBinding:
      glob: $(inputs.output_readdist)
  - id: output_plots
    type:
      - 'null'
      - File
    doc: write diagnostic plots in PDF format to PLOT
    outputBinding:
      glob: $(inputs.output_plots)
  - id: output_groupwise_fits
    type:
      - 'null'
      - File
    doc: write group-wise model details to FILE
    outputBinding:
      glob: $(inputs.output_groupwise_fits)
  - id: output_genewise_fits
    type:
      - 'null'
      - File
    doc: obsolete name for --output-groupwise-fits
    outputBinding:
      glob: $(inputs.output_genewise_fits)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trumicount:0.9.14--r44hdfd78af_3
