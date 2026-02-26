# chromosight CWL Generation Report

## chromosight_detect

### Tool Description
Explore and detect patterns (loops, borders, centromeres, etc.) in Hi-C contact maps with pattern matching.

### Metadata
- **Docker Image**: quay.io/biocontainers/chromosight:1.6.3--pyhdfd78af_0
- **Homepage**: https://github.com/koszullab/chromosight
- **Package**: https://anaconda.org/channels/bioconda/packages/chromosight/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chromosight/overview
- **Total Downloads**: 89.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/koszullab/chromosight
- **Stars**: N/A
### Original Help Text
```text
Pattern exploration and detection

Explore and detect patterns (loops, borders, centromeres, etc.) in Hi-C contact
maps with pattern matching.

Usage:
    chromosight detect  [--kernel-config=FILE] [--pattern=loops]
                        [--pearson=auto] [--win-size=auto] [--iterations=auto]
                        [--win-fmt={json,npy}] [--norm={auto,raw,force}]
                        [--subsample=no] [--inter] [--tsvd] [--smooth-trend]
                        [--n-mads=5] [--min-dist=0] [--max-dist=auto]
                        [--no-plotting] [--min-separation=auto] [--dump=DIR]
                        [--threads=1] [--perc-zero=auto]
                        [--perc-undetected=auto] <contact_map> <prefix>
    chromosight generate-config [--preset loops] [--click contact_map]
                        [--norm={auto,raw,norm}] [--win-size=auto] [--n-mads=5]
                        [--chroms=CHROMS] [--inter] [--threads=1] <prefix>
    chromosight quantify [--inter] [--pattern=loops] [--subsample=no]
                         [--win-fmt=json] [--kernel-config=FILE] [--norm={auto,raw,norm}]
                         [--threads=1] [--n-mads=5] [--win-size=auto]
                         [--perc-undetected=auto] [--perc-zero=auto]
                         [--no-plotting] [--tsvd] <bed2d> <contact_map> <prefix>
    chromosight list-kernels [--long] [--mat] [--name=kernel_name]
    chromosight test

    detect:
        performs pattern detection on a Hi-C contact map via template matching
    generate-config:
        Generate pre-filled config files to use for detect and quantify.
        A config consists of a JSON file describing parameters for the
        analysis and path pointing to kernel matrices files. Those matrices
        files are tsv files with numeric values as kernel to use for
        convolution.
    quantify:
        Given a list of pairs of positions and a contact map, computes the
        correlation coefficients between those positions and the kernel of the
        selected pattern.
    list-kernels:
        Prints information about available kernels.
    test:
        Download example data and run loop detection on it.

Arguments for detect:
    contact_map                 The Hi-C contact map to detect patterns on, in
                                cool format.
    prefix                      Common path prefix used to generate output files.
                                Extensions will be added for each file.

Arguments for quantify:
    bed2d                       Tab-separated text files with columns chrom1, start1
                                end1, chrom2, start2, end2. Each line correspond to
                                a pair of positions (i.e. a position in the matrix).
    contact_map                 Path to the contact map, in cool format.
    prefix                      Common path prefix used to generate output files.
                                Extensions will be added for each file.

Arguments for generate-config:
    prefix                      Path prefix for config files. If prefix is a/b,
                                files a/b.json and a/b.1.txt will be generated.
                                If a given pattern has N kernel matrices, N txt
                                files are created they will be named a/b.[1-N].txt.
    -e, --preset=loops          Generate a preset config for the given pattern.
                                Preset configs available are "loops" and
                                "borders". [default: loops]
    -c, --click=contact_map     Show input contact map and uses double clicks from
                                user to build the kernel. Warning: memory-heavy,
                                reserve for small genomes or subsetted matrices.
    -C, --chroms=CHROMS         Comma-separated list of chromosome names. When used
                                with --click, this will show each chromosome's
                                one-by-one sequentially instead of the whole genome.
                                This is useful to reduce memory usage.

Arguments for list-kernels:
    --name=kernel_name      Only show information related to a particular
                            kernel.[default: all]
    --long                  Show default parameters in addition to kernel names.
    --mat                   Prints an ascii representation of the kernel matrix.

Basic options:
    -h, --help                  Display this help message.
    --version                   Display the program's current version.
    --verbose                   Displays the logo.
    -n, --norm={auto,raw,force} Normalization / balancing behaviour. auto: weights
                                present in the cool file are used. raw: raw contact
                                values are used. force: recompute weights and
                                overwrite existing values. raw[default: auto]
    -I, --inter                 Enable to consider interchromosomal contacts.
                                Warning: Experimental feature with high memory
                                consumption, only use with small matrices.
    -m, --min-dist=auto         Minimum distance from the diagonal (in base pairs).
                                at which detection should operate. [default: auto]
    -M, --max-dist=auto         Maximum distance from the diagonal (in base pairs)
                                for detection. [default: auto]
    -P, --pattern=loops         Which pattern to detect. This will use preset
                                configurations for the given pattern. Possible
                                values are: loops, loops_small, borders, hairpins and
                                centromeres. [default: loops]
    -p, --pearson=auto          Pearson correlation threshold when detecting patterns
                                in the contact map. Lower values leads to potentially
                                more detections, but more false positives. [default: auto]
    -s, --subsample=INT         If greater than 1, subsample INT contacts from the
                                matrix. If between 0 and 1, subsample a proportion of
                                contacts instead. Useful when comparing matrices with
                                different coverages. [default: no]
    -t, --threads=1             Number of CPUs to use in parallel. [default: 1]
    -u, --perc-undetected=auto  Maximum percentage of non-detectable pixels (nan) in
                                windows allowed to report patterns. [default: auto]
    -z, --perc-zero=auto        Maximum percentage of empty (0) pixels in windows
                                allowed to report patterns. [default: auto]

Advanced options:
    -d, --dump=DIR              Directory where to save matrix dumps during
                                processing and detection. Each dump is saved as
                                a compressed npz of a sparse matrix and can be
                                loaded using scipy.sparse.load_npz.
    -i, --iterations=auto       How many iterations to perform after the first
                                template-based pass. [default: 1]
    -k, --kernel-config=FILE    Optionally give a path to a custom JSON kernel
                                config path. Use this to override pattern if
                                you do not want to use one of the preset
                                patterns.
    --no-plotting               Disable generation of pileup plots.
    -N, --n-mads=5              Maximum number of median absolute deviations below
                                the median of the bin sums distribution allowed to
                                consider detectable bins. [default: 5]
    -S, --min-separation=auto   Minimum distance required between patterns, in
                                basepairs. If two patterns are closer than this
                                distance in both axes, the one with the lowest
                                score is discarded. [default: auto]
    -T, --smooth-trend          Use isotonic regression when detrending to reduce
                                noise at long ranges. Do not enable this for circular
                                genomes.
    -V, --tsvd                  Enable kernel factorisation via truncated svd.
                                Accelerates detection, at the cost of slight
                                inaccuracies. Singular matrices are truncated to
                                retain 99.9% of the information in the kernel.
    -w, --win-fmt={json,npy}    File format used to store individual windows
                                around each pattern. Window order matches
                                patterns inside the associated text file.
                                Possible formats are json and npy. [default: json]
    -W, --win-size=auto         Window size (width), in pixels, to use for the
                                kernel when computing correlations. The pattern
                                kernel will be resized to match this size. Linear
                                linear interpolation is used to fill between pixels.
                                If not specified, the default kernel size will
                                be used instead. [default: auto]
```


