# Wikipedia
Wikipedia is a multilingual online encyclopaedia created and maintained as an open collaboration project by a community of volunteer editors. This file README contains all the information about the functions in Wikipedia Package. I explain you all functuions of Wikipedia Package in the following sections. In each section I show you a single function with explaination about:
- input: the input class and the means of input;
- output: the output class and the means of output;
- function: the explaination


### 1. wiki_extract_text
The function **wiki_extract_text** is a function that extract the content of Wikipedia web page in text format. 

#### 1.1 Input
- **page_name**: *string object*. The element of Wikipedia database that you want to search;
- **language**: *string object*. The language code of the wikipedia element that you want to search. The starting value of the argument **language** is *"en"* for english language. 

#### 1.2 Output
The output is a *vector string object* that contains the Wikipedia content of the input element. The content is divided in paragraph: each element of the vector is a paragraph. 

### 2. wiki_extract_link
The function **wiki_extract_link** is a function that extract the links in Wikipedia web page. 

#### 2.1 Input
- **page_name**: *string object*. The element of Wikipedia database that you want to search;
- **language**: *string object*. The language code of the wikipedia element that you want to search. The starting value of the argument **language** is *"en"* for english language. 

#### 2.2 Output
The output is a *data frame* that contains the Wikipedia link of the input element. 

### 3. wiki_extract_traduction
The function **wiki_extract_traduction** is a function that extract the traduction of Wikipedia element from a lenguage to another. 

#### 3.1 Input
- **page_name**: *string object*. The element of Wikipedia database that you want to search;
- **language_in**: *string object*. The input language code of the wikipedia element that you want to traduce.
- **language_in**: *string object*. The output language code of the wikipedia element that you want to traduce.

#### 3.2 Output
The output is a *string* that contains the translation of a Wikipedia element from a lenguage to another. 


### 4. wiki_extract_categories
The function **wiki_extract_categories** is a function that extract the categories in which Wikipedia classifies an element. 

#### 4.1 Input
- **page_name**: *string object*. The element of Wikipedia database that you want to search;
- **language**: *string object*. The language code of the wikipedia element that you want to search. The starting value of the argument **language** is *"en"* for english language. 


#### 4.2 Output
The output is a *string* that contains the categories of a Wikipedia element. Each category is divided from others using a *dot comma* characther (*;*). 


