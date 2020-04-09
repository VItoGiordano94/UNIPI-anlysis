# FreePatentsOnline
FreePatentsOnline is a multilingual online encyclopaedia created and maintained as an open collaboration project by a community of volunteer editors. This file README contains all the information about the functions in FreePatentsOnline Package. I explain you all functuions of FreePatentsOnline Package in the following sections. In each section I show you a single function with explaination about:
- input: the input class and the means of input;
- output: the output class and the means of output;
- function: the explaination

The FreePatentsOnline package use the following external package sources:
- **tidyverse**
- **rvest**
- **rebus**

You must rember to install these packages and import (using *library()*) in your R workspace.

### 1. wiki_extract_text
The function **wiki_extract_text** is a function that extract the content of Wikipedia web page in text format. 

#### 1.1 Input
- **page_name**: *string object*. The element of Wikipedia database that you want to search;
- **language**: *string object*. The language code of the wikipedia element that you want to search. The starting value of the argument **language** is *"en"* for english language. 

#### 1.2 Output
The output is a *vector string object* that contains the Wikipedia content of the input element. The content is divided in paragraph: each element of the vector is a paragraph. 
