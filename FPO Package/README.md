# FreePatentsOnline
The FreePatentsOnline (FPO) package is a set of fuctnions to extract information from FreePatentsOnline (FPO) Sources with R automatically. FPO is complete Patent Searching Database and Patent Data Analytics Services. This file README contains all the information about the functions in FreePatentsOnline Package. I explain you all functuions of FreePatentsOnline Package in the following sections. In each section I show you a single function with explaination about:
- input: the input class and the means of input;
- output: the output class and the means of output;
- function: the explaination

The FreePatentsOnline package use the following external package sources:
- **tidyverse**
- **rvest**
- **rebus**

You must rember to install these packages and import (using *library()*) in your R workspace.

### 1. patent_count_query
The function **patent_count_query** is a function that extract the number of results in FreePatentsOnline with an input query. 

#### 1.1 Input
- **query**: *string object*. The query that you want to search. You must follow the instructions in http://www.freepatentsonline.com/search.html?srch=xprtsrch to Construct the query.
- **uspat**: *string object*. This argumnet allows you to include the US Patents in your search. If you don't want to include these patens you must set **uspat** as *"off"*. Otherwise, if you want to include these type of patens you must set **uspat** as *"on"*. The starting value of the argument **uspat** is *"on"*. 
- **usapp**: *string object*. This argumnet allows you to include the US Patent Applications in your search. If you don't want to include these patens you must set **usapp** as *"off"*. Otherwise, if you want to include these type of patens you must set **usapp** as *"on"*. The starting value of the argument **usapp** is *"on"*. 
- **eupat**: *string object*. This argumnet allows you to include the European patetens in your search. If you don't want to include these patens you must set **eupat** as *"off"*. Otherwise, if you want to include these type of patens you must set **eupat** as *"on"*. The starting value of the argument **eupat** is *"on"*.
- **jp**: *string object*. This argumnet allows you to include the Abstracts of Japan in your search. If you don't want to include these patens you must set **jp** as *"off"*. Otherwise, if you want to include these type of patens you must set **jp** as *"on"*. The starting value of the argument **jp** is *"off"*.
- **pct**: *string object*. This argumnet allows you to include the WIPO patents in your search. If you don't want to include these patens you must set **pct** as *"off"*. Otherwise, if you want to include these type of patens you must set **pct** as *"on"*. The starting value of the argument **pct** is *"off"*.
- **depat**: *string object*. This argumnet allows you to include the German Patents in your search. If you don't want include these patens you must set **depat** as *"off"*. Otherwise, if you want to include these type of patens you must set **depat** as *"on"*. The starting value of the argument **depat** is *"off"*.
- **stemming**: *string object*. This argumnet allows you to stemm the query for your search. If you don't want to include the stemming words in your search you must set **stemming** as *"off"*. Otherwise, if you want to include the stemming words in your search you must set **stemming** as *"on"*. The starting value of the argument **stemming** is *"off"*.

#### 1.2 Output
The output is a *integer object* that contains the number of patents in FreePatentsOnline that you can find with your query.
