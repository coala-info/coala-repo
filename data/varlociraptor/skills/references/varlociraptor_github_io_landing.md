* [Home](https://varlociraptor.github.io/landing/)
* [Documentation](https://varlociraptor.github.io/docs/)
  + [Installation](https://varlociraptor.github.io/docs/installation/)
  + [Calling alterations](https://varlociraptor.github.io/docs/calling/)
  + [Filtering alteration calls](https://varlociraptor.github.io/docs/filtering/)
  + [Estimating properties](https://varlociraptor.github.io/docs/estimating/)
  + [Output format](https://varlociraptor.github.io/docs/output/)
  + [Reporting issues](https://varlociraptor.github.io/docs/reporting-issues/)
  + [Statistical model](https://varlociraptor.github.io/docs/model/)
* [Authors](https://varlociraptor.github.io/authors/)
* [Scenario catalog](https://varlociraptor.github.io/varlociraptor-scenarios)
![](/landing/varlociraptor-logo.svg)

🔎

# Home

![](varlociraptor-logo.svg)

Flexible, arbitrary-scenario, uncertainty-aware variant and methylation calling
 with parameter free filtration via FDR control.

### Key features

* Calls SNVs, MNVs, indels, arbitrary replacements, inversions, duplications, haplotype blocks (combinations of any of the previous), methylation and breakends.
* Supports all length ranges (from small to structural) with a unified statistical model.
* The statistical model entails all possible sources of uncertainty (mapping, typing, heterogeneity) and biases (strand, read pair orientation, read position, sampling, contamination, homologous regions).
* Resulting variant calls can be filtered by false discovery rate. No parameter tuning necessary.
* Each call provides a maximum a posteriori alteration fraction estimate, interpreted as variant allele frequency, allelic fraction, or methylation rate depending on the biological context.

### Calling modes

* Generic, grammar based configuration of the statistical model, allowing to call variants for arbitrary scenarios (including germline, tumor/normal/relapse, pedigrees, FFPE data, and anything else).
* Tumor-normal-calling, classifying variants as somatic in tumor, somatic in normal, germline, or absent.

---

[![Bioconda](https://img.shields.io/conda/dn/bioconda/varlociraptor?label=bioconda%20downloads)](https://bioconda.github.io/recipes/varlociraptor/README.html)
[![Repo](https://img.shields.io/badge/code%20on-github-blue)](https://github.com/varlociraptor/varlociraptor)
[![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/varlociraptor/varlociraptor/rust.yml?branch=master&label=tests)](https://github.com/varlociraptor/varlociraptor/commits/master)
[![License](https://img.shields.io/github/license/varlociraptor/varlociraptor)](https://github.com/varlociraptor/varlociraptor/blob/master/LICENSE)
[![Codecov](https://img.shields.io/codecov/c/github/varlociraptor/varlociraptor/master.svg?label=test%20coverage)](https://codecov.io/gh/varlociraptor/varlociraptor)
[![API docs](https://img.shields.io/badge/API-documentation-blue.svg)](https://docs.rs/varlociraptor)
[![Commitizen friendly](https://img.shields.io/badge/commitizen-friendly-brightgreen.svg)](http://commitizen.github.io/cz-cli/)

[>](https://varlociraptor.github.io/docs/)