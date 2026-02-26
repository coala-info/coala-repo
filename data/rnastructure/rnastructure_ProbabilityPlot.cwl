cwlVersion: v1.2
class: CommandLineTool
baseCommand: ProbabilityPlot
label: rnastructure_ProbabilityPlot
doc: "Generates plots from base pairing probability data.\n\nTool homepage: http://rna.urmc.rochester.edu/RNAstructure.html"
inputs:
  - id: input_file
    type: File
    doc: The name of the input file that holds base pairing probabilities. This 
      file may be one of the following file types. 1) Partition function save 
      file (binary file). 2) Matrix file (plain text). Note that in order to use
      a matrix file, the "--matrix" flag must be specified. 3) Dot plot file 
      (plain text). This file is in the standard format exported by all dot plot
      interfaces when the "text" option is used. Note that in order to use a dot
      plot file, the "--log10" flag must be specified.
    inputBinding:
      position: 1
  - id: description_config
    type:
      - 'null'
      - string
    doc: 'Configure the output of descriptions. Valid values are: (1) "" or "~none"
      -- Do not write a description (2) "~file" -- If the default description corresponds
      to a file or path, use only the base name of the path (i.e. no directory or
      file extension). (3) "~~", or "~default" -- Use the default description (this
      is the same as not specifying the flag) (4) "~list|DESC1|DESC2|DESC3" -- use
      this syntax when the output is expected to have more than one plot. It specifies
      a list of descriptions will be applied in the order given. The character immediately
      after "~list" will be used as the separator (i.e. it need not be the bar (|)
      character. (5) Any other value is assumed to be the literal description you
      want to have displayed in the plot legend.'
    inputBinding:
      position: 102
      prefix: --desc
  - id: log10
    type:
      - 'null'
      - boolean
    doc: Specifies that the input file format is a dot plot text file of log10 
      base pair probabilities. Giving this flag with one of the text options 
      would give a file identical to the input file.
    inputBinding:
      position: 102
      prefix: --log10
  - id: matrix
    type:
      - 'null'
      - boolean
    doc: Specifies that the input file format is a plain text matrix of base 
      pair probabilities.
    inputBinding:
      position: 102
      prefix: --matrix
  - id: max_value
    type:
      - 'null'
      - float
    doc: Specifies the maximum value that is viewable in the plot. Default is 
      the largest allowable point in a given data file. If the given value is 
      greater than the default, it is ignored.
    inputBinding:
      position: 102
      prefix: --maximum
  - id: min_value
    type:
      - 'null'
      - float
    doc: Specifies the minimum value that is viewable in the plot. Default is 
      the smallest allowable point in a given data file. If the given value is 
      less than the default, it is ignored.
    inputBinding:
      position: 102
      prefix: --minimum
  - id: num_colors
    type:
      - 'null'
      - int
    doc: Specifies the number of colors in the dot plot. Default is 5 colors. 
      Minimum is 3 colors. Maximum is 15 colors.
    default: 5
    inputBinding:
      position: 102
      prefix: --entries
  - id: svg
    type:
      - 'null'
      - boolean
    doc: Specify that the output file should be an SVG image file, rather than a
      Postscript image file.
    inputBinding:
      position: 102
      prefix: --svg
  - id: text_output
    type:
      - 'null'
      - boolean
    doc: Specifies that output should be a dot plot (text) file.
    inputBinding:
      position: 102
      prefix: --text
outputs:
  - id: output_file
    type: File
    doc: The name of a file to which output will be written. Depending on the 
      options selected, this may be one of the following file types. 1) A 
      Postscript image file. 2) An SVG image file. 3) A plain text file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnastructure:6.5--hde5307d_0
