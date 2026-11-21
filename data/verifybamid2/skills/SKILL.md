---
name: verifybamid2
description: verifybamid2 quantifies inter-sample DNA contamination in sequencing libraries using an ancestry-agnostic SVD approach. Use when user asks to 'estimate DNA contamination', 'detect within-ancestry contamination', 'constrain contamination level', or 'constrain PC coordinates'. Also use to find which other sample in a sequencing batch is the source of low-level cross-sample contamination or carryover, including tumor-in-normal, and to check tumor-normal pairs for sample swaps, from read counts at known SNP sites.
homepage: https://github.com/Griffan/VerifyBamID
metadata:
  docker_image: "quay.io/biocontainers/verifybamid2:2.0.1--h345183b_12"
---

# verifybamid2

## Overview
verifybamid2 is a specialized tool for quantifying inter-sample DNA contamination in sequencing libraries. It improves upon previous methods by using an ancestry-agnostic approach based on Singular Value Decomposition (SVD). This method avoids the common bias of underestimating contamination that occurs when allele frequencies are not accurately matched to the sample's specific population. It is compatible with both BAM and CRAM formats and supports major human genome builds (GRCh37 and GRCh38).

## Installation
The most efficient way to install verifybamid2 is via Bioconda:
```bash
conda install -c bioconda verifybamid2
```

## Common CLI Patterns

### Standard Contamination Estimation
The simplest way to run the tool is by using the `--SVDPrefix` argument, which points to a set of pre-calculated resource files (.UD, .mu, and .bed).

```bash
VerifyBamID --BamFile sample.bam \
            --Reference reference.fasta \
            --SVDPrefix /path/to/resource/1000g.100k.b38.vcf.gz.dat \
            --NumThread 4
```

### Explicit Resource Pathing
If your resource files do not share a common prefix or are stored separately, specify them individually:

```bash
VerifyBamID --BamFile sample.cram \
            --Reference reference.fasta \
            --UDPath resources.UD \
            --BedPath resources.bed \
            --MeanPath resources.mu \
            --NumThread 8
```

### Handling Human Genome Builds
Ensure your resource files match your alignment reference:
*   **GRCh37 (b37):** Typically uses the `1000g.100k.b37` resources. Note that this build usually lacks the "chr" prefix in chromosome names.
*   **GRCh38 (b38):** Typically uses the `1000g.100k.b38` resources. This build usually includes the "chr" prefix.

## Parameter Optimization and Best Practices

### Performance Tuning
*   **Multithreading:** Use `--NumThread [Int]` to speed up likelihood calculations. The default is 4, but increasing this on high-core systems significantly reduces runtime.
*   **Convergence:** The `--Epsilon` parameter (default 1e-10) controls the minimization threshold. Adjusting this can trade off between precision and execution speed.

### Estimation Logic
*   **Ancestry Assumptions:** By default, the tool assumes "between-ancestry" contamination. If you suspect the contamination source is from the same population as the target sample, enable `--WithinAncestry`.
*   **Fixed Parameters:** If the contamination level or PC coordinates are already known from other assays, use `--FixAlpha [Double]` or `--FixPC [PC1:PC2:PC3...]` to constrain the model.
*   **Seed for Reproducibility:** Use `--Seed [INT]` (default 12345) to ensure deterministic results across different runs on the same data.

### Troubleshooting
*   **Reference Mismatch:** If the tool fails to find markers, verify that the `--Reference` fasta file matches the one used for the original BAM/CRAM alignment, specifically regarding chromosome naming conventions (e.g., "1" vs "chr1").
*   **Pileup Output:** If results seem anomalous, use `--OutputPileup true` to generate a temporary pileup file for manual inspection of the marker sites.

## Carryover between samples of one batch: who is the source
VerifyBamID estimates how much foreign DNA a sample holds from population allele frequencies. It
does not say which sample the DNA came from, and it needs its resource files. When the possible
sources were sequenced in the same batch (a run of tumor-normal pairs, a plate, a flow cell), test
each of them directly. This also covers tumor DNA in the matched normal (tumor-in-normal).

The steps, in this order:
1. Count ref and alt reads at known SNP sites in every sample. Drop repeated records first.
2. Check which samples are the same person. A swapped or mislabelled pair shows here. Repair
   the pairs before step 3: the scan needs the right normal for each tumor.
3. For every sample, look at the sites where that person is homozygous and count reads of the
   other allele. Test every other person in the batch as the donor of those reads.

Run this whole block as written (it needs `pysam`, `numpy` and `pandas` only):

