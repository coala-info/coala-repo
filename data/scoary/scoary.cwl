cwlVersion: v1.2
class: CommandLineTool
baseCommand: scoary
label: scoary
doc: "Screen pan-genome for trait-associated variants\n\nTool homepage: https://github.com/AdmiralenOla/Scoary"
inputs:
  - id: citation
    type:
      - 'null'
      - boolean
    doc: Show citation information, and exit.
    inputBinding:
      position: 101
      prefix: --citation
  - id: collapse
    type:
      - 'null'
      - boolean
    doc: "Add this to collapse correlated genes (genes that have\nidentical distribution
      patterns in the sample) into\nmerged units."
    inputBinding:
      position: 101
      prefix: --collapse
  - id: correction
    type:
      - 'null'
      - type: array
        items: string
    doc: "Apply the indicated filtration measure. Allowed values\nare I, B, BH, PW,
      EPW, P. I=Individual (naive)\np-value. B=Bonferroni adjusted p-value. BH=Benjamini-\n\
      Hochberg adjusted p. PW=Best (lowest) pairwise\ncomparison. EPW=Entire range
      of pairwise comparison\np-values. P=Empirical p-value from permutations. You\n\
      can enter as many correction criteria as you would\nlike. These will be associated
      with the\np_value_cutoffs you enter. For example \"-c I EPW -p\n0.1 0.05\" will
      apply the following cutoffs: Naive\np-value must be lower than 0.1 AND the entire
      range of\npairwise comparison values are below 0.05 for this\ngene. Note that
      the empirical p-values should be\ninterpreted at both tails. Therefore, running
      \"-c P -p\n0.05\" will apply an alpha of 0.05 to the empirical\n(permuted) p-values,
      i.e. it will filter everything\nexcept the upper and lower 2.5 percent of the\n\
      distribution. Default = Individual p-value. (I)"
    inputBinding:
      position: 101
      prefix: --correction
  - id: delimiter
    type:
      - 'null'
      - string
    doc: "The delimiter between cells in the gene\npresence/absence and trait files,
      as well as the\noutput file."
    inputBinding:
      position: 101
      prefix: --delimiter
  - id: genes
    type:
      - 'null'
      - File
    doc: "Input gene presence/absence table (comma-separated-\nvalues) from ROARY.
      Strain names must be equal to\nthose in the trait table"
    inputBinding:
      position: 101
      prefix: --genes
  - id: include_input_columns
    type:
      - 'null'
      - string
    doc: "Grab columns from the input Roary file. and puts them\nin the output. Handles
      comma and ranges, e.g.\n--include_input_columns 4,6,8,16-23. The special\nkeyword
      ALL will include all relevant input columns in\nthe output"
    inputBinding:
      position: 101
      prefix: --include_input_columns
  - id: max_hits
    type:
      - 'null'
      - int
    doc: "Maximum number of hits to report. SCOARY will only\nreport the top max_hits
      results per trait"
    inputBinding:
      position: 101
      prefix: --max_hits
  - id: newicktree
    type:
      - 'null'
      - File
    doc: "Supply a custom tree (Newick format) for phylogenetic\nanalyses instead
      instead of calculating it internally."
    inputBinding:
      position: 101
      prefix: --newicktree
  - id: no_pairwise
    type:
      - 'null'
      - boolean
    doc: "Do not perform pairwise comparisons. Inthis mode,\nScoary will perform population
      structure-naive\ncalculations only. (Fishers test, ORs etc). Useful for\nsummary
      operations and exploring sets. (Genes unique\nin groups, intersections etc)
      but not causal analyses."
    inputBinding:
      position: 101
      prefix: --no_pairwise
  - id: no_time
    type:
      - 'null'
      - boolean
    doc: "Output file in the form TRAIT.results.csv, instead of\nTRAIT_TIMESTAMP.csv.
      When used with the -w argument\nwill output a reduced gene matrix in the form\n\
      gene_presence_absence_reduced.csv rather than\ngene_presence_absence_reduced_TIMESTAMP.csv"
    inputBinding:
      position: 101
      prefix: --no-time
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Directory to place output files. Default = .
    inputBinding:
      position: 101
      prefix: --outdir
  - id: p_value_cutoff
    type:
      - 'null'
      - type: array
        items: float
    doc: "P-value cut-off / alpha level. For Fishers,\nBonferronis, and Benjamini-Hochbergs
      tests, SCOARY\nwill not report genes with higher p-values than this.\nFor empirical
      p-values, this is treated as an alpha\nlevel instead. I.e. 0.02 will filter
      all genes except\nthe lower and upper percentile from this test. Run\nwith \"\
      -p 1.0\" to report all genes. Accepts standard\nform (e.g. 1E-8). Provide a
      single value (applied to\nall) or exactly as many values as correction criteria\n\
      and in corresponding order. (See example under\ncorrection). Default = 0.05"
    inputBinding:
      position: 101
      prefix: --p_value_cutoff
  - id: permute
    type:
      - 'null'
      - int
    doc: "Perform N number of permutations of the significant\nresults post-analysis.
      Each permutation will do a\nlabel switching of the phenotype and a new p-value
      is\ncalculated according to this new dataset. After all N\npermutations are
      completed, the results are ordered in\nascending order, and the percentile of
      the original\nresult in the permuted p-value distribution is\nreported."
    inputBinding:
      position: 101
      prefix: --permute
  - id: restrict_to
    type:
      - 'null'
      - File
    doc: "Use if you only want to analyze a subset of your\nstrains. Scoary will read
      the provided comma-separated\ntable of strains and restrict analyzes to these."
    inputBinding:
      position: 101
      prefix: --restrict_to
  - id: start_col
    type:
      - 'null'
      - int
    doc: "On which column in the gene presence/absence file do\nindividual strain
      info start. Default=15. (1-based\nindexing)"
    inputBinding:
      position: 101
      prefix: --start_col
  - id: test
    type:
      - 'null'
      - boolean
    doc: "Run Scoary on the test set in exampledata, overriding\nall other parameters."
    inputBinding:
      position: 101
      prefix: --test
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use. Default = 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: traits
    type:
      - 'null'
      - File
    doc: "Input trait table (comma-separated-values). Trait\npresence is indicated
      by 1, trait absence by 0.\nAssumes strain names in the first column and trait\n\
      names in the first row"
    inputBinding:
      position: 101
      prefix: --traits
  - id: upgma_tree
    type:
      - 'null'
      - boolean
    doc: "This flag will cause Scoary to write the calculated\nUPGMA tree to a newick
      file"
    inputBinding:
      position: 101
      prefix: --upgma_tree
  - id: write_reduced
    type:
      - 'null'
      - boolean
    doc: "Use with -r if you want Scoary to create a new gene\npresence absence file
      from your reduced set of\nisolates. Note: Columns 1-14 (No. sequences, Avg group\n\
      size nuc etc) in this file do not reflect the reduced\ndataset. These are taken
      from the full dataset."
    inputBinding:
      position: 101
      prefix: --write_reduced
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/scoary:v1.6.16-1-deb_cv1
stdout: scoary.out
