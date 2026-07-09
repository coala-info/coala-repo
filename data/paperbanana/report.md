# paperbanana CWL Generation Report

## paperbanana

### Tool Description
FAIL to generate CWL: paperbanana not found in Docker image. The image may not provide this executable.

### Metadata
- **Docker Image**: paperbanana
- **Homepage**: https://github.com/dwzhu-pku/PaperBanana
- **Package**: Not found
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/paperbanana/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/dwzhu-pku/PaperBanana
- **Stars**: N/A
### Generation Failed

FAIL to generate CWL: paperbanana not found in Docker image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: paperbanana not found in Docker image. The image may not provide this executable.



### Original Help Text
```text

```


## python_main_one.py

### Tool Description
PaperVizAgent single-sample processing (direct text input)

### Metadata
- **Docker Image**: paperbanana
- **Homepage**: https://github.com/dwzhu-pku/PaperBanana
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Initialized Gemini Client with API Key
usage: main_one.py [-h] [--task_name {diagram,plot}] [--raw_text RAW_TEXT]
                   [--raw_file RAW_FILE] [--caption_intent CAPTION_INTENT]
                   [--model_config MODEL_CONFIG] [--exp_mode EXP_MODE]
                   [--retrieval_setting {auto,manual,random,none}]
                   [--ref_dir REF_DIR] [--planner-metaphor]
                   [--max_critic_rounds MAX_CRITIC_ROUNDS]
                   [--main_model_name MAIN_MODEL_NAME]
                   [--image_gen_model_name IMAGE_GEN_MODEL_NAME]
                   [--aspect_ratio ASPECT_RATIO] [--image_size {1k,2k,4k}]
                   [--output OUTPUT] [--image_output IMAGE_OUTPUT]

PaperVizAgent single-sample processing (direct text input)

options:
  -h, --help            show this help message and exit
  --task_name {diagram,plot}
                        task type: diagram or plot (default: diagram)
  --raw_text RAW_TEXT   methodology text (diagram) or raw plot data as
                        text/JSON (plot)
  --raw_file RAW_FILE   file containing raw_text (diagram methodology or plot
                        raw data)
  --caption_intent CAPTION_INTENT
                        figure caption (diagram) or visual intent (plot)
  --model_config MODEL_CONFIG
                        path to model_config.yaml (default:
                        /app/configs/model_config.yaml)
  --exp_mode EXP_MODE   experiment pipeline mode (default: demo_full)
  --retrieval_setting {auto,manual,random,none}
                        retrieval setting for planner agent (default: auto)
  --ref_dir REF_DIR     directory with ref.json and reference images for
                        Retriever/Planner (default:
                        data/PaperBananaBench/{task_name}; falls back to none
                        if missing)
  --planner-metaphor    enable diagram-only Planner visual-metaphor discovery
                        before detailed description output
  --max_critic_rounds MAX_CRITIC_ROUNDS
                        maximum number of critic rounds (default: 3)
  --main_model_name MAIN_MODEL_NAME
                        main model name (default: from model_config
                        "defaults.main_model_name")
  --image_gen_model_name IMAGE_GEN_MODEL_NAME
                        image generation model name (default: from
                        model_config "defaults.image_gen_model_name")
  --aspect_ratio ASPECT_RATIO
                        output image aspect ratio, e.g. 1:1, 16:9, 21:9
                        (default: 1:1)
  --image_size {1k,2k,4k}
                        output image resolution for providers that support it
                        (default: 1k)
  --output OUTPUT       output JSON path (default:
                        results/PaperBananaBench_{task}/{exp_name}.json)
  --image_output IMAGE_OUTPUT
                        output image path (default: same stem as --output with
                        .jpg)
```

## Metadata
- **Skill**: generated