## chromosight_generate-config

### Tool Description
Explore and detect patterns (loops, borders, centromeres, etc.) in Hi-C contact maps with pattern matching.

### Metadata
- **Docker Image**: quay.io/biocontainers/chromosight:1.6.3--pyhdfd78af_0
- **Homepage**: https://github.com/koszullab/chromosight
- **Package**: https://anaconda.org/channels/bioconda/packages/chromosight/overview
- **Validation**: PASS

### Original Help Text
```text
Pattern exploration and detection

Explore and detect patterns (loops, borders, centromeres, etc.) in Hi-C contact
maps with pattern matching.

Usage:
    chromosight detect  [--kernel-config=FILE] [--pattern=loops]
                        [--pearson=auto] [--win-size=auto] [--iterations=auto]
                        [--win-fmt={json,npy}] [--norm={auto,raw,force}]
                        [--subsample=no] [--inter] [--tsvd] [--smooth-trend]
                        [--n-mads=5] [--min-dist=0] [--max-dist=auto]
                        [--no-plotting] [--min-separation=auto] [--dump=DIR]
                        [--threads=1] [--perc-zero=auto]
                        [--perc-undetected=auto] <contact_map> <prefix>
    chromosight generate-config [--preset loops] [--click contact_map]
                        [--norm={auto,raw,norm}] [--win-size=auto] [--n-mads=5]
                        [--chroms=CHROMS] [--inter] [--threads=1] <prefix>
    chromosight quantify [--inter] [--pattern=loops] [--subsample=no]
                         [--win-fmt=json] [--kernel-config=FILE] [--norm={auto,raw,norm}]
                         [--threads=1] [--n-mads=5] [--win-size=auto]
                         [--perc-undetected=auto] [--perc-zero=auto]
                         [--no-plotting] [--tsvd] <bed2d> <contact_map> <prefix>
    chromosight list-kernels [--long] [--mat] [--name=kernel_name]
    chromosight test

    detect:
        performs pattern detection on a Hi-C contact map via template matching
    generate-config:
        Generate pre-filled config files to use for detect and quantify.
        A config consists of a JSON file describing parameters for the
        analysis and path pointing to kernel matrices files. Those matrices
        files are tsv files with numeric values as kernel to use for
        convolution.
    quantify:
        Given a list of pairs of positions and a contact map, computes the
        correlation coefficients between those positions and the kernel of the
        selected pattern.
    list-kernels:
        Prints information about available kernels.
    test:
        Download example data and run loop detection on it.

Arguments for detect:
    contact_map                 The Hi-C contact map to detect patterns on, in
                                cool format.
    prefix                      Common path prefix used to generate output files.
                                Extensions will be added for each file.

Arguments for quantify:
    bed2d                       Tab-separated text files with columns chrom1, start1
                                end1, chrom2, start2, end2. Each line correspond to
                                a pair of positions (i.e. a position in the matrix).
    contact_map                 Path to the contact map, in cool format.
    prefix                      Common path prefix used to generate output files.
                                Extensions will be added for each file.

Arguments for generate-config:
    prefix                      Path prefix for config files. If prefix is a/b,
                                files a/b.json and a/b.1.txt will be generated.
                                If a given pattern has N kernel matrices, N txt
                                files are created they will be named a/b.[1-N].txt.
    -e, --preset=loops          Generate a preset config for the given pattern.
                                Preset configs available are "loops" and
                                "borders". [default: loops]
    -c, --click=contact_map     Show input contact map and uses double clicks from
                                user to build the kernel. Warning: memory-heavy,
                                reserve for small genomes or subsetted matrices.
    -C, --chroms=CHROMS         Comma-separated list of chromosome names. When used
                                with --click, this will show each chromosome's
                                one-by-one sequentially instead of the whole genome.
                                This is useful to reduce memory usage.

Arguments for list-kernels:
    --name=kernel_name      Only show information related to a particular
                            kernel.[default: all]
    --long                  Show default parameters in addition to kernel names.
    --mat                   Prints an ascii representation of the kernel matrix.

Basic options:
    -h, --help                  Display this help message.
    --version                   Display the program's current version.
    --verbose                   Displays the logo.
    -n, --norm={auto,raw,force} Normalization / balancing behaviour. auto: weights
                                present in the cool file are used. raw: raw contact
                                values are used. force: recompute weights and
                                overwrite existing values. raw[default: auto]
    -I, --inter                 Enable to consider interchromosomal contacts.
                                Warning: Experimental feature with high memory
                                consumption, only use with small matrices.
    -m, --min-dist=auto         Minimum distance from the diagonal (in base pairs).
                                at which detection should operate. [default: auto]
    -M, --max-dist=auto         Maximum distance from the diagonal (in base pairs)
                                for detection. [default: auto]
    -P, --pattern=loops         Which pattern to detect. This will use preset
                                configurations for the given pattern. Possible
                                values are: loops, loops_small, borders, hairpins and
                                centromeres. [default: loops]
    -p, --pearson=auto          Pearson correlation threshold when detecting patterns
                                in the contact map. Lower values leads to potentially
                                more detections, but more false positives. [default: auto]
    -s, --subsample=INT         If greater than 1, subsample INT contacts from the
                                matrix. If between 0 and 1, subsample a proportion of
                                contacts instead. Useful when comparing matrices with
                                different coverages. [default: no]
    -t, --threads=1             Number of CPUs to use in parallel. [default: 1]
    -u, --perc-undetected=auto  Maximum percentage of non-detectable pixels (nan) in
                                windows allowed to report patterns. [default: auto]
    -z, --perc-zero=auto        Maximum percentage of empty (0) pixels in windows
                                allowed to report patterns. [default: auto]

Advanced options:
    -d, --dump=DIR              Directory where to save matrix dumps during
                                processing and detection. Each dump is saved as
                                a compressed npz of a sparse matrix and can be
                                loaded using scipy.sparse.load_npz.
    -i, --iterations=auto       How many iterations to perform after the first
                                template-based pass. [default: 1]
    -k, --kernel-config=FILE    Optionally give a path to a custom JSON kernel
                                config path. Use this to override pattern if
                                you do not want to use one of the preset
                                patterns.
    --no-plotting               Disable generation of pileup plots.
    -N, --n-mads=5              Maximum number of median absolute deviations below
                                the median of the bin sums distribution allowed to
                                consider detectable bins. [default: 5]
    -S, --min-separation=auto   Minimum distance required between patterns, in
                                basepairs. If two patterns are closer than this
                                distance in both axes, the one with the lowest
                                score is discarded. [default: auto]
    -T, --smooth-trend          Use isotonic regression when detrending to reduce
                                noise at long ranges. Do not enable this for circular
                                genomes.
    -V, --tsvd                  Enable kernel factorisation via truncated svd.
                                Accelerates detection, at the cost of slight
                                inaccuracies. Singular matrices are truncated to
                                retain 99.9% of the information in the kernel.
    -w, --win-fmt={json,npy}    File format used to store individual windows
                                around each pattern. Window order matches
                                patterns inside the associated text file.
                                Possible formats are json and npy. [default: json]
    -W, --win-size=auto         Window size (width), in pixels, to use for the
                                kernel when computing correlations. The pattern
                                kernel will be resized to match this size. Linear
                                linear interpolation is used to fill between pixels.
                                If not specified, the default kernel size will
                                be used instead. [default: auto]
```


