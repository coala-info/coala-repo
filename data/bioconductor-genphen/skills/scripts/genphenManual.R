# Code example from 'genphenManual' vignette. See references/ for full tutorial.

### R code from vignette source 'genphenManual.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: genphenManual.Rnw:265-274
###################################################
require(genphen)
require(ggplot2)
require(knitr)
require(ggrepel)
require(reshape)
require(ape)
require(xtable)
require(gridExtra)
options(xtable.floating = FALSE)


###################################################
### code chunk number 2: genphenManual.Rnw:280-285
###################################################
# genotype as matrix (120x154), we will subset part of it:
data(genotype.saap)

# phenotype as vector (120 measurements):
data(phenotype.saap)


###################################################
### code chunk number 3: genphenManual.Rnw:296-305
###################################################
# Format the genotype-phenotype data, such that it can then
# be visualized with ggplot
df <- data.frame(genotype.saap[, 82:89], 
                 phenotype = phenotype.saap,
                 stringsAsFactors = FALSE)
df <- melt(data = df, id.vars = "phenotype")
colnames(df) <- c("phenotype", "site", "genotype")
df$site <- gsub(pattern = "X", replacement = '', x = df$site)
df$site <- factor(x = df$site, levels = unique(df$site))


###################################################
### code chunk number 4: genphenManual.Rnw:309-321
###################################################
# Visualization
g <- ggplot(data = df)+
  facet_wrap(facets = ~site, nrow = 2, scales = "free_x")+
  geom_violin(aes(x = genotype, y = phenotype))+
  ylab(label = "Quantitative phenotype")+
  xlab(label = "Genotypes")+
  geom_point(aes(x = genotype, y = phenotype, col = genotype), 
             size = 1, shape = 21, position = position_jitterdodge())+
  scale_color_discrete(name = "genotype")+
  theme_bw(base_size = 14)+
  theme(legend.position = "none")
g


###################################################
### code chunk number 5: genphenManual.Rnw:327-328
###################################################
g


###################################################
### code chunk number 6: genphenManual.Rnw:357-369
###################################################
# Run genphen
c.out <- genphen::runGenphen(genotype = genotype.saap[, 82:89], 
                             phenotype = phenotype.saap,
                             phenotype.type = "Q",
                             model.type = "hierarchical",
                             mcmc.chains = 2,
                             mcmc.steps = 1500,
                             mcmc.warmup = 500,
                             cores = 2,
                             hdi.level = 0.95,
                             stat.learn.method = "rf",
                             cv.steps = 200)


###################################################
### code chunk number 7: genphenManual.Rnw:384-407
###################################################
# Get the scores data
c.score <- c.out$scores

# Some optional formatting for the SNPs (label = site : genotype1 -> genotype2)
c.score$label <- paste(c.score$site, ":", c.score$ref,
                       "->", c.score$alt, sep = '')

# Visualization
g <- ggplot(data = c.score)+
  geom_errorbar(aes(x = ca.mean, ymin = beta.hdi.low, ymax = beta.hdi.high),
                width = 0.015, col = "darkgray")+
  geom_point(aes(x = ca.mean, y = beta.mean, fill = kappa.mean), 
             shape = 21, size = 4)+
  geom_text_repel(aes(x = ca.mean, y = beta.mean, label = label), size = 5)+
  theme_bw(base_size = 14)+
  ylab(label = "Effect size (with 95% HDI)")+
  scale_x_continuous(name = "CA", limits = c(0, 1.05))+
  geom_hline(yintercept = 0, linetype = "dashed")+
  theme(legend.position = "top")+
  scale_fill_distiller(palette = "Spectral", limits = c(-0.2, 1))+
  guides(fill = guide_colorbar(barwidth = 10, barheight = 1.5))

g


###################################################
### code chunk number 8: genphenManual.Rnw:415-416
###################################################
g


