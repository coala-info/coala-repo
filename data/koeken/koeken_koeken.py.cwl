cwlVersion: v1.2
class: CommandLineTool
baseCommand: koeken.py
label: koeken_koeken.py
doc: "Performs Linear Discriminant Analysis (LEfSe) on A Longitudinal Dataset.\n\n\
  Tool homepage: https://github.com/twbattaglia/koeken"
inputs:
  - id: clade
    type:
      - 'null'
      - boolean
    doc: Plot Lefse Cladogram for each output time point. Outputs are placed in 
      a new folder created in the lefse results location.
    inputBinding:
      position: 101
      prefix: --clade
  - id: classid
    type: File
    doc: Location of the OTU Table for main analysis. (Must be .biom format)
    inputBinding:
      position: 101
      prefix: --class
  - id: compare
    type:
      - 'null'
      - type: array
        items: string
    doc: Which groups should be kept to be compared against one another.
    inputBinding:
      position: 101
      prefix: --compare
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable debugging
    inputBinding:
      position: 101
      prefix: --debug
  - id: dpi
    type:
      - 'null'
      - int
    doc: Set DPI resolution for cladogram
    inputBinding:
      position: 101
      prefix: --dpi
  - id: image
    type:
      - 'null'
      - string
    doc: Set the file type for the image create when using cladogram setting
    inputBinding:
      position: 101
      prefix: --image
  - id: input_biom
    type: File
    doc: Location of the OTU Table for main analysis. (Must be .biom format)
    inputBinding:
      position: 101
      prefix: --input
  - id: lda_cutoff
    type:
      - 'null'
      - float
    doc: Change the cutoff for logarithmic LDA score
    inputBinding:
      position: 101
      prefix: --effect
  - id: level
    type:
      - 'null'
      - int
    doc: Level for which to use for summarize_taxa.py.
    inputBinding:
      position: 101
      prefix: --level
  - id: map_fp
    type: File
    doc: Location of the mapping file associated with OTU Table.
    inputBinding:
      position: 101
      prefix: --map
  - id: p_cutoff
    type:
      - 'null'
      - float
    doc: Change alpha value for the Anova test
    inputBinding:
      position: 101
      prefix: --pval
  - id: picrust
    type:
      - 'null'
      - boolean
    doc: Run analysis with PICRUSt biom file. Must use the cateogirze by 
      function level 3. Next updates will reflect the difference levels.
    inputBinding:
      position: 101
      prefix: --picrust
  - id: split
    type: string
    doc: The name of the timepoint variable in you mapping file. This variable 
      will be used to split the table for each value in this variable.
    inputBinding:
      position: 101
      prefix: --split
  - id: strict
    type:
      - 'null'
      - int
    doc: Change the strictness of the comparisons. Can be changed to less strict
      (1).
    inputBinding:
      position: 101
      prefix: --strict
  - id: subclassid
    type:
      - 'null'
      - Directory
    doc: Directory to place all the files.
    inputBinding:
      position: 101
      prefix: --subclass
  - id: subjectid
    type:
      - 'null'
      - string
    doc: Only change if your Sample-ID column names differs.
    inputBinding:
      position: 101
      prefix: --subject
outputs:
  - id: outputdir
    type: Directory
    doc: Location of the folder to place all resulting files. If folder does not
      exist, the program will create it.
    outputBinding:
      glob: $(inputs.outputdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/koeken:0.2.6--py27h24bf2e0_1
