## [Evaluating the Model](https://docs.nvidia.com/tao/tao-toolkit/text/object_detection/detectnet_v2.html#evaluating-the-model)
#### This component is a wrapper for the TAO DetectNet_v2 evaluate command

Execute <span style="color:red;font-weight:700;font-size:12px">evaluate</span> on a DetectNet_v2 model.

<pre style="background-color:rgba(0, 0, 0, 0.0470588)"><font size="2">tao detectnet_v2 evaluate [-h] -e < experiment_spec>
                               -m < model_file>
                               -k < key>
                               [--use_training_set]
                               [--gpu_index]
</pre>

### Required Arguments
* <span style="color:red;font-weight:700;font-size:12px">-e, --experiment_spec_file:</span> The experiment spec file to set up the evaluation experiment. This should be the same as training spec file.
* <span style="color:red;font-weight:700;font-size:12px">-m, --model:</span> The path to the model file to use for evaluation. This could be a .tlt model file or a tensorrt engine generated using the export tool.
* <span style="color:red;font-weight:700;font-size:12px">-k, -–key:</span> The encryption key to decrypt the model. This argument is only required with a .tlt model file.

### Optional Arguments
* <span style="color:red;font-weight:700;font-size:12px">-h, --help:</span> Show this help message and exit.
* <span style="color:red;font-weight:700;font-size:12px">-f, --framework:</span> The framework to use when running evaluation (choices: “tlt”, “tensorrt”). By default the framework is set to TensorRT.
* <span style="color:red;font-weight:700;font-size:12px">--use_training_set:</span> Set this flag to run evaluation on the training dataset.
* <span style="color:red;font-weight:700;font-size:12px">--gpu_index:</span> The index of the GPU to run evaluation on.

### Sample Usage
If you have followed the example in [Training a Detection Model](https://docs.nvidia.com/tao/tao-toolkit/text/object_detection/detectnet_v2.html#training-the-model-detectnet-v2), you may now evaluate the model using the following command:

<pre style="background-color:rgba(0, 0, 0, 0.0470588)"><font size="2">tao detectnet_v2 evaluate -e < path to training spec file>
                          -m < path to the model>
                          -k < key to load the model>
</pre>