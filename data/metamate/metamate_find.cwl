cwlVersion: v1.2
class: CommandLineTool
baseCommand: metamate_find
label: metamate_find
doc: "find arguments:\n\nTool homepage: https://github.com/tjcreedy/metamate"
inputs:
  - id: anyfail
    type:
      - 'null'
      - boolean
    doc: "reject ASVs when any incidences fail to meet a\n                       \
      \ threshold (default is all incidences)"
    inputBinding:
      position: 101
      prefix: --anyfail
  - id: asvs
    type: File
    doc: path to a fasta of unique sequences to filter
    inputBinding:
      position: 101
      prefix: --asvs
  - id: basesvariation
    type:
      - 'null'
      - int
    doc: "the number of bases of variation from the expected\n                   \
      \     length outside which ASVs should be designated as non-target"
    inputBinding:
      position: 101
      prefix: --basesvariation
  - id: codonsvariation
    type:
      - 'null'
      - int
    doc: "the number of codons of variation from the expected\n                  \
      \      length outside which ASVs should be designated as non-\n            \
      \            target"
    inputBinding:
      position: 101
      prefix: --codonsvariation
  - id: detectionconfidence
    type:
      - 'null'
      - float
    doc: "confidence level for detection of reading frame\n                      \
      \  (default 0.95)"
    inputBinding:
      position: 101
      prefix: --detectionconfidence
  - id: detectionminstops
    type:
      - 'null'
      - int
    doc: "minimum number of stops to encounter for detection\n                   \
      \     (default 100, may need to decrease for few input ASVs)"
    inputBinding:
      position: 101
      prefix: --detectionminstops
  - id: distancemodel
    type:
      - 'null'
      - string
    doc: "substitution model for UPGMA tree estimation (passed\n                 \
      \       to R dist.dna, default F84)"
    inputBinding:
      position: 101
      prefix: --distancemodel
  - id: divergence
    type:
      - 'null'
      - float
    doc: "divergence level to use for assigning clades (default\n                \
      \        0.2)"
    inputBinding:
      position: 101
      prefix: --divergence
  - id: expectedlength
    type:
      - 'null'
      - int
    doc: the expected length of the sequences
    inputBinding:
      position: 101
      prefix: --expectedlength
  - id: generate_asv_results
    type:
      - 'null'
      - type: array
        items: float
    doc: "generate fasta files of retained ASVs for for\n                        threshold
      sets: if no value is given, generate for top\n                        scoring
      set(s) only; otherwise generate for the given\n                        proportion
      of top scoring sets (default 0: no ASVs\n                        output)"
    inputBinding:
      position: 101
      prefix: --generateASVresults
  - id: ignoreambigASVs
    type:
      - 'null'
      - boolean
    doc: "ASVs that match the same reference will not be\n                       \
      \ considered vaASV (default is to count the most\n                        abundant
      one as verified authentic)."
    inputBinding:
      position: 101
      prefix: --ignoreambigASVs
  - id: keeptemporaryfiles
    type:
      - 'null'
      - boolean
    doc: "don't delete the temporary bbmap result files\n                        generated
      during reference matching"
    inputBinding:
      position: 101
      prefix: --keeptemporaryfiles
  - id: libraries
    type:
      - 'null'
      - type: array
        items: File
    doc: "path to fastx file(s) of individual libraries/discrete\n               \
      \         samples from which ASVs were drawn, or a single fastx\n          \
      \              with ';samplename=NAME;' or ';barcodelabel=NAME;'\n         \
      \               annotations in headers."
    inputBinding:
      position: 101
      prefix: --libraries
  - id: maximumlength
    type:
      - 'null'
      - int
    doc: "designate ASVs that are longer than this value as non-\n               \
      \         target"
    inputBinding:
      position: 101
      prefix: --maximumlength
  - id: minimumlength
    type:
      - 'null'
      - int
    doc: "designate ASVs that are shorter than this value as\n                   \
      \     non-target"
    inputBinding:
      position: 101
      prefix: --minimumlength
  - id: onlyvarybycodon
    type:
      - 'null'
      - boolean
    doc: "designate ASVs that fall within other length\n                        thresholds
      but do not vary by a multiple of 3 bases\n                        from the expected
      length as non-target"
    inputBinding:
      position: 101
      prefix: --onlyvarybycodon
  - id: otu_fasta
    type:
      - 'null'
      - File
    doc: path to a fasta file containing OTU centroid sequences
    inputBinding:
      position: 101
      prefix: --otu_fasta
  - id: otu_table
    type:
      - 'null'
      - File
    doc: "path to a table (CSV/TSV) containing OTU counts per\n                  \
      \      library"
    inputBinding:
      position: 101
      prefix: --otu_table
  - id: output
    type: string
    doc: "the base directory/file name path to which\n                        intermediate
      and final output data should be written,\n                        file extensions
      will be added as necessary"
    inputBinding:
      position: 101
      prefix: --output
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: "force overwriting of intermediate and/or final\n                       \
      \ output(s)"
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: percentvariation
    type:
      - 'null'
      - float
    doc: "the percentage variation from the expected length\n                    \
      \    outside which ASVs should be designated as non-target"
    inputBinding:
      position: 101
      prefix: --percentvariation
  - id: readingframe
    type:
      - 'null'
      - int
    doc: coding frame of sequences, if known
    inputBinding:
      position: 101
      prefix: --readingframe
  - id: readmap
    type:
      - 'null'
      - File
    doc: "path to a comma- or tab- separated tabular text file\n                 \
      \       containing read counts for ASVs by library"
    inputBinding:
      position: 101
      prefix: --readmap
  - id: realign
    type:
      - 'null'
      - boolean
    doc: force (re)alignment of the input ASVs
    inputBinding:
      position: 101
      prefix: --realign
  - id: references
    type:
      - 'null'
      - File
    doc: path to a fasta of known correct reference sequences
    inputBinding:
      position: 101
      prefix: --references
  - id: refmatchlength
    type:
      - 'null'
      - int
    doc: "the minimum alignment length to consider a match when\n                \
      \        comparing ASVs against reference sequences (default is\n          \
      \              80% of [calculated value of] -n/--minimumlength)"
    inputBinding:
      position: 101
      prefix: --refmatchlength
  - id: scoremetric
    type:
      - 'null'
      - string
    doc: "which of the three calculated scoring metrics\n                        ('accuracy',
      'precision' or 'recall') to use for\n                        selecting the top
      scoring set(s) (default accuracy)"
    inputBinding:
      position: 101
      prefix: --scoremetric
  - id: specification
    type: File
    doc: "path to a text file detailing the read count binning\n                 \
      \       strategy and thresholds. An example can be found in\n              \
      \          the github"
    inputBinding:
      position: 101
      prefix: --specification
  - id: table
    type:
      - 'null'
      - File
    doc: "the number referring to the translation table to use\n                 \
      \       for translation filtering"
    inputBinding:
      position: 101
      prefix: --table
  - id: taxgroups
    type:
      - 'null'
      - File
    doc: "path to a two-column csv file specifying the taxon for\n               \
      \         each ASV"
    inputBinding:
      position: 101
      prefix: --taxgroups
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use (default 1)
    inputBinding:
      position: 101
      prefix: --threads
  - id: tree
    type:
      - 'null'
      - File
    doc: path to an ultrametric tree of the ASVs
    inputBinding:
      position: 101
      prefix: --tree
  - id: uc
    type:
      - 'null'
      - File
    doc: "path to a .uc file (vsearch output) mapping ASVs to\n                  \
      \      OTUs"
    inputBinding:
      position: 101
      prefix: --uc
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metamate:0.5.2--pyr44h7e72e81_0
stdout: metamate_find.out
