# mtm-align CWL Generation Report

## mtm-align

### Tool Description
An algorithm for multiple protein structure alignment (MSTA)

### Metadata
- **Docker Image**: quay.io/biocontainers/mtm-align:20220104--h9948957_3
- **Homepage**: http://yanglab.nankai.edu.cn/mTM-align/help/
- **Package**: https://anaconda.org/channels/bioconda/packages/mtm-align/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mtm-align/overview
- **Total Downloads**: 2.0K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
***************************************************************
 *                 mTM-align (Version 20220104)                *
 * An algorithm for multiple protein structure alignment (MSTA)*
 * Reference: Dong, et al, Bioinformatics, 34: 1719-1725 (2018)*
 * Please email your comments to: yangjy@nankai.edu.cn         *
 ***************************************************************

 Usage: mtm-align -i <input_list> [Options]
 Options:
   -i input_list   The input_list is an input file, listing the file names of the structures to be aligned.
                   Each line represents the file name for one structure.
                   Please note that each input structure should be a single-chain structure.

   -o filename     The name of the file to save the superimposed structures. The default is 'result.pdb'
                   When the number of input structures is >61, the superimposed structures will be separated by 'MODEL'
                   Otherwise, the structures are speparated using the chain IDs: A,B,C,...


   -outdir         The output directory to save the results (the default is './mTM_result')


  -v               Print the version of mTM-align
  -h               Print this help information
 Example usage:
 mtm-align -i input_list
 mtm-align -i input_list -o result.pdb
 mtm-align -i input_list -outdir mTM_result
```

