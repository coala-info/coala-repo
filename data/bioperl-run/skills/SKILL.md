---
name: bioperl-run
description: "Bioperl-run provides a consistent Perl interface to execute and manage external bioinformatics software using BioPerl objects. Use when user asks to run sequence alignment tools, perform homology searches, predict genes, or build phylogenetic trees through Perl scripts."
homepage: https://github.com/bioperl/bioperl-run
---


# bioperl-run

## Overview
bioperl-run is a specialized suite of Perl modules designed to provide a consistent interface to a wide array of external bioinformatics software. Instead of manually managing command-line arguments and file conversions, this tool allows you to treat external programs as BioPerl "factories." It handles the translation of BioPerl objects (such as `Bio::Seq` or `Bio::Align::AlignI`) into the specific input formats required by external tools and parses the resulting output back into standard BioPerl objects.

## Core Usage Patterns

### The Factory Pattern
Most wrappers in bioperl-run follow a "factory" instantiation pattern. You create a runner object, set parameters, and then pass your data objects to a run method.

```perl
use Bio::Tools::Run::Alignment::ClustalW;

# Initialize the factory with program parameters
my $factory = Bio::Tools::Run::Alignment::ClustalW->new(
    -matrix => 'BLOSUM',
    -gapopen => 10
);

# Execute the tool using BioPerl objects
my $aln = $factory->align($seq_array_ref);
```

### Common Wrappers Supported
Based on the distribution contents, the following categories of tools are natively supported:
*   **Sequence Alignment**: ClustalW, T-Coffee, Bowtie, BWA, StandAloneFasta.
*   **Search & Local Alignment**: BLAST+ (via `SABlastPlus`), Meme, Exonerate.
*   **Phylogeny**: PhyML, ExaML, Gumby.
*   **Assembly**: Phrap, Cap3, TigrAssembler, Newbler, Minimo.
*   **Gene Prediction**: Eponine, Genemark.

### Environment Configuration
BioPerl wrappers require the underlying executable to be in your PATH or explicitly defined via environment variables.
*   **Check Executables**: Use the `program_dir` or `program_name` methods to verify the wrapper can find the binary.
*   **Environment Variables**: Many wrappers look for specific variables (e.g., `CLUSTALDIR`, `BLASTDIR`) to locate their respective binaries.

## Best Practices and Expert Tips

### Handling Large Datasets
When working with high-throughput tools like Bowtie or BWA, avoid loading all sequences into memory as BioPerl objects if possible. Use the wrappers' ability to take file paths as input:
```perl
# Instead of passing an array of objects, pass the filename
my $db = "reference_genome.fasta";
my $query = "reads.fastq";
my $search_obj = Bio::Tools::Run::Bowtie->new(-db => $db);
$search_obj->run($query);
```

### Parameter Mapping
BioPerl-run wrappers typically map Perl-style arguments (with a leading dash) to the native command-line flags of the tool.
*   If a tool uses `-i` for input, the wrapper often uses `-i` or `-input`.
*   Consult the specific module's POD (Plain Old Documentation) to see the exact mapping, as some wrappers normalize flag names across different versions of the same tool (e.g., BLAST vs. BLAST+).

### Error Handling
Always check if the executable is available before attempting a run to prevent script crashes:
```perl
my $wrapper = Bio::Tools::Run::Alignment::ClustalW->new();
unless ($wrapper->executable) {
    die "ClustalW executable not found in PATH or CLUSTALDIR";
}
```

### Cleaning Up
Wrappers often create temporary files in the system's temp directory. While most attempt to clean up after themselves, in long-running loops, you should monitor disk usage or explicitly set the `-tempdir` parameter to a managed location.

## Reference documentation
- [BioPerl-run Main Repository](./references/github_com_bioperl_bioperl-run.md)
- [Commit History and Module List](./references/github_com_bioperl_bioperl-run_commits_master.md)
- [Known Issues and Tool Compatibility](./references/github_com_bioperl_bioperl-run_issues.md)