###################################################
### code chunk number 9: genphenManual.Rnw:423-443
###################################################
# Description:
# Rounds digits to 2-decimal points, and concatinates the lower and upper
# limits of the HDI to have a simpler visualization
getHdiPretty <- function(x, digits = 2) {
  x[1] <- round(x = x[1], digits = digits)
  x[2] <- round(x = x[2], digits = digits)
  return(paste("(", x[1], ", ", x[2], ")", sep = ''))
}
c.score$beta.hdi <- apply(X = c.score[, c("beta.hdi.low", "beta.hdi.high")],
                          MARGIN = 1, getHdiPretty, digits = 2)
c.score$ca.hdi <- apply(X = c.score[, c("ca.hdi.low", "ca.hdi.high")],
                        MARGIN = 1, getHdiPretty, digits = 2)
c.score$kappa.hdi <- apply(X = c.score[, c("kappa.hdi.low", "kappa.hdi.high")],
                           MARGIN = 1, getHdiPretty, digits = 2)

# Print table
print(xtable(c.score[, c("label", "beta.mean", "beta.hdi", "ca.mean",
                         "ca.hdi", "kappa.mean", "kappa.hdi"), ],
             align = rep(x = "c", times = 8, digits = 2)),
      include.rownames = FALSE, size = "scriptsize")


###################################################
### code chunk number 10: genphenManual.Rnw:448-452
###################################################
print(xtable(c.score[, c("label", "beta.mean", "beta.hdi", "ca.mean",
                         "ca.hdi", "kappa.mean", "kappa.hdi"), ],
             align = rep(x = "c", times = 8, digits = 2)),
      include.rownames = FALSE, size = "scriptsize")


###################################################
### code chunk number 11: genphenManual.Rnw:467-471
###################################################
rstan::check_hmc_diagnostics(c.out$complete.posterior)
rstan::stan_rhat(c.out$complete.posterior)
rstan::stan_ess(c.out$complete.posterior)
rstan::stan_diag(c.out$complete.posterior)


###################################################
### code chunk number 12: genphenManual.Rnw:483-503
###################################################
# Compute the phylogenetic bias
bias <- runPhyloBiasCheck(genotype = genotype.saap,
                          input.kinship.matrix = NULL)

# Extract kinship matrix
kinship.matrix <- bias$kinship.matrix

# Extract the bias associated with mutations of the sites which 
# were included in the association analysis
mutation.bias <- bias$bias

# To make site id concordant with data
mutation.bias$site <- mutation.bias$site - 81
mutation.bias <- merge(x = c.score, y = mutation.bias,
                       by = c("site", "ref", "alt"))

# Show the bias table
print(xtable(mutation.bias[, c("site", "ref", "alt", "bias.ref", "bias.alt")],
             align = rep(x = "c", times = 6, digits = 2)),
      include.rownames = FALSE, size = "small")


###################################################
### code chunk number 13: genphenManual.Rnw:508-511
###################################################
print(xtable(mutation.bias[, c("site", "ref", "alt", "bias.ref", "bias.alt")],
             align = rep(x = "c", times = 6, digits = 2)),
      include.rownames = FALSE, size = "scriptsize")


###################################################
### code chunk number 14: genphenManual.Rnw:522-539
###################################################
color.a <- character(length = nrow(genotype.saap))
color.a[1:length(color.a)] <- "gray"
color.a[which(genotype.saap[, 82] == "h")] <- "orange"
color.a[which(genotype.saap[, 82] == "q")] <- "blue"

color.b <- character(length = nrow(genotype.saap))
color.b[1:length(color.b)] <- "gray"
color.b[which(genotype.saap[, 84] == "a")] <- "orange"
color.b[which(genotype.saap[, 84] == "d")] <- "blue"

c.hclust <- hclust(as.dist(kinship.matrix), method = "average")

par(mfrow = c(1, 2), mar = c(0,0,1,0) + 0.1)
plot(as.phylo(c.hclust), tip.color = color.a, cex = 0.6, 
     type = "fan", main = "B = 0.15")
