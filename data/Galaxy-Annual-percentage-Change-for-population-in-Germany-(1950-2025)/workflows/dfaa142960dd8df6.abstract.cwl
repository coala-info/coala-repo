class: Workflow
label: Climate Stripes
cwlVersion: v1.2
inputs:
  files.tabular:
    format:
    - tabular
    doc: An input file with a header line and at least one column used to create the
      stripes.
    id: files.tabular
    type: File
  Column name to use for plotting:
    id: Column name to use for plotting
    type: string
  Plot Title:
    default: My stripes
    id: Plot Title
    type: string?
  nxsplit:
    doc: Number of values per intervals
    id: nxsplit
    type: int?
  xname (column name for the x-axis):
    doc: The column name to use for the x-axis.
    id: xname (column name for the x-axis)
    type: string?
  Date/time format for the x-axis column:
    doc: Date/time format to use when reading the column to be used for the x-axis.
    id: Date/time format for the x-axis column
    type: string?
  dates format for xlabels:
    doc: Format for plotting dates on the x-axis
    id: dates format for xlabels
    type: string?
  Matplotlib colormap:
    default: RdBu_r
    doc: 'Parameter ''colormap'': valid options: winter,PRGn,hsv,gist_ncar,RdYlGn,summer,BrBG,Pastel1,autumn,PuBuGn,seismic,YlOrRd,Purples,Wistia,YlOrBr,tab10,tab20c,gist_heat,bone,gist_yarg,ocean,flag,RdGy,gist_earth,coolwarm,spring,PuBu,cool,gist_stern,gray,Reds,Greens,Accent,BuGn,RdGy_r,Set3,Pastel2,pink,OrRd,gist_rainbow,Blues,binary,gist_gray,PuOr,Set2,rainbow,copper,RdBu_r,Oranges,Set1,afmhot,BuPu,gnuplot2,brg,terrain,YlGnBu,tab20,Greys,bwr,RdPu,PuRd,tab20b,PiYG,hot,gnuplot,YlGn,Dark2,prism,Spectral,Paired,RdPu_r,RdBu,RdYlBu,GnBu,cubehelix,CMRmap,jet,nipy_spectral)
      Using default: ''RdBu_r''.'
    id: Matplotlib colormap
    type: string
outputs:
  _anonymous_output_1:
    outputSource: Column name to use for plotting
    type: File
  _anonymous_output_2:
    outputSource: Plot Title
    type: File
  _anonymous_output_3:
    outputSource: nxsplit
    type: File
  _anonymous_output_4:
    outputSource: xname (column name for the x-axis)
    type: File
  _anonymous_output_5:
    outputSource: Date/time format for the x-axis column
    type: File
  _anonymous_output_6:
    outputSource: dates format for xlabels
    type: File
  _anonymous_output_7:
    outputSource: Matplotlib colormap
    type: File
  stripes.png:
    outputSource: Generate stripes/ofilename
    type: File
steps:
  Generate stripes:
    doc: 'Generate stripe from tabular file with at least one column. User needs to
      specify the column name in the tool. '
    run:
      class: Operation
      doc: 'Generate stripe from tabular file with at least one column. User needs
        to specify the column name in the tool. '
      inputs: {}
      outputs: {}
    in:
      adv|colormap:
        source: Matplotlib colormap
      adv|format_plot:
        source: dates format for xlabels
      adv|format_date:
        source: Date/time format for the x-axis column
      adv|xname:
        source: xname (column name for the x-axis)
      variable:
        source: Column name to use for plotting
      ifilename:
        source: files.tabular
      adv|nxsplit:
        source: nxsplit
      title:
        source: Plot Title
    out:
    - ofilename