## chromosight_quantify

### Tool Description
Given a list of pairs of positions and a contact map, computes the correlation coefficients between those positions and the kernel of the selected pattern.

### Metadata
- **Docker Image**: quay.io/biocontainers/chromosight:1.6.3--pyhdfd78af_0
- **Homepage**: https://github.com/koszullab/chromosight
- **Package**: https://anaconda.org/channels/bioconda/packages/chromosight/overview
- **Validation**: PASS

### Original Help Text
```text
Pattern exploration and detection

Explore and detect patterns (loops, borders, centromeres, etc.) in Hi-C contact
maps with pattern matching.

Usage:
    chromosight detect  [--kernel-config=FILE] [--pattern=loops]
                        [--pearson=auto] [--win-size=auto] [--iterations=auto]
                        [--win-fmt={json,npy}] [--norm={auto,raw,force}]
                        [--subsample=no] [--inter] [--tsvd] [--smooth-trend]
                        [--n-mads=5] [--min-dist=0] [--max-dist=auto]
                        [--no-plotting] [--min-separation=auto] [--dump=DIR]
                        [--threads=1] [--perc-zero=auto]
                        [--perc-undetected=auto] <contact_map> <prefix>
    chromosight generate-config [--preset loops] [--click contact_map]
                        [--norm={auto,raw,norm}] [--win-size=auto] [--n-mads=5]
                        [--chroms=CHROMS] [--inter] [--threads=1] <prefix>
    chromosight quantify [--inter] [--pattern=loops] [--subsample=no]
                         [--win-fmt=json] [--kernel-config=FILE] [--norm={auto,raw,norm}]
                         [--threads=1] [--n-mads=5] [--win-size=auto]
                         [--perc-undetected=auto] [--perc-zero=auto]
                         [--no-plotting] [--tsvd] <bed2d> <contact_map> <prefix>
    chromosight list-kernels [--long] [--mat] [--name=kernel_name]
    chromosight test

    detect:
        performs pattern detection on a Hi-C contact map via template matching
    generate-config:
        Generate pre-filled config files to use for detect and quantify.
        A config consists of a JSON file describing parameters for the
        analysis and path pointing to kernel matrices files. Those matrices
        files are tsv files with numeric values as kernel to use for
        convolution.
    quantify:
        Given a list of pairs of positions and a contact map, computes the
        correlation coefficients between those positions and the kernel of the
        selected pattern.
    list-kernels:
        Prints information about available kernels.
    test:
        Download example data and run loop detection on it.

Arguments for detect:
    contact_map                 The Hi-C contact map to detect patterns on, in
                                cool format.
    prefix                      Common path prefix used to generate output files.
                                Extensions will be added for each file.

Arguments for quantify:
    bed2d                       Tab-separated text files with columns chrom1, start1
                                end1, chrom2, start2, end2. Each line correspond to
                                a pair of positions (i.e. a position in the matrix).
    contact_map                 Path to the contact map, in cool format.
    prefix                      Common path prefix used to generate output files.
                                Extensions will be added for each file.

Arguments for generate-config:
    prefix                      Path prefix for config files. If prefix is a/b,
                                files a/b.json and a/b.1.txt will be generated.
                                If a given pattern has N kernel matrices, N txt
                                files are created they will be named a/b.[1-N].txt.
    -e, --preset=loops          Generate a preset config for the given pattern.
                                Preset configs available are "loops" and
                                "borders". [default: loops]
    -c, --click=contact_map     Show input contact map and uses double clicks from
                                user to build the kernel. Warning: memory-heavy,
                                reserve for small genomes or subsetted matrices.
    -C, --chroms=CHROMS         Comma-separated list of chromosome names. When used
                                with --click, this will show each chromosome's
                                one-by-one sequentially instead of the whole genome.
                                This is useful to reduce memory usage.

Arguments for list-kernels:
    --name=kernel_name      Only show information related to a particular
                            kernel.[default: all]
    --long                  Show default parameters in addition to kernel names.
    --mat                   Prints an ascii representation of the kernel matrix.

Basic options:
    -h, --help                  Display this help message.
    --version                   Display the program's current version.
    --verbose                   Displays the logo.
    -n, --norm={auto,raw,force} Normalization / balancing behaviour. auto: weights
                                present in the cool file are used. raw: raw contact
                                values are used. force: recompute weights and
                                overwrite existing values. raw[default: auto]
    -I, --inter                 Enable to consider interchromosomal contacts.
                                Warning: Experimental feature with high memory
                                consumption, only use with small matrices.
    -m, --min-dist=auto         Minimum distance from the diagonal (in base pairs).
                                at which detection should operate. [default: auto]
    -M, --max-dist=auto         Maximum distance from the diagonal (in base pairs)
                                for detection. [default: auto]
    -P, --pattern=loops         Which pattern to detect. This will use preset
                                configurations for the given pattern. Possible
                                values are: loops, loops_small, borders, hairpins and
                                centromeres. [default: loops]
    -p, --pearson=auto          Pearson correlation threshold when detecting patterns
                                in the contact map. Lower values leads to potentially
                                more detections, but more false positives. [default: auto]
    -s, --subsample=INT         If greater than 1, subsample INT contacts from the
                                matrix. If between 0 and 1, subsample a proportion of
                                contacts instead. Useful when comparing matrices with
                                different coverages. [default: no]
    -t, --threads=1             Number of CPUs to use in parallel. [default: 1]
    -u, --perc-undetected=auto  Maximum percentage of non-detectable pixels (nan) in
                                windows allowed to report patterns. [default: auto]
    -z, --perc-zero=auto        Maximum percentage of empty (0) pixels in windows
                                allowed to report patterns. [default: auto]

Advanced options:
    -d, --dump=DIR              Directory where to save matrix dumps during
                                processing and detection. Each dump is saved as
                                a compressed npz of a sparse matrix and can be
                                loaded using scipy.sparse.load_npz.
    -i, --iterations=auto       How many iterations to perform after the first
                                template-based pass. [default: 1]
    -k, --kernel-config=FILE    Optionally give a path to a custom JSON kernel
                                config path. Use this to override pattern if
                                you do not want to use one of the preset
                                patterns.
    --no-plotting               Disable generation of pileup plots.
    -N, --n-mads=5              Maximum number of median absolute deviations below
                                the median of the bin sums distribution allowed to
                                consider detectable bins. [default: 5]
    -S, --min-separation=auto   Minimum distance required between patterns, in
                                basepairs. If two patterns are closer than this
                                distance in both axes, the one with the lowest
                                score is discarded. [default: auto]
    -T, --smooth-trend          Use isotonic regression when detrending to reduce
                                noise at long ranges. Do not enable this for circular
                                genomes.
    -V, --tsvd                  Enable kernel factorisation via truncated svd.
                                Accelerates detection, at the cost of slight
                                inaccuracies. Singular matrices are truncated to
                                retain 99.9% of the information in the kernel.
    -w, --win-fmt={json,npy}    File format used to store individual windows
                                around each pattern. Window order matches
                                patterns inside the associated text file.
                                Possible formats are json and npy. [default: json]
    -W, --win-size=auto         Window size (width), in pixels, to use for the
                                kernel when computing correlations. The pattern
                                kernel will be resized to match this size. Linear
                                linear interpolation is used to fill between pixels.
                                If not specified, the default kernel size will
                                be used instead. [default: auto]
```


