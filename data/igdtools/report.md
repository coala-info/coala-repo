# igdtools CWL Generation Report

## igdtools

### Tool Description
Process or create IGD files.

### Metadata
- **Docker Image**: quay.io/biocontainers/igdtools:2.6--py312h5e9d817_0
- **Homepage**: https://aprilweilab.github.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/igdtools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/igdtools/overview
- **Total Downloads**: 2.6K
- **Last updated**: 2025-11-25
- **GitHub**: https://github.com/aprilweilab/picovcf
- **Stars**: N/A
### Original Help Text
```text
Flag could not be matched: h
  /usr/local/lib/python3.12/site-packages/igdtools/igdtools {OPTIONS}
    [input_file]

    Process or create IGD files.

  OPTIONS:

      -h, --help                        Display this help menu
      input_file                        The input file (.vcf, .vcf.gz, or .igd)
      -o[output], --out=[output]        The output file to produce.
      --description=[outputDescription] The description string to include in the
                                        IGD output.
      --merge=[mergeWith...]            Merge the input IGD file with all of
                                        these specified IGD files.
      -r[range], --range=[range]        Restrict to the given base-pair range
                                        (inclusive).
      -f[frange], --frange=[frange]     Restrict to variants with frequency in
                                        the range (inclusive, exclusive).
      -i, --info                        Display information from the IGD header.
      --individuals                     Emit the mapping from individual index
                                        to ID.
      --variants                        Emit the mapping from variant index to
                                        ID.
      -s, --stats                       Emit some simple statistics about the
                                        distribution of samples, sites, and
                                        variants.
      -a, --alleles                     Emit allele frequencies.
      --lists                           Emit sample lists.
      --no-var-ids                      Do not emit IDs for variants in the
                                        resulting IGD file.
      --trim=[trimSamples]              Trim samples to this many individuals.
      -S[keepSamples],
      --samples=[keepSamples]           Keep samples listed in the given text
                                        file.
      --force-unphased                  Force output file to be unphased,
                                        regardless of input.
      --drop-multi-sites                Drop multi-allelic sites (more than one
                                        alternate allele).
      --drop-non-snvs                   Drop variants containing alleles that
                                        are not single nucleotides.
      --drop-non-snv-sites              Drop sites containing alleles that are
                                        not single nucleotides.
      --drop-unphased                   Drop sites containing unphased data.
      -e[exportMetadata],
      --export-metadata=[exportMetadata]
                                        Export the metadata from the given
                                        .vcf[.gz] file to the given filename.
                                        The output format is a text file in the
                                        format that can be loaded via
                                        numpy.loadtxt(), where the first line is
                                        a comment containing information about
                                        the metadata. This option takes a list
                                        of metadata to export, which can be:
                                        all, chrom, qual, filter, info
      -p[forceToPloidy],
      --force-ploidy=[forceToPloidy]    IGD files have a single ploidy, but you
                                        can use this to force all
                                        variants/individuals to have the same
                                        ploidy.
      --update-indiv-ids=[update-indiv-ids]
                                        Given a text file with an individual ID
                                        per line, set the IDs in the output IGD
                                        file to match them
      --contig-require-one              Require the input VCF to contain a
                                        single contig, or fail the conversion.
      --contig-use-first                Only convert the first contig
                                        encountered in the input VCF.
      --contig=[contig]                 Only convert the contig with the given
                                        name from the input VCF.
      -j[jobs], --jobs=[jobs]           How many jobs (threads) to use. Only
                                        VCF->IGD conversion supports this
                                        currently
      "--" can be used to terminate flag options and force all following
      arguments to be treated as positional options
```


## Metadata
- **Skill**: generated
