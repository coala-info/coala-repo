# Code example from 'using_pcxn' vignette. See references/ for full tutorial.

### R code from vignette source 'using_pcxn.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: queries
###################################################
# Select a query gene set from a specific collection while requesting 
# the 10 most correlated neighbors, whether the correlation coefficients are 
# adjusted for gene overlap and specific cut-offs for minimum absolute 
# correlation and maximum p-value

library(pcxn)
library(pcxnData)

data(list = c("pathprint.Hs.gs",
                "pathCor_pathprint_v1.2.3_dframe",
                "pathCor_pathprint_v1.2.3_unadjusted_dframe",
                "pathCor_CPv5.1_dframe", "gobp_gs_v5.1"))

pcxn.obj <- pcxn_explore(collection = "pathprint",
                        query_geneset = "Alzheimer's disease (KEGG)",
                        adj_overlap = TRUE,
                        top = 10,
                        min_abs_corr = 0.05,
                        max_pval = 0.05)

# Select one or two pathway groups from a specific collection while requesting 
# the 10 most correlated neighbors, whether the correlation coefficients are 
# adjusted for gene overlap and specific cut-offs for minimum absolute 
# correlation and maximum p-value

pcxn.obj <- pcxn_analyze("pathprint",c("ABC transporters (KEGG)",
                                        "ACE Inhibitor Pathway (Wikipathways)",
                                        "AR down reg. targets (Netpath)"),
                                    c("DNA Repair (Reactome)"), 
                                    adj_overlap = FALSE, 10, 0.05, 0.05)


###################################################
### code chunk number 2: pcxn_gene_members
###################################################
# Use the pcxn package to select pathway from any collection and get it's
# gene members as a list

gene_member_list <- pcxn_gene_members("Alzheimer's disease (KEGG)")


###################################################
### code chunk number 3: pcxn_heatmap
###################################################
# Creare the pcxn object needed as an input
pcxn.obj <- pcxn_analyze("pathprint",c("ABC transporters (KEGG)",
                                        "ACE Inhibitor Pathway (Wikipathways)",
                                        "AR down reg. targets (Netpath)"),
                            c("DNA Repair (Reactome)"), 10, 0.05, 0.05)

# Draw the heatmap
heatmap <- pcxn_heatmap(pcxn.obj, "complete")


###################################################
### code chunk number 4: pcxn_network
###################################################
# Create the pcxn object needed as an input
pcxn.obj <- pcxn_analyze("pathprint",c("ABC transporters (KEGG)",
                                        "ACE Inhibitor Pathway (Wikipathways)",
                                        "AR down reg. targets (Netpath)"),
                            c("DNA Repair (Reactome)"), 10, 0.05, 0.05)

# Create the network
# network <- pcxn_network(pcxn.obj)