plot(as.phylo(c.hclust), tip.color = color.b, cex = 0.6, 
     type = "fan", main = "B = 0.43")


###################################################
### code chunk number 15: genphenManual.Rnw:547-552
###################################################
par(mfrow = c(1, 2), mar = c(0,0,1,0) + 0.1)
plot(as.phylo(c.hclust), tip.color = color.a, cex = 0.6, 
     type = "fan", main = "B = 0.15")
plot(as.phylo(c.hclust), tip.color = color.b, cex = 0.6, 
     type = "fan", main = "B = 0.43")


###################################################
### code chunk number 16: genphenManual.Rnw:567-593
###################################################
# simulate genotype
genotype <- rep(x = c("A", "C", "T", "G"), each = 10)

# simulate quantitative and dichotomous phenotypes
phenotype.Q <- c(rnorm(n = 10, mean = 0, sd = 1),
                 rnorm(n = 10, mean = 0.5, sd = 1),
                 rnorm(n = 10, mean = -0.5, sd = 1),
                 rnorm(n = 10, mean = 2, sd = 1))
phenotype.D <- c(rbinom(n = 10, size = 1, prob = 0.3),
                 rbinom(n = 10, size = 1, prob = 0.5),
                 rbinom(n = 10, size = 1, prob = 0.6),
                 rbinom(n = 10, size = 1, prob = 0.7))
phenotype <- cbind(phenotype.Q, phenotype.D)
rm(phenotype.Q, phenotype.D)

out <- runGenphen(genotype = genotype,
                  phenotype = phenotype,
                  phenotype.type = c("Q", "D"),
                  model.type = "hierarchical",
                  mcmc.chains = 4,
                  mcmc.steps = 2500,
                  mcmc.warmup = 500,
                  cores = 2,
                  hdi.level = 0.95,
                  stat.learn.method = "svm",
                  cv.steps = 500)


###################################################
### code chunk number 17: genphenManual.Rnw:598-604
###################################################
# Format the genotype-phenotype data, such that it can then
# be visualized with ggplot
df <- data.frame(genotype = genotype, 
                 phenotype.Q = phenotype[, 1], 
                 phenotype.D = phenotype[, 2],
                 stringsAsFactors = FALSE)


###################################################
### code chunk number 18: genphenManual.Rnw:608-631
###################################################
# Visualization
g1 <- ggplot(data = df)+
  geom_point(aes(x = genotype, y = phenotype.Q, col = genotype), size = 1,
             shape = 21, position = position_jitterdodge(jitter.width = 0.2,
                                                         jitter.height = 0,
                                                         dodge.width = 0.5))+
  xlab(label = "Genotypes")+
  ylab(label = "Phenotype (Q)")+
  theme_bw(base_size = 14)+
  theme(legend.position = "none")

g2 <- ggplot(data = df)+
  geom_point(aes(x = genotype, y = phenotype.D, col = genotype), size = 1,
             shape = 21, position = position_jitterdodge(jitter.width = 0.2,
                                                         jitter.height = 0.05,
                                                         dodge.width = 0.5))+
  xlab(label = "Genotypes")+
  scale_y_continuous(name = "Phenotype (D)", 
                     breaks = c(0, 1), labels = c(0, 1))+
  theme_bw(base_size = 14)+
  theme(legend.position = "none")

gridExtra::grid.arrange(g1, g2, ncol = 2)


###################################################
### code chunk number 19: genphenManual.Rnw:637-638
###################################################
gridExtra::grid.arrange(g1, g2, ncol = 2)


###################################################
### code chunk number 20: genphenManual.Rnw:668-681
###################################################
# run genphen
m.out <- genphen::runGenphen(genotype = genotype,
                             phenotype = phenotype,
                             phenotype.type = c("Q", "D"),
                             model.type = "univariate",
                             mcmc.chains = 4,
                             mcmc.steps = 1500,
                             mcmc.warmup = 500,
                             cores = 2,
                             hdi.level = 0.95,
                             stat.learn.method = "svm",
                             cv.steps = 500,
                             cv.fold = 0.8)


