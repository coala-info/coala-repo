# Code example from 'Prize' vignette. See references/ for full tutorial.

### R code from vignette source 'Prize.Rnw'

###################################################
### code chunk number 1: Prize.Rnw:52-54
###################################################
require(Prize)
require(diagram)


###################################################
### code chunk number 2: Prize.Rnw:57-62
###################################################
mat <- matrix(nrow = 7, ncol = 2, data = NA)
mat[,1] <- c('0', '1','2','3','4','4.1','4.2')
mat[,2] <- c('Prioritization_of_DE_genes','Tumor_expression','Normal_expression',
             'Frequency', 'Epitopes', 'Number_of_epitopes', 'Size_of_epitopes')
mat


###################################################
### code chunk number 3: Prize.Rnw:66-67
###################################################
ahplot(mat, fontsize = 0.7, cradx = 0.11 ,sradx = 0.12, cirx= 0.18, ciry = 0.07)


###################################################
### code chunk number 4: Prize.Rnw:101-104
###################################################
pcm <- read.table(system.file('extdata','ind1.tsv',package = 'Prize'), 
                  sep = '\t', header = TRUE, row.names = 1)
pcm


###################################################
### code chunk number 5: Prize.Rnw:109-111
###################################################
pcm <- ahmatrix(pcm)
ahp_matrix(pcm)


###################################################
### code chunk number 6: Prize.Rnw:117-127
###################################################
mat = matrix(nrow = 4, ncol = 1, data = NA)
mat[,1] = c(system.file('extdata','ind1.tsv',package = 'Prize'), 
            system.file('extdata','ind2.tsv',package = 'Prize'), 
            system.file('extdata','ind3.tsv',package = 'Prize'),
            system.file('extdata','ind4.tsv',package = 'Prize'))
rownames(mat) = c('ind1','ind2','ind3', 'ind4')
colnames(mat) = c('individual_judgement') 

# non-weighted AIJ 
res = gaggregate(srcfile = mat, method = 'geometric', simulation = 500)


###################################################
### code chunk number 7: Prize.Rnw:130-135
###################################################
# aggregated group judgement using non-weighted AIJ
AIJ(res)

# consistency ratio of the aggregated group judgement
GCR(res)


###################################################
### code chunk number 8: Prize.Rnw:140-141
###################################################
require(ggplot2)


###################################################
### code chunk number 9: Prize.Rnw:144-146
###################################################
# Distance between individual opinions and the aggregated group judgement
dplot(IP(res))


###################################################
### code chunk number 10: Prize.Rnw:151-153
###################################################
# Consistency ratio of individal opinions
crplot(ICR(res), angle = 45)


###################################################
### code chunk number 11: Prize.Rnw:161-162
###################################################
require(stringr)


###################################################
### code chunk number 12: Prize.Rnw:165-176
###################################################
mat <- matrix(nrow = 7, ncol = 3, data = NA)
mat[,1] <- c('0', '1','2','3','4','4.1','4.2')
mat[,2] <- c('Prioritization_of_DE_genes','Tumor_expression','Normal_expression',
             'Frequency', 'Epitopes', 'Number_of_epitopes', 'Size_of_epitopes')
mat[,3] <- c(system.file('extdata','aggreg.judgement.tsv',package = 'Prize'), 
             system.file('extdata','tumor.PCM.tsv',package = 'Prize'), 
             system.file('extdata','normal.PCM.tsv',package = 'Prize'), 
             system.file('extdata','freq.PCM.tsv',package = 'Prize'), 
             system.file('extdata','epitope.PCM.tsv',package = 'Prize'), 
             system.file('extdata','epitopeNum.PCM.tsv',package = 'Prize'), 
             system.file('extdata','epitopeLength.PCM.tsv',package = 'Prize'))


###################################################
### code chunk number 13: Prize.Rnw:179-181
###################################################
# Computing alternatives priorities
prioritization <- pipeline(mat, model = 'relative', simulation = 500)


###################################################
### code chunk number 14: Prize.Rnw:186-188
###################################################
ahplot(ahp_plot(prioritization), fontsize = 0.7, cradx = 0.11 ,sradx = 0.12, 
       cirx= 0.18, ciry = 0.07, dist = 0.06)


###################################################
### code chunk number 15: Prize.Rnw:193-194
###################################################
require(reshape2)


###################################################
### code chunk number 16: Prize.Rnw:197-199
###################################################
wplot(weight_plot(prioritization)$criteria_wplot, type = 'pie', 
      fontsize = 7, pcex = 3)


###################################################
### code chunk number 17: Prize.Rnw:209-210
###################################################
rainbowplot(rainbow_plot(prioritization)$criteria_rainbowplot, xcex = 3)


###################################################
### code chunk number 18: Prize.Rnw:215-216
###################################################
rainbow_plot(prioritization)$criteria_rainbowplot


###################################################
### code chunk number 19: Prize.Rnw:228-232
###################################################
category_pcm = read.table(system.file('extdata','number.tsv', package = 'Prize')
                          , sep = '\t', header = TRUE, row.names = 1)

category_pcm


###################################################
### code chunk number 20: Prize.Rnw:237-241
###################################################
alt_mat = read.table(system.file('extdata','numEpitope_alternative_category.tsv', 
                    package = 'Prize'), sep = '\t', header = FALSE)

alt_mat


###################################################
### code chunk number 21: Prize.Rnw:246-250
###################################################
result = rating(category_pcm, alt_mat, simulation = 500)

# rated alternatives 
RM(result)


###################################################
### code chunk number 22: Prize.Rnw:255-269
###################################################
mat <- matrix(nrow = 7, ncol = 3, data = NA)
mat[,1] <- c('0', '1','2','3','4','4.1','4.2')
mat[,2] <- c('Prioritization_of_DE_genes','Tumor_expression','Normal_expression',
             'Frequency', 'Epitopes', 'Number_of_epitopes', 'Size_of_epitopes')
mat[,3] <- c(system.file('extdata','aggreg.judgement.tsv',package = 'Prize'), 
             system.file('extdata','tumor_exp_rating.tsv',package = 'Prize'), 
             system.file('extdata','normal_exp_rating.tsv',package = 'Prize'), 
             system.file('extdata','freq_exp_rating.tsv',package = 'Prize'), 
             system.file('extdata','epitope.PCM.tsv',package = 'Prize'), 
             system.file('extdata','epitope_num_rating.tsv',package = 'Prize'), 
             system.file('extdata','epitope_size_rating.tsv',package = 'Prize'))

# Computing alternatives priorities
prioritization <- pipeline(mat, model = 'rating', simulation = 500)


