# gait-gm CWL Generation Report

## gait-gm_sPLS.py

### Tool Description
sPLS

### Metadata
- **Docker Image**: quay.io/biocontainers/gait-gm:21.7.22--pyhdfd78af_0
- **Homepage**: https://github.com/secimTools/gait-gm
- **Package**: https://anaconda.org/channels/bioconda/packages/gait-gm/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gait-gm/overview
- **Total Downloads**: 5.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/secimTools/gait-gm
- **Stars**: N/A
### Original Help Text
```text
usage: sPLS.py [-h] -g GENEDATASET -gid GENEID [-ga GENEANNO] [-gn GENENAME]
               -k KEEPX -t THRES -go GENEOPTION [-gl GENELIST]
               [-gkp GENEKEGGPATH] [-gka GENEKEGGANNO] [-gkn GENEKEGGNAME]
               [-p2g PATH2GENES] [-p2n PATH2NAMES] [-cu CUTOFF] [-f FACSEL] -m
               METDATASET -mid METID [-ma METANNO] [-mn METNAME] -mo METOPTION
               [-mka METKEGGANNO] [-mkp METKEGGPATH] [-d DESIGN]
               [-c {pearson,kendall,spearman}] [-sl SIGMALOW] [-sh SIGMAHIGH]
               [-sn SIGMANUM] [-pal PALETTE] [-col COLOR] -f1 FIGURE1 -o1
               SPLSOUT [-f2 FIGURE2] [-o2 MMCOUT] [-o3 PANAOUT]

sPLS

optional arguments:
  -h, --help            show this help message and exit

  Gene Expression

  -g GENEDATASET, --geneDataset GENEDATASET
                        Gene Expression dataset.
  -gid GENEID, --geneId GENEID
                        Gene Unique ID column name.
  -ga GENEANNO, --geneAnno GENEANNO
                        Gene Expression Annotation File (Only if user want
                        gene names in output).
  -gn GENENAME, --geneName GENENAME
                        Gene Names column name in geneAnno File (Only if user
                        want gene names in output).
  -k KEEPX, -keepX KEEPX
                        Number of genes to keep in each component.
  -t THRES, -thres THRES
                        Threshold to cut the sPLS output file.
  -go GENEOPTION, --geneOption GENEOPTION
                        One of: all, geneList, path, pana.
  -gl GENELIST, --geneList GENELIST
                        Relevant genes to make a sublist (Only required in
                        geneList option).
  -gkp GENEKEGGPATH, --geneKeggPath GENEKEGGPATH
                        Gene Expression Add KEGG Pathway Info File (Only
                        required in path option).
  -gka GENEKEGGANNO, --geneKeggAnno GENEKEGGANNO
                        Gene Expression Add KEGG Annotation Info File (Only
                        required in pana option).
  -gkn GENEKEGGNAME, --geneKeggName GENEKEGGNAME
                        Name of the column in geneKeggAnno that has Gene
                        Symbols (Only required in pana option).
  -p2g PATH2GENES, --path2genes PATH2GENES
                        Pathway2Genes File, from Add KEGG Pathway Info Tool
                        (Only required in pana option).
  -p2n PATH2NAMES, --path2names PATH2NAMES
                        PathId2PathNames File, from Add KEGG Pathway Info Tool
                        (Only required in pana option and if desired).
  -cu CUTOFF, --cutoff CUTOFF
                        Variability cut-off value Default: 0.2 (Only required
                        in pana option).
  -f FACSEL, --facSel FACSEL
                        criterion to select components. One of 'accum',
                        'single', 'abs.val' or 'rel.abs' Default: 'single'.
                        (Only required in pana option).

  Metabolites

  -m METDATASET, --metDataset METDATASET
                        Metabolomic Datset.
  -mid METID, --metId METID
                        Metabolite Unique ID column name.
  -ma METANNO, --metAnno METANNO
                        Metabolomics Annotation File (Only if user want
                        metabolite names in output).
  -mn METNAME, --metName METNAME
                        Metabolite Names column name (Only if user want
                        metabolite names in output, or in metOption=generic or
                        both).
  -mo METOPTION, --metOption METOPTION
                        One of generic, mmc or both.
  -mka METKEGGANNO, --metKeggAnno METKEGGANNO
                        Metabolomic Add KEGG Annotation Info File. (Only
                        required if metOption != mmc).
  -mkp METKEGGPATH, --metKeggPath METKEGGPATH
                        Metabolomic Add KEGG Pathway Info File (Only if
                        geneOption = path).
  -d DESIGN, --design DESIGN
                        Design file (Only required in mmc or both option).

  MMC

  -c {pearson,kendall,spearman}, --correlation {pearson,kendall,spearman}
                        Compute correlation coefficients using either
                        'pearson' (standard correlation coefficient),
                        'kendall' (Kendall Tau correlation coefficient), or
                        'spearman' (Spearman rank correlation).
  -sl SIGMALOW, --sigmaLow SIGMALOW
                        Low value of sigma (Default: 0.05).
  -sh SIGMAHIGH, --sigmaHigh SIGMAHIGH
                        High value of sigma (Default: 0.50).
  -sn SIGMANUM, --sigmaNum SIGMANUM
                        Number of values of sigma to search (Default: 451).

Plot options:
  -pal PALETTE, --palette PALETTE
                        Name of the palette to use.
  -col COLOR, --color COLOR
                        Name of a valid color scheme on the selected palette

  Output

  -f1 FIGURE1, --figure1 FIGURE1
                        sPLS heatmaps
  -o1 SPLSOUT, --splsOut SPLSOUT
                        Output Table.
  -f2 FIGURE2, --figure2 FIGURE2
                        MMC Heatmaps (Only if MMC Option)
  -o2 MMCOUT, --mmcOut MMCOUT
                        MMC Output TSV name (Only if MMC Option)
  -o3 PANAOUT, --panaOut PANAOUT
                        PANA Output TSV name (Only if PANA Option)
```

