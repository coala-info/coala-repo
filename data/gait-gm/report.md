# gait-gm CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| gait-gm_add_kegg_anno_info.py | Failed | tool bug: the tool reads the KEGG REST list format of the past; the current format has extra columns, so no gene matches (98 of 98 unmatched) and metabolite ids and scores differ from the Galaxy expected file |
| gait-gm_add_kegg_pathway_info.py | Failed | tool bug: the current KEGG pathway name list has no 'path:' prefix, so pathway names are not joined (NA) and the metabolite table differs from the Galaxy expected file |
| gait-gm_add_pval_flags.py | PASS | output and flags files are identical to the Galaxy expected files |
| gait-gm_all_by_all_correlation.py | PASS | 300 genes of the Galaxy test data: all correlation coefficients equal the Galaxy expected table for the same pairs (p-value filtering differs with fewer tests); matrix and PDF written |
| gait-gm_ensembl2symbol.py | PASS | 100 rat genes of the Galaxy test data: symbols such as Lrp11, Pcmt1, Nup43 are correct; 86 of 101 equal the Galaxy expected file (the online gene database has changed since) |
| gait-gm_sPLS.py | PASS | Galaxy test data: the PANA table equals the Galaxy expected table (sorted) and the sPLS tables differ from the expected files in a few tied rows (Galaxy allows this); CWL fixed (output flags --splsOut and the like, dataset inputs as File) |
| gait-gm_split_wide_dataset.py | PASS | wide, design and annotation files are identical to the Galaxy expected files |

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

## gait-gm_add_kegg_anno_info.py

### Tool Description
kegg_anno: link gene and metabolite names to KEGG identifiers.

### Metadata
- **Docker Image**: quay.io/biocontainers/gait-gm:21.7.22--pyhdfd78af_0
- **Homepage**: https://github.com/secimTools/gait-gm
- **Package**: https://anaconda.org/channels/bioconda/packages/gait-gm/overview
- **Validation**: PASS

### Original Help Text
```text
[help] add_kegg_anno_info.py: ok via add_kegg_anno_info.py --help (--help=ok, -h=ok, -help=flag_rejected, (no args)=usage_only)
usage: add_kegg_anno_info.py [-h] -s SPECIES [-ga GENEANNOT] [-gid GENEUNIQID]
                             [-gn GENENAME] [-ma METANNOT] [-mid METUNIQID]
                             [-mn METNAME] [-go GENEOUT] [-mo METOUT]

kegg_anno

optional arguments:
  -h, --help            show this help message and exit

Tool Specific Inputs:
  -s SPECIES, --species SPECIES
                        Specie to download.
  -ga GENEANNOT, --geneAnnot GENEANNOT
                        Gene Annotation File.
  -gid GENEUNIQID, --geneUniqId GENEUNIQID
                        Name of the column with gene unique Ids.
  -gn GENENAME, --geneName GENENAME
                        Name of the column with genes names.
  -ma METANNOT, --metAnnot METANNOT
                        Metabolite Annotation File.
  -mid METUNIQID, --metUniqId METUNIQID
                        Name of the column with metabolite unique Ids.
  -mn METNAME, --metName METNAME
                        Name of the column with metabolite names.

  Output

  -go GENEOUT, --geneOut GENEOUT
                        Gene Output file name.
  -mo METOUT, --metOut METOUT
                        Metabolite Output file name.
```

## gait-gm_add_kegg_pathway_info.py

### Tool Description
Kegg Downloader: add KEGG pathway information to gene and metabolite KEGG annotation files.

### Metadata
- **Docker Image**: quay.io/biocontainers/gait-gm:21.7.22--pyhdfd78af_0
- **Homepage**: https://github.com/secimTools/gait-gm
- **Package**: https://anaconda.org/channels/bioconda/packages/gait-gm/overview
- **Validation**: PASS

