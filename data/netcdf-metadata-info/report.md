# netcdf-metadata-info CWL Generation Report

## netcdf-metadata-info

### Tool Description
Provides information on Netcdf metadata, including details about variables and dimensions, and summarizes it into an output tabular file.

### Metadata
- **Docker Image**: quay.io/biocontainers/netcdf-metadata-info:1.1.6--h7b50bb2_7
- **Homepage**: https://github.com/Alanamosse/Netcdf-Metadata-Info/
- **Package**: https://anaconda.org/channels/bioconda/packages/netcdf-metadata-info/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/netcdf-metadata-info/overview
- **Total Downloads**: 7.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Alanamosse/Netcdf-Metadata-Info
- **Stars**: N/A
### Original Help Text
```text
**** Information on Netcdf metadata ****

- The netcdf-metadata-info tool needs a netcdf input file. It will give informations about every variable and dimension and summarize it into an output tabular file named : variable.tabular.

- The file has the general structure : 

  ******************************************************************************************
  * Variable1    Var1_Number_of_Dim    Dim1    Dim1_size    ...    DimN    DimN_size       *
  * VariableX    VarX_Number_of_Dim    DimX1   DimX1_size   ...    DimXN   DimXN_size      *
  * ...                                                                                    *
  ******************************************************************************************


- This tool is necessary to execute the Galaxy tool Netcdf read : URL.

- Code is written in C and use the unidata Netcdf source functions : https://www.unidata.ucar.edu/software/netcdf/
- For more complete and human readable informations you can use the ncdump command line from Netcdf package.
```

