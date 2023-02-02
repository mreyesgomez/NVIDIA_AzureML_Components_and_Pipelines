# NVIDIA_AzureML Components and Pipelines

This repo contains material to produce AzureML Components and Pipelines based on NVIDIA products, along with the required AzureML Resources: Compute Clusters and Environments needed to run such Components and Pipelines.

The main folders in this repo are:

* components
* pipelines
* environments
* compute_clusters
* scripts

## Components

Contains the definitions to create AzureML Components wrapped around NVIDIA Products Commands (Functional pieces of code)

They are divided by NVIDIA product, i.e.: Tao, Triton, Rapids. Since components are tied to AzureML Environments, for each product, components are then subdivided by the container they are associated with. AzureML Components associated with the same NVIDIA product command (functional piece of code) would use their versioning to map them to a particular AzureML Environment (NVIDIA product container). If a particular NVIDIA product further subdivides their commands into for instance user cases, such subdivision would be reflected on the subdirectory structure for such NVIDIA product.

Each component definition folder has the yml file defining the inputs and outputs of the components, the scripts needed to run the code associated with the component and a README.md file that explains how the component is mapped into the NVIDIA product commands. More details on Azureml Components below

## Pipelines

Contains the definition of end-to-end user cases as AzureML Pipelines

They are also divided by NVIDIA product, container (tied to the versioning of the components used on the pipeline) and product subdivision, if any.

Each pipeline definition folder has the yml file defining the jobs interconnecting the corresponding components, and a README.md file that explains the end-to-end user case implemented by the pipeline and what are the expected results and how they could be deployed to production using the scripts on the deployment_scripts

### Deployment Scripts
Pipelines contain end-to-end user cases that produce a model or a set of models as output, each pipeline has a folder deployment_scripts that has the scripts the user needs to run to deploy the model(s) into an AzureML Inference Endpoint

The deployment scripts migth later being converted into pipelines themselves

## Environments

Contains the definition of AzureML Environments having as base images specific NVIDIA NGC containers

They are also divided by NVIDIA product and container

## Compute_Cluster

Contains the definition of AzureML Compute Clusters using Azure VM Sizes that support NVIDIA GPUs

The folder is subdivided by VM Size

## AzureML Resources

### AzureML Workspace
First the user needs to create an AzureML Workspace, if there is not one that is already set up

Go to the Azure Portal and on the search box type "Azure Machine Learning"

<img src="imgs/search.png" width="900">

Click into the Azure Machine Learning link

Then create a new Workspace

<img src="imgs/create.png" width="900">

Fill the details

<img src="imgs/details.png" width="900">

Then click "Review and Create"

### AzureML CLI

All the material in this repo require the use of the [AzureML CLI V2.0](https://learn.microsoft.com/en-us/azure/machine-learning/how-to-configure-cli?tabs=public)

If you do not have it installed please run:

<pre style="background-color:rgba(0, 0, 0, 0.0470588)"><font size="2">bash scripts/install_libs.sh
</pre>

To interact with the material, the user needs to provide its AzureML Information along with the NVIDIA Product to use, the container and the VM Size by filling the environmental variables at file: scripts/config_files/config.sh

<img src="imgs/config_file.png" width="700">

If a user wants to use a previously provisioned compute cluster, the user would need to change the "compute_name" variable to the one of the desired compute cluster

Before running any of the material the user needs to pass its AzureML credentials by running:

<pre style="background-color:rgba(0, 0, 0, 0.0470588)"><font size="2">bash scripts/set_credentials.sh
</pre>

### AzureML Environment
Before being able to define an AzureML Component, you would need to define and create an [AzureML Environment](https://learn.microsoft.com/en-us/azure/machine-learning/how-to-manage-environments-v2?tabs=cli)

We will use the "Create an environment from a Docker build context" option that you can see in the link above

The environment is created by running

<pre style="background-color:rgba(0, 0, 0, 0.0470588)"><font size="2">bash scripts/set_environment.sh
</pre>

Also please pay attention to the version number variable on the yml file. any change on the Dockerfile requires an increment in the version number for the change to go through and take effect. You also would need to update the version number used on the Components associated with such Environment

The user can confirm that the Environment was created by launching the Azure Machine Learning Studio for the specified Workspace:

<img src="imgs/AMLStudio.png" width="900">

And then navigating to the Environments tab

<img src="imgs/env.png" width="900">

### AzureML Components
[AzureML Components](https://docs.microsoft.com/en-us/azure/machine-learning/how-to-create-component-pipeline-python) are functional pieces of code that are meant to be used repeatedly

They are defined by a yml file

<img src="imgs/TAO_Train_yml.png" width="1000">

That specifies the name, number and nature of its inputs and output

It also specifies the AzureML Environment to use

The code that the component would execute is defined in the command variable

The yml file also specifies the Component version number, once a Component is created any changes on its definition or the code associated with it would require an increase on its version number to be able to update the Components functionality

In this case the yml file refers to a bash script thats in turn runs two other scripts

<img src="imgs/update_and_train.png" width="1000">

One just changes the config file that the actual command would use, and the other tao_train.sh is the wrapper for the actual TAO command:
<img src="imgs/tao_train_sh.png" width="1000">

A restriction that pipelines have is that inputs are Read-Only so whatever changes you want to do an input they need to be saved as an output. also outputs can not be shared between components so resources produced by a component run need to be stored on its own folder. This is done by design to be able to track what component produced what output.

To create all the components for the NVIDIA product and container specified on the scripts/config_files/config.sh file. The user should run:

<pre style="background-color:rgba(0, 0, 0, 0.0470588)"><font size="2">bash scripts/set_components.sh
</pre>

Once Components have been created you should be able to see them on the AzureML Portal

Navigate to the Microsoft Azure Machine Learning Studio for your Workspace and then navigate to the Components tab 

<img src="imgs/component_list.png" width="900">


### AzureML Compute Cluster

If a user wants to use a previously provisioned compute cluster, and had changed the "compute_name" variable on the scripts/config_files/config.sh file to reflect that then this step is NOT required and it will throw an error 

Before being able to submit an AzureML Job using a pipeline that uses the created components, the user needs to set up a compute resource to run the following script:

<pre style="background-color:rgba(0, 0, 0, 0.0470588)"><font size="2">bash scripts/set_compute_cluster.sh
</pre>


### AzureML Pipeline

An [AzureML Pipeline](https://learn.microsoft.com/en-us/azure/machine-learning/how-to-create-component-pipelines-cli) describes the interconections between multiple AzureML Components, a particular Run with specific inputs and outputs of a Component is called a Job, a Component could be call multiple times under different Job Names.

<img src="imgs/pipeline_yml.png" width="900">

Notice that each job has an associated Compute Resource

The desired pipeline is submitted by using:

<pre style="background-color:rgba(0, 0, 0, 0.0470588)"><font size="2">bash scripts/run_pipeline.sh
</pre>

If the submission succeeds you should be able to see the job runing on the Azure Portal, it would be running under the desired Workspace

<img src="imgs/pipeline_run.png" width="900">

### AzureML Inference Endpoint

Pipelines contain end-to-end user cases that produce a model or a set of models as output, each pipeline has a folder deployment_scripts that has the scripts the user needs to run to deploy the model(s) into an AzureML Inference Endpoint

Once the pipeline job has been succesfully completed, the user can now deploy the produced models by going to the corresponding pipeline folder and follow the deployment instructions in the pipeline README.md file

To navigate to the pipeline folder the user should run:

<pre style="background-color:rgba(0, 0, 0, 0.0470588)"><font size="2">source scripts/config_files/config.sh
cd $pipeline_path
</pre>