### Original Help Text
```text
[help] add_kegg_pathway_info.py: ok via add_kegg_pathway_info.py --help (--help=ok, -h=ok, -help=ok, (no args)=ok)
usage: add_kegg_pathway_info.py [-h] -sp SPECIES [-gka GENEKEGGANNOT]
                                [-gid GENEUNIQID] [-gn GENENAME]
                                [-gkid GENEKEGGID] [-mka METKEGGANNOT]
                                [-mid METUNIQID] [-mn METNAME]
                                [-mkid METKEGGID] [-go GENEOUT] [-mo METOUT]
                                [-kg2p KGEN2PATHWAYS] [-km2p KMET2PATHWAYS] -p
                                PATHWAYS

Kegg Downloader

optional arguments:
  -h, --help            show this help message and exit

Tool Specific Inputs:
  -sp SPECIES, --species SPECIES
                        Species to download.
  -gka GENEKEGGANNOT, --geneKeggAnnot GENEKEGGANNOT
                        Gene KEGG Annotation File.
  -gid GENEUNIQID, --geneUniqId GENEUNIQID
                        Name of the column with gene unique Ids.
  -gn GENENAME, --geneName GENENAME
                        Name of the column with genes names.
  -gkid GENEKEGGID, --geneKeggId GENEKEGGID
                        Name of the column with gene KEGG Identifiers.
  -mka METKEGGANNOT, --metKeggAnnot METKEGGANNOT
                        Metabolite KEGG Annotation File.
  -mid METUNIQID, --metUniqId METUNIQID
                        Name of the column with metabolite unique Ids.
  -mn METNAME, --metName METNAME
                        Name of the column with metabolite names.
  -mkid METKEGGID, --metKeggId METKEGGID
                        Name of the column with Metabolite KEGG Identifiers.

  Output

  -go GENEOUT, --geneOut GENEOUT
                        Gene Output file name.
  -mo METOUT, --metOut METOUT
                        Metabolite Output file name.
  -kg2p KGEN2PATHWAYS, --kgen2pathways KGEN2PATHWAYS
                        Gene2Pathway file.
  -km2p KMET2PATHWAYS, --kmet2pathways KMET2PATHWAYS
                        Metabolite2Pathway file.
  -p PATHWAYS, --pathways PATHWAYS
                        PathwaysNames file.
```

## gait-gm_add_pval_flags.py

### Tool Description
Add Pval Flags: add flags for P-value thresholds to a differential expression analysis dataset.

### Metadata
- **Docker Image**: quay.io/biocontainers/gait-gm:21.7.22--pyhdfd78af_0
- **Homepage**: https://github.com/secimTools/gait-gm
- **Package**: https://anaconda.org/channels/bioconda/packages/gait-gm/overview
- **Validation**: PASS

### Original Help Text
```text
[help] add_pval_flags.py: ok via add_pval_flags.py --help (--help=ok, -h=ok, -help=flag_rejected, (no args)=usage_only)
usage: add_pval_flags.py [-h] -de DEADATASET -id UNIQID -p PVALUE -t
                         THRESHOLDS -o OUTPUT -fl FLAGS

Add Pval Flags

optional arguments:
  -h, --help            show this help message and exit

  Tool Input

  -de DEADATASET, --deaDataset DEADATASET
                        Differential Expression Analysis Datset.
  -id UNIQID, --uniqID UNIQID
                        Name of the column with unique identifiers.
  -p PVALUE, --pvalue PVALUE
                        Name of the column with P-values.
  -t THRESHOLDS, --thres THRESHOLDS
                        P-value thresholds.

  Output

  -o OUTPUT, --output OUTPUT
                        Output file name.
  -fl FLAGS, --flags FLAGS
                        Flags file name.
```

## gait-gm_all_by_all_correlation.py

### Tool Description
allByAllCorr: all-by-all correlation between a gene expression dataset and a metabolomic dataset.

### Metadata
- **Docker Image**: quay.io/biocontainers/gait-gm:21.7.22--pyhdfd78af_0
- **Homepage**: https://github.com/secimTools/gait-gm
- **Package**: https://anaconda.org/channels/bioconda/packages/gait-gm/overview
- **Validation**: PASS

