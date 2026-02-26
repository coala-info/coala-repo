cwlVersion: v1.2
class: CommandLineTool
baseCommand: msstitch_peptides
label: msstitch_peptides
doc: "Stitches together peptide-level quantification data.\n\nTool homepage: https://github.com/lehtiolab/msstitch"
inputs:
  - id: denomcols
    type:
      - 'null'
      - type: array
        items: int
    doc: Column numbers of denominator channels when creating a summarized 
      feature table with isobaric ratios from PSMs
    inputBinding:
      position: 101
      prefix: --denomcols
  - id: denompatterns
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Regex patterns to detect denominator channels in a PSM table, when creating
      a table with summarized feature isobaric ratios. If both --denompatterns and
      --denomcol are given then column numbers are used. Usage e.g. --denompattern
      _126 _131. Also possible: --denompattern _12[6-7] to detect multiple columns.'
    inputBinding:
      position: 101
      prefix: --denompatterns
  - id: input_file
    type: File
    doc: Input file of {} format
    inputBinding:
      position: 101
      prefix: -i
  - id: isobquantcolpattern
    type:
      - 'null'
      - string
    doc: Unique text pattern to identify isobaric quant columns in input table.
    inputBinding:
      position: 101
      prefix: --isobquantcolpattern
  - id: keep_psms_na_quant
    type:
      - 'null'
      - boolean
    doc: When summarizing isobaric quantification data, also use the PSMs that 
      have an NA in any channel, even if these may contain overly noisy quant 
      data in the other channels. Normally these PSMs would be skipped in 
      quantification
    inputBinding:
      position: 101
      prefix: --keep-psms-na-quant
  - id: logisoquant
    type:
      - 'null'
      - boolean
    doc: Output log2 values for isoquant ratios. This log2-transforms input PSM 
      data prior to summarizing and optional normalization. Ratios will be 
      calculated subtracted rather than divided, obviously.
    inputBinding:
      position: 101
      prefix: --logisoquant
  - id: median_normalize
    type:
      - 'null'
      - boolean
    doc: Median-centering normalization for isobaric quant data on protein or 
      peptide level. This median-centers the data for each channel by dividing 
      with the median channel value (or subtracting in case of log data), for 
      each channel in output features, e.g. proteins.
    inputBinding:
      position: 101
      prefix: --median-normalize
  - id: medianintensity
    type:
      - 'null'
      - boolean
    doc: Instead of choosing a denominator channel or median-sweeping, report 
      the the median intensity of each summarized feat per channel. This results
      in reported intensities rather than ratios.
    inputBinding:
      position: 101
      prefix: --medianintensity
  - id: mediansweep
    type:
      - 'null'
      - boolean
    doc: Instead of choosing a denominator channel, use the median intensity of 
      each PSM as its denominator.
    inputBinding:
      position: 101
      prefix: --mediansweep
  - id: minint
    type:
      - 'null'
      - float
    doc: Intensity threshold of PSMs when calculating isobaric ratios. Values 
      below threshold will be set to NA. Defaults to no threshold.
    inputBinding:
      position: 101
      prefix: --minint
  - id: minpepnr
    type:
      - 'null'
      - int
    doc: Specifies the minimal amount of peptides (passing the --qvalthreshold) 
      needed to fit a linear model, default is 10.
    default: 10
    inputBinding:
      position: 101
      prefix: --minpepnr
  - id: modelqvals
    type:
      - 'null'
      - boolean
    doc: Create linear-modeled q-vals for peptides, to avoid overlapping stepped
      low-qvalue data of peptides with different scores
    inputBinding:
      position: 101
      prefix: --modelqvals
  - id: ms1quantcolpattern
    type:
      - 'null'
      - string
    doc: Unique text pattern to identify precursor quant column in input table.
    inputBinding:
      position: 101
      prefix: --ms1quantcolpattern
  - id: normalization_factors_table
    type:
      - 'null'
      - File
    doc: A protein/peptide/gene table that provides an alternate source of 
      normalization factors than the table to be normalized. This can be used 
      e.g. when having a PTM table which does not have a large amount of 
      peptides or is noisy. Use together with --median- normalize
    inputBinding:
      position: 101
      prefix: --normalization-factors-table
  - id: qvalthreshold
    type:
      - 'null'
      - float
    doc: Specifies the inclusion threshold for q-values to fit a linear model 
      to. Any scores/q-values below this threshold will not be used.
    inputBinding:
      position: 101
      prefix: --qvalthreshold
  - id: scorecolpattern
    type: string
    doc: Regular expression pattern to find column where score to use (e.g. 
      percolator svm-score) is written.
    inputBinding:
      position: 101
      prefix: --scorecolpattern
  - id: spectracol
    type:
      - 'null'
      - int
    doc: Specify this column number (first col. is 1) containing PSM table 
      spectrafiles (e.g. mzML) if you want to track PSMs when creating peptide 
      tables
    inputBinding:
      position: 101
      prefix: --spectracol
  - id: summarize_average
    type:
      - 'null'
      - boolean
    doc: Use average isobaric quantification values for summarizing quant from 
      PSMs, instead of default PSM median values
    inputBinding:
      position: 101
      prefix: --summarize-average
  - id: totalproteome
    type:
      - 'null'
      - File
    doc: File containing total proteome quantification to normalize PTM peptide 
      quantification against, i.e. Phospho peptides isobaric quant ratios are 
      divided by their proteins to distinguish differential phosphorylation from
      the protein expression variation in the sample. This file can also be a 
      gene names or ENSG table. Accession should be in the first column. The 
      file is preferably generated from a search without the relevant PTM, and 
      can be a median-center normalized table.
    inputBinding:
      position: 101
      prefix: --totalproteome
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory to output in
    outputBinding:
      glob: $(inputs.output_dir)
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msstitch:3.19--pyhdfd78af_0
