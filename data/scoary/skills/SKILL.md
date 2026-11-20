---
name: scoary
description: Scoary performs microbial pan-genome wide association studies by calculating the statistical association between gene presence/absence and binary phenotypic traits. Use when user asks to identify genes associated with a specific phenotype, perform a pan-genome wide association study, or convert VCF files into a format suitable for association analysis. Also use after any gene-by-gene association screen to tell causal determinants from passenger (hitchhiking) genes and from permissive background loci, with a conditional search that tests gene-gene interactions (epistasis).
homepage: https://github.com/AdmiralenOla/Scoary
metadata:
  docker_image: "biocontainers/scoary:v1.6.16-1-deb_cv1"
---

# scoary

## Overview
Scoary is a specialized tool for microbial pan-genome wide association studies. It bridges the gap between pan-genome pipelines (like Roary or LS-BSR) and phenotypic data. By taking a gene presence/absence matrix and a binary trait file, Scoary calculates the statistical strength of association for every gene in the accessory genome, providing a ranked list of candidate genes based on p-values and sensitivity/specificity metrics.

## Core Command Line Usage

The primary command requires a genotype file (gene presence/absence) and a phenotypic trait file.

```bash
# Basic association analysis
scoary -g gene_presence_absence.csv -t traits.csv
```

### Working with Variants (VCF)
If you are working with SNPs, indels, or structural variants instead of gene presence/absence, use the `vcf2scoary` utility to convert your data into the required format.

```bash
# Convert VCF to Scoary format
vcf2scoary myvariants.vcf

# Extract specific variant types during conversion
vcf2scoary --types snp,mnp,complex myvariants.vcf
```

## Input Requirements

### Genotype File (`-g`)
- Typically the `gene_presence_absence.csv` output from Roary.
- Can also be converted from LS-BSR or VCF files.

### Traits File (`-t`)
- **Format**: CSV file where rows are isolates and columns are traits.
- **Values**: Must be dichotomized (binary). Use `1` for presence/positive and `0` for absence/negative.
- **Isolate Names**: Must match the names used in the genotype file exactly.
- **Header**: The top-left cell (A1) should be left blank.
- **Missing Data**: Represent missing phenotypic measurements as `NA`, `.`, or `-`. Scoary will exclude these isolates from the specific trait analysis.

## Expert Tips and Best Practices

- **Delimiter Consistency**: Ensure the `traits.csv` uses the same delimiter as the `gene_presence_absence.csv` (default is a comma).
- **Naming Conventions**: Avoid using special characters (e.g., `%;,/&[]@?`) in isolate or trait names, as these can cause parsing errors.
- **Performance**: While a GUI (`scoary_GUI`) is available, the CLI version is significantly faster, especially when performing many permutations or handling large datasets.
- **VCF Allele Handling**: When using `vcf2scoary` on sites with more than two alleles, the tool compares each non-reference allele against the reference. It does not test every possible contrast between non-reference alleles (e.g., it tests Ref vs. Alt1 and Ref vs. Alt2, but not Alt1 vs. Alt2).
- **Output Interpretation**: Scoary generates one CSV file per trait. Focus on the `Corrected_P` or `Empirical_P` values rather than the naive p-value to account for multiple testing and population structure.

## After the screen: determinants, passengers and background loci
Scoary tests one gene at a time. A test of one gene at a time cannot tell three kinds of
associated gene apart:
- a determinant, which causes the trait;
- a passenger, which is carried with a determinant (same plasmid or lineage) and has no effect
  of its own;
- a permissive background locus, which does nothing alone and lets other genes act. It may gate
  all determinants of a trait or only some of them, so it can look like one more strong gene.

Marginal association, L1 logistic regression and random-forest importance all rank passengers
and the background locus among the top genes. Decide with conditional tests instead. Run this
whole block once per trait (`G` is isolates x genes, 0/1; `y` is 0/1):

