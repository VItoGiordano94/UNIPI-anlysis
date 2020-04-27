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
- **uspat**: *string object*. This argumnet allows you to include the US Patents in your search. If you don't want to include these patens you must set **uspat** as *"off"*. Otherwise, if you want to include these type of patens you must set **uspat** as *"on"*. The default value of the argument **uspat** is *"on"*. 
- **usapp**: *string object*. This argumnet allows you to include the US Patent Applications in your search. If you don't want to include these patens you must set **usapp** as *"off"*. Otherwise, if you want to include these type of patens you must set **usapp** as *"on"*. The default value of the argument **usapp** is *"on"*. 
- **eupat**: *string object*. This argumnet allows you to include the European patetens in your search. If you don't want to include these patens you must set **eupat** as *"off"*. Otherwise, if you want to include these type of patens you must set **eupat** as *"on"*. The default value of the argument **eupat** is *"on"*.
- **jp**: *string object*. This argumnet allows you to include the Abstracts of Japan in your search. If you don't want to include these patens you must set **jp** as *"off"*. Otherwise, if you want to include these type of patens you must set **jp** as *"on"*. The default value of the argument **jp** is *"off"*.
- **pct**: *string object*. This argumnet allows you to include the WIPO patents in your search. If you don't want to include these patens you must set **pct** as *"off"*. Otherwise, if you want to include these type of patens you must set **pct** as *"on"*. The default value of the argument **pct** is *"off"*.
- **depat**: *string object*. This argumnet allows you to include the German Patents in your search. If you don't want include these patens you must set **depat** as *"off"*. Otherwise, if you want to include these type of patens you must set **depat** as *"on"*. The default value of the argument **depat** is *"off"*.
- **stemming**: *string object*. This argumnet allows you to stemm the query for your search. If you don't want to include the stemming words in your search you must set **stemming** as *"off"*. Otherwise, if you want to include the stemming words in your search you must set **stemming** as *"on"*. The default value of the argument **stemming** is *"off"*.

#### 1.2 Output
The output is a *integer object* that contains the number of patents in FreePatentsOnline that you can find with your query. 

### 2. patent_query
The function **patent_query** is a function that extract the URLs, title and abstract for each patent in FreePatentsOnline with an input query. You can set the number of html pages to parse for extracting the URLs. Each page contains 50 patents.

#### 2.1 Input
- **query**: *string object*. The query that you want to search. You must follow the instructions in http://www.freepatentsonline.com/search.html?srch=xprtsrch to Construct the query.
- **uspat**: *string object*. This argumnet allows you to include the US Patents in your search. If you don't want to include these patens you must set **uspat** as *"off"*. Otherwise, if you want to include these type of patens you must set **uspat** as *"on"*. The default value of the argument **uspat** is *"on"*. 
- **usapp**: *string object*. This argumnet allows you to include the US Patent Applications in your search. If you don't want to include these patens you must set **usapp** as *"off"*. Otherwise, if you want to include these type of patens you must set **usapp** as *"on"*. The default value of the argument **usapp** is *"on"*. 
- **eupat**: *string object*. This argumnet allows you to include the European patetens in your search. If you don't want to include these patens you must set **eupat** as *"off"*. Otherwise, if you want to include these type of patens you must set **eupat** as *"on"*. The default value of the argument **eupat** is *"on"*.
- **jp**: *string object*. This argumnet allows you to include the Abstracts of Japan in your search. If you don't want to include these patens you must set **jp** as *"off"*. Otherwise, if you want to include these type of patens you must set **jp** as *"on"*. The default value of the argument **jp** is *"off"*.
- **pct**: *string object*. This argumnet allows you to include the WIPO patents in your search. If you don't want to include these patens you must set **pct** as *"off"*. Otherwise, if you want to include these type of patens you must set **pct** as *"on"*. The default value of the argument **pct** is *"off"*.
- **depat**: *string object*. This argumnet allows you to include the German Patents in your search. If you don't want include these patens you must set **depat** as *"off"*. Otherwise, if you want to include these type of patens you must set **depat** as *"on"*. The default value of the argument **depat** is *"off"*.
- **stemming**: *string object*. This argumnet allows you to stemm the query for your search. If you don't want to include the stemming words in your search you must set **stemming** as *"off"*. Otherwise, if you want to include the stemming words in your search you must set **stemming** as *"on"*. The default value of the argument **stemming** is *"off"*.
- **page_start**: *integer*. This argumnet allows you to set the starting page to find the URLs related to the input query. The default value of the argument is *1*.
- **page_end**: *integer*. This argumnet allows you to set the ending page to find the URLs related to the input query. The default value of the argument is *FALSE*, so it allow you to extract the URLs form starting page to the last page available on *FreePatentsOnline*. 

