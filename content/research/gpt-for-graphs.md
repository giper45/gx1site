+++
title = 'Create diagrams with ChatGPT'
date = 2024-09-12T11:05:09+02:00
draft = false
+++



Have you ever thought that ChatGPT can be used to create awesome decision diagrams? You have a sort of text like this: 
```
Step 1: What is the primary goal of your model?
Classification / Prediction (e.g., categorizing images, predicting a label):

Proceed to Step 2
Regression (e.g., predicting continuous values):

Proceed to Step 2
Clustering (e.g., grouping similar data):

Use K-Means, DBSCAN, or Hierarchical Clustering
Dimensionality Reduction (e.g., feature reduction or compression):

Use PCA, t-SNE, UMAP
Generative (e.g., generating text, images, etc.):

Proceed to Step 7

```

Try to generate an image of the diagram with ChatGPT, but this is the result: 
```
Now create an image of the flow diagram
```
![alt text](/images/gpt-error.png)



In this guide, I will show you how can address the problem. 

## Does ChatGPT perform well in diagrams generation? 
The main problem is that ChatGPT is a generative AI, and its best performance is in generating text. But diagrams can indeed be generated through an **Infrastructure as Code** approach. Therefore, we can use a tool like Draw.io, which has a diagram structure based on XML.




## Requirements

- A ChatGPT account (for small graphs, free account, but more complex examples require the GPT4-o version).

- Install [Draw.io](https://github.com/jgraph/drawio-desktop/releases/tag/v24.7.8) 


## Start by realizing a decision sentence

The prompt: 
```
Create a decisional flow on how to select an AI model according to computing constraints, data size, goal, data types, etc.  Use the structure with questions, as it would be a decision tree
```

## Realize the diagram
Once obtained the output response, simply prompt: 
```
Now create an xml output compatible with drawio  based on the realized decision tree. Use the flowchart diagram syntax
```
### Fix errors
If some error occurs (especially for the free version), just copy the output error in ChatGPT, and it will fix the diagram.



## Adjust the diagram
Save the output in `.drawio` file, open it with `drawio`. 
![alt text](/images/original-drawio.png)

Now, you can organize it by several drawio features: 
- Select All -> Arrange -> Layout -> Vertical Flow. 

And adjust the diagrams.



## Conclusions
ChatGPT is a great tool, but you have to use it with proper cognition, and with just a bit of ... fantasy.
You can extend the experiments by trying other formats, such as **plantUML**. 
Look at [kroki](https://kroki.io/#try) examples to select a diagram format, and experiment. 
