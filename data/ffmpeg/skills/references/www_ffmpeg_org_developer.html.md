* [![FFmpeg](img/ffmpeg3d_white_20.png)
  FFmpeg](.)
* [About](about.html)
* [News](index.html#news)
* [Download](download.html)
* [Documentation](documentation.html)
* [Community](community.html)
  + [Code of Conduct](community.html#Code-of-Conduct)
  + [Mailing Lists](contact.html#MailingLists)
  + [IRC](contact.html#IRCChannels)
  + [Forums](contact.html#Forums)
  + [Bug Reports](bugreports.html)
  + [Wiki](https://trac.ffmpeg.org)
  + [Conferences](https://trac.ffmpeg.org/wiki/Conferences)
* [Developers](developer.html)
  + [Source Code](download.html#get-sources)+ [Contribute](developer.html#Introduction)
    + [FATE](http://fate.ffmpeg.org)
    + [Code Coverage](http://coverage.ffmpeg.org)
    + [Funding through SPI](spi.html)
* More
  + [Donate](donations.html)
  + [Hire Developers](consulting.html)
  + [Contact](contact.html)
  + [Security](security.html)
  + [Legal](legal.html)

# Developer Documentation

## Table of Contents

* [1 Introduction](#Introduction)
* [2 Coding Rules](#Coding-Rules-1)
  + [2.1 Language](#Language)
    - [2.1.1 SIMD/DSP](#SIMD_002fDSP-1)
    - [2.1.2 Other languages](#Other-languages)
  + [2.2 Code formatting conventions](#Code-formatting-conventions)
    - [2.2.1 Examples](#Examples)
    - [2.2.2 Vim configuration](#Vim-configuration)
    - [2.2.3 Emacs configuration](#Emacs-configuration)
  + [2.3 Comments](#Comments)
  + [2.4 Naming conventions](#Naming-conventions-1)
  + [2.5 Miscellaneous conventions](#Miscellaneous-conventions)
* [3 Development Policy](#Development-Policy-1)
  + [3.1 Code behaviour](#Code-behaviour)
  + [3.2 Patches/Committing](#Patches_002fCommitting)
  + [3.3 Code](#Code)
  + [3.4 Library public interfaces](#Library-public-interfaces)
    - [3.4.1 Adding new interfaces](#Adding-new-interfaces)
    - [3.4.2 Removing interfaces](#Removing-interfaces-1)
    - [3.4.3 Major version bumps](#Major-version-bumps-1)
  + [3.5 Documentation/Other](#Documentation_002fOther)
* [4 Submitting patches](#Submitting-patches-1)
* [5 New codecs or formats checklist](#New-codecs-or-formats-checklist)
* [6 Patch submission checklist](#Patch-submission-checklist)
* [7 Patch review process](#Patch-review-process)
* [8 Regression tests](#Regression-tests-1)
  + [8.1 Adding files to the fate-suite dataset](#Adding-files-to-the-fate_002dsuite-dataset)
  + [8.2 Visualizing Test Coverage](#Visualizing-Test-Coverage)
  + [8.3 Using Valgrind](#Using-Valgrind)
* [9 Maintenance process](#Maintenance-process)
  + [9.1 MAINTAINERS](#MAINTAINERS-1)
  + [9.2 Becoming a maintainer](#Becoming-a-maintainer-1)
* [10 Release process](#Release-process-1)
  + [10.1 Criteria for Point Releases](#Criteria-for-Point-Releases-1)
  + [10.2 Release Checklist](#Release-Checklist)

## [1 Introduction](#toc-Introduction)

This text is concerned with the development *of* FFmpeg itself. Information
on using the FFmpeg libraries in other programs can be found elsewhere, e.g. in:

* the installed header files
* [the Doxygen documentation](http://ffmpeg.org/doxygen/trunk/index.html)
  generated from the headers
* the examples under `doc/examples`

For more detailed legal information about the use of FFmpeg in
external programs read the `LICENSE` file in the source tree and
consult <https://ffmpeg.org/legal.html>.

If you modify FFmpeg code for your own use case, you are highly encouraged to
*submit your changes back to us*, using this document as a guide. There are
both pragmatic and ideological reasons to do so:

* Maintaining external changes to keep up with upstream development is
  time-consuming and error-prone. With your code in the main tree, it will be
  maintained by FFmpeg developers.
* FFmpeg developers include leading experts in the field who can find bugs or
  design flaws in your code.
* By supporting the project you find useful you ensure it continues to be
  maintained and developed.

All proposed code changes should be submitted for review to
[Forgejo](https://code.ffmpeg.org/FFmpeg/FFmpeg/pulls) or
the development mailing list, as
described in more detail in the [Submitting patches](#Submitting-patches) chapter. The code
should comply with the [Development Policy](#Development-Policy) and follow the [Coding Rules](#Coding-Rules).
The developer making the commit and the author are responsible for their changes
and should try to fix issues their commit causes.

## [2 Coding Rules](#toc-Coding-Rules-1)

### [2.1 Language](#toc-Language)

FFmpeg is mainly programmed in the ISO C11 language, except for the public
headers which must stay C99 compatible.

Compiler-specific extensions may be used with good reason, but must not be
depended on, i.e. the code must still compile and work with compilers lacking
the extension.

The following C99 features must not be used anywhere in the codebase:

* variable-length arrays;
* complex numbers;

#### [2.1.1 SIMD/DSP](#toc-SIMD_002fDSP-1)

As modern compilers are unable to generate efficient SIMD or other
performance-critical DSP code from plain C, handwritten assembly is used.
Usually such code is isolated in a separate function. Then the standard approach
is writing multiple versions of this function – a plain C one that works
everywhere and may also be useful for debugging, and potentially multiple
architecture-specific optimized implementations. Initialization code then
chooses the best available version at runtime and loads it into a function
pointer; the function in question is then always called through this pointer.

The specific syntax used for writing assembly is:

* NASM on x86;
* GAS on ARM and RISC-V.

A unit testing framework for assembly called `checkasm` lives under
`tests/checkasm`. All new assembly should come with `checkasm` tests;
adding tests for existing assembly that lacks them is also strongly encouraged.

#### [2.1.2 Other languages](#toc-Other-languages)

Other languages than C may be used in special cases:

* Compiler intrinsics or inline assembly when the code in question cannot be
  written in the standard way described in the [SIMD/DSP](#SIMD_002fDSP) section. This
  typically applies to code that needs to be inlined.
* Objective-C where required for interacting with macOS-specific interfaces.

### [2.2 Code formatting conventions](#toc-Code-formatting-conventions)

There are the following guidelines regarding the code style in files:

* Indent size is 4.
* The TAB character is forbidden outside of Makefiles as is any
  form of trailing whitespace. Commits containing either will be
  rejected by the git repository.
* You should try to limit your code lines to 80 characters; however, do so if
  and only if this improves readability.
* K&R coding style is used.

The presentation is one inspired by ’indent -i4 -kr -nut’.

#### [2.2.1 Examples](#toc-Examples)

Some notable examples to illustrate common code style in FFmpeg:

* Space around assignments and after
  `if`/`do`/`while`/`for` keywords:

  ```
  // Good
  if (condition)
      av_foo();
  ```

  ```
  // Good
  for (size_t i = 0; i < len; i++)
      av_bar(i);
  ```

  ```
  // Good
  size_t size = 0;
  ```

  However no spaces between the parentheses and condition, unless it helps
  readability of complex conditions, so the following should not be done:

  ```
  // Bad style
  if ( condition )
      av_foo();
  ```
* No unnecessary parentheses, unless it helps readability:

  ```
  // Good
  int fields = ilace ? 2 : 1;
  ```
* Don’t wrap single-line blocks in braces. Use braces only if there is an accompanying else statement. This keeps future code changes easier to keep track of.

  ```
  // Good
  if (bits_pixel == 24) {
      avctx->pix_fmt = AV_PIX_FMT_BGR24;
  } else if (bits_pixel == 8) {
      avctx->pix_fmt = AV_PIX_FMT_GRAY8;
  } else
      return AVERROR_INVALIDDATA;
  ```
* Avoid assignments in conditions where it makes sense:

  ```
  // Good
  video_enc->chroma_intra_matrix = av_mallocz(sizeof(*video_enc->chroma_intra_matrix) * 64)
  if (!video_enc->chroma_intra_matrix)
      return AVERROR(ENOMEM);
  ```

  ```
  // Bad style
  if (!(video_enc->chroma_intra_matrix = av_mallocz(sizeof(*video_enc->chroma_intra_matrix) * 64)))
      return AVERROR(ENOMEM);
  ```

  ```
  // Ok
  while ((entry = av_dict_iterate(options, entry)))
      av_log(ctx, AV_LOG_INFO, "Item '%s': '%s'\n", entry->key, entry->value);
  ```
* When declaring a pointer variable, the `*` goes with the variable not the type:

  ```
  // Good
  AVStream *stream;
  ```

  ```
  // Bad style
  AVStream* stream;
  ```
* When sensible, prefer a narrow variable scope, especially in for loops:

  ```
  // Good
  for (unsigned i = 0; i < submix->nb_elements; i++) {
      // Do something...
  }
  ```

  ```
  // Bad style
  unsigned i;
  //...
  for (i = 0; i < submix->nb_elements; i++) {
      // Do something...
  }
  ```

If you work on a file that does not follow these guidelines consistently,
change the parts that you are editing to follow these guidelines but do
not make unrelated changes in the file to make it conform to these.

#### [2.2.2 Vim configuration](#toc-Vim-configuration)

In order to configure Vim to follow FFmpeg formatting conventions, paste
the following snippet into your `.vimrc`:

```
" indentation rules for FFmpeg: 4 spaces, no tabs
set expandtab
set shiftwidth=4
set softtabstop=4
set cindent
set cinoptions=(0
" Allow tabs in Makefiles.
autocmd FileType make,automake set noexpandtab shiftwidth=8 softtabstop=8
" Trailing whitespace and tabs are forbidden, so highlight them.
highlight ForbiddenWhitespace ctermbg=red guibg=red
match ForbiddenWhitespace /\s\+$\|\t/
" Do not highlight spaces at the end of line while typing on that line.
autocmd InsertEnter * match ForbiddenWhitespace /\t\|\s\+\%#\@<!$/
```

#### [2.2.3 Emacs configuration](#toc-Emacs-configuration)

For Emacs, add these roughly equivalent lines to your `.emacs.d/init.el`:

```
(c-add-style "ffmpeg"
             '("k&r"
               (c-basic-offset . 4)
               (indent-tabs-mode . nil)
               (show-trailing-whitespace . t)
               (c-offsets-alist
                (statement-cont . (c-lineup-assignments +)))
               )
             )
(setq c-default-style "ffmpeg")
```

### [2.3 Comments](#toc-Comments)

Use the JavaDoc/Doxygen format (see examples below) so that code documentation
can be generated automatically. All nontrivial functions should have a comment
above them explaining what the function does, even if it is just one sentence.
All structures and their member variables should be documented, too.

Avoid Qt-style and similar Doxygen syntax with `!` in it, i.e. replace
`//!` with `///` and similar. Also @ syntax should be employed
for markup commands, i.e. use `@param` and not `\param`.

```
/**
 * @file
 * MPEG codec.
 * @author ...
 */

/**
 * Summary sentence.
 * more text ...
 * ...
 */
typedef struct Foobar {
    int var1; /**< var1 description */
    int var2; ///< var2 description
    /** var3 description */
    int var3;
} Foobar;

/**
 * Summary sentence.
 * more text ...
 * ...
 * @param my_parameter description of my_parameter
 * @return return value description
 */
int myfunc(int my_parameter)
...
```

### [2.4 Naming conventions](#toc-Naming-conventions-1)

Names of functions, variables, and struct members must be lowercase, using
underscores (\_) to separate words. For example, ‘`avfilter_get_video_buffer`’
is an acceptable function name and ‘`AVFilterGetVideo`’ is not.

Struct, union, enum, and typedeffed type names must use CamelCase. All structs
and unions should be typedeffed to the same name as the struct/union tag, e.g.
`typedef struct AVFoo { ... } AVFoo;`. Enums are typically not
typedeffed.

Enumeration constants and macros must be UPPERCASE, except for macros
masquerading as functions, which should use the function naming convention.

All identifiers in the libraries should be namespaced as follows:

* No namespacing for identifiers with file and lower scope (e.g. local variables,
  static functions), and struct and union members,
* The `ff_` prefix must be used for variables and functions visible outside
  of file scope, but only used internally within a single library, e.g.
  ‘`ff_w64_demuxer`’. This prevents name collisions when FFmpeg is statically
  linked.
* For variables and functions visible outside of file scope, used internally
  across multiple libraries, use `avpriv_` as prefix, for example,
  ‘`avpriv_report_missing_feature`’.
* All other internal identifiers, like private type or macro names, should be
  namespaced only to avoid possible internal conflicts. E.g. `H264_NAL_SPS`
  vs. `HEVC_NAL_SPS`.
* Each library has its own prefix for public symbols, in addition to the
  commonly used `av_` (`avformat_` for libavformat,
  `avcodec_` for libavcodec, `swr_` for libswresample, etc).
  Check the existing code and choose names accordingly.
* Other public identifiers (struct, union, enum, macro, type names) must use their
  library’s public prefix (`AV`, `Sws`, or `Swr`).

Furthermore, name space reserved for the system should not be invaded.
Identifiers ending in `_t` are reserved by
[POSIX](http://pubs.opengroup.org/onlinepubs/007904975/functions/xsh_chap02_02.html#tag_02_02_02).
Also avoid names starting with `__` or `_` followed by an uppercase
letter as they are reserved by the C standard. Names starting with `_`
are reserved at the file level and may not be used for externally visible
symbols. If in doubt, just avoid names starting with `_` altogether.

### [2.5 Miscellaneous conventions](#toc-Miscellaneous-conventions)

* Casts should be used only when necessary. Unneeded parentheses
  should also be avoided if they don’t make the code easier to understand.
* Where applicable, SI units shall be used. For example timeouts should use seconds as the fundamental unit not micro seconds.
  That means a bare value like ‘`1.0`’ must mean 1 second, ‘`50m`’ means 50 milliseconds. For weight, gram shall be used.

## [3 Development Policy](#toc-Development-Policy-1)

### [3.1 Code behaviour](#toc-Code-behaviour)

#### Correctness

The code must be valid. It must not crash, abort, access invalid pointers, leak
memory, cause data races or signed integer overflow, or otherwise cause
undefined behaviour. Error codes should be checked and, when applicable,
forwarded to the caller.

#### Thread- and library-safety

Our libraries may be called by multiple independent callers in the same process.
These calls may happen from any number of threads and the different call sites
may not be aware of each other - e.g. a user program may be calling our
libraries directly, and use one or more libraries that also call our libraries.
The code must behave correctly under such conditions.

#### Robustness

The code must treat as untrusted any bytestream received from a caller or read
from a file, network, etc. It must not misbehave when arbitrary data is sent to
it - typically it should print an error message and return
`AVERROR_INVALIDDATA` on encountering invalid input data.

