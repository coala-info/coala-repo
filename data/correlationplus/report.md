# correlationplus CWL Generation Report

## correlationplus_calculate

### Tool Description
A Python package to calculate, visualize and analyze protein correlation maps.

### Metadata
- **Docker Image**: quay.io/biocontainers/correlationplus:0.2.1--pyh5e36f6f_0
- **Homepage**: https://github.com/tekpinar/correlationplus
- **Package**: https://anaconda.org/channels/bioconda/packages/correlationplus/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/correlationplus/overview
- **Total Downloads**: 11.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/tekpinar/correlationplus
- **Stars**: N/A
### Original Help Text
```text
|------------------------------Correlation Plus------------------------------|
|                                                                            |
|        A Python package to calculate, visualize and analyze protein        |
|                           correlation maps.                                |
|               Copyright (C) Mustafa Tekpinar, 2017-2018                    |
|                   Copyright (C) CNRS-UMR3528, 2019                         |
|             Copyright (C) Institut Pasteur Paris, 2020-2021                |
|                         Author: Mustafa Tekpinar                           |
|                       Email: tekpinar@buffalo.edu                          |
|                           Licence: GNU LGPL V3                             |
|     Please cite us: https://pubs.acs.org/doi/10.1021/acs.jcim.1c00742      |
|                              Version: 0.2.1                                |
|--------------------------------------------------------------------------- |



@> ERROR: PDB file is mandatory!


Example usage: 

If you would like to calculate ANM-based normalized dynamical cross-correlations
 from a pdb file:
                                            
correlationplus calculate -p 4z90.pdb

If you would like to calculate dynamical cross-correlations from a reference pdb
 file and a trajectory file (in dcd, xtc or trr formats):
                                                                                     
correlationplus calculate -p 4z90.pdb -f 4z90.xtc

If you would like to calculate ANM-based normalized linear mutual information maps
 from a pdb file:                                   

correlationplus calculate -p 4z90.pdb -t nlmi

If you would like to calculate a normalized linear mutual information map from a 
reference pdb file and a trajectory file (in dcd, xtc or trr formats):
 
correlationplus calculate -p 4z90.pdb -f 4z90.xtc -t nlmi

Arguments:                                                                                         
           -p: PDB file of the protein. (Mandatory)
           -f: A trajectory file in dcd, xtc or trr format. (Optional)
           -b: Beginning frame in the trajectory to calculate the 
               correlation map (Valid only if you are using a trajectory).
           -e: Ending frame in the trajectory to calculate the 
               correlation map (Valid only if you are using a trajectory).
           -m: Elastic network model to calculate the correlations. 
               It can be ANM or GNM. Default is ANM. (Optional)
               (Valid only when you don't have a trajectory file.)
           -n: Number of non-zero modes, when ANM or GNM is used. 
               Default is 100. (Optional)
               (It can not exceed 3N-6 in ANM and N-1 in GNM, where N 
               is number of Calpha atoms.)
           -c: Cutoff radius in Angstrom for ANM or GNM. (Optional) 
               Default is 15 for ANM and 10 for GNM. 
           -t: Type of the correlation matrix. It can be dcc, ndcc, 
               tldcc (time-lagged dynamical cross-correlations),
               tlndcc (time-lagged normalized dynamical cross-correlations),
               lmi or nlmi (normalized lmi).
               Default value is ndcc. (Optional)
           -o: This will be your output data file.
               Default is DCC.dat. (Optional)
```


## correlationplus_visualize

### Tool Description
A Python package to calculate, visualize and analyze protein correlation maps.

### Metadata
- **Docker Image**: quay.io/biocontainers/correlationplus:0.2.1--pyh5e36f6f_0
- **Homepage**: https://github.com/tekpinar/correlationplus
- **Package**: https://anaconda.org/channels/bioconda/packages/correlationplus/overview
- **Validation**: PASS

