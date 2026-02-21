# Code example from 'biobtreeR' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
library(biobtreeR)

# Create an folder and set as an output directory 
# It is used for database and configuration files

# temporary directory is used for demonstration purpose
bbUseOutDir(tempdir())


## -----------------------------------------------------------------------------
# Called once and saves the built in database to local disk

# Included datasets hgnc,hmdb,taxonomy,go,efo,eco,chebi,interpro
# Included uniprot proteins and ensembl genomes belongs to following organisms:
# homo_sapiens, danio_rerio(zebrafish), gallus_gallus(chicken), mus_musculus, Rattus norvegicus, saccharomyces_cerevisiae, 
# arabidopsis_thaliana, drosophila_melanogaster, caenorhabditis_elegans, Escherichia coli, Escherichia coli str. K-12 substr. MG1655, Escherichia coli K-12

# Requires ~ 6 GB free storage
bbBuiltInDB()


## ----eval=FALSE---------------------------------------------------------------
# 
# # multiple species genomes supported with comma seperated taxonomy identifiers
# bbBuildCustomDB(taxonomyIDs = "1408103,206403")
# 

## -----------------------------------------------------------------------------
 bbStart()

## -----------------------------------------------------------------------------
bbSearch("tpi1,vav_human,ENST00000297261")

## -----------------------------------------------------------------------------
bbSearch("tpi1,ENSG00000164690","ensembl")

## -----------------------------------------------------------------------------
bbSearch("tpi1,vav_human,ENST00000297261",showURL =TRUE)

## -----------------------------------------------------------------------------
bbMapping("AT5G3_HUMAN",'map(go)',attrs = "type")

## -----------------------------------------------------------------------------
bbMapping("AT5G3_HUMAN",'map(go).filter(go.type=="biological_process")',attrs = "type")

## -----------------------------------------------------------------------------
bbListAttrs("go")

## -----------------------------------------------------------------------------
bbListAttrs("uniprot")

## -----------------------------------------------------------------------------
bbListAttrs("hgnc")

## -----------------------------------------------------------------------------
bbListAttrs("ensembl")

## -----------------------------------------------------------------------------
bbListAttrs("transcript")

## -----------------------------------------------------------------------------
bbListAttrs("exon")

## -----------------------------------------------------------------------------
bbListAttrs("cds")

## -----------------------------------------------------------------------------
res<-bbMapping("ATP5MC3,TP53",'map(transcript)')
head(res)

## -----------------------------------------------------------------------------
res<-bbMapping("ATP5MC3,TP53",'map(transcript).map(exon)',attrs = "seq_region")
head(res)

## -----------------------------------------------------------------------------
res<-bbMapping("shh",'filter(ensembl.genome=="homo_sapiens").map(ortholog)')
head(res)

## -----------------------------------------------------------------------------
bbMapping("fry,mog",'map(paralog)',showInputColumn = TRUE)

## -----------------------------------------------------------------------------
bbMapping("ENSG00000073910,shh" ,'map(entrez)')

## -----------------------------------------------------------------------------
bbMapping("NM_005359,NM_000546",'map(hgnc)',attrs = "symbols")

## -----------------------------------------------------------------------------
res<-bbMapping("homo_sapiens",'map(ensembl).filter(ensembl.seq_region=="Y" && ensembl.biotype=="lncRNA")',attrs = 'name')
head(res)

## -----------------------------------------------------------------------------
bbMapping("tpi1,shh",'map(transcript).map(cds)')

## -----------------------------------------------------------------------------
bbMapping("9606",'map(ensembl).filter((114129278>ensembl.start && 114129278<ensembl.end) || (114129328>ensembl.start && 114129328<ensembl.end))',attrs = "name")

## -----------------------------------------------------------------------------
bbMapping("9606",'map(ensembl).filter(ensembl.overlaps(114129278,114129328))',attrs = "name")

## -----------------------------------------------------------------------------
bbMapping("202763_at,213596_at,209310_s_at",source ="affy_hg_u133_plus_2" ,'map(transcript).map(ensembl)',attrs = "name")

## -----------------------------------------------------------------------------
bbMapping("CASP3,CASP4",'map(transcript).map(affy_hg_u133_plus_2)')

## -----------------------------------------------------------------------------
res<-bbMapping("homo sapiens",'map(ensembl).filter(ensembl.name.contains("TTY"))',attrs = "name")
head(res)

## -----------------------------------------------------------------------------
bbListAttrs("uniprot")

## -----------------------------------------------------------------------------
bbListAttrs("ufeature")

## -----------------------------------------------------------------------------
bbListAttrs("pdb")

## -----------------------------------------------------------------------------
bbListAttrs("interpro")

## -----------------------------------------------------------------------------
bbMapping("msh6,stk11,bmpr1a,smad4,brca2","map(uniprot)",source ="hgnc")

## -----------------------------------------------------------------------------
bbMapping("clock_human,shh_human,aicda_human,at5g3_human,p53_human","filter(uniprot.sequence.mass > 45000)" ,attrs = "sequence$mass,sequence$seq")

## -----------------------------------------------------------------------------
bbMapping("shh_human",'map(ufeature).filter(ufeature.type=="helix")' ,attrs = "location$begin,location$end")

## -----------------------------------------------------------------------------
bbMapping("tp53",'map(uniprot).map(ufeature).filter(ufeature.original=="I" && ufeature.variation=="S").map(variantid)',source = "hgnc")

## -----------------------------------------------------------------------------
bbStop()

## -----------------------------------------------------------------------------
sessionInfo()

