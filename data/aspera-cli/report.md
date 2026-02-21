# aspera-cli CWL Generation Report

## aspera-cli

### Tool Description
FAIL to generate CWL: aspera-cli not found in Singularity image. The image may not provide this executable.

### Metadata
- **Docker Image**: quay.io/biocontainers/aspera-cli:4.20.0--hdfd78af_0
- **Homepage**: https://github.com/IBM/aspera-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/aspera-cli/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/aspera-cli/overview
- **Total Downloads**: 7.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/IBM/aspera-cli
- **Stars**: N/A
### Generation Failed

FAIL to generate CWL: aspera-cli not found in Singularity image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: aspera-cli not found in Singularity image. The image may not provide this executable.



### Original Help Text
```text

```


## Metadata
- **Skill**: generated

## aspera-cli_ascli

### Tool Description
Aspera CLI tool for file transfer and management. Note: The provided help text contains a Ruby LoadError (missing 'webrick') and does not list available arguments.

### Metadata
- **Docker Image**: quay.io/biocontainers/aspera-cli:4.20.0--hdfd78af_0
- **Homepage**: https://github.com/IBM/aspera-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/aspera-cli/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
<internal:/usr/local/lib/ruby/3.4.0/rubygems/core_ext/kernel_require.rb>:136:in 'Kernel#require': cannot load such file -- webrick (LoadError)
	from <internal:/usr/local/lib/ruby/3.4.0/rubygems/core_ext/kernel_require.rb>:136:in 'Kernel#require'
	from /usr/local/share/rubygems/gems/aspera-cli-4.20.0/lib/aspera/web_server_simple.rb:3:in '<top (required)>'
	from <internal:/usr/local/lib/ruby/3.4.0/rubygems/core_ext/kernel_require.rb>:136:in 'Kernel#require'
	from <internal:/usr/local/lib/ruby/3.4.0/rubygems/core_ext/kernel_require.rb>:136:in 'Kernel#require'
	from /usr/local/share/rubygems/gems/aspera-cli-4.20.0/lib/aspera/web_auth.rb:3:in '<top (required)>'
	from <internal:/usr/local/lib/ruby/3.4.0/rubygems/core_ext/kernel_require.rb>:136:in 'Kernel#require'
	from <internal:/usr/local/lib/ruby/3.4.0/rubygems/core_ext/kernel_require.rb>:136:in 'Kernel#require'
	from /usr/local/share/rubygems/gems/aspera-cli-4.20.0/lib/aspera/oauth/web.rb:5:in '<top (required)>'
	from <internal:/usr/local/lib/ruby/3.4.0/rubygems/core_ext/kernel_require.rb>:136:in 'Kernel#require'
	from <internal:/usr/local/lib/ruby/3.4.0/rubygems/core_ext/kernel_require.rb>:136:in 'Kernel#require'
	from /usr/local/share/rubygems/gems/aspera-cli-4.20.0/lib/aspera/oauth.rb:6:in '<top (required)>'
	from <internal:/usr/local/lib/ruby/3.4.0/rubygems/core_ext/kernel_require.rb>:136:in 'Kernel#require'
	from <internal:/usr/local/lib/ruby/3.4.0/rubygems/core_ext/kernel_require.rb>:136:in 'Kernel#require'
	from /usr/local/share/rubygems/gems/aspera-cli-4.20.0/lib/aspera/rest.rb:7:in '<top (required)>'
	from <internal:/usr/local/lib/ruby/3.4.0/rubygems/core_ext/kernel_require.rb>:136:in 'Kernel#require'
	from <internal:/usr/local/lib/ruby/3.4.0/rubygems/core_ext/kernel_require.rb>:136:in 'Kernel#require'
	from /usr/local/share/rubygems/gems/aspera-cli-4.20.0/lib/aspera/uri_reader.rb:4:in '<top (required)>'
	from <internal:/usr/local/lib/ruby/3.4.0/rubygems/core_ext/kernel_require.rb>:136:in 'Kernel#require'
	from <internal:/usr/local/lib/ruby/3.4.0/rubygems/core_ext/kernel_require.rb>:136:in 'Kernel#require'
	from /usr/local/share/rubygems/gems/aspera-cli-4.20.0/lib/aspera/cli/extended_value.rb:4:in '<top (required)>'
	from <internal:/usr/local/lib/ruby/3.4.0/rubygems/core_ext/kernel_require.rb>:136:in 'Kernel#require'
	from <internal:/usr/local/lib/ruby/3.4.0/rubygems/core_ext/kernel_require.rb>:136:in 'Kernel#require'
	from /usr/local/share/rubygems/gems/aspera-cli-4.20.0/lib/aspera/cli/manager.rb:3:in '<top (required)>'
	from <internal:/usr/local/lib/ruby/3.4.0/rubygems/core_ext/kernel_require.rb>:136:in 'Kernel#require'
	from <internal:/usr/local/lib/ruby/3.4.0/rubygems/core_ext/kernel_require.rb>:136:in 'Kernel#require'
	from /usr/local/share/rubygems/gems/aspera-cli-4.20.0/lib/aspera/cli/main.rb:3:in '<top (required)>'
	from <internal:/usr/local/lib/ruby/3.4.0/rubygems/core_ext/kernel_require.rb>:136:in 'Kernel#require'
	from <internal:/usr/local/lib/ruby/3.4.0/rubygems/core_ext/kernel_require.rb>:136:in 'Kernel#require'
	from /usr/local/bin/ascli:25:in '<main>'
<internal:/usr/local/lib/ruby/3.4.0/rubygems/core_ext/kernel_require.rb>:136:in 'Kernel#require': cannot load such file -- aspera/cli/main (LoadError)
	from <internal:/usr/local/lib/ruby/3.4.0/rubygems/core_ext/kernel_require.rb>:136:in 'Kernel#require'
	from /usr/local/bin/ascli:21:in '<main>'
```

