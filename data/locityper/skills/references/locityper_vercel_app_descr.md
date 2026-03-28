[Locityper](/)[AboutAbout](/about)[GitHubGitHub (opens in a new tab)](https://github.com/tprodanov/locityper)

* [Introduction](/)
* [Installation](/install)
* [Test dataset](/test_dataset)
* [Commands](/commands)
* [Input/Output](/input_output)
* [Method description](/descr)
* [Avalable data](/available_data)

Light

[Report bug/Ask question (opens in a new tab)](https://github.com/tprodanov/locityper/issues)Scroll to top

Method description

![Model diagram](/_next/image?url=%2F_next%2Fstatic%2Fmedia%2Fmodel.951b5da0.png&w=3840&q=75)

Locityper starts with a collection of known locus haplotypes (alleles), and a given WGS dataset.
It then evaluates all haplotype pairs (genotypes), and searches for the most likely one.
Optimal genotype is selected based on three factors:

* Minimal number of sequencing errors,
* Optimal insert sizes (for paired-end data),
* Optimal read depth profile: no dips and excesses of read coverage.

You can find more details in our [preprint (opens in a new tab)](https://doi.org/10.1101/2024.05.03.592358).

[Input/Output](/input_output "Input/Output")[Avalable data](/available_data "Avalable data")

Light

---

[Timofey Prodanov. Locityper documentation (2024).](https://github.com/tprodanov/locityper-docs)

[Created using the Nextra theme.](https://nextra.site)