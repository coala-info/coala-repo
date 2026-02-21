# Pre-compiled GO Gene Sets

#### Zuguang Gu (z.gu@dkfz.de)

#### 2023-09-27

The **BioMartGOGeneSets** contains pre-compiled GO gene sets for a huge number of organisms supported in [BioMart](https://www.ensembl.org/info/data/biomart/index.html). There are two types of data: 1. genes and 2 gene sets.

## Retrieve genes

To obtain the genes, use the function `getBioMartGenes()`. You need to provide a proper “dataset”, which can be found with the function `supportedOrganisms()` (A complete list can be also found from “[**BioMart Gene Ontology Gene Sets Collections**](supported_organisms.html))”. Here we use the dataset `"hsapiens_gene_ensembl"` as an example which is for human.

```
library(BioMartGOGeneSets)
gr = getBioMartGenes("hsapiens_gene_ensembl")
gr
```

```
## GRanges object with 69299 ranges and 4 metadata columns:
##                   seqnames              ranges strand | ensembl_gene_id
##                      <Rle>           <IRanges>  <Rle> |     <character>
##   ENSG00000000003        X 100627108-100639991      - | ENSG00000000003
##   ENSG00000000005        X 100584936-100599885      + | ENSG00000000005
##   ENSG00000000419       20   50934867-50959140      - | ENSG00000000419
##   ENSG00000000457        1 169849631-169894267      - | ENSG00000000457
##   ENSG00000000460        1 169662007-169854080      + | ENSG00000000460
##               ...      ...                 ...    ... .             ...
##   ENSG00000291313       14 103334237-103335932      + | ENSG00000291313
##   ENSG00000291314        X   10566888-10576955      - | ENSG00000291314
##   ENSG00000291315        3   40312086-40312214      + | ENSG00000291315
##   ENSG00000291316        8 144449582-144465430      - | ENSG00000291316
##   ENSG00000291317        8 144463817-144465667      - | ENSG00000291317
##                     gene_biotype   entrezgene_id external_gene_name
##                      <character> <CharacterList>        <character>
##   ENSG00000000003 protein_coding            7105             TSPAN6
##   ENSG00000000005 protein_coding           64102               TNMD
##   ENSG00000000419 protein_coding            8813               DPM1
##   ENSG00000000457 protein_coding           57147              SCYL3
##   ENSG00000000460 protein_coding           55732           C1orf112
##               ...            ...             ...                ...
##   ENSG00000291313 protein_coding            <NA>               <NA>
##   ENSG00000291314 protein_coding            <NA>               <NA>
##   ENSG00000291315 protein_coding            <NA>               <NA>
##   ENSG00000291316 protein_coding          157542               <NA>
##   ENSG00000291317 protein_coding           84773            TMEM276
##   -------
##   seqinfo: 445 sequences from an unspecified genome; no seqlengths
```

The returned value is a `GRanges` object which contains the coordinates of genes. The meta columns contain additional information of genes such as different gene IDs and type of genes.

You can also provide a “short name” for dataset and the function will perform a partial matching.

```
gr = getBioMartGenes("hsapiens")
```

You can try the following command and see what will be printed:

```
gr = getBioMartGenes("human")
```

You can also provide the taxon id for the organism:

```
gr = getBioMartGenes(9606)
```

Chromosome names from Ensembl have no “chr” prefix. You can set `add_chr_prefix = TURE` to add `"chr"` prefix to some of the chromosome names. Internally it uses `GenomeInfoDb::seqlevelsStyle(gr) = "UCSC"` to check and to add `"chr"` prefix.

```
gr = getBioMartGenes("hsapiens_gene_ensembl", add_chr_prefix = TRUE)
gr
```

```
## GRanges object with 69299 ranges and 4 metadata columns:
##                   seqnames              ranges strand | ensembl_gene_id
##                      <Rle>           <IRanges>  <Rle> |     <character>
##   ENSG00000000003     chrX 100627108-100639991      - | ENSG00000000003
##   ENSG00000000005     chrX 100584936-100599885      + | ENSG00000000005
##   ENSG00000000419    chr20   50934867-50959140      - | ENSG00000000419
##   ENSG00000000457     chr1 169849631-169894267      - | ENSG00000000457
##   ENSG00000000460     chr1 169662007-169854080      + | ENSG00000000460
##               ...      ...                 ...    ... .             ...
##   ENSG00000291313    chr14 103334237-103335932      + | ENSG00000291313
##   ENSG00000291314     chrX   10566888-10576955      - | ENSG00000291314
##   ENSG00000291315     chr3   40312086-40312214      + | ENSG00000291315
##   ENSG00000291316     chr8 144449582-144465430      - | ENSG00000291316
##   ENSG00000291317     chr8 144463817-144465667      - | ENSG00000291317
##                     gene_biotype   entrezgene_id external_gene_name
##                      <character> <CharacterList>        <character>
##   ENSG00000000003 protein_coding            7105             TSPAN6
##   ENSG00000000005 protein_coding           64102               TNMD
##   ENSG00000000419 protein_coding            8813               DPM1
##   ENSG00000000457 protein_coding           57147              SCYL3
##   ENSG00000000460 protein_coding           55732           C1orf112
##               ...            ...             ...                ...
##   ENSG00000291313 protein_coding            <NA>               <NA>
##   ENSG00000291314 protein_coding            <NA>               <NA>
##   ENSG00000291315 protein_coding            <NA>               <NA>
##   ENSG00000291316 protein_coding          157542               <NA>
##   ENSG00000291317 protein_coding           84773            TMEM276
##   -------
##   seqinfo: 445 sequences from an unspecified genome; no seqlengths
```

Note `add_chr_prefix` is just a helper argument. You can basically do the same as:

```
gr = getBioMartGenes("hsapiens_gene_ensembl")
GenomeInfoDb::seqlevelsStyle(gr) = "UCSC"
gr
```

```
## GRanges object with 69299 ranges and 4 metadata columns:
##                   seqnames              ranges strand | ensembl_gene_id
##                      <Rle>           <IRanges>  <Rle> |     <character>
##   ENSG00000000003     chrX 100627108-100639991      - | ENSG00000000003
##   ENSG00000000005     chrX 100584936-100599885      + | ENSG00000000005
##   ENSG00000000419    chr20   50934867-50959140      - | ENSG00000000419
##   ENSG00000000457     chr1 169849631-169894267      - | ENSG00000000457
##   ENSG00000000460     chr1 169662007-169854080      + | ENSG00000000460
##               ...      ...                 ...    ... .             ...
##   ENSG00000291313    chr14 103334237-103335932      + | ENSG00000291313
##   ENSG00000291314     chrX   10566888-10576955      - | ENSG00000291314
##   ENSG00000291315     chr3   40312086-40312214      + | ENSG00000291315
##   ENSG00000291316     chr8 144449582-144465430      - | ENSG00000291316
##   ENSG00000291317     chr8 144463817-144465667      - | ENSG00000291317
##                     gene_biotype   entrezgene_id external_gene_name
##                      <character> <CharacterList>        <character>
##   ENSG00000000003 protein_coding            7105             TSPAN6
##   ENSG00000000005 protein_coding           64102               TNMD
##   ENSG00000000419 protein_coding            8813               DPM1
##   ENSG00000000457 protein_coding           57147              SCYL3
##   ENSG00000000460 protein_coding           55732           C1orf112
##               ...            ...             ...                ...
##   ENSG00000291313 protein_coding            <NA>               <NA>
##   ENSG00000291314 protein_coding            <NA>               <NA>
##   ENSG00000291315 protein_coding            <NA>               <NA>
##   ENSG00000291316 protein_coding          157542               <NA>
##   ENSG00000291317 protein_coding           84773            TMEM276
##   -------
##   seqinfo: 445 sequences from an unspecified genome; no seqlengths
```

For some not-well-studied organisms, there might be no “official chromosome name”. For example, `"cporcellus_gene_ensembl"` for the guinea Pig:

```
gr = getBioMartGenes("cporcellus_gene_ensembl")
gr
```

```
## GRanges object with 26855 ranges and 4 metadata columns:
##                        seqnames            ranges strand |    ensembl_gene_id
##                           <Rle>         <IRanges>  <Rle> |        <character>
##   ENSCPOG00000000007 DS562868.1 22719983-22745621      - | ENSCPOG00000000007
##   ENSCPOG00000000011 DS562863.1 58475996-58484540      + | ENSCPOG00000000011
##   ENSCPOG00000000012 DS562864.1 51072990-51073943      + | ENSCPOG00000000012
##   ENSCPOG00000000013 DS563093.1     409300-421802      + | ENSCPOG00000000013
##   ENSCPOG00000000014 DS562923.1   9324624-9325632      + | ENSCPOG00000000014
##                  ...        ...               ...    ... .                ...
##   ENSCPOG00000040808 DS562855.1     547865-551436      + | ENSCPOG00000040808
##   ENSCPOG00000040809 DS562862.1 50369714-50415125      - | ENSCPOG00000040809
##   ENSCPOG00000040810 DS562864.1 43092199-43093149      - | ENSCPOG00000040810
##   ENSCPOG00000040811 DS562863.1 28315518-28533596      + | ENSCPOG00000040811
##   ENSCPOG00000040812 DS562897.1 10154287-10157556      - | ENSCPOG00000040812
##                        gene_biotype   entrezgene_id external_gene_name
##                         <character> <CharacterList>        <character>
##   ENSCPOG00000000007 protein_coding       100730010             D2HGDH
##   ENSCPOG00000000011 protein_coding       100730666              OTOL1
##   ENSCPOG00000000012 protein_coding       100720088               <NA>
##   ENSCPOG00000000013 protein_coding            <NA>             TRIM10
##   ENSCPOG00000000014 protein_coding            <NA>               <NA>
##                  ...            ...             ...                ...
##   ENSCPOG00000040808 protein_coding       100735988             TMEM74
##   ENSCPOG00000040809 protein_coding            <NA>               <NA>
##   ENSCPOG00000040810     pseudogene            <NA>               <NA>
##   ENSCPOG00000040811 protein_coding            <NA>               <NA>
##   ENSCPOG00000040812        lincRNA            <NA>               <NA>
##   -------
##   seqinfo: 449 sequences from an unspecified genome; no seqlengths
```

The sequence names are in a special format of `DS\d+`. The source of the format can be obtained by `getBioMartGenomeInfo()`. In the `seqname_style` element of the returned list, there are several examples that you can compare to.

```
getBioMartGenomeInfo("cporcellus_gene_ensembl")
```

```
## $dataset
## [1] "cporcellus_gene_ensembl"
##
## $version
## [1] "Cavpor3.0"
##
## $name
## [1] "Cavia porcellus (Guinea Pig)"
##
## $taxon_id
## [1] 10141
##
## $genbank_accession
## [1] "GCA_000151735.1"
##
## $mart
## [1] "genes_mart"
##
## $seqname_style
## $seqname_style$`Sequence-Name`
## [1] "supercont2_0" "supercont2_1" "supercont2_2" "supercont2_3" "supercont2_4"
##
## $seqname_style$`GenBank-Accn`
## [1] "DS562855.1" "DS562856.1" "DS562857.1" "DS562858.1" "DS562859.1"
##
## $seqname_style$`RefSeq-Accn`
## [1] "NT_176419.1" "NT_176418.1" "NT_176417.1" "NT_176416.1" "NT_176415.1"
```

Now we know they are the GenBank accession IDs. Next we might want to change them to the `"Sequence-Name"` style. Simply use `changeSeqnameStyle()`.

```
gr2 = changeSeqnameStyle(gr, "cporcellus_gene_ensembl",
    seqname_style_from = "GenBank-Accn",
    seqname_style_to = "Sequence-Name")
gr2
```

```
## GRanges object with 26818 ranges and 5 metadata columns:
##                            seqnames            ranges strand |
##                               <Rle>         <IRanges>  <Rle> |
##   ENSCPOG00000000007  supercont2_13 22719983-22745621      - |
##   ENSCPOG00000000011   supercont2_8 58475996-58484540      + |
##   ENSCPOG00000000012   supercont2_9 51072990-51073943      + |
##   ENSCPOG00000000013 supercont2_238     409300-421802      + |
##   ENSCPOG00000000014  supercont2_68   9324624-9325632      + |
##                  ...            ...               ...    ... .
##   ENSCPOG00000040808   supercont2_0     547865-551436      + |
##   ENSCPOG00000040809   supercont2_7 50369714-50415125      - |
##   ENSCPOG00000040810   supercont2_9 43092199-43093149      - |
##   ENSCPOG00000040811   supercont2_8 28315518-28533596      + |
##   ENSCPOG00000040812  supercont2_42 10154287-10157556      - |
##                         ensembl_gene_id   gene_biotype   entrezgene_id
##                             <character>    <character> <CharacterList>
##   ENSCPOG00000000007 ENSCPOG00000000007 protein_coding       100730010
##   ENSCPOG00000000011 ENSCPOG00000000011 protein_coding       100730666
##   ENSCPOG00000000012 ENSCPOG00000000012 protein_coding       100720088
##   ENSCPOG00000000013 ENSCPOG00000000013 protein_coding            <NA>
##   ENSCPOG00000000014 ENSCPOG00000000014 protein_coding            <NA>
##                  ...                ...            ...             ...
##   ENSCPOG00000040808 ENSCPOG00000040808 protein_coding       100735988
##   ENSCPOG00000040809 ENSCPOG00000040809 protein_coding            <NA>
##   ENSCPOG00000040810 ENSCPOG00000040810     pseudogene            <NA>
##   ENSCPOG00000040811 ENSCPOG00000040811 protein_coding            <NA>
##   ENSCPOG00000040812 ENSCPOG00000040812        lincRNA            <NA>
##                      external_gene_name .original_seqname
##                             <character>       <character>
##   ENSCPOG00000000007             D2HGDH        DS562868.1
##   ENSCPOG00000000011              OTOL1        DS562863.1
##   ENSCPOG00000000012               <NA>        DS562864.1
##   ENSCPOG00000000013             TRIM10        DS563093.1
##   ENSCPOG00000000014               <NA>        DS562923.1
##                  ...                ...               ...
##   ENSCPOG00000040808             TMEM74        DS562855.1
##   ENSCPOG00000040809               <NA>        DS562862.1
##   ENSCPOG00000040810               <NA>        DS562864.1
##   ENSCPOG00000040811               <NA>        DS562863.1
##   ENSCPOG00000040812               <NA>        DS562897.1
##   -------
##   seqinfo: 448 sequences from an unspecified genome; no seqlengths
```

Sometimes the internal sequence names need to be reformatted to fit the input `gr`. In the second example ( `"apercula_gene_ensembl"` for the orange clownfish), the sequence names are in format of `1, 2, 3, ...`, while internally they are represented as `chr1, chr2, ...`.

```
gr = getBioMartGenes("apercula_gene_ensembl")
gr
```

```
## GRanges object with 24840 ranges and 3 metadata columns:
##                      seqnames            ranges strand |    ensembl_gene_id
##                         <Rle>         <IRanges>  <Rle> |        <character>
##   ENSAPEG00000000002        1       24225-56222      - | ENSAPEG00000000002
##   ENSAPEG00000000003        1       84299-92425      - | ENSAPEG00000000003
##   ENSAPEG00000000004        1     128917-153166      - | ENSAPEG00000000004
##   ENSAPEG00000000005        1     159517-165941      + | ENSAPEG00000000005
##   ENSAPEG00000000006        1     169070-172981      - | ENSAPEG00000000006
##                  ...      ...               ...    ... .                ...
##   ENSAPEG00000024837        1 42572675-42577642      + | ENSAPEG00000024837
##   ENSAPEG00000024838        1 42576978-42651838      - | ENSAPEG00000024838
##   ENSAPEG00000024839        1 42687220-42701205      - | ENSAPEG00000024839
##   ENSAPEG00000024840        1 42704049-42726377      - | ENSAPEG00000024840
##   ENSAPEG00000024841        1 42727223-42735871      - | ENSAPEG00000024841
##                        gene_biotype external_gene_name
##                         <character>        <character>
##   ENSAPEG00000000002 protein_coding           emilin1b
##   ENSAPEG00000000003 protein_coding               <NA>
##   ENSAPEG00000000004 protein_coding               <NA>
##   ENSAPEG00000000005 protein_coding               <NA>
##   ENSAPEG00000000006 protein_coding              ctrb1
##                  ...            ...                ...
##   ENSAPEG00000024837 protein_coding                dut
##   ENSAPEG00000024838 protein_coding               FBN1
##   ENSAPEG00000024839 protein_coding               <NA>
##   ENSAPEG00000024840 protein_coding          SECISBP2L
##   ENSAPEG00000024841 protein_coding              cops2
##   -------
##   seqinfo: 72 sequences from an unspecified genome; no seqlengths
```

```
getBioMartGenomeInfo("apercula_gene_ensembl")
```

```
## $dataset
## [1] "apercula_gene_ensembl"
##
## $version
## [1] "Nemo_v1"
##
## $name
## [1] "Amphiprion percula (Orange clownfish)"
##
## $taxon_id
## [1] 161767
##
## $genbank_accession
## [1] "GCA_003047355.1"
##
## $mart
## [1] "genes_mart"
##
## $seqname_style
## $seqname_style$`Sequence-Name`
## [1] "chr1" "chr2" "chr3" "chr4" "chr5"
##
## $seqname_style$`GenBank-Accn`
## [1] "CM009708.1" "CM009709.1" "CM009710.1" "CM009711.1" "CM009712.1"
##
## $seqname_style$`RefSeq-Accn`
## [1] "na" "na" "na" "na" "na"
```

In this case, we need to set the argument `reformat_from` as a function to reformat the internal format to fit the sequence names in `gr`. Also you can set `reformat_to` as a function to reformat the converted sequence names.

```
gr2 = changeSeqnameStyle(gr, "apercula_gene_ensembl",
    seqname_style_from = "Sequence-Name",
    seqname_style_to = "GenBank-Accn",
    reformat_from =function(x) gsub("chr", "", x),
    reformat_to = function(x) gsub("\\.\\d+$", "", x)
)
gr2
```

```
## GRanges object with 24678 ranges and 4 metadata columns:
##                      seqnames            ranges strand |    ensembl_gene_id
##                         <Rle>         <IRanges>  <Rle> |        <character>
##   ENSAPEG00000000002 CM009708       24225-56222      - | ENSAPEG00000000002
##   ENSAPEG00000000003 CM009708       84299-92425      - | ENSAPEG00000000003
##   ENSAPEG00000000004 CM009708     128917-153166      - | ENSAPEG00000000004
##   ENSAPEG00000000005 CM009708     159517-165941      + | ENSAPEG00000000005
##   ENSAPEG00000000006 CM009708     169070-172981      - | ENSAPEG00000000006
##                  ...      ...               ...    ... .                ...
##   ENSAPEG00000024837 CM009708 42572675-42577642      + | ENSAPEG00000024837
##   ENSAPEG00000024838 CM009708 42576978-42651838      - | ENSAPEG00000024838
##   ENSAPEG00000024839 CM009708 42687220-42701205      - | ENSAPEG00000024839
##   ENSAPEG00000024840 CM009708 42704049-42726377      - | ENSAPEG00000024840
##   ENSAPEG00000024841 CM009708 42727223-42735871      - | ENSAPEG00000024841
##                        gene_biotype external_gene_name .original_seqname
##                         <character>        <character>       <character>
##   ENSAPEG00000000002 protein_coding           emilin1b                 1
##   ENSAPEG00000000003 protein_coding               <NA>                 1
##   ENSAPEG00000000004 protein_coding               <NA>                 1
##   ENSAPEG00000000005 protein_coding               <NA>                 1
##   ENSAPEG00000000006 protein_coding              ctrb1                 1
##                  ...            ...                ...               ...
##   ENSAPEG00000024837 protein_coding                dut                 1
##   ENSAPEG00000024838 protein_coding               FBN1                 1
##   ENSAPEG00000024839 protein_coding               <NA>                 1
##   ENSAPEG00000024840 protein_coding          SECISBP2L                 1
##   ENSAPEG00000024841 protein_coding              cops2                 1
##   -------
##   seqinfo: 24 sequences from an unspecified genome; no seqlengths
```

## Retrieve gene sets

To obtain the gene sets, use the function `getBioMartGOGeneSets()`. Also you need to provide the “dataset”. Here we use a different dataset: `"mmusculus_gene_ensembl"` (mouse).

```
lt = getBioMartGOGeneSets("mmusculus_gene_ensembl")
length(lt)
```

```
## [1] 15791
```

```
lt[1]
```

```
## $`GO:0000002`
##  [1] "ENSMUSG00000019699" "ENSMUSG00000028982" "ENSMUSG00000022615"
##  [4] "ENSMUSG00000039264" "ENSMUSG00000030557" "ENSMUSG00000030879"
##  [7] "ENSMUSG00000032449" "ENSMUSG00000038084" "ENSMUSG00000022889"
## [10] "ENSMUSG00000041064" "ENSMUSG00000033845" "ENSMUSG00000107283"
## [13] "ENSMUSG00000027424" "ENSMUSG00000036875" "ENSMUSG00000038225"
## [16] "ENSMUSG00000022292" "ENSMUSG00000004069" "ENSMUSG00000039176"
## [19] "ENSMUSG00000025209" "ENSMUSG00000029911" "ENSMUSG00000020718"
## [22] "ENSMUSG00000030978" "ENSMUSG00000026496" "ENSMUSG00000028893"
## [25] "ENSMUSG00000002814" "ENSMUSG00000026365" "ENSMUSG00000015337"
## [28] "ENSMUSG00000034203" "ENSMUSG00000059552" "ENSMUSG00000055660"
## [31] "ENSMUSG00000028455" "ENSMUSG00000030314" "ENSMUSG00000020697"
## [34] "ENSMUSG00000036923" "ENSMUSG00000032633" "ENSMUSG00000029167"
```

The variable `lt` is a list of vectors where each vector corresponds to a GO gene set with Ensembl IDs as gene identifiers.

You can try the following command and see what will be printed:

```
lt = getBioMartGOGeneSets("mouse")
```

Remember you can also set the taxon ID:

```
lt = getBioMartGOGeneSets(10090)
```

In `getBioMartGOGeneSets()`, argument `as_table` can be set to `TRUE`, then the function returns a data frame.

```
tb = getBioMartGOGeneSets("mmusculus_gene_ensembl", as_table = TRUE)
head(tb)
```

```
##   go_geneset       ensembl_gene
## 1 GO:0000002 ENSMUSG00000019699
## 2 GO:0000002 ENSMUSG00000028982
## 3 GO:0000002 ENSMUSG00000022615
## 4 GO:0000002 ENSMUSG00000039264
## 5 GO:0000002 ENSMUSG00000030557
## 6 GO:0000002 ENSMUSG00000030879
```

Argument `ontology` controls which category of GO gene sets. Possible values should be `"BP"`, `"CC"` and `"MF"`.

```
getBioMartGOGeneSets("mmusculus_gene_ensembl", ontology = "BP") # the default one
getBioMartGOGeneSets("mmusculus_gene_ensembl", ontology = "CC")
getBioMartGOGeneSets("mmusculus_gene_ensembl", ontology = "MF")
```

Last, argument `gene_id_type` can be set to `"entrez_gene"` or `"gene_symbol"`, then genes in the gene sets are in Entrez IDs or gene symbols. Note this depends on specific organisms, that not every organism supports Entrez IDs or gene symbols.

```
lt = getBioMartGOGeneSets("mmusculus_gene_ensembl", gene_id_type = "entrez_gene")
lt[1]
```

```
## $`GO:0000002`
##  [1] "23797"  "70556"  "72962"  "83408"  "17258"  "27397"  "192287" "74143"
##  [9] "27393"  "208084" "27395"  "17527"  "74528"  "327762" "408022" "382985"
## [17] "83945"  "18975"  "226153" "381760" "50776"  "20133"  "11545"  "230784"
## [25] "21975"  "12628"  "13804"  "72170"  "22059"  "76781"  "66592"  "74244"
## [33] "16882"  "216021" "216805" "19017"
```

## Version of the data

The object `BioMartGOGeneSets` contains the version and source of data.

```
BioMartGOGeneSets
```

```
## BioMart Gene Ontology gene sets
##   Source: https://www.ensembl.org/info/data/biomart/index.html
##   Number of organisms: 718
##   Marts: fungi_mart, genes_mart, metazoa_mart, plants_mart, protists_mart
##   Built date: 2023-09-23, with biomaRt (2.54.1), GO.db (3.18.0)
```

## Session Info

```
sessionInfo()
```

```
## R version 4.3.1 (2023-06-16)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 22.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.18-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.10.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
## [1] BioMartGOGeneSets_0.99.11 GO.db_3.18.0
## [3] AnnotationDbi_1.63.2      IRanges_2.35.2
## [5] S4Vectors_0.39.2          Biobase_2.61.0
## [7] BiocGenerics_0.47.0       biomaRt_2.57.1
## [9] knitr_1.44
##
## loaded via a namespace (and not attached):
##  [1] KEGGREST_1.41.4         xfun_0.40               bslib_0.5.1
##  [4] vctrs_0.6.3             tools_4.3.1             bitops_1.0-7
##  [7] generics_0.1.3          curl_5.0.2              tibble_3.2.1
## [10] fansi_1.0.4             RSQLite_2.3.1           blob_1.2.4
## [13] pkgconfig_2.0.3         dbplyr_2.3.3            lifecycle_1.0.3
## [16] GenomeInfoDbData_1.2.10 compiler_4.3.1          stringr_1.5.0
## [19] Biostrings_2.69.2       progress_1.2.2          GenomeInfoDb_1.37.4
## [22] htmltools_0.5.6         sass_0.4.7              RCurl_1.98-1.12
## [25] yaml_2.3.7              pillar_1.9.0            crayon_1.5.2
## [28] jquerylib_0.1.4         cachem_1.0.8            tidyselect_1.2.0
## [31] digest_0.6.33           stringi_1.7.12          purrr_1.0.2
## [34] dplyr_1.1.3             fastmap_1.1.1           cli_3.6.1
## [37] magrittr_2.0.3          XML_3.99-0.14           utf8_1.2.3
## [40] withr_2.5.1             prettyunits_1.2.0       filelock_1.0.2
## [43] rappdirs_0.3.3          bit64_4.0.5             rmarkdown_2.25
## [46] XVector_0.41.1          httr_1.4.7              bit_4.0.5
## [49] png_0.1-8               hms_1.1.3               memoise_2.0.1
## [52] evaluate_0.21           GenomicRanges_1.53.1    BiocFileCache_2.9.1
## [55] rlang_1.1.1             glue_1.6.2              DBI_1.1.3
## [58] xml2_1.3.5              jsonlite_1.8.7          R6_2.5.1
## [61] zlibbioc_1.47.0
```