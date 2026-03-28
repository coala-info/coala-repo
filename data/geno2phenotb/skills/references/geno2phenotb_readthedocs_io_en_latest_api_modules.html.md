latest

* [Overview](../readme.html)
* [Installation](../installation.html)
* [Command Line Interface](../cli.html)
* Python Interface
  + [geno2phenotb package](geno2phenotb.html)
* [Contributing & Help](../contributing.html)
* [Acknowledgments](../acknowledgments.html)
* [Authors](../authors.html)
* [Release Notes](../changelog.html)
* [License](../license.html)
* [References](../references.html)

[geno2phenoTB](../index.html)

* geno2phenotb
* [Edit on GitHub](https://github.com/msmdev/geno2phenoTB/blob/main/docs/api/modules.rst)

---

# geno2phenotb[](#geno2phenotb "Permalink to this heading")

* [geno2phenotb package](geno2phenotb.html)
  + [Submodules](geno2phenotb.html#submodules)
  + [geno2phenotb.annotate\_vcf module](geno2phenotb.html#module-geno2phenotb.annotate_vcf)
    - [`annotate_vcf()`](geno2phenotb.html#geno2phenotb.annotate_vcf.annotate_vcf)
  + [geno2phenotb.geno2phenotb module](geno2phenotb.html#module-geno2phenotb.geno2phenotb)
    - [`main()`](geno2phenotb.html#geno2phenotb.geno2phenotb.main)
    - [`run()`](geno2phenotb.html#geno2phenotb.geno2phenotb.run)
    - [`setup_logging()`](geno2phenotb.html#geno2phenotb.geno2phenotb.setup_logging)
  + [geno2phenotb.installation\_test module](geno2phenotb.html#module-geno2phenotb.installation_test)
    - [`check_sha256()`](geno2phenotb.html#geno2phenotb.installation_test.check_sha256)
    - [`download_file()`](geno2phenotb.html#geno2phenotb.installation_test.download_file)
    - [`download_test_files()`](geno2phenotb.html#geno2phenotb.installation_test.download_test_files)
    - [`self_test()`](geno2phenotb.html#geno2phenotb.installation_test.self_test)
  + [geno2phenotb.parse\_args module](geno2phenotb.html#module-geno2phenotb.parse_args)
    - [`parse_args()`](geno2phenotb.html#geno2phenotb.parse_args.parse_args)
  + [geno2phenotb.predict module](geno2phenotb.html#module-geno2phenotb.predict)
    - [`adjusted_classes()`](geno2phenotb.html#geno2phenotb.predict.adjusted_classes)
    - [`predict()`](geno2phenotb.html#geno2phenotb.predict.predict)
    - [`single_prediction()`](geno2phenotb.html#geno2phenotb.predict.single_prediction)
  + [geno2phenotb.preprocess module](geno2phenotb.html#module-geno2phenotb.preprocess)
    - [`collect_lineages()`](geno2phenotb.html#geno2phenotb.preprocess.collect_lineages)
    - [`determine_genotype()`](geno2phenotb.html#geno2phenotb.preprocess.determine_genotype)
    - [`preprocess()`](geno2phenotb.html#geno2phenotb.preprocess.preprocess)
    - [`run_mtbseq()`](geno2phenotb.html#geno2phenotb.preprocess.run_mtbseq)
  + [geno2phenotb.utils module](geno2phenotb.html#module-geno2phenotb.utils)
    - [`check_fastq_filenames()`](geno2phenotb.html#geno2phenotb.utils.check_fastq_filenames)
    - [`check_output()`](geno2phenotb.html#geno2phenotb.utils.check_output)
    - [`get_amino_ann()`](geno2phenotb.html#geno2phenotb.utils.get_amino_ann)
    - [`get_aminos()`](geno2phenotb.html#geno2phenotb.utils.get_aminos)
    - [`get_drugs()`](geno2phenotb.html#geno2phenotb.utils.get_drugs)
    - [`get_key_genes()`](geno2phenotb.html#geno2phenotb.utils.get_key_genes)
    - [`get_lineages()`](geno2phenotb.html#geno2phenotb.utils.get_lineages)
    - [`get_rules()`](geno2phenotb.html#geno2phenotb.utils.get_rules)
    - [`get_static_dir()`](geno2phenotb.html#geno2phenotb.utils.get_static_dir)
    - [`stripper()`](geno2phenotb.html#geno2phenotb.utils.stripper)
  + [geno2phenotb.vcf\_columns\_extractor module](geno2phenotb.html#module-geno2phenotb.vcf_columns_extractor)
    - [`vcf_columns_extractor()`](geno2phenotb.html#geno2phenotb.vcf_columns_extractor.vcf_columns_extractor)
  + [geno2phenotb.vcf\_columns\_extractor\_geno module](geno2phenotb.html#module-geno2phenotb.vcf_columns_extractor_geno)
    - [`vcf_columns_extractor_geno()`](geno2phenotb.html#geno2phenotb.vcf_columns_extractor_geno.vcf_columns_extractor_geno)
  + [Module contents](geno2phenotb.html#module-geno2phenotb)

[Previous](../cli.html "Command Line Interface")
[Next](geno2phenotb.html "geno2phenotb package")

---

© Copyright 2023, Bernhard Reuter, Jules Kreuer.
Revision `d0de6e0a`.