```python
import numpy as np

def fit_logit(Z, y, ridge=1e-2):
    b = np.zeros(Z.shape[1])
    for _ in range(50):
        mu = 1 / (1 + np.exp(-np.clip(Z @ b, -30, 30)))
        W = np.clip(mu * (1 - mu), 1e-6, None)
        step = np.linalg.solve(Z.T @ (Z * W[:, None]) + ridge * np.eye(Z.shape[1]),
                               Z.T @ (y - mu) - ridge * b)
        b += step
        if np.abs(step).max() < 1e-7:
            break
    mu = 1 / (1 + np.exp(-np.clip(Z @ b, -30, 30)))
    return mu, np.sum(y * np.log(mu + 1e-12) + (1 - y) * np.log(1 - mu + 1e-12))

def score(X, y, mu, Z):                      # 1-df score test for adding each column of X to model Z
    W = np.clip(mu * (1 - mu), 1e-6, None)
    B = Z.T @ (X * W[:, None])
    A = Z.T @ (Z * W[:, None]) + 1e-8 * np.eye(Z.shape[1])
    V = ((X ** 2) * W[:, None]).sum(0) - (B * np.linalg.solve(A, B)).sum(0)
    return np.where(V > 1e-8, (X.T @ (y - mu)) ** 2 / np.maximum(V, 1e-8), 0.0)

def conditional_search(G, y, shortlist=40, max_terms=30):
    """Forward selection of main effects and pairwise products. A passenger adds nothing once
    its determinant is in the model, so it is never selected."""
    G, y = G.astype(float), y.astype(float)
    n, p = G.shape
    cut = 2 * np.log(p * shortlist + p) + 10             # bound for all the terms tried
    terms, Z = [], np.ones((n, 1))
    mu, _ = fit_logit(Z, y)
    short = list(np.argsort(-score(G, y, mu, Z))[:shortlist])
    while len(terms) < max_terms:
        s = score(G, y, mu, Z)
        s[[t[0] for t in terms if len(t) == 1]] = 0
        best = (s.max(), (int(s.argmax()),))
        for a in short:                                  # products of a shortlisted gene with every gene
            s = score(G * G[:, [a]], y, mu, Z)
            s[a] = 0
            for t in terms:
                if len(t) == 2 and a in t:
                    s[t[0] if t[1] == a else t[1]] = 0
            if s.max() > best[0] * 1.02:
                best = (s.max(), tuple(sorted((int(a), int(s.argmax())))))
        if best[0] < cut:
            break
        t = best[1]
        terms.append(t)
        Z = np.column_stack([Z, G[:, t[0]] if len(t) == 1 else G[:, t[0]] * G[:, t[1]]])
        mu, _ = fit_logit(Z, y)
        short += [g for g in t if g not in short]
    return terms

def roles(G, y, terms, min_carriers=30):
    """`d needs h`: d has an effect among isolates with h and none among isolates without h.
    A background locus is needed by others and does nothing where those others are absent."""
    G, y = G.astype(float), y.astype(float)
    genes = sorted({g for t in terms for g in t})
    cut = 2 * np.log(len(genes) ** 2) + 6

    def effect(d, rows, others):
        k = G[rows, d].sum()
        if rows.sum() < 50 or k < min_carriers or rows.sum() - k < min_carriers:
            return None
        Z = np.column_stack([np.ones(rows.sum())] + [G[rows, o] for o in others])
        Z = Z[:, np.r_[True, Z[:, 1:].std(0) > 0]]
        mu, _ = fit_logit(Z, y[rows])
        return float(score(G[rows][:, [d]], y[rows], mu, Z)[0])

    needs = {}
    for h in genes:
        for d in genes:
            if d != h:
                others = [o for o in genes if o not in (d, h)]
                on, off = effect(d, G[:, h] == 1, others), effect(d, G[:, h] == 0, others)
                if on is not None and off is not None and on > cut and off < cut:
                    needs.setdefault(h, []).append(d)
    background = []
    for h, deps in needs.items():
        alone = effect(h, G[:, deps].sum(1) == 0, [o for o in genes if o != h and o not in deps])
        if (alone is None or alone < cut) and not any(h in v for k, v in needs.items() if k != h):
            background.append(h)
    dets = [g for g in genes if g not in background]
    gate = {d: [h for h in background if d in needs[h]] for d in dets}
    Z = np.column_stack([np.ones(len(y))] + [G[:, d] * np.prod(G[:, gate[d]], axis=1) for d in dets])
    ll = fit_logit(Z, y)[1]
    importance = {d: ll - fit_logit(np.delete(Z, k + 1, axis=1), y)[1] for k, d in enumerate(dets)}
    return sorted(dets, key=lambda d: -importance[d]), background, gate, importance

terms = conditional_search(G, y)
dets, background, gate, importance = roles(G, y, terms)
for d in dets:
    print(d, round(importance[d], 1), "needs", gate[d])
print("background loci:", background)
```
- Rank the determinants by `importance`, the log-likelihood lost when one leaves the model. Put
  background loci and every gene the search did not select below all determinants.
- Use the result as it comes. Do not move a gene by eye because its marginal association is
  strong or weak; that is the error this step removes.
- Do not drop a gene because it also associates with another trait, for example resistance to
  another drug. A gene can be a determinant of both. Judge it by its conditional effect on this
  trait.
- Run each trait on its own. A gene can be a determinant of one trait and a passenger or a
  background locus of another.
- A background locus that gates only some determinants shows no drop of the trait to zero among
  isolates without it. Only the per-pair test (`needs`) finds it.
- Cost grows with isolates x genes x `shortlist`. If it is slow, lower `shortlist` first.

## Reference documentation
- [Scoary GitHub Repository](./references/github_com_AdmiralenOla_Scoary.md)
- [Scoary Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_scoary_overview.md)