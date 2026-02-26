# scrappie CWL Generation Report

## scrappie_events

### Tool Description
Scrappie basecaller -- basecall via events

### Metadata
- **Docker Image**: quay.io/biocontainers/scrappie:1.4.2--py310pl5321h9a1f509_7
- **Homepage**: https://github.com/nanoporetech/scrappie
- **Package**: https://anaconda.org/channels/bioconda/packages/scrappie/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/scrappie/overview
- **Total Downloads**: 23.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/nanoporetech/scrappie
- **Stars**: N/A
### Original Help Text
```text
Usage: events [OPTION...] fast5 [fast5 ...]
Scrappie basecaller -- basecall via events

  -#, --threads=nparallel    Number of reads to call in parallel
      --dump=filename        Dump annotated events to HDF5 file
      --dwell, --no-dwell    Perform dwell correction of homopolymer lengths
  -f, --format=format        Format to output reads (FASTA or SAM)
      --hdf5-chunk=size      Chunk size for HDF5 output
      --hdf5-compression=level   Gzip compression level for HDF5 output (0:off,
                             1: quickest, 9: best)
      --licence, --license   Print licensing information
      --local=penalty        Penalty for local basecalling
  -l, --limit=nreads         Maximum number of reads to call (0 is unlimited)
  -m, --min_prob=probability Minimum bound on probability of match
  -o, --output=filename      Write to file rather than stdout
  -p, --prefix=string        Prefix to append to name of each read
      --segmentation=chunk:percentile
                             Chunk size and percentile for variance based
                             segmentation
      --slip, --no-slip      Use slipping
  -s, --skip=penalty         Penalty for skipping a base
      --temperature1=factor  Temperature for softmax weights
      --temperature2=factor  Temperature for softmax bias
  -t, --trim=start:end       Number of events to trim, as start:end
      --uuid, --no-uuid      Output UUID
  -y, --stay=penalty         Penalty for staying
  -?, --help                 Give this help list
      --usage                Give a short usage message
  -V, --version              Print program version

Mandatory or optional arguments to long options are also mandatory or optional
for any corresponding short options.

Report bugs to <tim.massingham@nanoporetech.com>.
```


## scrappie_help

### Tool Description
Scrappie is a technology demonstrator for the Oxford Nanopore Technologies Limited Research Algorithms group.

### Metadata
- **Docker Image**: quay.io/biocontainers/scrappie:1.4.2--py310pl5321h9a1f509_7
- **Homepage**: https://github.com/nanoporetech/scrappie
- **Package**: https://anaconda.org/channels/bioconda/packages/scrappie/overview
- **Validation**: PASS

### Original Help Text
```text
Scrappie is a technology demonstrator for the Oxford Nanopore Technologies
Limited Research Algorithms group.

Basic usage:
* scrappie events        Base call from event based data.
* scrappie help          Print general help or help about specific Scrappie command.
* scrappie licence       Print licensing information.
* scrappie raw           Base call directly from raw signal.
* scrappie version       Print version information.
* scrappie squiggle      Create approximate squiggle for sequence
* scrappie mappy         Map signal to approximate squiggle
* scrappie seqmappy      Map signal to sequence via basecall posteriors
* scrappie event_table   Output table of events for read

This project began life as a proof (bet) that a base caller could be written
in a low level language in under 8 hours.  Some of the poor and just plain odd
design decisions, along with the lack of documentation, are a result of its
inception. In keeping with ONT's fish naming policy, the project was originally
called Crappie.

Scrappie's purpose is to demonstrate the next generation of base calling and, as
such, may change drastically between releases and breaks backwards
compatibility.  Newer versions may drop support of current features or change their
behaviour.
```


## scrappie_licence

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/scrappie:1.4.2--py310pl5321h9a1f509_7
- **Homepage**: https://github.com/nanoporetech/scrappie
- **Package**: https://anaconda.org/channels/bioconda/packages/scrappie/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
This software is subject to the terms of the Mozilla Public
License, v. 2.0. If a copy of the MPL was not distributed with this
file, You can obtain one at http://mozilla.org/MPL/2.0/.

(c) 2017 Oxford Nanopore Technologies Ltd.



The vectorised math functions 'src/sse_mathfun.h' are from
http://gruntthepeon.free.fr/ssemath/ and the original version of this file is
under the 'zlib' licence.  See the top of 'src/sse_mathfun.h' for details.
```


## scrappie_raw

### Tool Description
Scrappie basecaller -- basecall from raw signal

### Metadata
- **Docker Image**: quay.io/biocontainers/scrappie:1.4.2--py310pl5321h9a1f509_7
- **Homepage**: https://github.com/nanoporetech/scrappie
- **Package**: https://anaconda.org/channels/bioconda/packages/scrappie/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: raw [OPTION...] fast5 [fast5 ...]
Scrappie basecaller -- basecall from raw signal

  -#, --threads=nparallel    Number of reads to call in parallel
  -f, --format=format        Format to output reads (FASTA or SAM)
      --hdf5-chunk=size      Chunk size for HDF5 output
      --hdf5-compression=level   Gzip compression level for HDF5 output (0:off,
                             1: quickest, 9: best)
  -H, --homopolymer=homopolymer   Homopolymer run calc. to use: choose from
                             "nochange" or "mean" (default). Not implemented
                             for CRF.
      --licence, --license   Print licensing information
      --local=penalty        Penalty for local basecalling
  -l, --limit=nreads         Maximum number of reads to call (0 is unlimited)
      --model=name           Raw model to use: "raw_r94", "rgrgr_r94",
                             "rgrgr_r941", "rgrgr_r10", "rnnrf_r94"
  -m, --min_prob=probability Minimum bound on probability of match
  -o, --output=filename      Write to file rather than stdout
  -p, --prefix=string        Prefix to append to name of each read
      --segmentation=chunk:percentile
                             Chunk size and percentile for variance based
                             segmentation
      --slip, --no-slip      Use slipping
  -s, --skip=penalty         Penalty for skipping a base
      --temperature1=factor  Temperature for softmax weights
      --temperature2=factor  Temperature for softmax bias
  -t, --trim=start:end       Number of samples to trim, as start:end
      --uuid, --no-uuid      Output UUID
  -y, --stay=penalty         Penalty for staying
  -?, --help                 Give this help list
      --usage                Give a short usage message
  -V, --version              Print program version

Mandatory or optional arguments to long options are also mandatory or optional
for any corresponding short options.

Report bugs to <tim.massingham@nanoporetech.com>.
```