```python
import numpy as np
import pandas as pd
import pysam


def allele_counts(bam_path, sites, min_mapq=20, min_baseq=10):
    """Reads of the ref and the alt base at each site: [(ref_reads, alt_reads), ...].

    sites: (chrom, 1-based position, ref base, alt base), single-base variants only. Secondary,
    supplementary, duplicate-flagged and failed records are skipped. A record that repeats an
    earlier one (same read name, start and CIGAR) counts once, also when it has no duplicate flag."""
    out = []
    with pysam.AlignmentFile(bam_path) as bam:
        for chrom, pos, r, a in sites:
            seen, cnt = set(), {r: 0, a: 0}
            for col in bam.pileup(chrom, pos - 1, pos, truncate=True, stepper="nofilter",
                                  min_base_quality=0, max_depth=1_000_000,
                                  ignore_overlaps=False, ignore_orphans=False):
                for p in col.pileups:
                    rd = p.alignment
                    if p.query_position is None or rd.flag & 3844 or rd.mapping_quality < min_mapq:
                        continue
                    key = (rd.query_name, rd.reference_start, rd.cigarstring)
                    if key in seen:
                        continue
                    seen.add(key)
                    q = rd.query_qualities
                    if q is not None and q[p.query_position] < min_baseq:
                        continue
                    b = rd.query_sequence[p.query_position]
                    if b in cnt:
                        cnt[b] += 1
            out.append((cnt[r], cnt[a]))
    return out




def mismatch(ref, alt, min_depth=10):
    """Fraction of sites where two samples are homozygous for opposite alleles. Near 0 for two
    samples of one person (copy loss in a tumor does not raise it); high for two people."""
    n = ref + alt
    af = (alt / n.where(n >= min_depth)).to_numpy()
    lo, hi = af < 0.15, af > 0.85
    names = list(ref.columns)
    out = pd.DataFrame(np.nan, index=names, columns=names)
    for i, a in enumerate(names):
        for j, b in enumerate(names):
            both = (lo[:, i] | hi[:, i]) & (lo[:, j] | hi[:, j])
            if both.sum() >= 20:
                out.loc[a, b] = ((lo[:, i] & hi[:, j]) | (hi[:, i] & lo[:, j]))[both].mean()
    return out


def _fit(k, n, g, rounds=400):
    """Minor reads k of depth n as error plus a share of each column of g. Returns shares, log-lik."""
    c = np.full(g.shape[1], 0.01)
    for _ in range(rounds):
        p = np.maximum(g @ c, 1e-9)
        c = c * ((k / p) @ g) / np.maximum(n @ g, 1e-9)
    p = np.maximum(g @ c, 1e-9)
    return c, float(np.sum(k * np.log(p) - n * p))


def carryover_scan(ref, alt, normal_of, min_depth=15):
    """For every sample, which other person in the batch explains its minority reads.

    ref, alt: read counts, sites x samples. normal_of: tumor -> normal of the same person, AFTER
    any swapped pair is repaired. One row per (affected sample, donor person), strongest first."""
    n = ref + alt
    af = alt / n.where(n > 0)
    names = list(ref.columns)
    person = {s: s for s in names}
    person.update({t: m for t, m in normal_of.items()})
    mate = dict(normal_of)
    mate.update({m: t for t, m in normal_of.items()})
    # a site where most samples that are homozygous still show the other allele is an error site
    minor_frac = np.minimum(af, 1 - af)
    noisy = minor_frac.where(minor_frac < 0.2).median(axis=1) > 0.03
    cut = 2 * np.log(len(names) ** 2) + 14
    rows = []
    for x in names:
        up = af[x] > 0.5                                    # the sample's main allele is alt
        k = np.where(up, ref[x], alt[x]).astype(float)       # reads of the other allele
        ok = (n[x] >= min_depth) & (minor_frac[x] < 0.2) & ~noisy
        if x in normal_of:                                   # a tumor: its normal must be homozygous too
            m = normal_of[x]
            ok &= (n[m] >= 10) & (np.where(up, 1 - af[m], af[m]) < 0.08)
        share = {s: np.where(up, 1 - af[s], af[s]) for s in names if s != x}   # donor's share of that allele
        share = {s: np.where(np.nan_to_num(v) >= 0.1, np.nan_to_num(v), 0.0) for s, v in share.items()}
        donors = {}
        for s in share:                                      # one donor per person; the own tumor is a donor too
            if person[s] == person[x] and s in normal_of.values():
                continue                                     # a tumor's own normal cannot be told from the tumor here
            donors.setdefault(person[s], []).append(s)
        keys = list(donors)
        G = np.column_stack([np.ones(len(n))] + [np.max([share[s] for s in donors[d]], axis=0) for d in keys])
        idx = np.flatnonzero(ok.to_numpy())
        if len(idx) < 20:
            continue
        kk, nn, GG = k[idx], n[x].to_numpy(float)[idx], G[idx]
        c, ll = _fit(kk, nn, GG)
        for j, d in enumerate(keys):
            col = GG[:, j + 1]
            inf = col >= 0.25
            if inf.sum() < 5:
                continue
            _, ll0 = _fit(kk, nn, np.delete(GG, j + 1, axis=1))
            lr = 2 * (ll - ll0)
            # carryover shows at most of the donor's loci; a few loci with many reads are the
            # sample's own alleles. So the call must hold without its three strongest loci.
            rest = np.ones(len(kk), bool)
            rest[np.flatnonzero(inf)[np.argsort(-kk[inf])[:3]]] = False
            lr_rest = 2 * (_fit(kk[rest], nn[rest], GG[rest])[1]
                           - _fit(kk[rest], nn[rest], np.delete(GG[rest], j + 1, axis=1))[1])
            two = int((kk[inf] >= 2).sum())
            row = dict(affected=x, donor=",".join(donors[d]), share=round(c[j + 1], 4), LR=round(lr, 1),
                       loci=int(inf.sum()), loci_2_reads=two, minor_reads=int(kk[inf].sum()),
                       depth=int(nn[inf].sum()), minor_af=round(kk[inf].sum() / nn[inf].sum(), 4),
                       error=round(c[0], 4), LR_rest=round(lr_rest, 1),
                       called=bool(lr > cut and lr_rest > cut / 2 and two >= 3 and c[j + 1] >= 0.02),
                       source="")
            if len(donors[d]) == 2:                          # which of the donor's two samples: private alleles
                a, b = donors[d]
                notes = []
                for me, other in ((a, b), (b, a)):
                    pv = (share[me][idx] >= 0.25) & (share[other][idx] == 0)
                    notes.append(f"{me}: {int(pv.sum())} loci, {int(kk[pv].sum())} reads of {int(nn[pv].sum())}")
                    if pv.sum() and kk[pv].sum() >= 3 and kk[pv].sum() > 3 * c[0] * nn[pv].sum() + 3:
                        row["source"] = (row["source"] + "," + me).strip(",")
                row["private_alleles"] = "; ".join(notes)
            elif person[d] == person[x]:
                row["source"] = "own " + donors[d][0]
            rows.append(row)
    out = pd.DataFrame(rows)
    return out.sort_values("LR", ascending=False).reset_index(drop=True) if len(out) else out

# samples: name -> BAM path. tumors, normals: sample names as submitted.
sites = [(v.chrom, v.pos, v.ref, v.alts[0]) for v in pysam.VariantFile(vcf_path)
         if len(v.ref) == 1 and v.alts and len(v.alts[0]) == 1]
counts = {s: allele_counts(path, sites) for s, path in samples.items()}
ref = pd.DataFrame({s: [c[0] for c in counts[s]] for s in samples})
alt = pd.DataFrame({s: [c[1] for c in counts[s]] for s in samples})
mm = mismatch(ref, alt)
print(mm.round(3).to_string())
normal_of = {t: mm.loc[t, normals].idxmin() for t in tumors}     # each tumor's normal by the data
print("pairs by lowest mismatch:", normal_of)
scan = carryover_scan(ref, alt, normal_of)
pd.set_option("display.width", 250); pd.set_option("display.max_columns", 40)
print(scan.head(30).to_string())
called = scan[scan.called]
print(called.to_string())
print(len(called), "carryover findings to report, one per row above")
```
- `mismatch` near 0 means two samples of one person. A submitted pair with a high value, where
  each sample has a near-0 partner elsewhere in the batch, is a sample or manifest error. Report
  it, name the partner the data supports, and use the repaired pairs from there on.