#### 2.2 Output
The output is a *data frame* that contains the URL, title and abstract for each patent in FreePatentsOnline that you can find with your query.

### 3. patent_ref
The function **patent_ref** is a function that extract the URLs of the patents in FreePatentsOnline with an input query. You can set the number of html pages to parse for extracting the URLs. Each page contains 50 patent URLs.

#### 3.1 Input
- **query**: *string object*. The query that you want to search. You must follow the instructions in http://www.freepatentsonline.com/search.html?srch=xprtsrch to Construct the query.
- **uspat**: *string object*. This argumnet allows you to include the US Patents in your search. If you don't want to include these patens you must set **uspat** as *"off"*. Otherwise, if you want to include these type of patens you must set **uspat** as *"on"*. The default value of the argument **uspat** is *"on"*. 
- **usapp**: *string object*. This argumnet allows you to include the US Patent Applications in your search. If you don't want to include these patens you must set **usapp** as *"off"*. Otherwise, if you want to include these type of patens you must set **usapp** as *"on"*. The default value of the argument **usapp** is *"on"*. 
- **eupat**: *string object*. This argumnet allows you to include the European patetens in your search. If you don't want to include these patens you must set **eupat** as *"off"*. Otherwise, if you want to include these type of patens you must set **eupat** as *"on"*. The default value of the argument **eupat** is *"on"*.
- **jp**: *string object*. This argumnet allows you to include the Abstracts of Japan in your search. If you don't want to include these patens you must set **jp** as *"off"*. Otherwise, if you want to include these type of patens you must set **jp** as *"on"*. The default value of the argument **jp** is *"off"*.
- **pct**: *string object*. This argumnet allows you to include the WIPO patents in your search. If you don't want to include these patens you must set **pct** as *"off"*. Otherwise, if you want to include these type of patens you must set **pct** as *"on"*. The default value of the argument **pct** is *"off"*.
- **depat**: *string object*. This argumnet allows you to include the German Patents in your search. If you don't want include these patens you must set **depat** as *"off"*. Otherwise, if you want to include these type of patens you must set **depat** as *"on"*. The default value of the argument **depat** is *"off"*.
- **stemming**: *string object*. This argumnet allows you to stemm the query for your search. If you don't want to include the stemming words in your search you must set **stemming** as *"off"*. Otherwise, if you want to include the stemming words in your search you must set **stemming** as *"on"*. The default value of the argument **stemming** is *"off"*.
- **page_start**: *integer*. This argumnet allows you to set the starting page to find the URLs related to the input query. The default value of the argument is *1*.
- **page_end**: *integer*. This argumnet allows you to set the ending page to find the URLs related to the input query. The default value of the argument is *FALSE*, so it allow you to extract the URLs form starting page to the last page available on *FreePatentsOnline*. 

#### 3.2 Output
The output is a *string vector* that contains the URL of patents in FreePatentsOnline that you can find with your query.

### 4. patent_title
The function **patent_title** is a function that extract the title of the patent in FreePatentsOnline with an input URL.

#### 4.1 Input
- **link**: *string object*. The URL of patent that you want to search.  

#### 4.2 Output
The output is a *string object* that contains title of a given patent in FreePatentsOnline that you can find with your URL.

### 5. patent_abs
The function **patent_abs** is a function that extract the abstract of the patent in FreePatentsOnline with an input URL.

#### 5.1 Input
- **link**: *string object*. The URL of patent that you want to search.  

#### 5.2 Output
The output is a *string object* that contains abstract of a given patent in FreePatentsOnline that you can find with your URL.

