Toggle navigation

[Samtools](/)

* [Home](/)
* [Download](/download)
  + [Downloads](/download)
  + [Development](/develop)
* [Workflows](/workflow)
  + [FASTQ to BAM / CRAM](/workflow/fastq.html)
  + [WGS/WES Mapping to Variant Calls](/workflow/wgs-call.html)
  + [Filtering of VCF Files](/workflow/filter.html)
  + [Using CRAM within Samtools](/workflow/cram.html)
* [Documentation](/doc)
  + [Man Pages](/doc#manual-pages)
  + [HowTos](/doc#howtos)
  + [Specifications](/doc#file-formats)
  + [Duplicate Marking](/algorithms/duplicate.html)
  + [Zlib Benchmarks](/benchmarks/zlib.html)
  + [CRAM Benchmarks](/benchmarks/CRAM.html)
  + [Reference Sequences](/doc/reference_seqs.html)
  + [Publications](/doc#publications)
* [Support](/support)
  + [HTSlib issues](https://github.com/samtools/htslib/issues)
  + [BCFtools issues](https://github.com/samtools/bcftools/issues)
  + [Samtools issues](https://github.com/samtools/samtools/issues)
  + [General help](/support#general-help)

# Filtering of VCF Files

It is important to note this guide is covering filtering a single WGS
sample with an expectation of broadly even allele frequencies and
therefore any recommendations need to be taken cautiously. The
techniques described however can be applied to any data set if you
have a suitable truth set.

Filtering in Bcftools is broadly broken down into two types: pre and
post-call filtering.

Pre-call filtering is where the application decides not to emit a
variant line to the VCF file. Post-call filtering is where a variant
is emitted along with ancillary metrics, such as quality and depth,
which are then used for further filtering.

Where possible post-call filtering gives us the most flexibility as we
can adjust the filter rules and rapidly produce a revised call set
without rerunning a CPU expensive task.

However there are times where we know we may never wish to accept a
variant, such as specifying the minimum number of reads required to
call an insertion. This sort of filtering is typically performed by
command line arguments in either `bcftools mpileup` or `bcftools call`
and are discussed below.

The post-call filtering is covered in more detail, split up into SNP
and InDel sections.

## Pre-call filtering

`bcftools mpileup` includes a number of options that govern when an indel
is permitted. Some of these aren’t strictly filters, but weights that
impact on when to call. The appropriate options are.

| Option ![]() | Description |
| --- | --- |
| -I | Skips indel calling altogether |
| -L INT | Maximum depth permitted to output an indel [250]. This can be filtered later using INFO/IDV so consider increasing this. |
| -m INT | Minimum number of gapped reads for indel candidates [1]. The default is 2, but was 1 in earlier bcftools releases. This can be filtered later using INFO/IDV. |
| -F FLOAT | Minimum fraction of gapped reads [0.05]. This can be filtered later using INFO/IMF. |
| -h INT | A coefficient for the likelihood of variations in homopolymer being genuine or sequencing artifact. Lower indicates more likely to be an error. The default is now 500, but used to be 100. |
| –indel-bias FLOAT | A catch-all parameter to call more indels (higher FLOAT) at the expense of precision, or fewer (lower FLOAT) but more precise calls. The default is 1.0. |

Additionally `bcftools call` has some options which govern output of variants.

| Option ![]() | Description |
| --- | --- |
| -A | Keep all possible alternate alleles at variant sites |
| -V TYPE | Skip TYPE (indels or SNPs). |

There are also options which tune both SNP and indel calling, but they
are various priors and scaling factors rather than hard filtering.
See the `mpileup` and `call` man pages for guidance.

## SNP post-call filtering

Bcftools produces a number of parameters which may be useful for
filtering variant calls. For SNPs the list of INFO fields are
plentiful. We do not cover them all, but include DP, MQBZ, RPBZ,
and SCBZ below. Additional filtering INFO and FORMAT fields can be
requested using the `mpileup -a` option and we also include
FORMAT/SP. See the man page for full details of other filtering
fields.

The most obvious filter parameter however is the QUAL field.

Bcftools can filter-in or filter-out using options `-i` and `-e`
respectively on the `bcftools view` or `bcftools filter` commands. For
example:

```
bcftools filter -O z -o filtered.vcf.gz -i '%QUAL>50' in.vcf.gz
bcftools view -O z -o filtered.vcf.gz -e 'QUAL<=50' in.vcf.gz
```

The quality field is the most obvious filtering method. This is one
of the primary columns in the VCF file and is filtered using `QUAL`.
However the INFO and FORMAT fields contain many other statistics which
may be useful in distinguish true from false variants, and this is
where more complex filtering rules come in.

It can be tricky to work out the impact of various filtering rules,
and paramters may need to be changed by depth or sequencing strategy,
both technology and WGS vs Exome. Different filtering will be needed
for SNPs and indels too.

However one useful technique, if you have a truth set available, is to
use `bcftools isec` on a VCF call file and a VCF truth file. This
will produce 4 files containing the variants only in file 1, only in
file 2, and the variants matching in both (with the records from file 1
and in file 2 respectively). Combining this with bcftools query will
permit construction of histograms, indicating what filtering
thresholds are appropriate.

The following are examples produced from the GIAB HG002 Illumina data
set, aligned by Novoalign.

Firstly we need to ensure both truth set and call set are normalised
using the same tool. For this `bcftools norm -m -both -f $ref` may be
used. Additionally you may wish to use something like `vt
decompose_blocksub` to separate out multi-allelic calls if you wish to
count each allele call separately. If you have a bed file listing
valid regions to include or exclude, make sure to filter to those
regions too.

After this, ensure both files are bgzipped and indexed before running
isec.

```
bcftools isec -c both -p isec truth.vcf.gz call.vcf.gz
```

Now outdir/0001.vcf contains variants only found in truth.vcf.gz and
hence are false negatives. Outdir/0002.vcf contains only variants
only in the call set, and are false positives. Outdir/0003.vcf and
outdir/0004.vcf are the true variants.

### VCF Call Quality

We may produce a histogram from outdir/0003.vcf (true) and
outdir/0001.vcf (false) to compare the distributions of the `DP`
(depth) field. This may be either an INFO or a FORMAT field, but for
simplicitly we are restricting this guide to a single sample and using
INFO.

```
bcftools query -i 'TYPE="SNP"' -f '%QUAL\n' isec/0001.vcf > QUAL_1
bcftools query -i 'TYPE="SNP"' -f '%QUAL\n' isec/0003.vcf > QUAL_3
```

These files may be turned into histograms with a simple perl script or
whatever language you prefer:

```
perl -MPOSIX -lane '$h{POSIX::round($F[0]/10)}++; END {@k=sort {$a <=> $b} (keys %h);for ($i=@k[0]; $i <= @k[-1]; $i++) {print $i*10,"\t",$h{$i}+0}}' QUAL_1 > QUAL_1_hist
perl -MPOSIX -lane '$h{POSIX::round($F[0]/10)}++; END {@k=sort {$a <=> $b} (keys %h);for ($i=@k[0]; $i <= @k[-1]; $i++) {print $i*10,"\t",$h{$i}+0}}' QUAL_3 > QUAL_3_hist
```

(Note if you are also going to be selectively filtering for high
quality variants only, then you may wish to amend the “bcftools query”
command above to `-i 'TYPE="SNP" && QUAL >= 30'` to see how the
various metrics work in conjunction with quality filtering.)

Finally we can plot them in gnuplot, using a log scale as the
disparity in sample sizes is very significant and attempting to
normalise by total sample size may also mislead us.

```
$ gnuplot
gnuplot> set logscale y
gnuplot> plot \
    "QUAL_1_hist" with lines lw 2 title "False", \
    "QUAL_3_hist" with lines lw 2 title "True"
```

![15x quality distribution](/images/15x_QUAL_lhist.png)
![150x quality distribution](/images/150x_QUAL_lhist.png)

There are some strange spikes at very high values, but overall the
trend is as we’d hope with an enrichment for false calls at low
quality and for true calls at high quality.

At deep depths, we see a clear point of around 60 or below where calls
are more likely to be incorrect than correct, but there are still a
significant number of correct calls (log-odds of -0.5 equates to
around 30:70 split in true:false).

For shallow depths, all quality values still are still more likely
correct calls than incorrect.

Ultimately the threshold for filtering will depend on your application
and whether high recall (low false negatives) is more important than
high precision (low false positives).

### Depth

The sequencing depth may vary considerably across the sample. If we
have a very sudden increase in depth, then it is possibly an
indication of misalignment or an additional repeat copy in this sample
vs the reference. Such cases can lead to incorrect calls, which are
often extremely confident due to the high depth.

![15x normalised depth](/images/15x_DP_lhist.png)
![150x normalised depth](/images/150x_DP_lhist.png)

We see a sharp spike in depth for the true variants somewhere around
the expected average depth. The false variants have a broader
distribution with long tails.

The filter value obviously depends on the average depth, but filtering
at some multiple of that can be powerful. For example 2 times the
depth may be a reasonable starting point. We see here that perhaps
`DP > 35` will work well on the shallow data and `DP > 250` for the
deep data. These are not too far off doubling the depth (30 and 300).

### Mapping Quality

In a heterozygous call with one allele matching the reference, the
distribution of mapping qualities for sequences matching REF versus
those matching ALT may differ due to reference bias. This is to be
expected, however a large difference in these distributions may be
indicative of a false call. We have a Mann-Whitney U test available
to compare these distributions. These are normalised into a Z-score,
indicating the number of multiples of standard deviation above or
below the mean. This is saved in the MQBZ INFO tag.

Normalised plots of these distributions can be seen here.

Note in bcftools 1.12 and earlier this is expressed as a probability
value, so filter rules will need to check against very small values,
such as `MQB < 1e-5`.

![15x MAPQ Bias](/images/15x_MQBZ_lhist.png)
![150x MAPQ Bias](/images/150x_MQBZ_lhist.png)

While there is a large overlap between the false and true
distributions, at both low and high depth there is a clear shifting
left for false variants. Unfortunately the correct filtering offset
does also seem to be depth dependent. Filters of `MQBZ < -4` would be
appropriate for shallow data, and perhaps -9 for deep.

### SNP Base Quality

Individual base qualities should have comparable distributions between
REF and ALT. I bias here indicates the SNP may be a systematic error
caused by a specific sequence motif.

Note in bcftools 1.12 and earlier this is expressed as a probability
value, so filter rules will need to check against very small values,
such as `BQB < 1e-5`.

![15x Base Bias](/images/15x_BQBZ_lhist.png)
![150x Base Bias](/images/150x_BQBZ_lhist.png)

There is a slight skew towards lower BQBZ values for both low and high
depth, with a more noticable discrimination at depth. The useful
threshold varies slightly by depth.

%-(3.1 + DP/40)

### Position

The position of a variant within the reads can matter. We should
expect reads to be aligned fairly randomly, and thus variants to be
distributed randomly over the read. Reference bias alignment
artifacts tend to be enriched for the ends of reads where a
substitution near the read end is usually preferable to an indel to
achieve optimal score (as alignments are pair-wise against the
reference rather than against the other sequences within in the
sample).

The RPBZ statistic is a Mann-Whitney U test represented as a Z-score
(the distance from the mean expressed in units of the standard
deviation) describing the difference in read position distributions
of REF and ALT calls. As MQBZ this cannot be calculated for many
SNPS, but where possible it can help spot false calls due to reference
bias.

![15x Read Pos Bias](/images/15x_RPBZ_lhist.png)
![150x Read Pos Bias](/images/150x_RPBZ_lhist.png)

At shallow depth there isn’t any discrimination power between false
and true variants. It’s more likely to be wrong at the extreme ends
of the distribution, but it’s never more likely wrong than correct. At
deep data however the statistic becomes far more powerful.

The plots are largely symmetric so a filter of e.g. `RPBZ < -5 || RPBZ > +5`
may work.

### Soft-clips

A multitude of sequence alignments having soft-clipped bases may be
indicative or a bad alignment, perhaps caused by reference bias
again. The SCBZ is a Mann-Whitney U Z-score for the relative
distribution of length of soft-clip within the proximity of the
variant.

![15x Soft Clip Bias](/images/15x_SCBZ_lhist.png)
![150x Soft Clip Bias](/images/150x_SCBZ_lhist.png)

This test shows a sharp increase to the right end of the distribution
for false variants. As with some other tests, the exact cutoff point
is dependent on the depth of the sample.

A filter of `SCBZ > 3` or `SCBZ > 4` would be appropriate for this data.

### Strand bias

This statistic is not enabled by default, but can be added with the
`-a FORMAT/SP` option of bcftools mpileup.

The plots below are normalises, and truncated in X.

![15x Strand Bias](/images/15x_SP_lhist.png)
![150x Strand Bias](/images/150x_SP_lhist.png)

Both true and false variants have a sharp decay, but the tail is
considerably longer for false variants. The test is still quite
powerful for shallow data too.

As with some other metrics, the threshold is very depth specific,
indicating `FORMAT/SP > 100` for the 150x data and `FORMAT/SP > 32` for
the 15x data.

### Putting it all together

While each test does not have a huge power to separate true from false
variants, some of the indicators may not be strongly correlated so
combining them together in a single clause can give a significant
boost. If we are filtering out things that match our patterns, then
we should combine with logical OR. For example the shallow data may use:

```
bcftools view -e 'QUAL <= 10 || DP > 35 || MQBZ < -3 || RPBZ < -3 || RPBZ > 3 || FORMAT/SP > 32 || SCBZ > 3' in.vcf
```

with the deep data using:

```
bcftools view -e 'QUAL <= 10 || DP > 250 || MQBZ < -3 || RPBZ < -3 || RPBZ > 3 || FORMAT/SP > 100 || SCBZ > 6' in.vcf
```

Note it’s possible to construct some filtering rules that adjust these
thresholds according to the local depth of the data. This is
challenging to optimise, but an example could be:

```
bcftools view -e "QUAL < $qual || DP>2*$DP || MQBZ < -(3.5+4*DP/QUAL) || RPBZ > (3+3*DP/QUAL) || RPBZ < -(3+3*DP/QUAL) || FORMAT/SP > (40+DP/2) || SCBZ > (2.5+DP/30)"
```

Where `$qual` is the desired quality threshold and `$DP`