## chromosight_list-kernels

### Tool Description
Explore and detect patterns (loops, borders, centromeres, etc.) in Hi-C contact maps with pattern matching.

### Metadata
- **Docker Image**: quay.io/biocontainers/chromosight:1.6.3--pyhdfd78af_0
- **Homepage**: https://github.com/koszullab/chromosight
- **Package**: https://anaconda.org/channels/bioconda/packages/chromosight/overview
- **Validation**: PASS

### Original Help Text
```text
Pattern exploration and detection

Explore and detect patterns (loops, borders, centromeres, etc.) in Hi-C contact
maps with pattern matching.

Usage:
    chromosight detect  [--kernel-config=FILE] [--pattern=loops]
                        [--pearson=auto] [--win-size=auto] [--iterations=auto]
                        [--win-fmt={json,npy}] [--norm={auto,raw,force}]
                        [--subsample=no] [--inter] [--tsvd] [--smooth-trend]
                        [--n-mads=5] [--min-dist=0] [--max-dist=auto]
                        [--no-plotting] [--min-separation=auto] [--dump=DIR]
                        [--threads=1] [--perc-zero=auto]
                        [--perc-undetected=auto] <contact_map> <prefix>
    chromosight generate-config [--preset loops] [--click contact_map]
                        [--norm={auto,raw,norm}] [--win-size=auto] [--n-mads=5]
                        [--chroms=CHROMS] [--inter] [--threads=1] <prefix>
    chromosight quantify [--inter] [--pattern=loops] [--subsample=no]
                         [--win-fmt=json] [--kernel-config=FILE] [--norm={auto,raw,norm}]
                         [--threads=1] [--n-mads=5] [--win-size=auto]
                         [--perc-undetected=auto] [--perc-zero=auto]
                         [--no-plotting] [--tsvd] <bed2d> <contact_map> <prefix>
    chromosight list-kernels [--long] [--mat] [--name=kernel_name]
    chromosight test

    detect:
        performs pattern detection on a Hi-C contact map via template matching
    generate-config:
        Generate pre-filled config files to use for detect and quantify.
        A config consists of a JSON file describing parameters for the
        analysis and path pointing to kernel matrices files. Those matrices
        files are tsv files with numeric values as kernel to use for
        convolution.
    quantify:
        Given a list of pairs of positions and a contact map, computes the
        correlation coefficients between those positions and the kernel of the
        selected pattern.
    list-kernels:
        Prints information about available kernels.
    test:
        Download example data and run loop detection on it.

Arguments for detect:
    contact_map                 The Hi-C contact map to detect patterns on, in
                                cool format.
    prefix                      Common path prefix used to generate output files.
                                Extensions will be added for each file.

Arguments for quantify:
    bed2d                       Tab-separated text files with columns chrom1, start1
                                end1, chrom2, start2, end2. Each line correspond to
                                a pair of positions (i.e. a position in the matrix).
    contact_map                 Path to the contact map, in cool format.
    prefix                      Common path prefix used to generate output files.
                                Extensions will be added for each file.

Arguments for generate-config:
    prefix                      Path prefix for config files. If prefix is a/b,
                                files a/b.json and a/b.1.txt will be generated.
                                If a given pattern has N kernel matrices, N txt
                                files are created they will be named a/b.[1-N].txt.
    -e, --preset=loops          Generate a preset config for the given pattern.
                                Preset configs available are "loops" and
                                "borders". [default: loops]
    -c, --click=contact_map     Show input contact map and uses double clicks from
                                user to build the kernel. Warning: memory-heavy,
                                reserve for small genomes or subsetted matrices.
    -C, --chroms=CHROMS         Comma-separated list of chromosome names. When used
                                with --click, this will show each chromosome's
                                one-by-one sequentially instead of the whole genome.
                                This is useful to reduce memory usage.

Arguments for list-kernels:
    --name=kernel_name      Only show information related to a particular
                            kernel.[default: all]
    --long                  Show default parameters in addition to kernel names.
    --mat                   Prints an ascii representation of the kernel matrix.

Basic options:
    -h, --help                  Display this help message.
    --version                   Display the program's current version.
    --verbose                   Displays the logo.
    -n, --norm={auto,raw,force} Normalization / balancing behaviour. auto: weights
                                present in the cool file are used. raw: raw contact
                                values are used. force: recompute weights and
                                overwrite existing values. raw[default: auto]
    -I, --inter                 Enable to consider interchromosomal contacts.
                                Warning: Experimental feature with high memory
                                consumption, only use with small matrices.
    -m, --min-dist=auto         Minimum distance from the diagonal (in base pairs).
                                at which detection should operate. [default: auto]
    -M, --max-dist=auto         Maximum distance from the diagonal (in base pairs)
                                for detection. [default: auto]
    -P, --pattern=loops         Which pattern to detect. This will use preset
                                configurations for the given pattern. Possible
                                values are: loops, loops_small, borders, hairpins and
                                centromeres. [default: loops]
    -p, --pearson=auto          Pearson correlation threshold when detecting patterns
                                in the contact map. Lower values leads to potentially
                                more detections, but more false positives. [default: auto]
    -s, --subsample=INT         If greater than 1, subsample INT contacts from the
                                matrix. If between 0 and 1, subsample a proportion of
                                contacts instead. Useful when comparing matrices with
                                different coverages. [default: no]
    -t, --threads=1             Number of CPUs to use in parallel. [default: 1]
    -u, --perc-undetected=auto  Maximum percentage of non-detectable pixels (nan) in
                                windows allowed to report patterns. [default: auto]
    -z, --perc-zero=auto        Maximum percentage of empty (0) pixels in windows
                                allowed to report patterns. [default: auto]

Advanced options:
    -d, --dump=DIR              Directory where to save matrix dumps during
                                processing and detection. Each dump is saved as
                                a compressed npz of a sparse matrix and can be
                                loaded using scipy.sparse.load_npz.
    -i, --iterations=auto       How many iterations to perform after the first
                                template-based pass. [default: 1]
    -k, --kernel-config=FILE    Optionally give a path to a custom JSON kernel
                                config path. Use this to override pattern if
                                you do not want to use one of the preset
                                patterns.
    --no-plotting               Disable generation of pileup plots.
    -N, --n-mads=5              Maximum number of median absolute deviations below
                                the median of the bin sums distribution allowed to
                                consider detectable bins. [default: 5]
    -S, --min-separation=auto   Minimum distance required between patterns, in
                                basepairs. If two patterns are closer than this
                                distance in both axes, the one with the lowest
                                score is discarded. [default: auto]
    -T, --smooth-trend          Use isotonic regression when detrending to reduce
                                noise at long ranges. Do not enable this for circular
                                genomes.
    -V, --tsvd                  Enable kernel factorisation via truncated svd.
                                Accelerates detection, at the cost of slight
                                inaccuracies. Singular matrices are truncated to
                                retain 99.9% of the information in the kernel.
    -w, --win-fmt={json,npy}    File format used to store individual windows
                                around each pattern. Window order matches
                                patterns inside the associated text file.
                                Possible formats are json and npy. [default: json]
    -W, --win-size=auto         Window size (width), in pixels, to use for the
                                kernel when computing correlations. The pattern
                                kernel will be resized to match this size. Linear
                                linear interpolation is used to fill between pixels.
                                If not specified, the default kernel size will
                                be used instead. [default: auto]
```


