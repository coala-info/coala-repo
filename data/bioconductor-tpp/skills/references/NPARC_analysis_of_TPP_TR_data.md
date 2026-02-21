Analyzing Thermal Proteome Profiling ex-
periments by NPARC (Non-Parametric Anal-
ysis of Response Curves)

Dorothee Childs, Nils Kurzawa

European Molecular Biology Laboratory (EMBL),
Heidelberg, Germany
dorothee.childs@embl.de

TPP version 3.38.0

Abstract

This document demonstrates how to analyze TPP-TR (temperature range) experiments by
the NPARC approach [1]. NPARC is a recent extension to the TPP package.
It offers a
novel methodology to model the temperature dependent melting behaviour of each protein,
and to detect significant changes in this behavior due to changes in experimental conditions
like drug treatment [2].

The melting curve of each protein is represented by sigmoid functions or natural splines,
either once for all conditions (null model), or separately for different experimental conditions
(alternative model). Condition specific effects are then detected by testing for significant
improvements in goodnes-of-fit of the alternative model relative to the null model.

Contents

1

Using NPARC .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

1

1

Using NPARC

The integration of NPARC into the TPP is currently ongoing (you can find the GitHub
repository here). If you want to try it in the mean time please refer to this workflow.

References

[1] Dorothee Childs, Karsten Bach, Holger Franken, Simon Anders, Nils Kurzawa, Marcus
Bantscheff, Mikhail M. Savitski, and Wolfgang Huber. Non-parametric analysis of
thermal proteome profiles reveals novel drug-binding proteins. Molecular and Cellular
Proteomics, 2019. doi:https://doi.org/10.1074/mcp.TIR119.001481.

[2] Mikhail M Savitski, Friedrich BM Reinhard, Holger Franken, Thilo Werner, Maria Fälth

Savitski, Dirk Eberhard, Daniel Martinez Molina, Rozbeh Jafari, Rebecca Bakszt
Dovega, Susan Klaeger, et al. Tracking cancer drugs in living cells by thermal profiling
of the proteome. Science, 346(6205):1255784, 2014.

2