### Original Help Text
```text
|------------------------------Correlation Plus------------------------------|
|                                                                            |
|        A Python package to calculate, visualize and analyze protein        |
|                           correlation maps.                                |
|               Copyright (C) Mustafa Tekpinar, 2017-2018                    |
|                   Copyright (C) CNRS-UMR3528, 2019                         |
|             Copyright (C) Institut Pasteur Paris, 2020-2021                |
|                         Author: Mustafa Tekpinar                           |
|                       Email: tekpinar@buffalo.edu                          |
|                           Licence: GNU LGPL V3                             |
|     Please cite us: https://pubs.acs.org/doi/10.1021/acs.jcim.1c00742      |
|                              Version: 0.2.1                                |
|--------------------------------------------------------------------------- |



Example usage:
correlationplus visualize -i ndcc-6lu7-anm.dat -p 6lu7_dimer_with_N3_protein_sim1_ca.pdb

Arguments: -i: A file containing correlations in matrix format. (Mandatory)

           -p: PDB file of the protein. (Mandatory)
           
           -t: Type of the matrix. It can be dcc, ndcc, lmi, nlmi (normalized lmi), 
               absndcc (absolute values of ndcc) or eg (elasticity graph).
               In addition, coeviz and evcouplings are also some options to analyze sequence
               correlations. 
               If your data is any other coupling data in full matrix format, you can select 
               your data type as 'generic'. 
               Default value is ndcc (Optional)

           -v: Minimal correlation value. Any value equal or greater than this 
               will be projected onto protein structure. Default is minimal value of the map. (Optional)
            
           -x: Maximal correlation value. Any value equal or lower than this 
               will be projected onto protein structure. Default is maximal value of the map. (Optional)

           -d: If the distance between two C_alpha atoms is bigger 
               than the specified distance, it will be projected onto protein structure. 
               Default is 0.0 Angstroms. (Optional)

           -D: If the distance between two C_alpha atoms is smaller 
               than the specified distance, it will be projected onto protein structure. 
               Default is 9999.9 Angstroms. (Optional)

           -r: Cylinder radius scaling coefficient to multiply with the correlation quantity.
               It can be used to improve tcl and pml outputs to view the interaction 
               strengths properly. Recommended values are between 0.0 and 2.0. (Optional)

           -o: This will be your output file. Output figures are in png format. (Optional)
```


## correlationplus_analyze

### Tool Description
A Python package to calculate, visualize and analyze protein correlation maps.

### Metadata
- **Docker Image**: quay.io/biocontainers/correlationplus:0.2.1--pyh5e36f6f_0
- **Homepage**: https://github.com/tekpinar/correlationplus
- **Package**: https://anaconda.org/channels/bioconda/packages/correlationplus/overview
- **Validation**: PASS

### Original Help Text
```text
|------------------------------Correlation Plus------------------------------|
|                                                                            |
|        A Python package to calculate, visualize and analyze protein        |
|                           correlation maps.                                |
|               Copyright (C) Mustafa Tekpinar, 2017-2018                    |
|                   Copyright (C) CNRS-UMR3528, 2019                         |
|             Copyright (C) Institut Pasteur Paris, 2020-2021                |
|                         Author: Mustafa Tekpinar                           |
|                       Email: tekpinar@buffalo.edu                          |
|                           Licence: GNU LGPL V3                             |
|     Please cite us: https://pubs.acs.org/doi/10.1021/acs.jcim.1c00742      |
|                              Version: 0.2.1                                |
|--------------------------------------------------------------------------- |


@> ERROR: A PDB file and a correlation matrix are mandatory!

Example usage:
correlationplus analyze -i ndcc-6lu7-anm.dat -p 6lu7_dimer_with_N3_protein_sim1_ca.pdb

Arguments: -i: A file containing correlations in matrix format. (Mandatory)

           -p: PDB file of the protein. (Mandatory)
           
           -t: Type of the matrix. It can be dcc, ndcc, lmi, nlmi (normalized lmi), 
               absndcc (absolute values of ndcc) or eg (elasticity graph).
               In addition, coeviz and evcouplings are also some options to analyze sequence
               correlations. 
               If your data any other coupling data in full matrix format, you can select generic
               as your data type. 
               Default value is ndcc (Optional)

           -o: This will be your output file. Output figures are in png format. 
               (Optional)

           -c: Type of the centrality that you want to calculate. Default is 'all'.
               (Optional). If you want only a particular centrality, you can select 
               one of the following options: 
                    * degree
                    * betweenness
                    * closeness
                    * current_flow_betweenness
                    * current_flow_closeness
                    * eigenvector
                    * community
               
           -v: Value filter. The values lower than this value in the map will be 
               considered as zero. Default is 0.3. (Optional)

           -d: Distance filter. The residues with distances higher than this value 
               will be considered as zero. Default is 7.0 Angstrom. (Optional)
```