## chromosight_test

### Tool Description
Explore and detect patterns (loops, borders, centromeres, etc.) in Hi-C contact maps with pattern matching.

### Metadata
- **Docker Image**: quay.io/biocontainers/chromosight:1.6.3--pyhdfd78af_0
- **Homepage**: https://github.com/koszullab/chromosight
- **Package**: https://anaconda.org/channels/bioconda/packages/chromosight/overview
- **Validation**: PASS

### Original Help Text
```text
Pattern exploration and detection

Explore and detect patterns (loops, borders, centromeres, etc.) in Hi-C contact
maps with pattern matching.

Usage:
    chromosight detect  [--kernel-config=FILE] [--pattern=loops]
                        [--pearson=auto] [--win-size=auto] [--iterations=auto]
                        [--win-fmt={json,npy}] [--norm={auto,raw,force}]
                        [--subsample=no] [--inter] [--tsvd] [--smooth-trend]
                        [--n-mads=5] [--min-dist=0] [--max-dist=auto]
                        [--no-plotting] [--min-separation=auto] [--dump=DIR]
                        [--threads=1] [--perc-zero=auto]
                        [--perc-undetected=auto] <contact_map> <prefix>
    chromosight generate-config [--preset loops] [--click contact_map]
                        [--norm={auto,raw,norm}] [--win-size=auto] [--n-mads=5]
                        [--chroms=CHROMS] [--inter] [--threads=1] <prefix>
    chromosight quantify [--inter] [--pattern=loops] [--subsample=no]
                         [--win-fmt=json] [--kernel-config=FILE] [--norm={auto,raw,norm}]
                         [--threads=1] [--n-mads=5] [--win-size=auto]
                         [--perc-undetected=auto] [--perc-zero=auto]
                         [--no-plotting] [--tsvd] <bed2d> <contact_map> <prefix>
    chromosight list-kernels [--long] [--mat] [--name=kernel_name]
    chromosight test

    detect:
        performs pattern detection on a Hi-C contact map via template matching
    generate-config:
        Generate pre-filled config files to use for detect and quantify.
        A config consists of a JSON file describing parameters for the
        analysis and path pointing to kernel matrices files. Those matrices
        files are tsv files with numeric values as kernel to use for
        convolution.
    quantify:
        Given a list of pairs of positions and a contact map, computes the
        correlation coefficients between those positions and the kernel of the
        selected pattern.
    list-kernels:
        Prints information about available kernels.
    test:
        Download example data and run loop detection on it.

Arguments for detect:
    contact_map                 The Hi-C contact map to detect patterns on, in
                                cool format.
    prefix                      Common path prefix used to generate output files.
                                Extensions will be added for each file.

Arguments for quantify:
    bed2d                       Tab-separated text files with columns chrom1, start1
                                end1, chrom2, start2, end2. Each line correspond to
                                a pair of positions (i.e. a position in the matrix).
    contact_map                 Path to the contact map, in cool format.
    prefix                      Common path prefix used to generate output files.
                                Extensions will be added for each file.

Arguments for generate-config:
    prefix                      Path prefix for config files. If prefix is a/b,
                                files a/b.json and a/b.1.txt will be generated.
                                If a given pattern has N kernel matrices, N txt
                                files are created they will be named a/b.[1-N].txt.
    -e, --preset=loops          Generate a preset config for the given pattern.
                                Preset configs available are "loops" and
                                "borders". [default: loops]
    -c, --click=contact_map     Show input contact map and uses double clicks from
                                user to build the kernel. Warning: memory-heavy,
                                reserve for small genomes or subsetted matrices.
    -C, --chroms=CHROMS         Comma-separated list of chromosome names. When used
                                with --click, this will show each chromosome's
                                one-by-one sequentially instead of the whole genome.
                                This is useful to reduce memory usage.

Arguments for list-kernels:
    --name=kernel_name      Only show information related to a particular
                            kernel.[default: all]
    --long                  Show default parameters in addition to kernel names.
    --mat                   Prints an ascii representation of the kernel matrix.

Basic options:
    -h, --help                  Display this help message.
    --version                   Display the program's current version.
    --verbose                   Displays the logo.
    -n, --norm={auto,raw,force} Normalization / balancing behaviour. auto: weights
                                present in the cool file are used. raw: raw contact
                                values are used. force: recompute weights and
                                overwrite existing values. raw[default: auto]
    -I, --inter                 Enable to consider interchromosomal contacts.
                                Warning: Experimental feature with high memory
                                consumption, only use with small matrices.
    -m, --min-dist=auto         Minimum distance from the diagonal (in base pairs).
                                at which detection should operate. [default: auto]
    -M, --max-dist=auto         Maximum distance from the diagonal (in base pairs)
                                for detection. [default: auto]
    -P, --pattern=loops         Which pattern to detect. This will use preset
                                configurations for the given pattern. Possible
                                values are: loops, loops_small, borders, hairpins and
                                centromeres. [default: loops]
    -p, --pearson=auto          Pearson correlation threshold when detecting patterns
                                in the contact map. Lower values leads to potentially
                                more detections, but more false positives. [default: auto]
    -s, --subsample=INT         If greater than 1, subsample INT contacts from the
                                matrix. If between 0 and 1, subsample a proportion of
                                contacts instead. Useful when comparing matrices with
                                different coverages. [default: no]
    -t, --threads=1             Number of CPUs to use in parallel. [default: 1]
    -u, --perc-undetected=auto  Maximum percentage of non-detectable pixels (nan) in
                                windows allowed to report patterns. [default: auto]
    -z, --perc-zero=auto        Maximum percentage of empty (0) pixels in windows
                                allowed to report patterns. [default: auto]

Advanced options:
    -d, --dump=DIR              Directory where to save matrix dumps during
                                processing and detection. Each dump is saved as
                                a compressed npz of a sparse matrix and can be
                                loaded using scipy.sparse.load_npz.
    -i, --iterations=auto       How many iterations to perform after the first
                                template-based pass. [default: 1]
    -k, --kernel-config=FILE    Optionally give a path to a custom JSON kernel
                                config path. Use this to override pattern if
                                you do not want to use one of the preset
                                patterns.
    --no-plotting               Disable generation of pileup plots.
    -N, --n-mads=5              Maximum number of median absolute deviations below
                                the median of the bin sums distribution allowed to
                                consider detectable bins. [default: 5]
    -S, --min-separation=auto   Minimum distance required between patterns, in
                                basepairs. If two patterns are closer than this
                                distance in both axes, the one with the lowest
                                score is discarded. [default: auto]
    -T, --smooth-trend          Use isotonic regression when detrending to reduce
                                noise at long ranges. Do not enable this for circular
                                genomes.
    -V, --tsvd                  Enable kernel factorisation via truncated svd.
                                Accelerates detection, at the cost of slight
                                inaccuracies. Singular matrices are truncated to
                                retain 99.9% of the information in the kernel.
    -w, --win-fmt={json,npy}    File format used to store individual windows
                                around each pattern. Window order matches
                                patterns inside the associated text file.
                                Possible formats are json and npy. [default: json]
    -W, --win-size=auto         Window size (width), in pixels, to use for the
                                kernel when computing correlations. The pattern
                                kernel will be resized to match this size. Linear
                                linear interpolation is used to fill between pixels.
                                If not specified, the default kernel size will
                                be used instead. [default: auto]
```