###################################################
### code chunk number 21: genphenManual.Rnw:692-733
###################################################
# Get the scores data
m.score <- m.out$scores

# Some optional formatting for the SNPs 
# (label = site : genotype1 -> genotype2)
m.score$label <- paste(m.score$site, ":", m.score$ref,
                       "->", m.score$alt, sep = '')


# Visualization
g1 <- ggplot(data = m.score[m.score$phenotype.id == 1, ])+
  geom_errorbar(aes(x = ca.mean, ymin = beta.hdi.low, ymax = beta.hdi.high),
                width = 0.015, col = "darkgray")+
  geom_point(aes(x = ca.mean, y = beta.mean, fill = kappa.mean), 
             shape = 21, size = 4)+
  geom_text_repel(aes(x = ca.mean, y = beta.mean, label = label), size = 5)+
  theme_bw(base_size = 14)+
  ylab(label = "Effect size (with 95% HDI)")+
  scale_x_continuous(name = "CA", limits = c(0, 1.05))+
  geom_hline(yintercept = 0, linetype = "dashed")+
  theme(legend.position = "top")+
  scale_fill_distiller(palette = "Spectral", limits = c(-0.2, 1))+
  guides(fill = guide_colorbar(barwidth = 10, barheight = 1.5))+
  ggtitle(label = "Phenotype Q")

g2 <- ggplot(data = m.score[m.score$phenotype.id == 2, ])+
  geom_errorbar(aes(x = ca.mean, ymin = beta.hdi.low, ymax = beta.hdi.high),
                width = 0.015, col = "darkgray")+
  geom_point(aes(x = ca.mean, y = beta.mean, fill = kappa.mean), 
             shape = 21, size = 4)+
  geom_text_repel(aes(x = ca.mean, y = beta.mean, label = label), size = 5)+
  theme_bw(base_size = 14)+
  ylab(label = "Effect size (with 95% HDI)")+
  scale_x_continuous(name = "CA", limits = c(0, 1.05))+
  geom_hline(yintercept = 0, linetype = "dashed")+
  theme(legend.position = "top")+
  scale_fill_distiller(palette = "Spectral", limits = c(-0.2, 1))+
  guides(fill = guide_colorbar(barwidth = 10, barheight = 1.5))+
  ggtitle(label = "Phenotype D")

grid.arrange(g1, g2, ncol = 2)


###################################################
### code chunk number 22: genphenManual.Rnw:740-741
###################################################
grid.arrange(g1, g2, ncol = 2)


###################################################
### code chunk number 23: genphenManual.Rnw:778-784
###################################################
# Simulate 50,000 SNPs and 60 phenotypes
set.seed(seed = 551155)
g1 <- replicate(n=5*10^4, expr=as.character(rbinom(n=30, size = 1,prob = 0.49)))
g2 <- replicate(n=5*10^4, expr=as.character(rbinom(n=30, size = 1,prob = 0.51)))
gen <- rbind(g1, g2)
phen <- c(rnorm(n = 30, mean = 3, sd = 3), rnorm(n = 30, mean = 5, sd = 3))


###################################################
### code chunk number 24: genphenManual.Rnw:789-794
###################################################
# Run diagnostics
diag <- genphen::runDiagnostics(genotype = gen,
                                phenotype = phen,
                                phenotype.type = "Q",
                                rf.trees = 50000)


###################################################
### code chunk number 25: genphenManual.Rnw:803-811
###################################################
# Visualization
g <- ggplot(data = diag)+
  geom_density(aes(importance))+
  xlab("Importance")+
  theme_bw(base_size = 14)+
  scale_x_continuous(trans = "log10")+
  annotation_logticks(base = 10, sides = "b")
g


###################################################
### code chunk number 26: genphenManual.Rnw:817-818
###################################################
g


