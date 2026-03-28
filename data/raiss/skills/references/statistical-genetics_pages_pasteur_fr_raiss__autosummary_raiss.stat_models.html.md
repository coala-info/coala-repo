[RAISS](../index.html)

* [raiss.imputation\_launcher](raiss.imputation_launcher.html)
* [raiss.ld\_matrix](raiss.ld_matrix.html)
* raiss.stat\_models
* [raiss.windows](raiss.windows.html)
* [raiss.filter\_format\_output](raiss.filter_format_output.html)
* [raiss.imputation\_R2](raiss.imputation_R2.html)

[RAISS](../index.html)

* raiss.stat\_models
* [View page source](../_sources/_autosummary/raiss.stat_models.rst.txt)

---

# raiss.stat\_models[](#module-raiss.stat_models "Link to this heading")

This module contain the statistical library for imputation.

Notation style of matrices subset and vectors are based on the publication:

Bogdan Pasaniuc, Noah Zaitlen, Huwenbo Shi, Gaurav Bhatia, Alexander Gusev,
Joseph Pickrell, Joel Hirschhorn, David P. Strachan, Nick Patterson,
Alkes L. Price;
Fast and accurate imputation of summary statistics enhances evidence
of functional enrichment, Bioinformatics, Volume 30, Issue 20, 15 October 2014,
Pages 2906–2914

Functions

|  |  |
| --- | --- |
| `check_inversion`(sig\_t, sig\_t\_inv) |  |
| `compute_mu`(sig\_i\_t, sig\_t\_inv, zt) | Compute the estimation of z-score from neighborring snp |
| `compute_var`(sig\_i\_t, sig\_t\_inv, lamb[, batch]) | Compute the expected variance of the imputed SNPs :param sig\_i\_t: correlation matrix with line corresponding to :type sig\_i\_t: matrix? :param unknown Snp: :type unknown Snp: snp to impute :param sig\_t\_inv: inverse of the correlation matrix of known :type sig\_t\_inv: np.ndarray :param matrix: :param lamb: regularization term added to matrix :type lamb: float |
| `invert_sig_t`(sig\_t, lamb, rtol) |  |
| `raiss_model`(zt, sig\_t, sig\_i\_t[, lamb, ...]) | Compute the variance :param zt: the vector of known Z scores :type zt: np.array :param sig\_t: the matrix of known Linkage desiquilibrium correlation :type sig\_t: np.ndarray :param sig\_i\_t: correlation matrix of known matrix :type sig\_i\_t: np.ndarray :param lamb: regularization term added to the diagonal of the sig\_t matrix :type lamb: float :param rtol: threshold to filter eigenvector with a eigenvalue under rtol :type rtol: float :param make inversion biased but much more numerically robust: |
| `var_in_boundaries`(var, lamb) | Forces the variance to be in the 0 to 1+lambda boundary theoritically we shouldn't have to do that |

[Previous](raiss.ld_matrix.html "raiss.ld_matrix")
[Next](raiss.windows.html "raiss.windows")

---

© Copyright 2018, hjulienne.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).