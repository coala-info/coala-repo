# downpore CWL Generation Report

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

## Metadata
- **Skill**: generated
