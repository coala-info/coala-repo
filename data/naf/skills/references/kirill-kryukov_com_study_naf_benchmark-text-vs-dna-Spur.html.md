# [NAF](/study/naf/): Text vs DNA mode

The NAF compressor has "--dna" mode for DNA sequences, and "--text" mode that supports any text sequences.
Since "--text" can be used for DNA data as well, the question is - which mode should be used for DNA sequences?
This page briefly explores this question.

### Theoretical considerations

* For compression time,
  in "--dna" mode, the sequences are first converted into 4-bit representation,
  which is then fed into zstd compressor.
  Since zstd now deals with twice smaller data, the compression should occur twice faster
  (which is the rationale for using 4-bit presentation in the first place).
  And the process of converting into 4-bit is so fast that its time can be ignored here.
* As for compactness, the difference should be small at stronger compression levels.
  However with low (fast) compression levels, "--dna" mode should provide measurable advantage.

### Benchmark

I benchmarked ennaf settings from "-1" to "-22" with "--dna" and "--text" on a test genome.

* Test dataset: *Strongylocentrotus purpuratus* (sea urchin) genome, RefSeq accession GCF\_000002235.4.
  + Size of FASTA file: 1,007,867,539 bytes
  + Number of sequences: 31,897

### Results

|  |  |
| --- | --- |
| ![](images/text-vs-dna/Text-vs-DNA-size-Spur.svg) | ![](images/text-vs-dna/Text-vs-DNA-time-Spur.svg) |
| ![](images/text-vs-dna/Text-vs-DNA-size-perc-Spur.svg) | ![](images/text-vs-dna/Text-vs-DNA-time-perc-Spur.svg) |
| ![](images/text-vs-dna/Text-vs-DNA-size-vs-c-time-Spur.svg) | ![](images/text-vs-dna/Text-vs-DNA-size-vs-d-time-Spur.svg) |

### Interpretation

* "--dna" mode speed (for both compression and decompression) is clearly better than "--text" mode at extreme levels ("-1" and "-22").
* For compactness, "--dna" mode is much better than "--text" at "-1" level.
  At "-22" level the difference is small.

### Other datasets

I tried a number of other datasets (data not shown here), and they show similar overall pattern.
Especially the speed difference is very similar to the above results.

As for compactness, at "-1" level, "--dna" mode is always much better.
At "-22" the two modes are close, and sometimes "--text" is more compact.
On average, with the datasets I tried so far, "--dna" has stronger compression even at "-22" level.

### What about the other modes?

The "--rna" mode performs identically with "--dna" (the only difference between them is the accepted sequence alphabet),
and "--protein" mode is just a more restrictive version of "--text".
So these results apply to "--rna" and "--protein" modes as well.

One thing to note is that with protein sequences,
there is no performance (size or speed) difference between "--protein" and "--text" modes.
The only reason to use "--protein" mode is for stricter protein-specific validation of the alphabet used in the input.

### Conclusion

"--dna" mode should be used for DNA sequences whenever possible, as it's faster and more compact.
Similarly, "--rna" should be used with RNA data.
For protein data, "--protein" and "--text" modes don't differ in speed or compactness, but only in how they validate the input.

Of course, if your data includes non-standard characters, you may have to use "--text" mode regardless,
as preserving the data intact is usually more important than any performance gain.

* © 2018-2019 [Kirill Kryukov](http://kirill-kryukov.com/kirr/)