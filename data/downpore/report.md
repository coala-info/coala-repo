# downpore CWL Generation Report

## downpore_overlap

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/downpore:0.3.4--h375a9b1_0
- **Homepage**: https://github.com/jteutenberg/downpore
- **Package**: https://anaconda.org/channels/bioconda/packages/downpore/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/downpore/overview
- **Total Downloads**: 22.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/jteutenberg/downpore
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
panic: runtime error: index out of range [3] with length 3

goroutine 1 [running]:
main.parseArgs(0x589d40, 0xc00000c080, 0x7)
	/opt/conda/conda-bld/downpore_1616523486763/work/src/github.com/jteutenberg/downpore/downpore.go:48 +0x3ec
main.main()
	/opt/conda/conda-bld/downpore_1616523486763/work/src/github.com/jteutenberg/downpore/downpore.go:86 +0xb8b
```


## downpore_map

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/downpore:0.3.4--h375a9b1_0
- **Homepage**: https://github.com/jteutenberg/downpore
- **Package**: https://anaconda.org/channels/bioconda/packages/downpore/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
K-mer counting complete. Preparing to start indexing and querying...
panic: runtime error: invalid memory address or nil pointer dereference
[signal SIGSEGV: segmentation violation code=0x1 addr=0x60 pc=0x4d8c55]

goroutine 1 [running]:
github.com/jteutenberg/downpore/seeds.(*SeedIndex).AddSingleSeeds(0xc00011c210, 0x0, 0x0, 0x28, 0xc00992c000, 0x400000, 0x400000)
	/opt/conda/conda-bld/downpore_1616523486763/work/src/github.com/jteutenberg/downpore/seeds/seeds.go:170 +0x75
github.com/jteutenberg/downpore/mapping.NewMapper(0x0, 0x0, 0x400001, 0xb, 0xc00992c000, 0x400000, 0x400000, 0x28, 0x3e8, 0x2710, ...)
	/opt/conda/conda-bld/downpore_1616523486763/work/src/github.com/jteutenberg/downpore/mapping/mapping.go:70 +0x14a
github.com/jteutenberg/downpore/commands.(*mapCommand).Run(0xc00000c100, 0xc000010240)
	/opt/conda/conda-bld/downpore_1616523486763/work/src/github.com/jteutenberg/downpore/commands/map.go:73 +0x985
main.main()
	/opt/conda/conda-bld/downpore_1616523486763/work/src/github.com/jteutenberg/downpore/downpore.go:86 +0xbac
```


## downpore_trim

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/downpore:0.3.4--h375a9b1_0
- **Homepage**: https://github.com/jteutenberg/downpore
- **Package**: https://anaconda.org/channels/bioconda/packages/downpore/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
2026/02/25 14:27:16 0 / 0 front adapters identified with high identity matches.
2026/02/25 14:27:16 0 / 0 back adapters identified with high identity matches.
2026/02/25 14:27:16 Trimming ends and indexing all sequences against 0 adapters...
2026/02/25 14:27:16 0 sequences require splitting
panic: runtime error: integer divide by zero

goroutine 1 [running]:
github.com/jteutenberg/downpore/trim.(*Trimmer).PrintStats(0xc00007e000, 0x58b580, 0xc0000d2280)
	/opt/conda/conda-bld/downpore_1616523486763/work/src/github.com/jteutenberg/downpore/trim/trim.go:267 +0x41e
github.com/jteutenberg/downpore/commands.(*trimCommand).Run(0xc0000ae0e0, 0xc0000982a0)
	/opt/conda/conda-bld/downpore_1616523486763/work/src/github.com/jteutenberg/downpore/commands/trim.go:42 +0xa72
main.main()
	/opt/conda/conda-bld/downpore_1616523486763/work/src/github.com/jteutenberg/downpore/downpore.go:86 +0xbac
```


## downpore_subseq

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/downpore:0.3.4--h375a9b1_0
- **Homepage**: https://github.com/jteutenberg/downpore
- **Package**: https://anaconda.org/channels/bioconda/packages/downpore/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
panic: runtime error: index out of range [3] with length 3

goroutine 1 [running]:
main.parseArgs(0x589d80, 0xc000126100, 0x6)
	/opt/conda/conda-bld/downpore_1616523486763/work/src/github.com/jteutenberg/downpore/downpore.go:48 +0x3ec
main.main()
	/opt/conda/conda-bld/downpore_1616523486763/work/src/github.com/jteutenberg/downpore/downpore.go:86 +0xb8b
```


## downpore_consensus

### Tool Description
Generates a consensus sequence from multiple input sequences using dynamic time warping.

### Metadata
- **Docker Image**: quay.io/biocontainers/downpore:0.3.4--h375a9b1_0
- **Homepage**: https://github.com/jteutenberg/downpore
- **Package**: https://anaconda.org/channels/bioconda/packages/downpore/overview
- **Validation**: PASS