### Original Help Text
```text
[help] all_by_all_correlation.py: ok via all_by_all_correlation.py --help (--help=ok, -h=ok, -help=flag_rejected, (no args)=usage_only)
usage: all_by_all_correlation.py [-h] -g GENEDATASET -gid GENEID
                                 [-ga GENEANNOT] [-gn GENENAME] -m METDATASET
                                 -mid METID [-ma METANNOT] [-mn METNAME] -me
                                 METH -t THRES -o OUTPUT -c CORMAT -f FIG

allByAllCorr

optional arguments:
  -h, --help            show this help message and exit

  Input

  -g GENEDATASET, --geneDataset GENEDATASET
                        Gene Expression dataset.
  -gid GENEID, --geneId GENEID
                        Gene Unique ID column name.
  -ga GENEANNOT, --geneAnnot GENEANNOT
                        Gene Expression Annotation Dataset.
  -gn GENENAME, --geneName GENENAME
                        Gene Expression Annotation Dataset column.
  -m METDATASET, --metDataset METDATASET
                        Metabolomic Datset.
  -mid METID, --metId METID
                        Metabolite Unique ID column name.
  -ma METANNOT, --metAnnot METANNOT
                        Metabolomic Annotation Dataset.
  -mn METNAME, --metName METNAME
                        Metabolomics Annotation Dataset column.
  -me METH, --meth METH
                        Correlation coefficient to be computed.
  -t THRES, --thres THRES
                        Pvalue threshold for the output.

  Output

  -o OUTPUT, --output OUTPUT
                        Output Table.
  -c CORMAT, --corMat CORMAT
                        Correlation Matrix.
  -f FIG, --fig FIG     Output figure name for results [pdf].
```

## gait-gm_ensembl2symbol.py

### Tool Description
kegg_anno: add gene symbols to a gene annotation file from ENSEMBL identifiers.

### Metadata
- **Docker Image**: quay.io/biocontainers/gait-gm:21.7.22--pyhdfd78af_0
- **Homepage**: https://github.com/secimTools/gait-gm
- **Package**: https://anaconda.org/channels/bioconda/packages/gait-gm/overview
- **Validation**: PASS

### Original Help Text
```text
[help] ensembl2symbol.py: ok via ensembl2symbol.py --help (--help=ok, -h=ok, -help=ok, (no args)=usage_only)
usage: ensembl2symbol.py [-h] -s SPECIES -ga GENEANNOT -id UNIQID -e ENSEMBLID
                         -o OUTPUT

kegg_anno

optional arguments:
  -h, --help            show this help message and exit

Tool Specific Inputs:
  -s SPECIES, --species SPECIES
                        Species to download. One of rat, human, mouse,
                        fruitfly, thale cress, yeast, E. coli, or nematode
  -ga GENEANNOT, --geneAnnot GENEANNOT
                        Gene Expression Annotation File.
  -id UNIQID, --uniqId UNIQID
                        Name of the column with gene Unique Ids.
  -e ENSEMBLID, --ensemblId ENSEMBLID
                        Name of the column with ENSEMBL IDs.

  Output

  -o OUTPUT, --output OUTPUT
                        Gene expression Annotation File with Gene Symbols.
```

## gait-gm_split_wide_dataset.py

### Tool Description
split_wide_dataset: split a wide dataset into wide, design and annotation files.

### Metadata
- **Docker Image**: quay.io/biocontainers/gait-gm:21.7.22--pyhdfd78af_0
- **Homepage**: https://github.com/secimTools/gait-gm
- **Package**: https://anaconda.org/channels/bioconda/packages/gait-gm/overview
- **Validation**: PASS

### Original Help Text
```text
[help] split_wide_dataset.py: ok via split_wide_dataset.py --help (--help=ok, -h=ok, -help=flag_rejected, (no args)=usage_only)
usage: split_wide_dataset.py [-h] -i INPUT [-id UNIQID] -s SAMPLES [-p PREFIX]
                             [-p2 PREFIX2] -w WIDE -d DESIGN -a ANNOT

split_wide_dataset

optional arguments:
  -h, --help            show this help message and exit

  Required Input

  -i INPUT, --input INPUT
                        Input dataset in wide format.
  -id UNIQID, --ID UNIQID
                        Name of the column with unique identifiers.
  -d DESIGN, --design DESIGN
                        Design file.

Tool Specific Inputs:
  -s SAMPLES, --samples SAMPLES
                        Select sample columns.
  -p PREFIX, --prefix PREFIX
                        Prefix to add to the new unique ID.
  -p2 PREFIX2, --prefix2 PREFIX2
                        Prefix to add to the old unique ID (only if the Unique
                        ID is numeric).

  Output

  -w WIDE, --wide WIDE  Wide dataset file.
  -a ANNOT, --annot ANNOT
                        Annotation file.
```

