nb1_input_notebook: 
  class: File
  path: nb1.ipynb
nb1_output_notebook: output.ipynb
nb2_input_notebook: 
  class: File
  path: nb2.ipynb
nb2_output_notebook: output2.ipynb

parameters: 
  class: File
  path: nb_parameters.json

cwltool:overrides:
  workflow.cwl:
    requirements:
      EnvVarRequirement:
        envDef:
          LC_ALL: C.UTF-8
          LANG: C.UTF-8