## correlationplus_paths

### Tool Description
A Python package to calculate, visualize and analyze protein correlation maps.

### Metadata
- **Docker Image**: quay.io/biocontainers/correlationplus:0.2.1--pyh5e36f6f_0
- **Homepage**: https://github.com/tekpinar/correlationplus
- **Package**: https://anaconda.org/channels/bioconda/packages/correlationplus/overview
- **Validation**: PASS

### Original Help Text
```text
|------------------------------Correlation Plus------------------------------|
|                                                                            |
|        A Python package to calculate, visualize and analyze protein        |
|                           correlation maps.                                |
|               Copyright (C) Mustafa Tekpinar, 2017-2018                    |
|                   Copyright (C) CNRS-UMR3528, 2019                         |
|             Copyright (C) Institut Pasteur Paris, 2020-2021                |
|                         Author: Mustafa Tekpinar                           |
|                       Email: tekpinar@buffalo.edu                          |
|                           Licence: GNU LGPL V3                             |
|     Please cite us: https://pubs.acs.org/doi/10.1021/acs.jcim.1c00742      |
|                              Version: 0.2.1                                |
|--------------------------------------------------------------------------- |


@> ERROR: A PDB file and a correlation matrix are mandatory!

Example usage:
correlationplus paths -i ndcc-6lu7-anm.dat -p 6lu7_dimer_with_N3_protein_sim1_ca.pdb -b A41 -e B41

Arguments: -i: A file containing correlations in matrix format. (Mandatory)

           -p: PDB file of the protein. (Mandatory)
           
           -t: Type of the matrix. It can be dcc, ndcc, lmi, nlmi (normalized lmi), 
               absndcc (absolute values of ndcc) or eg (elasticity graph).
               In addition, coeviz and evcouplings are also some options to analyze sequence
               correlations. 
               If your data is any other coupling data in full matrix format, you can select 'generic'
               as your data type. 
               Default value is ndcc (Optional)

           -o: This will be your output file. Output figures are in png format. 
               (Optional)

           -v: Value filter. The values lower than this value in the map will be 
               considered as zero. Default is 0.3. (Optional)

           -d: Distance filter. The residues with distances higher than this value 
               will be considered as zero. Default is 7.0 Angstrom. (Optional)
                              
           -b: ChainID and residue ID of the beginning (source)  residue (Ex: A41). (Mandatory)

           -e: ChainID and residue ID of the end (sink/target) residue (Ex: B41). (Mandatory)

           -n: Number of shortest paths to write to tcl or pml files. Default is 1. (Optional)
```


## correlationplus_diffmap

### Tool Description
A Python package to calculate, visualize and analyze protein correlation maps.

### Metadata
- **Docker Image**: quay.io/biocontainers/correlationplus:0.2.1--pyh5e36f6f_0
- **Homepage**: https://github.com/tekpinar/correlationplus
- **Package**: https://anaconda.org/channels/bioconda/packages/correlationplus/overview
- **Validation**: PASS

### Original Help Text
```text
|------------------------------Correlation Plus------------------------------|
|                                                                            |
|        A Python package to calculate, visualize and analyze protein        |
|                           correlation maps.                                |
|               Copyright (C) Mustafa Tekpinar, 2017-2018                    |
|                   Copyright (C) CNRS-UMR3528, 2019                         |
|             Copyright (C) Institut Pasteur Paris, 2020-2021                |
|                         Author: Mustafa Tekpinar                           |
|                       Email: tekpinar@buffalo.edu                          |
|                           Licence: GNU LGPL V3                             |
|     Please cite us: https://pubs.acs.org/doi/10.1021/acs.jcim.1c00742      |
|                              Version: 0.2.1                                |
|--------------------------------------------------------------------------- |



Example usage:

correlationplus -h

CorrelationPlus contains five apps:
 - calculate
 - visualize
 - analyze
 - paths
 - diffMap

You can get more information about each individual app as follows:

correlationplus analyze -h
```