## scrappie_version

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/scrappie:1.4.2--py310pl5321h9a1f509_7
- **Homepage**: https://github.com/nanoporetech/scrappie
- **Package**: https://anaconda.org/channels/bioconda/packages/scrappie/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
scrappie 1.4.0-
```


## scrappie_squiggle

### Tool Description
Scrappie squiggler

### Metadata
- **Docker Image**: quay.io/biocontainers/scrappie:1.4.2--py310pl5321h9a1f509_7
- **Homepage**: https://github.com/nanoporetech/scrappie
- **Package**: https://anaconda.org/channels/bioconda/packages/scrappie/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: squiggle [OPTION...] fasta [fasta ...]
Scrappie squiggler

      --licence, --license   Print licensing information
  -l, --limit=nreads         Maximum number of reads to call (0 is unlimited)
  -m, --model=name           Squiggle model to use: "squiggle_r94",
                             "squiggle_r94_rna", "squiggle_r10"
  -o, --output=filename      Write to file rather than stdout
  -p, --prefix=string        Prefix to append to name of each read
      --rescale, --no-rescale   Rescale network output
  -?, --help                 Give this help list
      --usage                Give a short usage message
  -V, --version              Print program version

Mandatory or optional arguments to long options are also mandatory or optional
for any corresponding short options.

Report bugs to <tim.massingham@nanoporetech.com>.
```


## scrappie_mappy

### Tool Description
Scrappie squiggler

### Metadata
- **Docker Image**: quay.io/biocontainers/scrappie:1.4.2--py310pl5321h9a1f509_7
- **Homepage**: https://github.com/nanoporetech/scrappie
- **Package**: https://anaconda.org/channels/bioconda/packages/scrappie/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mappy [OPTION...] fasta fast5
Scrappie squiggler

  -1, --model=name           Squiggle model to use: "squiggle_r94",
                             "squiggle_r10"
  -b, --backprob=probability Probability of backwards movement
  -k, --skippen=float        Penalty for skipping position
      --licence, --license   Print licensing information
  -l, --localpen=float       Penalty for local matching
  -m, --minscore=float       Minimum possible score for matching emission
  -o, --output=filename      Write to file rather than stdout
  -p, --prefix=string        Prefix to append to name of read
  -r, --rate=float           Translocation rate of read relative to standard
                             squiggle
  -s, --segmentation=chunk:percentile
                             Chunk size and percentile for variance based
                             segmentation
  -t, --trim=start:end       Number of samples to trim, as start:end
  -?, --help                 Give this help list
      --usage                Give a short usage message
  -V, --version              Print program version

Mandatory or optional arguments to long options are also mandatory or optional
for any corresponding short options.

Report bugs to <tim.massingham@nanoporetech.com>.
```


## scrappie_seqmappy

### Tool Description
Scrappie seqmappy (local-global)

### Metadata
- **Docker Image**: quay.io/biocontainers/scrappie:1.4.2--py310pl5321h9a1f509_7
- **Homepage**: https://github.com/nanoporetech/scrappie
- **Package**: https://anaconda.org/channels/bioconda/packages/scrappie/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seqmappy [OPTION...] fasta fast5
Scrappie seqmappy (local-global)

      --licence, --license   Print licensing information
  -l, --localpen=float       Penalty for local matching
  -m, --min_prob=probability Minimum bound on probability of match
  -o, --output=filename      Write to file rather than stdout
  -p, --prefix=string        Prefix to append to name of read
      --segmentation=chunk:percentile
                             Chunk size and percentile for variance based
                             segmentation
  -s, --skip=penalty         Penalty for skipping a base
      --temperature1=factor  Temperature for softmax weights
      --temperature2=factor  Temperature for softmax bias
  -t, --trim=start:end       Number of samples to trim, as start:end
  -y, --stay=penalty         Penalty for staying
  -?, --help                 Give this help list
      --usage                Give a short usage message
  -V, --version              Print program version

Mandatory or optional arguments to long options are also mandatory or optional
for any corresponding short options.

Report bugs to <tim.massingham@nanoporetech.com>.
```


## scrappie_event_table

### Tool Description
Scrappie basecaller -- basecall via events

### Metadata
- **Docker Image**: quay.io/biocontainers/scrappie:1.4.2--py310pl5321h9a1f509_7
- **Homepage**: https://github.com/nanoporetech/scrappie
- **Package**: https://anaconda.org/channels/bioconda/packages/scrappie/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: event_table [OPTION...] fast5 [fast5 ...]
Scrappie basecaller -- basecall via events

      --licence, --license   Print licensing information
  -o, --output=filename      Write to file rather than stdout
      --segmentation=chunk:percentile
                             Chunk size and percentile for variance based
                             segmentation
  -t, --trim=start:end       Number of events to trim, as start:end
  -?, --help                 Give this help list
      --usage                Give a short usage message
  -V, --version              Print program version

Mandatory or optional arguments to long options are also mandatory or optional
for any corresponding short options.

Report bugs to <tim.massingham@nanoporetech.com>.
```

