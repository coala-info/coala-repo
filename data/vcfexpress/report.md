# vcfexpress CWL Generation Report

## vcfexpress_filter

### Tool Description
Filter a VCF/BCF and optionally print by template expression. If no template is given the output will be VCF/BCF

### Metadata
- **Docker Image**: quay.io/biocontainers/vcfexpress:0.3.4--h3ab6199_0
- **Homepage**: https://github.com/brentp/vcfexpress/
- **Package**: https://anaconda.org/channels/bioconda/packages/vcfexpress/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/vcfexpress/overview
- **Total Downloads**: 481
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/brentp/vcfexpress
- **Stars**: N/A
### Original Help Text
```text
vcfexpress-filter 0.3.4
Filter a VCF/BCF and optionally print by template expression. If no template is given the output will be VCF/BCF

Usage: vcfexpress filter [OPTIONS] <PATH>

Arguments:
  <PATH>  Path to input VCF or BCF file

Options:
  -e, --expression <EXPRESSION>
          boolean Lua expression(s) to filter the VCF or BCF file
  -s, --set-expression <SET_EXPRESSION>
          expression(s) to set existing INFO field(s) (new ones can be added in prelude) e.g. --set-expression "AFmax=math.max(variant:info('AF'), variant:info('AFx'))"
  -t, --template <TEMPLATE>
          template expression in luau: https://luau-lang.org/syntax#string-interpolation. e.g. '{variant.chrom}:{variant.pos}'
  -p, --lua-prelude <LUA_PRELUDE>
          File(s) containing lua(u) code to run once before any variants are processed. `header` is available here to access or modify the header
  -o, --output <OUTPUT>
          Optional output file. Default is stdout
  -b, --sandbox
          Run lua code in https://luau.org/sandbox
  -h, --help
          Print help
  -V, --version
          Print version
```