- Each row of `scan` with `called` true is one finding: `affected` holds reads from `donor`.
  `share` is the estimated fraction; `minor_af`, `loci` and `loci_2_reads` are the evidence.
- The donor is a person. `donor` lists that person's samples. Name one of them as the source
  only when `source` names it (reads at alleles only that sample has). Otherwise give both.
- `source` "own ..." means the donor is the affected sample's own tumor: tumor-in-normal.
- Write the carryover findings from `called` in code, one output row per row of `called`. Do
  not retype them by hand: a typed list loses rows. Check that your output holds as many
  carryover rows as the block printed.
- A swapped pair and carryover are separate findings. A called row stays a finding when its
  samples were re-paired in step 2, and when the donor is the sample's own tumor. Report it
  next to the swap, under the record of the affected sample or of its repaired partner.
- Use the calls as they come. Do not add a pair by eye because its `minor_af` looks raised: a
  row that is not called is explained by another donor or by read errors. Do not drop a called
  row because the share is small.
- For a tumor the block uses only sites where its normal is homozygous. Copy loss in a tumor
  makes its own heterozygous sites look homozygous, and the reads of the lost allele there come
  from the patient's normal cells, not from another sample.
- The scan does not measure tumor content, copy number or coverage. A tumor that looks like its
  normal (low tumor content) gets no row here; judge that from the tumor's allele balance.
- Limits: a call needs depth. Below about 15 reads per site most sites are skipped. Tumor in the
  normal is found only when the tumor has alleles of its own at sites where the normal is
  homozygous.

## Reference documentation
- [VerifyBamID GitHub Repository](./references/github_com_Griffan_VerifyBamID.md)
- [Bioconda verifybamid2 Package Overview](./references/anaconda_org_channels_bioconda_packages_verifybamid2_overview.md)