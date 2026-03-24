# Annual percentage Change for population in Germany (1950 - 2025) CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://workflowhub.eu/workflows/1382
- **Package**: https://workflowhub.eu/workflows/1382
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/1382/ro_crate?version=1
- **Conda**: N/A
- **Total Downloads**: 335
- **Last updated**: 2025-05-28
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: MIT
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `workflows/dfaa142960dd8df6.gxwf.yml` (Main Workflow)
- **Project**: Galaxy Climate
- **Views**: 2567
- **Creators**: Anne Fouilloux

## Description

# Annual percentage Change for population in Germany (1950 - 2025)

This workflow run was executed on Galaxy (Workflow Rerun Information)

**Workflow:** Climate Stripes

**Execution Status:** scheduled

**Executed:** 2025-05-27 14:14:07.240149


## Workflow Inputs

### Formal Input Definitions

- **Germany-Population-Annual--Change-2025-05-27-15-17.csv** (File)

- **Column name to use for plotting** (Text)

- **Plot Title** (Text)

- **nxsplit** (Integer)
  - Description: Number of values per intervals

- **xname (column name for the x-axis)** (Text)
  - Description: The column name to use for the x-axis.

- **Date/time format for the x-axis column** (Text)
  - Description: Date/time format to use when reading the column to be used for the x-axis.

- **dates format for xlabels** (Text)
  - Description: Format for plotting dates on the x-axis

- **Matplotlib colormap** (Text)
  - Description: Parameter 'colormap': valid options: winter,PRGn,hsv,gist_ncar,RdYlGn,summer,BrBG,Pastel1,autumn,PuBuGn,seismic,YlOrRd,Purples,Wistia,YlOrBr,tab10,tab20c,gist_heat,bone,gist_yarg,ocean,flag,RdGy,gist_earth,coolwarm,spring,PuBu,cool,gist_stern,gray,Reds,Greens,Accent,BuGn,RdGy_r,Set3,Pastel2,pink,OrRd,gist_rainbow,Blues,binary,gist_gray,PuOr,Set2,rainbow,copper,RdBu_r,Oranges,Set1,afmhot,BuPu,gnuplot2,brg,terrain,YlGnBu,tab20,Greys,bwr,RdPu,PuRd,tab20b,PiYG,hot,gnuplot,YlGn,Dark2,prism,Spectral,Paired,RdPu_r,RdBu,RdYlBu,GnBu,cubehelix,CMRmap,jet,nipy_spectral) Using default: 'RdBu_r'.

### Actual Input Files Used

- **Germany-Population-Annual--Change-2025-05-27-15-17.csv**
  - Format: `text/plain`
  - Path: `datasets/Germany-Population-Annual--Change-2025-05-27-15-17.csv_31e7840b5aedca43e53def1f4fdf0064.csv`


## Workflow Parameters

- **input:**
  - __class__: `NoReplacement`

- **adv:**
  - colormap: `{'__class__': 'ConnectedValue'}`
  - format_date: `{'__class__': 'ConnectedValue'}`
  - format_plot: `{'__class__': 'ConnectedValue'}`
  - nxsplit: `{'__class__': 'ConnectedValue'}`
  - xname: `{'__class__': 'ConnectedValue'}`

- **ifilename:**
  - __class__: `ConnectedValue`

- **title:**
  - __class__: `ConnectedValue`

- **variable:**
  - __class__: `ConnectedValue`


## Workflow Outputs

### Formal Output Definitions

- **stripes.png** (File)

### Actual Output Files Generated

- **stripes.png**
  - Format: `application/octet-stream`
  - Path: `datasets/stripes.png_31e7840b5aedca437fdd404c00a60dc0.png`


## Rerun Template

To rerun this workflow:

1. **Workflow:** Climate Stripes

2. **Required inputs:**
   - Germany-Population-Annual--Change-2025-05-27-15-17.csv (type: `File`)
   - Column name to use for plotting (type: `Text`)
   - Plot Title (type: `Text`)
   - nxsplit (type: `Integer`)
   - xname (column name for the x-axis) (type: `Text`)
   - Date/time format for the x-axis column (type: `Text`)
   - dates format for xlabels (type: `Text`)
   - Matplotlib colormap (type: `Text`)

3. **Parameters to set:**
   - input:
     - __class__: `NoReplacement`
   - adv:
     - colormap: `{'__class__': 'ConnectedValue'}`
     - format_date: `{'__class__': 'ConnectedValue'}`
     - format_plot: `{'__class__': 'ConnectedValue'}`
     - nxsplit: `{'__class__': 'ConnectedValue'}`
     - xname: `{'__class__': 'ConnectedValue'}`
   - ifilename:
     - __class__: `ConnectedValue`
   - title:
     - __class__: `ConnectedValue`
   - variable:
     - __class__: `ConnectedValue`

4. **Expected outputs:**
   - stripes.png (type: `File`)
