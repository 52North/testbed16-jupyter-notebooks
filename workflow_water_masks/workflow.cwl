#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow
inputs:
  nb1_input_notebook: File
  nb1_output_notebook: string
  nb2_input_notebook: File
  nb2_output_notebook: string
  parameters: File

outputs: 
  nb1_output_notebook:
    type: File
    streamable: false
    outputSource: nb1_execute/output_0
  nb1_output:
    type: 
      type: array
      items: string
    streamable: false
    outputSource: nb1_parse/files
  nb2_output_notebooks:
    type: 
      type: array
      items: File
    streamable: false
    outputSource: nb2_execute/output_notebook
  nb2_output_results:
    type:
      type: array
      items: File
    streamable: false
    outputSource: nb2_execute/floodmask

requirements:
  SubworkflowFeatureRequirement: {}
  ScatterFeatureRequirement: {}

steps:
  nb1_execute:
    run: nb1_request/nb1.cwl
    in:
      nb1_input_notebook: nb1_input_notebook
      nb1_output_notebook: nb1_output_notebook
      parameters: parameters
    out: [output_0]

  nb1_parse:
    in: 
      input_nb: nb1_execute/output_0
    out: [files]
    run:
      class: CommandLineTool
      baseCommand: ["python3", "parse.py"]
      requirements:
        InlineJavascriptRequirement: {}
        InitialWorkDirRequirement:
          listing:
            - entryname: parse.py
              entry: |
                import scrapbook as sb
                nb = sb.read_notebook("$(inputs.input_nb.path)")
                print(','.join(list(nb.scrap_dataframe["data"])[0]))

      stdout: message

      inputs: 
        input_nb:
          type: File

      outputs: 
        files:
          type: 
            type: array
            items: string
          outputBinding:
            glob: message
            loadContents: true
            outputEval: $(self[0].contents.replace('\n','').split(','))
    
  nb2_execute:
    run: nb2_download_classify/nb2.cwl
    scatter: parameters
    in:
      nb2_input_notebook: nb2_input_notebook
      nb2_output_notebook: nb2_output_notebook
      parameters: nb1_parse/files
    out: [output_notebook, floodmask]





