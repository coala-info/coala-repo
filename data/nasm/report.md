# nasm CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| nasm | PASS |  |
| nasm_ndisasm | PASS |  |

## nasm

### Tool Description
NASM assembler

### Metadata
- **Docker Image**: quay.io/biocontainers/nasm:2.11.08--0
- **Homepage**: https://github.com/netwide-assembler/nasm
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/nasm/overview
- **Total Downloads**: 5.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/netwide-assembler/nasm
- **Stars**: N/A
### Original Help Text
```text
usage: nasm [-@ response file] [-o outfile] [-f format] [-l listfile]
            [options...] [--] filename
    or nasm -v (or --v) for version info

    -t          assemble in SciTech TASM compatible mode
    -g          generate debug information in selected format
    -E (or -e)  preprocess only (writes output to stdout by default)
    -a          don't preprocess (assemble only)
    -M          generate Makefile dependencies on stdout
    -MG         d:o, missing files assumed generated
    -MF <file>  set Makefile dependency file
    -MD <file>  assemble and generate dependencies
    -MT <file>  dependency target name
    -MQ <file>  dependency target name (quoted)
    -MP         emit phony target

    -Z<file>    redirect error messages to file
    -s          redirect error messages to stdout

    -F format   select a debugging format

    -o outfile  write output to an outfile

    -f format   select an output format

    -l listfile write listing to a listfile

    -I<path>    adds a pathname to the include file path
    -O<digit>   optimize branch offsets
                -O0: No optimization
                -O1: Minimal optimization
                -Ox: Multipass optimization (default)

    -P<file>    pre-includes a file
    -D<macro>[=<value>] pre-defines a macro
    -U<macro>   undefines a macro
    -X<format>  specifies error reporting format (gnu or vc)
    -w+foo      enables warning foo (equiv. -Wfoo)
    -w-foo      disable warning foo (equiv. -Wno-foo)

    -h          show invocation summary and exit

--prefix,--postfix
  this options prepend or append the given argument to all
  extern and global variables

Warnings:
    error                   treat warnings as errors (default off)
    macro-params            macro calls with wrong parameter count (default on)
    macro-selfref           cyclic macro references (default off)
    macro-defaults          macros with more default than optional parameters (default on)
    orphan-labels           labels alone on lines without trailing `:' (default on)
    number-overflow         numeric constant does not fit (default on)
    gnu-elf-extensions      using 8- or 16-bit relocation in ELF32, a GNU extension (default off)
    float-overflow          floating point overflow (default on)
    float-denorm            floating point denormal (default off)
    float-underflow         floating point underflow (default off)
    float-toolong           too many digits in floating-point number (default on)
    user                    %warning directives (default on)
    lock                    lock prefix on unlockable instructions (default on)
    hle                     invalid hle prefixes (default on)
    bnd                     invalid bnd prefixes (default on)

response files should contain command line parameters, one per line.

For a list of valid output formats, use -hf.
For a list of debug formats, use -f <form> -y.
```

## nasm_ndisasm

### Tool Description
NDISASM - the Netwide Disassembler for x86 binary files.

### Metadata
- **Docker Image**: quay.io/biocontainers/nasm:2.11.08--0
- **Homepage**: https://github.com/netwide-assembler/nasm
- **Package**: https://anaconda.org/channels/bioconda/packages/nasm/overview
- **Validation**: PASS

### Original Help Text
```text
Unable to find image 'quay.io/biocontainers/nasm:2.11.08--0' locally
2.11.08--0: Pulling from biocontainers/nasm
8f4bf927a74f: Pulling fs layer
8f4bf927a74f: Download complete
8f4bf927a74f: Pull complete
Digest: sha256:116be882abb207a68aab933453bc48883779d02a8ac07067ecff7033dd8d8e70
Status: Downloaded newer image for quay.io/biocontainers/nasm:2.11.08--0
usage: ndisasm [-a] [-i] [-h] [-r] [-u] [-b bits] [-o origin] [-s sync...]
               [-e bytes] [-k start,bytes] [-p vendor] file
   -a or -i activates auto (intelligent) sync
   -u same as -b 32
   -b 16, -b 32 or -b 64 sets the processor mode
   -h displays this text
   -r or -v displays the version number
   -e skips <bytes> bytes of header
   -k avoids disassembling <bytes> bytes from position <start>
   -p selects the preferred vendor instruction set (intel, amd, cyrix, idt)
```