### Original Help Text
```text
panic: runtime error: index out of range [0] with length 0

goroutine 42 [running]:
github.com/jteutenberg/downpore/sequence/alignment.(*dtw).nextStates(0xc0000ba000, 0xc0000c2000, 0x0, 0x64, 0xc00000c060, 0x0)
	/opt/conda/conda-bld/downpore_1616523486763/work/src/github.com/jteutenberg/downpore/sequence/alignment/alignment.go:576 +0x5576
github.com/jteutenberg/downpore/sequence/alignment.(*dtw).GlobalConsensus.func1(0xc000016021, 0xc0000ba000, 0xc00000c040, 0xc00000c060, 0xc0000c0000, 0xc00007a060, 0xc00014a000, 0x0, 0x64, 0xc00007a0c0)
	/opt/conda/conda-bld/downpore_1616523486763/work/src/github.com/jteutenberg/downpore/sequence/alignment/alignment.go:1169 +0x93
created by github.com/jteutenberg/downpore/sequence/alignment.(*dtw).GlobalConsensus
	/opt/conda/conda-bld/downpore_1616523486763/work/src/github.com/jteutenberg/downpore/sequence/alignment/alignment.go:1164 +0x29c
```


## downpore_align

### Tool Description
Aligns sequences using dynamic time warping.

### Metadata
- **Docker Image**: quay.io/biocontainers/downpore:0.3.4--h375a9b1_0
- **Homepage**: https://github.com/jteutenberg/downpore
- **Package**: https://anaconda.org/channels/bioconda/packages/downpore/overview
- **Validation**: PASS

### Original Help Text
```text
panic: runtime error: index out of range [0] with length 0

goroutine 21 [running]:
github.com/jteutenberg/downpore/sequence/alignment.(*dtw).nextStates(0xc0000ae000, 0xc0000b6000, 0x0, 0x64, 0xc00000c0a0, 0x0)
	/opt/conda/conda-bld/downpore_1616523486763/work/src/github.com/jteutenberg/downpore/sequence/alignment/alignment.go:576 +0x5576
github.com/jteutenberg/downpore/sequence/alignment.(*dtw).GlobalAlignment.func1(0xc000094041, 0xc0000ae000, 0xc00000c040, 0xc00000c0a0, 0xc0000b4000, 0xc0006080c0, 0xc000608120)
	/opt/conda/conda-bld/downpore_1616523486763/work/src/github.com/jteutenberg/downpore/sequence/alignment/alignment.go:1223 +0x66
created by github.com/jteutenberg/downpore/sequence/alignment.(*dtw).GlobalAlignment
	/opt/conda/conda-bld/downpore_1616523486763/work/src/github.com/jteutenberg/downpore/sequence/alignment/alignment.go:1221 +0x231
```


## downpore_correct

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/downpore:0.3.4--h375a9b1_0
- **Homepage**: https://github.com/jteutenberg/downpore
- **Package**: https://anaconda.org/channels/bioconda/packages/downpore/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
panic: runtime error: index out of range [3] with length 3

goroutine 1 [running]:
main.parseArgs(0x589c80, 0xc00000c200, 0x7)
	/opt/conda/conda-bld/downpore_1616523486763/work/src/github.com/jteutenberg/downpore/downpore.go:48 +0x3ec
main.main()
	/opt/conda/conda-bld/downpore_1616523486763/work/src/github.com/jteutenberg/downpore/downpore.go:86 +0xb8b
```


## downpore_kmers

### Tool Description
Compute k-mers from a FASTQ file.

### Metadata
- **Docker Image**: quay.io/biocontainers/downpore:0.3.4--h375a9b1_0
- **Homepage**: https://github.com/jteutenberg/downpore
- **Package**: https://anaconda.org/channels/bioconda/packages/downpore/overview
- **Validation**: PASS

### Original Help Text
```text
panic: runtime error: invalid memory address or nil pointer dereference
[signal SIGSEGV: segmentation violation code=0x1 addr=0x90 pc=0x51691b]

goroutine 1 [running]:
github.com/jteutenberg/downpore/commands.(*kmersCommand).doLong(0xc0000c42c0, 0x4, 0xa, 0xc00009a5a0)
	/opt/conda/conda-bld/downpore_1616523486763/work/src/github.com/jteutenberg/downpore/commands/kmers.go:356 +0x43b
github.com/jteutenberg/downpore/commands.(*kmersCommand).Run(0xc0000c42c0, 0xc00009a5a0)
	/opt/conda/conda-bld/downpore_1616523486763/work/src/github.com/jteutenberg/downpore/commands/kmers.go:393 +0xf3c
main.main()
	/opt/conda/conda-bld/downpore_1616523486763/work/src/github.com/jteutenberg/downpore/downpore.go:86 +0xbac
```

