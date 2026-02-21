---
name: pyhmmer
description: pyhmmer provides Cython bindings to the HMMER3 software suite, allowing for seamless integration of profile HMM searches into Python workflows.
homepage: https://github.com/althonos/pyhmmer
---

# pyhmmer

## Overview
pyhmmer provides Cython bindings to the HMMER3 software suite, allowing for seamless integration of profile HMM searches into Python workflows. It is designed for high-performance bioinformatics, offering direct access to the Easel and Plan7 libraries. Use this skill to implement efficient sequence homology searches, domain annotations, and multiple sequence alignments while maintaining all data in memory. It is particularly useful when working with sequences already loaded via Biopython or Pyrodigal, or when building automated pipelines that require fine-grained control over HMMER parameters and output retrieval.

## Core Usage Patterns

### Loading Sequences and HMMs
Always use context managers to ensure proper resource deallocation. For performance, use "digital" mode to store sequences in their binary representation.

```python
import pyhmmer.easel
import pyhmmer.plan7

# Load sequences in digital mode
with pyhmmer.easel.SequenceFile("sequences.faa", digital=True) as seq_file:
    sequences = seq_file.read_block()

# Load HMM profiles
with pyhmmer.plan7.HMMFile("profiles.hmm") as hmm_file:
    hmms = list(hmm_file)
```

### Running Searches
The `hmmsearch` function is the primary tool for searching HMMs against a sequence database. It returns an iterable of `TopHits` objects.

```python
# Run search with parallelization
for hits in pyhmmer.hmmer.hmmsearch(hmms, sequences, cpus=4):
    print(f"HMM {hits.query.name.decode()} found {len(hits)} hits")
    for hit in hits:
        if hit.is_reported():
            print(f"Target: {hit.name.decode()}, E-value: {hit.evalue}")
```

### Building HMMs from Alignments
You can build new HMM profiles from Multiple Sequence Alignments (MSA) using `hmmbuild`.

```python
with pyhmmer.easel.MSAFile("alignment.sto", digital=True) as msa_file:
    msa = msa_file.read()
    
alphabet = pyhmmer.easel.Alphabet.amino()
builder = pyhmmer.plan7.Builder(alphabet)
hmm, profile, optimized = builder.build_msa(msa)
```

## Expert Tips and Best Practices

- **Digital vs. Text Mode**: Always prefer `digital=True` when reading sequences or MSAs. This converts strings to internal Easel bytecodes once, preventing expensive re-conversion during every HMM comparison.
- **Parallelization Strategy**: 
    - For `hmmsearch`, performance typically scales best with the number of physical cores.
    - For `phmmer`, you can often benefit from using logical cores (hyperthreading).
    - Set `cpus=0` to automatically use all available CPUs.
- **Memory Management**: When dealing with very large sequence databases, use `seq_file.read_block()` to process data in chunks rather than loading an entire multi-gigabyte FASTA into memory.
- **Handling Results**: The `TopHits` object is a collection of `Hit` objects. Use `hits.sort()` to order them by E-value or score before processing. Note that `hit.name` and other identifiers are returned as `bytes`, so use `.decode()` for string manipulation.
- **Alphabet Consistency**: Ensure the `Alphabet` (DNA, RNA, or Amino) matches between your HMMs and your sequences. `pyhmmer` will raise a `ValueError` if there is a mismatch.

## Reference documentation
- [PyHMMER GitHub Repository](./references/github_com_althonos_pyhmmer.md)
- [Bioconda PyHMMER Overview](./references/anaconda_org_channels_bioconda_packages_pyhmmer_overview.md)