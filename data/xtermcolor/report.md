# xtermcolor CWL Generation Report

## xtermcolor_convert

### Tool Description
256 terminal color library

### Metadata
- **Docker Image**: quay.io/biocontainers/xtermcolor:1.3--pyh864c0ab_2
- **Homepage**: https://github.com/broadinstitute/xtermcolor
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/xtermcolor/overview
- **Total Downloads**: 8.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/broadinstitute/xtermcolor
- **Stars**: N/A
### Original Help Text
```text
usage: xtermcolor [-h] [--color COLOR] [--compat {xterm,vt100}] {convert,list}

xtermcolor: 256 terminal color library

positional arguments:
  {convert,list}        Actions

optional arguments:
  -h, --help            show this help message and exit
  --color COLOR         Color to convert
  --compat {xterm,vt100}
                        Compatibility mode. Defaults to xterm.
```


## xtermcolor_list

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/xtermcolor:1.3--pyh864c0ab_2
- **Homepage**: https://github.com/broadinstitute/xtermcolor
- **Package**: Not found
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
[38;5;0mansi=0; rgb=#000000; printf="\033[38;5;0m%s\033[0m"[0m
[38;5;1mansi=1; rgb=#800000; printf="\033[38;5;1m%s\033[0m"[0m
[38;5;2mansi=2; rgb=#008000; printf="\033[38;5;2m%s\033[0m"[0m
[38;5;3mansi=3; rgb=#808000; printf="\033[38;5;3m%s\033[0m"[0m
[38;5;4mansi=4; rgb=#000080; printf="\033[38;5;4m%s\033[0m"[0m
[38;5;5mansi=5; rgb=#800080; printf="\033[38;5;5m%s\033[0m"[0m
[38;5;6mansi=6; rgb=#008080; printf="\033[38;5;6m%s\033[0m"[0m
[38;5;7mansi=7; rgb=#c0c0c0; printf="\033[38;5;7m%s\033[0m"[0m
[38;5;8mansi=8; rgb=#808080; printf="\033[38;5;8m%s\033[0m"[0m
[38;5;9mansi=9; rgb=#ff0000; printf="\033[38;5;9m%s\033[0m"[0m
[38;5;10mansi=10; rgb=#00ff00; printf="\033[38;5;10m%s\033[0m"[0m
[38;5;11mansi=11; rgb=#ffff00; printf="\033[38;5;11m%s\033[0m"[0m
[38;5;12mansi=12; rgb=#0000ff; printf="\033[38;5;12m%s\033[0m"[0m
[38;5;13mansi=13; rgb=#ff00ff; printf="\033[38;5;13m%s\033[0m"[0m
[38;5;14mansi=14; rgb=#00ffff; printf="\033[38;5;14m%s\033[0m"[0m
[38;5;15mansi=15; rgb=#ffffff; printf="\033[38;5;15m%s\033[0m"[0m
[38;5;16mansi=16; rgb=#000000; printf="\033[38;5;16m%s\033[0m"[0m
[38;5;17mansi=17; rgb=#00005f; printf="\033[38;5;17m%s\033[0m"[0m
[38;5;18mansi=18; rgb=#000087; printf="\033[38;5;18m%s\033[0m"[0m
[38;5;19mansi=19; rgb=#0000af; printf="\033[38;5;19m%s\033[0m"[0m
[38;5;20mansi=20; rgb=#0000d7; printf="\033[38;5;20m%s\033[0m"[0m
[38;5;21mansi=21; rgb=#0000ff; printf="\033[38;5;21m%s\033[0m"[0m
[38;5;22mansi=22; rgb=#005f00; printf="\033[38;5;22m%s\033[0m"[0m
[38;5;23mansi=23; rgb=#005f5f; printf="\033[38;5;23m%s\033[0m"[0m
[38;5;24mansi=24; rgb=#005f87; printf="\033[38;5;24m%s\033[0m"[0m
[38;5;25mansi=25; rgb=#005faf; printf="\033[38;5;25m%s\033[0m"[0m
[38;5;26mansi=26; rgb=#005fd7; printf="\033[38;5;26m%s\033[0m"[0m
[38;5;27mansi=27; rgb=#005fff; printf="\033[38;5;27m%s\033[0m"[0m
[38;5;28mansi=28; rgb=#008700; printf="\033[38;5;28m%s\033[0m"[0m
[38;5;29mansi=29; rgb=#00875f; printf="\033[38;5;29m%s\033[0m"[0m
[38;5;30mansi=30; rgb=#008787; printf="\033[38;5;30m%s\033[0m"[0m
[38;5;31mansi=31; rgb=#0087af; printf="\033[38;5;31m%s\033[0m"[0m
[38;5;32mansi=32; rgb=#0087d7; printf="\033[38;5;32m%s\033[0m"[0m
[38;5;33mansi=33; rgb=#0087ff; printf="\033[38;5;33m%s\033[0m"[0m
[38;5;34mansi=34; rgb=#00af00; printf="\033[38;5;34m%s\033[0m"[0m
[38;5;35mansi=35; rgb=#00af5f; printf="\033[38;5;35m%s\033[0m"[0m
[38;5;36mansi=36; rgb=#00af87; printf="\033[38;5;36m%s\033[0m"[0m
[38;5;37mansi=37; rgb=#00afaf; printf="\033[38;5;37m%s\033[0m"[0m
[38;5;38mansi=38; rgb=#00afd7; printf="\033[38;5;38m%s\033[0m"[0m
[38;5;39mansi=39; rgb=#00afff; printf="\033[38;5;39m%s\033[0m"[0m
[38;5;40mansi=40; rgb=#00d700; printf="\033[38;5;40m%s\033[0m"[0m
[38;5;41mansi=41; rgb=#00d75f; printf="\033[38;5;41m%s\033[0m"[0m
[38;5;42mansi=42; rgb=#00d787; printf="\033[38;5;42m%s\033[0m"[0m
[38;5;43mansi=43; rgb=#00d7af; printf="\033[38;5;43m%s\033[0m"[0m
[38;5;44mansi=44; rgb=#00d7d7; printf="\033[38;5;44m%s\033[0m"[0m
[38;5;45mansi=45; rgb=#00d7ff; printf="\033[38;5;45m%s\033[0m"[0m
[38;5;46mansi=46; rgb=#00ff00; printf="\033[38;5;46m%s\033[0m"[0m
[38;5;47mansi=47; rgb=#00ff5f; printf="\033[38;5;47m%s\033[0m"[0m
[38;5;48mansi=48; rgb=#00ff87; printf="\033[38;5;48m%s\033[0m"[0m
[38;5;49mansi=49; rgb=#00ffaf; printf="\033[38;5;49m%s\033[0m"[0m
[38;5;50mansi=50; rgb=#00ffd7; printf="\033[38;5;50m%s\033[0m"[0m
[38;5;51mansi=51; rgb=#00ffff; printf="\033[38;5;51m%s\033[0m"[0m
[38;5;52mansi=52; rgb=#5f0000; printf="\033[38;5;52m%s\033[0m"[0m
[38;5;53mansi=53; rgb=#5f005f; printf="\033[38;5;53m%s\033[0m"[0m
[38;5;54mansi=54; rgb=#5f0087; printf="\033[38;5;54m%s\033[0m"[0m
[38;5;55mansi=55; rgb=#5f00af; printf="\033[38;5;55m%s\033[0m"[0m
[38;5;56mansi=56; rgb=#5f00d7; printf="\033[38;5;56m%s\033[0m"[0m
[38;5;57mansi=57; rgb=#5f00ff; printf="\033[38;5;57m%s\033[0m"[0m
[38;5;58mansi=58; rgb=#5f5f00; printf="\033[38;5;58m%s\033[0m"[0m
[38;5;59mansi=59; rgb=#5f5f5f; printf="\033[38;5;59m%s\033[0m"[0m
[38;5;60mansi=60; rgb=#5f5f87; printf="\033[38;5;60m%s\033[0m"[0m
[38;5;61mansi=61; rgb=#5f5faf; printf="\033[38;5;61m%s\033[0m"[0m
[38;5;62mansi=62; rgb=#5f5fd7; printf="\033[38;5;62m%s\033[0m"[0m
[38;5;63mansi=63; rgb=#5f5fff; printf="\033[38;5;63m%s\033[0m"[0m
[38;5;64mansi=64; rgb=#5f8700; printf="\033[38;5;64m%s\033[0m"[0m
[38;5;65mansi=65; rgb=#5f875f; printf="\033[38;5;65m%s\033[0m"[0m
[38;5;66mansi=66; rgb=#5f8787; printf="\033[38;5;66m%s\033[0m"[0m
[38;5;67mansi=67; rgb=#5f87af; printf="\033[38;5;67m%s\033[0m"[0m
[38;5;68mansi=68; rgb=#5f87d7; printf="\033[38;5;68m%s\033[0m"[0m
[38;5;69mansi=69; rgb=#5f87ff; printf="\033[38;5;69m%s\033[0m"[0m
[38;5;70mansi=70; rgb=#5faf00; printf="\033[38;5;70m%s\033[0m"[0m
[38;5;71mansi=71; rgb=#5faf5f; printf="\033[38;5;71m%s\033[0m"[0m
[38;5;72mansi=72; rgb=#5faf87; printf="\033[38;5;72m%s\033[0m"[0m
[38;5;73mansi=73; rgb=#5fafaf; printf="\033[38;5;73m%s\033[0m"[0m
[38;5;74mansi=74; rgb=#5fafd7; printf="\033[38;5;74m%s\033[0m"[0m
[38;5;75mansi=75; rgb=#5fafff; printf="\033[38;5;75m%s\033[0m"[0m
[38;5;76mansi=76; rgb=#5fd700; printf="\033[38;5;76m%s\033[0m"[0m
[38;5;77mansi=77; rgb=#5fd75f; printf="\033[38;5;77m%s\033[0m"[0m
[38;5;78mansi=78; rgb=#5fd787; printf="\033[38;5;78m%s\033[0m"[0m
[38;5;79mansi=79; rgb=#5fd7af; printf="\033[38;5;79m%s\033[0m"[0m
[38;5;80mansi=80; rgb=#5fd7d7; printf="\033[38;5;80m%s\033[0m"[0m
[38;5;81mansi=81; rgb=#5fd7ff; printf="\033[38;5;81m%s\033[0m"[0m
[38;5;82mansi=82; rgb=#5fff00; printf="\033[38;5;82m%s\033[0m"[0m
[38;5;83mansi=83; rgb=#5fff5f; printf="\033[38;5;83m%s\033[0m"[0m
[38;5;84mansi=84; rgb=#5fff87; printf="\033[38;5;84m%s\033[0m"[0m
[38;5;85mansi=85; rgb=#5fffaf; printf="\033[38;5;85m%s\033[0m"[0m
[38;5;86mansi=86; rgb=#5fffd7; printf="\033[38;5;86m%s\033[0m"[0m
[38;5;87mansi=87; rgb=#5fffff; printf="\033[38;5;87m%s\033[0m"[0m
[38;5;88mansi=88; rgb=#870000; printf="\033[38;5;88m%s\033[0m"[0m
[38;5;89mansi=89; rgb=#87005f; printf="\033[38;5;89m%s\033[0m"[0m
[38;5;90mansi=90; rgb=#870087; printf="\033[38;5;90m%s\033[0m"[0m
[38;5;91mansi=91; rgb=#8700af; printf="\033[38;5;91m%s\033[0m"[0m
[38;5;92mansi=92; rgb=#8700d7; printf="\033[38;5;92m%s\033[0m"[0m
[38;5;93mansi=93; rgb=#8700ff; printf="\033[38;5;93m%s\033[0m"[0m
[38;5;94mansi=94; rgb=#875f00; printf="\033[38;5;94m%s\033[0m"[0m
[38;5;95mansi=95; rgb=#875f5f; printf="\033[38;5;95m%s\033[0m"[0m
[38;5;96mansi=96; rgb=#875f87; printf="\033[38;5;96m%s\033[0m"[0m
[38;5;97mansi=97; rgb=#875faf; printf="\033[38;5;97m%s\033[0m"[0m
[38;5;98mansi=98; rgb=#875fd7; printf="\033[38;5;98m%s\033[0m"[0m
[38;5;99mansi=99; rgb=#875fff; printf="\033[38;5;99m%s\033[0m"[0m
[38;5;100mansi=100; rgb=#878700; printf="\033[38;5;100m%s\033[0m"[0m
[38;5;101mansi=101; rgb=#87875f; printf="\033[38;5;101m%s\033[0m"[0m
[38;5;102mansi=102; rgb=#878787; printf="\033[38;5;102m%s\033[0m"[0m
[38;5;103mansi=103; rgb=#8787af; printf="\033[38;5;103m%s\033[0m"[0m
[38;5;104mansi=104; rgb=#8787d7; printf="\033[38;5;104m%s\033[0m"[0m
[38;5;105mansi=105; rgb=#8787ff; printf="\033[38;5;105m%s\033[0m"[0m
[38;5;106mansi=106; rgb=#87af00; printf="\033[38;5;106m%s\033[0m"[0m
[38;5;107mansi=107; rgb=#87af5f; printf="\033[38;5;107m%s\033[0m"[0m
[38;5;108mansi=108; rgb=#87af87; printf="\033[38;5;108m%s\033[0m"[0m
[38;5;109mansi=109; rgb=#87afaf; printf="\033[38;5;109m%s\033[0m"[0m
[38;5;110mansi=110; rgb=#87afd7; printf="\033[38;5;110m%s\033[0m"[0m
[38;5;111mansi=111; rgb=#87afff; printf="\033[38;5;111m%s\033[0m"[0m
[38;5;112mansi=112; rgb=#87d700; printf="\033[38;5;112m%s\033[0m"[0m
[38;5;113mansi=113; rgb=#87d75f; printf="\033[38;5;113m%s\033[0m"[0m
[38;5;114mansi=114; rgb=#87d787; printf="\033[38;5;114m%s\033[0m"[0m
[38;5;115mansi=115; rgb=#87d7af; printf="\033[38;5;115m%s\033[0m"[0m
[38;5;116mansi=116; rgb=#87d7d7; printf="\033[38;5;116m%s\033[0m"[0m
[38;5;117mansi=117; rgb=#87d7ff; printf="\033[38;5;117m%s\033[0m"[0m
[38;5;118mansi=118; rgb=#87ff00; printf="\033[38;5;118m%s\033[0m"[0m
[38;5;119mansi=119; rgb=#87ff5f; printf="\033[38;5;119m%s\033[0m"[0m
[38;5;120mansi=120; rgb=#87ff87; printf="\033[38;5;120m%s\033[0m"[0m
[38;5;121mansi=121; rgb=#87ffaf; printf="\033[38;5;121m%s\033[0m"[0m
[38;5;122mansi=122; rgb=#87ffd7; printf="\033[38;5;122m%s\033[0m"[0m
[38;5;123mansi=123; rgb=#87ffff; printf="\033[38;5;123m%s\033[0m"[0m
[38;5;124mansi=124; rgb=#af0000; printf="\033[38;5;124m%s\033[0m"[0m
[38;5;125mansi=125; rgb=#af005f; printf="\033[38;5;125m%s\033[0m"[0m
[38;5;126mansi=126; rgb=#af0087; printf="\033[38;5;126m%s\033[0m"[0m
[38;5;127mansi=127; rgb=#af00af; printf="\033[38;5;127m%s\033[0m"[0m
[38;5;128mansi=128; rgb=#af00d7; printf="\033[38;5;128m%s\033[0m"[0m
[38;5;129mansi=129; rgb=#af00ff; printf="\033[38;5;129m%s\033[0m"[0m
[38;5;130mansi=130; rgb=#af5f00; printf="\033[38;5;130m%s\033[0m"[0m
[38;5;131mansi=131; rgb=#af5f5f; printf="\033[38;5;131m%s\033[0m"[0m
[38;5;132mansi=132; rgb=#af5f87; printf="\033[38;5;132m%s\033[0m"[0m
[38;5;133mansi=133; rgb=#af5faf; printf="\033[38;5;133m%s\033[0m"[0m
[38;5;134mansi=134; rgb=#af5fd7; printf="\033[38;5;134m%s\033[0m"[0m
[38;5;135mansi=135; rgb=#af5fff; printf="\033[38;5;135m%s\033[0m"[0m
[38;5;136mansi=136; rgb=#af8700; printf="\033[38;5;136m%s\033[0m"[0m
[38;5;137mansi=137; rgb=#af875f; printf="\033[38;5;137m%s\033[0m"[0m
[38;5;138mansi=138; rgb=#af8787; printf="\033[38;5;138m%s\033[0m"[0m
[38;5;139mansi=139; rgb=#af87af; printf="\033[38;5;139m%s\033[0m"[0m
[38;5;140mansi=140; rgb=#af87d7; printf="\033[38;5;140m%s\033[0m"[0m
[38;5;141mansi=141; rgb=#af87ff; printf="\033[38;5;141m%s\033[0m"[0m
[38;5;142mansi=142; rgb=#afaf00; printf="\033[38;5;142m%s\033[0m"[0m
[38;5;143mansi=143; rgb=#afaf5f; printf="\033[38;5;143m%s\033[0m"[0m
[38;5;144mansi=144; rgb=#afaf87; printf="\033[38;5;144m%s\033[0m"[0m
[38;5;145mansi=145; rgb=#afafaf; printf="\033[38;5;145m%s\033[0m"[0m
[38;5;146mansi=146; rgb=#afafd7; printf="\033[38;5;146m%s\033[0m"[0m
[38;5;147mansi=147; rgb=#afafff; printf="\033[38;5;147m%s\033[0m"[0m
[38;5;148mansi=148; rgb=#afd700; printf="\033[38;5;148m%s\033[0m"[0m
[38;5;149mansi=149; rgb=#afd75f; printf="\033[38;5;149m%s\033[0m"[0m
[38;5;150mansi=150; rgb=#afd787; printf="\033[38;5;150m%s\033[0m"[0m
[38;5;151mansi=151; rgb=#afd7af; printf="\033[38;5;151m%s\033[0m"[0m
[38;5;152mansi=152; rgb=#afd7d7; printf="\033[38;5;152m%s\033[0m"[0m
[38;5;153mansi=153; rgb=#afd7ff; printf="\033[38;5;153m%s\033[0m"[0m
[38;5;154mansi=154; rgb=#afff00; printf="\033[38;5;154m%s\033[0m"[0m
[38;5;155mansi=155; rgb=#afff5f; printf="\033[38;5;155m%s\033[0m"[0m
[38;5;156mansi=156; rgb=#afff87; printf="\033[38;5;156m%s\033[0m"[0m
[38;5;157mansi=157; rgb=#afffaf; printf="\033[38;5;157m%s\033[0m"[0m
[38;5;158mansi=158; rgb=#afffd7; printf="\033[38;5;158m%s\033[0m"[0m
[38;5;159mansi=159; rgb=#afffff; printf="\033[38;5;159m%s\033[0m"[0m
[38;5;160mansi=160; rgb=#d70000; printf="\033[38;5;160m%s\033[0m"[0m
[38;5;161mansi=161; rgb=#d7005f; printf="\033[38;5;161m%s\033[0m"[0m
[38;5;162mansi=162; rgb=#d70087; printf="\033[38;5;162m%s\033[0m"[0m
[38;5;163mansi=163; rgb=#d700af; printf="\033[38;5;163m%s\033[0m"[0m
[38;5;164mansi=164; rgb=#d700d7; printf="\033[38;5;164m%s\033[0m"[0m
[38;5;165mansi=165; rgb=#d700ff; printf="\033[38;5;165m%s\033[0m"[0m
[38;5;166mansi=166; rgb=#d75f00; printf="\033[38;5;166m%s\033[0m"[0m
[38;5;167mansi=167; rgb=#d75f5f; printf="\033[38;5;167m%s\033[0m"[0m
[38;5;168mansi=168; rgb=#d75f87; printf="\033[38;5;168m%s\033[0m"[0m
[38;5;169mansi=169; rgb=#d75faf; printf="\033[38;5;169m%s\033[0m"[0m
[38;5;170mansi=170; rgb=#d75fd7; printf="\033[38;5;170m%s\033[0m"[0m
[38;5;171mansi=171; rgb=#d75fff; printf="\033[38;5;171m%s\033[0m"[0m
[38;5;172mansi=172; rgb=#d78700; printf="\033[38;5;172m%s\033[0m"[0m
[38;5;173mansi=173; rgb=#d7875f; printf="\033[38;5;173m%s\033[0m"[0m
[38;5;174mansi=174; rgb=#d78787; printf="\033[38;5;174m%s\033[0m"[0m
[38;5;175mansi=175; rgb=#d787af; printf="\033[38;5;175m%s\033[0m"[0m
[38;5;176mansi=176; rgb=#d787d7; printf="\033[38;5;176m%s\033[0m"[0m
[38;5;177mansi=177; rgb=#d787ff; printf="\033[38;5;177m%s\033[0m"[0m
[38;5;178mansi=178; rgb=#d7af00; printf="\033[38;5;178m%s\033[0m"[0m
[38;5;179mansi=179; rgb=#d7af5f; printf="\033[38;5;179m%s\033[0m"[0m
[38;5;180mansi=180; rgb=#d7af87; printf="\033[38;5;180m%s\033[0m"[0m
[38;5;181mansi=181; rgb=#d7afaf; printf="\033[38;5;181m%s\033[0m"[0m
[38;5;182mansi=182; rgb=#d7afd7; printf="\033[38;5;182m%s\033[0m"[0m
[38;5;183mansi=183; rgb=#d7afff; printf="\033[38;5;183m%s\033[0m"[0m
[38;5;184mansi=184; rgb=#d7d700; printf="\033[38;5;184m%s\033[0m"[0m
[38;5;185mansi=185; rgb=#d7d75f; printf="\033[38;5;185m%s\033[0m"[0m
[38;5;186mansi=186; rgb=#d7d787; printf="\033[38;5;186m%s\033[0m"[0m
[38;5;187mansi=187; rgb=#d7d7af; printf="\033[38;5;187m%s\033[0m"[0m
[38;5;188mansi=188; rgb=#d7d7d7; printf="\033[38;5;188m%s\033[0m"[0m
[38;5;189mansi=189; rgb=#d7d7ff; printf="\033[38;5;189m%s\033[0m"[0m
[38;5;190mansi=190; rgb=#d7ff00; printf="\033[38;5;190m%s\033[0m"[0m
[38;5;191mansi=191; rgb=#d7ff5f; printf="\033[38;5;191m%s\033[0m"[0m
[38;5;192mansi=192; rgb=#d7ff87; printf="\033[38;5;192m%s\033[0m"[0m
[38;5;193mansi=193; rgb=#d7ffaf; printf="\033[38;5;193m%s\033[0m"[0m
[38;5;194mansi=194; rgb=#d7ffd7; printf="\033[38;5;194m%s\033[0m"[0m
[38;5;195mansi=195; rgb=#d7ffff; printf="\033[38;5;195m%s\033[0m"[0m
[38;5;196mansi=196; rgb=#ff0000; printf="\033[38;5;196m%s\033[0m"[0m
[38;5;197mansi=197; rgb=#ff005f; printf="\033[38;5;197m%s\033[0m"[0m
[38;5;198mansi=198; rgb=#ff0087; printf="\033[38;5;198m%s\033[0m"[0m
[38;5;199mansi=199; rgb=#ff00af; printf="\033[38;5;199m%s\033[0m"[0m
[38;5;200mansi=200; rgb=#ff00d7; printf="\033[38;5;200m%s\033[0m"[0m
[38;5;201mansi=201; rgb=#ff00ff; printf="\033[38;5;201m%s\033[0m"[0m
[38;5;202mansi=202; rgb=#ff5f00; printf="\033[38;5;202m%s\033[0m"[0m
[38;5;203mansi=203; rgb=#ff5f5f; printf="\033[38;5;203m%s\033[0m"[0m
[38;5;204mansi=204; rgb=#ff5f87; printf="\033[38;5;204m%s\033[0m"[0m
[38;5;205mansi=205; rgb=#ff5faf; printf="\033[38;5;205m%s\033[0m"[0m
[38;5;206mansi=206; rgb=#ff5fd7; printf="\033[38;5;206m%s\033[0m"[0m
[38;5;207mansi=207; rgb=#ff5fff; printf="\033[38;5;207m%s\033[0m"[0m
[38;5;208mansi=208; rgb=#ff8700; printf="\033[38;5;208m%s\033[0m"[0m
[38;5;209mansi=209; rgb=#ff875f; printf="\033[38;5;209m%s\033[0m"[0m
[38;5;210mansi=210; rgb=#ff8787; printf="\033[38;5;210m%s\033[0m"[0m
[38;5;211mansi=211; rgb=#ff87af; printf="\033[38;5;211m%s\033[0m"[0m
[38;5;212mansi=212; rgb=#ff87d7; printf="\033[38;5;212m%s\033[0m"[0m
[38;5;213mansi=213; rgb=#ff87ff; printf="\033[38;5;213m%s\033[0m"[0m
[38;5;214mansi=214; rgb=#ffaf00; printf="\033[38;5;214m%s\033[0m"[0m
[38;5;215mansi=215; rgb=#ffaf5f; printf="\033[38;5;215m%s\033[0m"[0m
[38;5;216mansi=216; rgb=#ffaf87; printf="\033[38;5;216m%s\033[0m"[0m
[38;5;217mansi=217; rgb=#ffafaf; printf="\033[38;5;217m%s\033[0m"[0m
[38;5;218mansi=218; rgb=#ffafd7; printf="\033[38;5;218m%s\033[0m"[0m
[38;5;219mansi=219; rgb=#ffafff; printf="\033[38;5;219m%s\033[0m"[0m
[38;5;220mansi=220; rgb=#ffd700; printf="\033[38;5;220m%s\033[0m"[0m
[38;5;221mansi=221; rgb=#ffd75f; printf="\033[38;5;221m%s\033[0m"[0m
[38;5;222mansi=222; rgb=#ffd787; printf="\033[38;5;222m%s\033[0m"[0m
[38;5;223mansi=223; rgb=#ffd7af; printf="\033[38;5;223m%s\033[0m"[0m
[38;5;224mansi=224; rgb=#ffd7d7; printf="\033[38;5;224m%s\033[0m"[0m
[38;5;225mansi=225; rgb=#ffd7ff; printf="\033[38;5;225m%s\033[0m"[0m
[38;5;226mansi=226; rgb=#ffff00; printf="\033[38;5;226m%s\033[0m"[0m
[38;5;227mansi=227; rgb=#ffff5f; printf="\033[38;5;227m%s\033[0m"[0m
[38;5;228mansi=228; rgb=#ffff87; printf="\033[38;5;228m%s\033[0m"[0m
[38;5;229mansi=229; rgb=#ffffaf; printf="\033[38;5;229m%s\033[0m"[0m
[38;5;230mansi=230; rgb=#ffffd7; printf="\033[38;5;230m%s\033[0m"[0m
[38;5;231mansi=231; rgb=#ffffff; printf="\033[38;5;231m%s\033[0m"[0m
[38;5;232mansi=232; rgb=#080808; printf="\033[38;5;232m%s\033[0m"[0m
[38;5;233mansi=233; rgb=#121212; printf="\033[38;5;233m%s\033[0m"[0m
[38;5;234mansi=234; rgb=#1c1c1c; printf="\033[38;5;234m%s\033[0m"[0m
[38;5;235mansi=235; rgb=#262626; printf="\033[38;5;235m%s\033[0m"[0m
[38;5;236mansi=236; rgb=#303030; printf="\033[38;5;236m%s\033[0m"[0m
[38;5;237mansi=237; rgb=#3a3a3a; printf="\033[38;5;237m%s\033[0m"[0m
[38;5;238mansi=238; rgb=#444444; printf="\033[38;5;238m%s\033[0m"[0m
[38;5;239mansi=239; rgb=#4e4e4e; printf="\033[38;5;239m%s\033[0m"[0m
[38;5;240mansi=240; rgb=#585858; printf="\033[38;5;240m%s\033[0m"[0m
[38;5;241mansi=241; rgb=#626262; printf="\033[38;5;241m%s\033[0m"[0m
[38;5;242mansi=242; rgb=#6c6c6c; printf="\033[38;5;242m%s\033[0m"[0m
[38;5;243mansi=243; rgb=#767676; printf="\033[38;5;243m%s\033[0m"[0m
[38;5;244mansi=244; rgb=#808080; printf="\033[38;5;244m%s\033[0m"[0m
[38;5;245mansi=245; rgb=#8a8a8a; printf="\033[38;5;245m%s\033[0m"[0m
[38;5;246mansi=246; rgb=#949494; printf="\033[38;5;246m%s\033[0m"[0m
[38;5;247mansi=247; rgb=#9e9e9e; printf="\033[38;5;247m%s\033[0m"[0m
[38;5;248mansi=248; rgb=#a8a8a8; printf="\033[38;5;248m%s\033[0m"[0m
[38;5;249mansi=249; rgb=#b2b2b2; printf="\033[38;5;249m%s\033[0m"[0m
[38;5;250mansi=250; rgb=#bcbcbc; printf="\033[38;5;250m%s\033[0m"[0m
[38;5;251mansi=251; rgb=#c6c6c6; printf="\033[38;5;251m%s\033[0m"[0m
[38;5;252mansi=252; rgb=#d0d0d0; printf="\033[38;5;252m%s\033[0m"[0m
[38;5;253mansi=253; rgb=#dadada; printf="\033[38;5;253m%s\033[0m"[0m
[38;5;254mansi=254; rgb=#e4e4e4; printf="\033[38;5;254m%s\033[0m"[0m
[38;5;255mansi=255; rgb=#eeeeee; printf="\033[38;5;255m%s\033[0m"[0m
```

