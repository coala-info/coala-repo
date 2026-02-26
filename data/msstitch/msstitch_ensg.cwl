cwlVersion: v1.2
class: CommandLineTool
baseCommand: msstitch ensg
label: msstitch_ensg
doc: "Stitches together isobaric quantification data from PSMs and other sources.\n\
  \nTool homepage: https://github.com/lehtiolab/msstitch"
inputs:
  - id: decoyfasta
    type:
      - 'null'
      - File
    doc: FASTA file with decoy proteins to determine best scoring proteins of 
      target/decoy pairs for picked FDR. Required when using --fdrtype picked
    inputBinding:
      position: 101
      prefix: --decoyfasta
  - id: decoyfn
    type: File
    doc: Decoy peptide table input file
    inputBinding:
      position: 101
      prefix: --decoyfn
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
  - id: fastadelim
    type:
      - 'null'
      - string
    doc: Delimiter in FASTA header, used to parse gene names in case of 
      non-ENSEMBL/Uniprot
    inputBinding:
      position: 101
      prefix: --fastadelim
  - id: fdrtype
    type:
      - 'null'
      - string
    doc: FDR strategy type used. Can be one of [classic, picked]. Picked FDR is 
      implemented after Savitski et al. 2015, MCP, and needs target and decoy 
      fasta files to form pairs
    inputBinding:
      position: 101
      prefix: --fdrtype
  - id: genefield
    type:
      - 'null'
      - int
    doc: Field nr (first=1) in FASTA that contains gene name when using 
      --fastadelim to parse the gene names
    inputBinding:
      position: 101
      prefix: --genefield
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
  - id: logscore
    type:
      - 'null'
      - boolean
    doc: Score, e.g. q-values will be converted to -log10 values.
    inputBinding:
      position: 101
      prefix: --logscore
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
  - id: ms1quant
    type:
      - 'null'
      - boolean
    doc: Specifies to add precursor quant data from lookup DB to output table
    inputBinding:
      position: 101
      prefix: --ms1quant
  - id: normalization_factors_table
    type:
      - 'null'
      - File
    doc: A protein/peptide/gene table that provides an alternate source of 
      normalization factors than the table to be normalized. This can be used 
      e.g. when having a PTM table which does not have a large amount of 
      peptides or is noisy. Use together with --median-normalize
    inputBinding:
      position: 101
      prefix: --normalization-factors-table
  - id: psmtable
    type:
      - 'null'
      - File
    doc: PSM table file containing isobaric quant data to add to table.
    inputBinding:
      position: 101
      prefix: --psmtable
  - id: scorecolpattern
    type: string
    doc: Regular expression pattern to find column where score to use (e.g. 
      percolator svm-score) is written.
    inputBinding:
      position: 101
      prefix: --scorecolpattern
  - id: summarize_average
    type:
      - 'null'
      - boolean
    doc: Use average isobaric quantification values for summarizing quant from 
      PSMs, instead of default PSM median values
    inputBinding:
      position: 101
      prefix: --summarize-average
  - id: targetfasta
    type:
      - 'null'
      - File
    doc: FASTA file with target proteins to determine best scoring proteins of 
      target/decoy pairs for picked FDR. Required when using --fdrtype picked
    inputBinding:
      position: 101
      prefix: --targetfasta
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
